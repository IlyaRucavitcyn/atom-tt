{View, $} = require 'space-pen'
request = require 'request-promise'

class Section extends View
  @content: (params) ->
    @div class: 'decresults', =>
      @h3 params.title
      if params.synWords
        @h4 'Synonyms'
        @ol =>
          @li name for name in params.synWords
      if params.simWords
        @h4 'Similar terms'
        @ol =>
          @li name for name in params.simWords
      if params.userSuggested
        @h4 'User suggested related terms'
        @ol =>
          @li name for name in params.userSuggested
      if params.antonyms
        @h5 'Antonyms'
        @ol =>
          @li name for name in params.antonyms

module.exports =
class WordDescriptionView extends View
  @content: ->
    @div =>
      @div outlet: "adjective"
      @div outlet: "noun"
      @div outlet: "verb"

  initialize: (word) ->
    @lookup = request({
      method: "GET",
      url: "http://words.bighugelabs.com/api/2/#{atom.config.get('atom-tt.bigHugeThesaurusApiKey')}/#{word}/json",
      json: {}
    })

  attached: ->
    @lookup.then((data) =>
      if data.adjective
        @adjective.replaceWith(
          new Section(
            title: 'Adjective',
            synWords: data.adjective.syn,
            userSuggested: data.adjective.usr,
            antonyms: data.adjective.ant,
            simWords: data.adjective.sim
          )
        )

      if data.noun
        @noun.replaceWith(
          new Section(
            title: 'Noun',
            synWords: data.noun.syn,
            userSuggested: data.noun.usr,
            antonyms: data.noun.ant,
            simWords: data.noun.sim
          )
        )

      if data.verb
        @verb.replaceWith(
          new Section(
            title: 'Verb',
            synWords: data.verb.syn,
            userSuggested: data.verb.usr,
            antonyms: data.verb.ant,
            simWords: data.verb.sim
          )
        )

    ).catch((e) ->
      console.log(e)
    )

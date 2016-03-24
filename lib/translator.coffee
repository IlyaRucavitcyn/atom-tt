request = require 'request-promise'

module.exports =
class Translator
  setDirection: (direction) ->
    @translationDirection = direction

  getDirection: ->
    @translationDirection

  setTextToTranslate: (text) ->
    @textToTranslate = text

  getTextToTranslate: ->
    @textToTranslate

  getOptions: ->
    # it has to return configuration object like so
    #  uri: 'https://translate.yandex.net/api/v1.5/tr.json/translate'
    #  qs:
    #    key: 'trnsl.1.1.20131018T064214Z.13f606fa635023bc.4f4ca095e1f2c70c3cc0ed9be9d55b2822a4b3b3'
    #    text: @getTextToTranslate() # 'Hello world'
    #    lang: @getDirection() #'en-ru'
    #    format: 'plain'
    #  json: true

  # translate: (text, direction, onSuccess, onFail) ->
  #   @setTextToTranslate(text)
  #   @setDirection(direction)
  #
  #   request(@getOptions()).then((response) ->
  #     onSuccess(response)
  #   ).catch((err) ->
  #     onFail(err)
  #   )

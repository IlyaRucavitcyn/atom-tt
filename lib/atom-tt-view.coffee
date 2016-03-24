{View} = require 'space-pen'
{TextEditorView} = require 'atom-space-pen-views'
request = require 'request-promise'
cheerio = require 'cheerio'
YandexTranslator = require './yandex-translator'

module.exports =
class TTView extends View
  @content: ->
    @div class: 'block', =>
      @div class: 'row', =>
        @div class: 'col-md-6', =>
          @subview 'srcLang', new TextEditorView
            placeholderText: 'Hi there, we are ready to translation ...'
        @div class: 'col-md-6', =>
          @subview 'destLang', new TextEditorView
            placeholderText: 'translation'
      @div class: 'row', =>
        @div class: 'col-md-6', =>
          @div outlet: "description"

  destroy: ->

  getSelectedText: ->
    atom.workspace.getActiveTextEditor().getSelectedText()

  translator: ->
    new YandexTranslator

  getDirection: ->
    'en-ru'

  translate: ->
    @srcLang.setText(text)
    @translator().translate @getSelectedText(), @getDirection(), ((response) =>
            if text = response.text[0]
              @destLang.setText(text)
            else
              @destLang.setText('uups')
      ), ((err) =>
        console.log err
        @destLang.setText('uups')
      )

    # debugger

    # @srcLang.setText(@getSelectedText())
    # that = @
    # options =
    #   uri: 'https://translate.yandex.net/api/v1.5/tr.json/translate'
    #   qs:
    #     key: 'trnsl.1.1.20131018T064214Z.13f606fa635023bc.4f4ca095e1f2c70c3cc0ed9be9d55b2822a4b3b3'
    #     text: @getSelectedText()
    #     lang: 'en-ru'
    #     format: 'plain'
    #   json: true
    #
    # descriptionTest =
    #   uri: "https://slovari.yandex.ru/#{that.getSelectedText()}/en-ru"
    #
    # request(descriptionTest).then((response) ->
    #   $ = cheerio.load(cheerio.load(response)('.b-translation__card_examples_three').html());
    #   $('a').replaceWith($('<span>'))
    #   that.description.append($.html())
    # )
    #
    # request(options).then((response) ->
    #   if text = response.text[0]
    #     that.destLang.setText(text)
    #   else
    #     that.destLang.setText('uups')
    # ).catch((err) ->
    #   that.destLang.setText(err)
    # ).then ->

  setSpinner: ->

    # @translation.setText(text)


      # buffer: new TextBuffer(@textContent)
      # softWrapped: false
      # tabLength: 2
      # softTabs: true
      # mini: @hasAttribute('mini')
      # lineNumberGutterVisible: not @hasAttribute('gutter-hidden')
      # placeholderText: @getAttribute('placeholder-text')
      #



# class MyView extends View
#   @content: ->
#     @raw """
#     <div class='block bordered'>
#       <atom-text-editor gutter-hidden class="source-lang">
#         11 Quick overview tab of open files. Similar to Mac OSX expose / mission control, Group, tab, Firefox, Safari and Chrome the browse tab, etc.
#         Shows the active tab, the panel and preview.
#         Text editor preview taken from the Minimap, if present, otherwise any icon file is used.
#         Shows file icons in tabs if the file has an icon pack installed.
#       </atom-text-editor>
#       <div class="block destination" style="">
#         askdaklsdj
#       </div>
#     </div>
#    """

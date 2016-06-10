{View} = require 'space-pen'
TTEditorView = require './tt-editor-view'
YandexTranslator = require './yandex-translator'

module.exports =
class TTView extends View
  @content: ->
    @div class: 'block', =>
      @div class: 'row', =>
        @div class: 'col-md-1 col-md-offset-11 translate', =>
          @div outlet: "ttaction", '&nbsp;'
          @button class: 'btn btn-info inline-block-tight', 'Translate'
      @div class: 'row', =>
        @div class: 'col-md-6', =>
          @div class: 'panel', =>
            @span class: 'picon list-picon'
            @span class: 'picon sound-picon'
            @span class: 'source-lang-name', 'english'
            @span class: 'picon change-picon'
            @span class: 'picon translate-picon'
          @subview 'srcLang', new TTEditorView
            placeholderText: 'Hi there, we are ready to translation ...', htmlClass: 'source-lang'
        @div class: 'col-md-6', style: 'padding-left: 0px;', =>
          @div class: 'panel', =>
            @span class: 'dest-lang-name', 'russian'
            @span class: 'picon sound-picon-right'
            @span class: 'picon translate-picon-right'
          @subview 'destLang', new TTEditorView
            placeholderText: 'translation', htmlClass: 'dest-lang'
      @div class: 'row', =>
        @div class: 'col-md-6', =>
          @div outlet: "description"

  destroy: ->

  setTextToTransate: (text)->
    @srcLang.setText(text)

  getTextToTransate: ->
    @srcLang.getText()

  translator: ->
    @transator ||= new YandexTranslator(atom.config.get('atom-tt.yandexApiKey'))

  getDirection: ->
    'en-ru'

  focusSourceLang: ->
    @srcLang.focus()

  translate: ->
    return if @instantTranslation

    @instantTranslation = true
    @srcLang.onDidStopChanging =>
      @translator().translate(@)

  setSpinner: ->
    @ttaction.html("<progress class='inline-block'></progress>")

  removeSpinner: ->
    @ttaction.html("")
    # @ttaction.html("<progress class='inline-block'></progress>")
    # @description.replaceWith('')



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

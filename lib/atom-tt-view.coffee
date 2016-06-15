{View} = require 'space-pen'
TTEditorView = require './tt-editor-view'
YandexTranslator = require './yandex-translator'
WordDescriptionView = require './word-description-view'

module.exports =
class TTView extends View
  @content: ->
    @div class: 'elock', =>
      @div class: 'row', =>
        @div class: 'col-md-12 translate text-right', =>
          @div class:'progress', outlet: "ttaction", ''
          @button class: 'btn btn-info inline-block-tight transbtnaction', 'Translate'
      @div class: 'row', =>
        @div class: 'col-md-6', =>
          @section class: 'src', =>
            @div class: 'panel', =>
              @span class: 'picon sound-picon'
              @span class: 'source-lang-name', 'english'
              @span class: 'picon change-picon'
              @span class: 'picon translate-picon'
            @subview 'srcLang', new TTEditorView
              placeholderText: 'Hi there, we are ready to translation ...', htmlClass: 'source-lang'
        @div class: 'col-md-6',  =>
          @section class: 'dest', =>
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

  getLangName: (code) ->
    @codes ||= {
      en: 'English',
      ru: 'Russian',
    }
    @codes[code]

  getTextToTransate: ->
    @srcLang.getText()

  setTextToTransate: (text) ->
    @srcLang.setText(text)

  getTranslatedText: ->
    @destLang.getText()

  setTranslatedText: (text) ->
    @destLang.setText(text)

  translator: ->
    @transator ||= new YandexTranslator(atom.config.get('atom-tt.yandexApiKey'))

  getSrcLangCode: ->
    @srcLangCode ||= 'en'

  setSrcLangCode: (code) ->
    @.element.querySelector('.source-lang-name').innerHTML = @getLangName(code)
    @srcLangCode = code

  getDestLangCode: ->
    @destLangCode ||= 'ru'

  setDestLangCode: (code) ->
    @.element.querySelector('.dest-lang-name').innerHTML = @getLangName(code)
    @destLangCode = code

  changeDirection: ->
    from = @getSrcLangCode()
    from_text = @getTextToTransate()
    to = @getDestLangCode()
    to_text = @getTranslatedText()

    @setDestLangCode(from)
    @setSrcLangCode(to)
    @setTextToTransate(to_text)
    @translate()


  getDirection: ->
    "#{@getSrcLangCode()}-#{@getDestLangCode()}"

  focusSourceLang: ->
    @srcLang.focus()

  translate: ->
    return if @instantTranslation

    @instantTranslation = true
    @srcLang.onDidStopChanging =>
      @translator().translate(@)

      words = @getTextToTransate().split(/\s/).filter((x) -> x.length > 1)
      if words.length == 1
        @getWordDescription(words[0])
      else
        @cleanUpDescription()

  setSpinner: ->
    @ttaction.html("<progress class='inline-block'></progress>")

  getWordDescription: (word) ->
    return unless word
    return if 'en' != @getSrcLangCode()
    @description.html(new WordDescriptionView(word))

  cleanUpDescription: ->
    @description.html('')

  prononce: (textToPrononce) ->
    (new Audio(
      "http://translate.google.com/translate_tts?ie=UTF-8&total=1&idx=0&textlen=32&client=tw-ob&q=#{encodeURIComponent(textToPrononce)}&tl=En-gb"
    )).play()

  attached: ->

    #bind translate function
    @on 'click', 'button', =>
      @translator().translate(@)

    @on 'click', '.change-picon', =>
      @changeDirection()

    @on 'click', '.sound-picon', =>
      @prononce(@getTextToTransate())

  removeSpinner: ->
    @ttaction.html("")
    # @description.replaceWith('')

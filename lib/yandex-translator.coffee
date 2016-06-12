request = require 'request-promise'
Translator = require './translator'

module.exports =
class YandexTranslator extends Translator
  constructor: (@key) ->

  getOptions: ->
     uri: 'https://translate.yandex.net/api/v1.5/tr.json/translate'
     qs:
       key: @key
       text: @getTextToTranslate() # 'Hello world'
       lang: @getDirection() #'en-ru'
       format: 'plain'
     json: true

  translate: (view) ->
    @setTextToTranslate(view.getTextToTransate())
    @setDirection(view.getDirection())

    view.setSpinner()

    request(@getOptions()).then((response) ->
      if text = response.text[0]
        view.setTranslatedText(text)
        view.removeSpinner()
      else
        view.setTranslatedText('uups nothing to translate')
        view.removeSpinner()
    ).catch((err) ->
      view.destLang.setText('uups :(')
      view.removeSpinner()
    )

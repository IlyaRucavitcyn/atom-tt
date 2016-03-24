request = require 'request-promise'
cheerio = require 'cheerio'
Translator = require './translator'

module.exports =
class YandexTranslator extends Translator
  getOptions: ->
     uri: 'https://translate.yandex.net/api/v1.5/tr.json/translate'
     qs:
       key: 'trnsl.1.1.20131018T064214Z.13f606fa635023bc.4f4ca095e1f2c70c3cc0ed9be9d55b2822a4b3b3'
       text: @getTextToTranslate() # 'Hello world'
       lang: @getDirection() #'en-ru'
       format: 'plain'
     json: true


  #
  # translate: ->
  #   @srcLang.setText(@getSelectedText())
  #   that = @
  #   options =
  #     uri: 'https://translate.yandex.net/api/v1.5/tr.json/translate'
  #     qs:
  #       key: 'trnsl.1.1.20131018T064214Z.13f606fa635023bc.4f4ca095e1f2c70c3cc0ed9be9d55b2822a4b3b3'
  #       text: @getSelectedText()
  #       lang: 'en-ru'
  #       format: 'plain'
  #     json: true
  #
  #   descriptionTest =
  #     uri: "https://slovari.yandex.ru/#{that.getSelectedText()}/en-ru"
  #
  #   request(descriptionTest).then((response) ->
  #     $ = cheerio.load(cheerio.load(response)('.b-translation__card_examples_three').html());
  #     $('a').replaceWith($('<span>'))
  #     that.description.append($.html())
  #   )
  #
  #   request(options).then((response) ->
  #     if text = response.text[0]
  #       that.destLang.setText(text)
  #     else
  #       that.destLang.setText('uups')
  #   ).catch((err) ->
  #     that.destLang.setText(err)
  #   ).then ->

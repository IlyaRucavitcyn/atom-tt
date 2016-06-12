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
    

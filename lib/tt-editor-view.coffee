{View, $} = require 'space-pen'

module.exports =
class TTEditorView extends View
  constructor: (params={}) ->
    {placeholderText, htmlClass} = params

    @instantTranslation = false

    @element = document.createElement('atom-text-editor')
    @element.classList.add(htmlClass)
    @element.style.height = '300px'

    model = @element.getModel()
    model.setPlaceholderText(placeholderText)
    model.setSoftWrapped(true)

    super

    @setModel(@element.getModel())

  setModel: (@model) ->

  onDidStopChanging: (callback) ->
    @model.onDidStopChanging(callback)

  # Returns a `TextEditor`
  getModel: -> @model

  # Returns a `String`.
  getText: ->
    @model.getText()

  # Public: Set the text of the editor as a `String`.
  setText: (text) ->
    @model.setText(text)

  # Returns a `Boolean`.
  hasFocus: ->
    @element.hasFocus()

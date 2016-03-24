{View, $} = require 'space-pen'

module.exports =
class TTEditorView extends View
  constructor: (params={}) ->
    {placeholderText, htmlClass} = params

    @element = document.createElement('atom-text-editor')
    @element.focus() if htmlClass is 'source-lang'
    @element.classList.add(htmlClass)

    model = @element.getModel()
    model.setPlaceholderText(placeholderText)
    model.setSoftWrapped(true)

    if @element.__spacePenView?
      @element.__spacePenView = this
      @element.__allowViewAccess = true

    super

    @setModel(@element.getModel())

  setModel: (@model) ->

  # Public: Get the underlying editor model for this view.
  #
  # Returns a `TextEditor`
  getModel: -> @model

  # Public: Get the text of the editor.
  #
  # Returns a `String`.
  getText: ->
    @model.getText()

  # Public: Set the text of the editor as a `String`.
  setText: (text) ->
    @model.setText(text)

  # Public: Determine whether the editor is or contains the active element.
  #
  # Returns a `Boolean`.
  hasFocus: ->
    @element.hasFocus()

{View} = require 'space-pen'
# {TextEditorView} = require 'atom-space-pen-views'

module.exports =
class MyView extends View
  @content: ->
    @div =>
      @div "Type your 22:"
      # @subview 'answer', new TextEditorView(mini: true)

{View} = require 'space-pen'
# {TextEditorView} = require 'atom-space-pen-views'

module.exports =
class MyView extends View
  @content: ->
    @div =>
      @div "Type your 22:"
      @raw """
      <h1>Hi</h1>
      <div class='block'>
          <label>You might want to type something here.</label>
          <atom-text-editor mini>Something you typed...</atom-text-editor>
      </div>
      <div class='block'>
          <label class='icon icon-file-directory'>Another field with an icon</label>
          <atom-text-editor mini>Something else you typed...</atom-text-editor>
      </div>
      <div class='block'>
          <button class='btn'>Do it</button>
      </div>
      <ul class='background-message'>
        <li>No Results</li>
      </ul>
      """
      # @subview 'answer', new TextEditorView(mini: true)

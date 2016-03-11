{View} = require 'space-pen'
{TextEditorView} = require 'atom-space-pen-views'

module.exports =
class MyView extends View
  @content: ->
    @div =>
      @raw """
      <atom-panel class='top'>
          <div class="padded">
              <div class="inset-panel">
                  <div class="panel-body">
                    <atom-text-editor gutter-hidden class="tt-from-lang">User input</atom-text-editor>
                  </div>
                    <atom-text-editor gutter-hidden class="tt-from-lang">User input</atom-text-editor>
                  </div>
              </div>
          </div>
      </atom-panel>
      """
      # @subview 'answer', new TextEditorView(mini: true)

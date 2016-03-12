{View} = require 'space-pen'
{TextEditorView} = require 'atom-space-pen-views'
request = require 'request-promise'

module.exports =
class TTView extends View
  @content: ->
    @div class: 'block', =>
      @subview 'srcLang', new TextEditorView
        placeholderText: 'Hi there, we are ready to translation ...'
      @subview 'destLang', new TextEditorView
        placeholderText: 'translation'

  destroy: ->

  getSelectedText: ->
    atom.workspace.getActiveTextEditor().getSelectedText()

  translate: ->
    @srcLang.setText(@getSelectedText())
    that = @
    options =
      uri: 'https://translate.yandex.net/api/v1.5/tr.json/translate'
      qs:
        key: 'trnsl.1.1.20131018T064214Z.13f606fa635023bc.4f4ca095e1f2c70c3cc0ed9be9d55b2822a4b3b3'
        text: @getSelectedText()
        lang: 'en-ru'
        format: 'plain'
      json: true

    request(options).then((response) ->
      if text = response.text[0]
        that.destLang.setText(text)
      else
        that.destLang.setText('uups')
    ).catch (err) ->
      that.destLang.setText(err)

  setSpinner: ->

    # @translation.setText(text)


      # buffer: new TextBuffer(@textContent)
      # softWrapped: false
      # tabLength: 2
      # softTabs: true
      # mini: @hasAttribute('mini')
      # lineNumberGutterVisible: not @hasAttribute('gutter-hidden')
      # placeholderText: @getAttribute('placeholder-text')
      #



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

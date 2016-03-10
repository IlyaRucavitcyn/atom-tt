TTView = require './atom-tt-view'
{CompositeDisposable} = require 'atom'

module.exports = AtomTt =
  ttView: null
  modalPanel: null
  subscriptions: null

  activate: (state) ->
    @ttView = new TTView
    @modalPanel = atom.workspace.addModalPanel(item: @ttView, visible: false)

    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'atom-tt:toggle': => @toggle()

  deactivate: ->
    @modalPanel.destroy()
    @subscriptions.dispose()

  serialize: ->
    ttViewState: @ttView.serialize()

  toggle: ->
    if @modalPanel.isVisible()
      @modalPanel.hide()
    else
      @modalPanel.show()

TTView = require './atom-tt-view'
{CompositeDisposable} = require 'atom'

module.exports = AtomTt =
  ttView: null
  modalPanel: null
  subscriptions: null
  config:
    yandexApiKey:
      type: 'string'
      default: 'trnsl.1.1.20131018T064214Z.13f606fa635023bc.4f4ca095e1f2c70c3cc0ed9be9d55b2822a4b3b3'
      description: 'You can get your API key here https://tech.yandex.com/keys/get/?service=trnsl'

  activate: (state) ->
    @ttView = new TTView
    @modalPanel = atom.workspace.addModalPanel(item: @ttView, visible: false, className: 'tt-panel')

    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'atom-tt:toggle': => @toggle()

  deactivate: ->
    @modalPanel.destroy()
    @subscriptions.dispose()
    @ttView.destroy()

  serialize: ->
    ttViewState: @ttView.serialize()

  toggle: ->
    if @modalPanel.isVisible()
      @modalPanel.hide()
    else
      @ttView.translate()
      @modalPanel.show()

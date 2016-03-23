mockery = require 'mockery'
fs = require 'fs'
AtomTt = require '../lib/atom-tt'

describe "AtomTt", ->
  [workspaceElement, activationPromise] = []

  beforeEach ->
    workspaceElement = atom.views.getView(atom.workspace)
    activationPromise = atom.packages.activatePackage('atom-tt')

    waitsForPromise ->
      atom.workspace.open 'new.txt'

  describe "when the atom-tt:toggle event is triggered", ->
    it "hides and shows the modal panel", ->
      expect(workspaceElement.querySelector('.tt-panel')).not.toExist()
      atom.commands.dispatch workspaceElement, 'atom-tt:toggle'

      waitsForPromise ->
        activationPromise

      runs ->
        expect(workspaceElement.querySelector('.tt-panel')).toExist()

        atomTtElement = workspaceElement.querySelector('.tt-panel')
        expect(atomTtElement).toExist()

        expect(atom.workspace.getModalPanels().length).toEqual(1)
        atomTtPanel = atom.workspace.getModalPanels()[0]
        expect(atomTtPanel.isVisible()).toBe true
        atom.commands.dispatch workspaceElement, 'atom-tt:toggle'
        expect(atomTtPanel.isVisible()).toBe false

    it "hides and shows the view", ->
      jasmine.attachToDOM(workspaceElement)

      expect(workspaceElement.querySelector('.tt-panel')).not.toExist()
      atom.commands.dispatch workspaceElement, 'atom-tt:toggle'

      waitsForPromise ->
        activationPromise

      runs ->
        atomTtElement = workspaceElement.querySelector('.tt-panel')
        expect(atomTtElement).toBeVisible()
        atom.commands.dispatch workspaceElement, 'atom-tt:toggle'
        expect(atomTtElement).not.toBeVisible()

    describe "translate selected text", ->

      beforeEach ->
        filename = "response.json"
        mockery.enable
            warnOnReplace: false,
            warnOnUnregistered: false,
            useCleanCache: true

        mockery.registerMock 'request-promise', ->
            response = fs.readFileSync(__dirname + '/spec/' + filename, 'utf8');
            Promise.resolve(response.trim());

      afterEach ->
        mockery.disable();
        mockery.deregisterAll();

      it "will translate from En to Ru by default", ->
        waitsForPromise ->
          activationPromise

        editor = atom.workspace.getActiveTextEditor()
        editor.setText('Hello world')
        editor.selectAll()
        atom.commands.dispatch atom.views.getView(atom.workspace), 'atom-tt:toggle'

        debugger
          # waitsFor ->
          #   translationService.translateTextLines.callCount > 0
          # runs ->
          #   expect(translationService.translateTextLines).toHaveBeenCalledWith(
          #     ['Hello world'], 'en', 'ru')

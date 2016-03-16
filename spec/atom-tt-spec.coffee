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

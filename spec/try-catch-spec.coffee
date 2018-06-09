{WorkspaceView} = require 'atom'
TryCatch = require '../lib/try-catch'

describe "TryCatch", ->
  activationPromise = null

  beforeEach ->
    atom.workspaceView = new WorkspaceView
    activationPromise = atom.packages.activatePackage('try-catch')

  describe "when the try-catch:toggle event is triggered", ->
    it "attaches and then detaches the view", ->
      expect(atom.workspaceView.find('.try-catch')).not.toExist()

      atom.workspaceView.trigger 'try-catch:toggle'

      waitsForPromise ->
        activationPromise

      runs ->
        expect(atom.workspaceView.find('.try-catch')).toExist()
        atom.workspaceView.trigger 'try-catch:toggle'
        expect(atom.workspaceView.find('.try-catch')).not.toExist()

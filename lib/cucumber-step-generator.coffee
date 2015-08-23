CucumberStepGeneratorView = require './cucumber-step-generator-view'
{CompositeDisposable} = require 'atom'

module.exports = CucumberStepGenerator =
  cucumberStepGeneratorView: null
  modalPanel: null
  subscriptions: null

  activate: (state) ->
    @cucumberStepGeneratorView = new CucumberStepGeneratorView(state.cucumberStepGeneratorViewState)
    @modalPanel = atom.workspace.addModalPanel(item: @cucumberStepGeneratorView.getElement(), visible: false)

    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'cucumber-step-generator:toggle': => @toggle()

  deactivate: ->
    @modalPanel.destroy()
    @subscriptions.dispose()
    @cucumberStepGeneratorView.destroy()

  serialize: ->
    cucumberStepGeneratorViewState: @cucumberStepGeneratorView.serialize()

  toggle: ->
    console.log 'CucumberStepGenerator was toggled!'

    if @modalPanel.isVisible()
      @modalPanel.hide()
    else
      @modalPanel.show()

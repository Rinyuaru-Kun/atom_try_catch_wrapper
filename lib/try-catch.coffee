module.exports =
  activate: ->
    atom.commands.add 'atom-workspace', 'try-catch:toggle': @toggle

  toggle: ->
    workspace = atom.workspace
    editor = workspace.getActiveTextEditor()

    fileName = editor.getTitle()
    blockStart = "try {\n";
    blockEnd = "\n
    } catch (e) {\n
    //console.log(e)\n
    }";

    selection = editor.getLastSelection()
    selectionText = selection.getText()

    if selectionText.length is 0
        selection.cursor.moveToBeginningOfLine()
        selection.selectToEndOfLine()
        selectionText = selection.getText()


    start = selectionText.trim().substr(0, blockStart.length)
    end = selectionText.trim().substr(-1 * blockEnd.length)

    if start is blockStart and end is blockEnd
       replaced = selectionText.trim().substr(blockStart.length)
       replaced = replaced.substr(0, replaced.length - blockEnd.length)
       selection.insertText(replaced, {select: true})
       selection.cursor.moveToEndOfLine()
    else
      selection.insertText("#{blockStart+selectionText+blockEnd}", {select: true})

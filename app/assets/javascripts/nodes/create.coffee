$ ->
  submitNodeForm = ->
    form = $('form.node-form')
    url = form.attr('action')
    $.ajax({
      url: url,
      type: form.attr('method'),
      data: form.serialize(),
      success: (data)->
        redrawTree()
    })

  drawTree = ->
    for container in $('.tree')
      $.getJSON $(container).data('url'), (data) ->
        settings = {
          'settings': { 'imageFolderName': '/assets' },
          'dimensions': { 'svgInitialWidth': $(container).width() }
        }
        techTree.createTree(data.nodes, settings, data.offsets)
        if window.location.pathname.match(/\/trees\/\d+\/edit/)
          techTree.activateAllNodes()

  redrawTree = ->
    if $('.tree').length > 0
      techTree.deleteTree()
      drawTree()

  $('#submitButton').click( (e)->
    submitNodeForm();
  )

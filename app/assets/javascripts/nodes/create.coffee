$ ->
  drawTree = ->
    for container in $('.tree')
      $.getJSON $(container).data('url'), (data) ->
        settings = {
          'settings': { 'imageFolderName': '/assets' },
          'dimensions': { 'svgInitialWidth': $(container).width() }
        }
        techTree.createTree(data.nodes, settings, data.offsets)
        if window.location.pathname.match(/\/trees\/\d+\/edit/)
          $('.node').d3Click();

  redrawTree = ->
    if $('.tree').length > 0
      techTree.deleteTree()
      drawTree()

  $('#submitButton').click( (e)->
    form = $('#new_node')
    url = form.attr('action')
    $.post(url, form.serialize(), (data)->
      redrawTree()
    )
  )

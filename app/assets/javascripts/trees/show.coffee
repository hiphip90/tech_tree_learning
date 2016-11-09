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

  if $('.tree').length > 0
    drawTree()

  $(".chzn-select").chosen({width: '100%'})


$ ->
  if $('.tree').length > 0
    for container in $('.tree')
      $.getJSON 'trees/' + $(container).data('id'), (data) ->
        settings = {
          'settings': { 'imageFolderName': '/assets' },
          'dimensions': { 'svgInitialWidth': $(container).width() }
        }
        techTree.createTree(data.nodes, settings, data.offsets)
        console.log techTree.dimensions

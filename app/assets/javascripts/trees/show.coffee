$ ->
  populateForm = (data)->
    form = $('form#new_node').attr('action', data.node_url)
      .attr('method', 'PUT').removeClass('new_node edit_node')
      .addClass('edit_node').attr('id', 'edit_node')
    for attr, value of data
      input = $('.' + attr).find('input')
      if input != undefined && input.length > 0
        input.val(value)

  getNodeDetails = (node)->
    nodeUrl = $(node)[0].__data__.node_url
    $.getJSON nodeUrl, (data) ->
      if window.location.pathname.match(/\/trees\/\d+\/edit/)
        populateForm(data)
      else
        $('.node-icon-show').find('img').attr('src', data.image_url)
        $('.node-header').find('h2').text(data.full_name)

  initializeClickHandlerForNodes = ->
    $('.node svg').click ()->
      getNodeDetails($(this).parent())

  drawTree = ->
    for container in $('.tree')
      $.getJSON $(container).data('url'), (data) ->
        settings = {
          'settings': { 'imageFolderName': '/assets' },
          'dimensions': { 'svgInitialWidth': $(container).width() }
        }
        techTree.createTree(data.nodes, settings, data.offsets)
        initializeClickHandlerForNodes()
        if window.location.pathname.match(/\/trees\/\d+\/edit/)
          techTree.activateAllNodes()

  redrawTree = ->
    if $('.tree').length > 0
      techTree.deleteTree()
      drawTree()

  if $('.tree').length > 0
    drawTree()

  $(".chzn-select").chosen({width: '100%'})



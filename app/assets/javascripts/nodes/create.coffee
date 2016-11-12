$ ->
  drawTree = ->
    for container in $('.tree')
      $.getJSON $(container).data('url'), (data) ->
        settings = {
          'settings': { 'imageFolderName': '/assets' },
          'dimensions': { 'svgInitialWidth': $(container).width() }
        }
        if window.location.pathname.match(/\/trees\/\d+\/edit/)
          data.nodes = $.map data.nodes, (node)->
                          node.selected = true
                          node
        techTree.createTree(data.nodes, settings, data.offsets)
        initializeClickHandlerForNodes()

  redrawTree = ->
    if $('.tree').length > 0
      techTree.deleteTree()
      drawTree()

  clearForm = ->
    form = $('form.node-form')
    form.attr('action', form.data('new-url')).attr('method', 'POST')
      .removeClass('new_node edit_node')
      .addClass('new_node').attr('id', 'new_node')
    form.find('input[type="text"]').val('')
    form.find('textarea').val('')
    form.find('button').text('Create Node')
    form.find('.destroy-link').attr('href', '#').addClass('hidden')
    form.find('.chzn-select').chosen('destroy')
    form.find('.chzn-select').val([])
    form.find('.chzn-select').chosen({width: '100%'})
    $('.node-learning-materials').html('')

  submitNodeForm = ->
    $('form.node-form').ajaxSubmit ()->
      redrawTree()
      clearForm()

  initializeClickHandlerForNodes = ->
    $('.node svg').click ()->
      getNodeDetails($(this).parent())

  $('#submitButton').click( (e)->
    submitNodeForm();
  )

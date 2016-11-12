$ ->
  displayMaterials = (materials)->
    $('.node-learning-materials').html('')
    for lm in materials
      container = $('<div class="lm-content"></div>').appendTo('.node-learning-materials')
      first_row = $('<div class="row-fluid"></div>').appendTo(container)
      first_row.append('<h4 class="white-font span8">'+lm.name+'</h4>')
      first_row.append('<div class="span4"><a class="pull-right destroy-lm-link" href="'+lm.url+'"><i class="icon-remove"></i></a></div>')
      container.append('<p class="white-font lm-description">'+lm.description+'</p>')
    $('.lm-description').linkify();

  populateRequirements = (available_requirements, selected_requirements)->
    requirements_selector = $('form.node-form').find('.chzn-select')
    requirements_selector.chosen('destroy')
    requirements_selector.find('option').remove()
    for req in available_requirements
      requirements_selector.append('<option value="' + req.name + '">' + req.full_name + '</option>')
    for req in selected_requirements
      requirements_selector.find('option[value=' + req + ']').attr('selected', 'selected')
    requirements_selector.chosen({width: '100%'})

  populateForm = (data)->
    form = $('form.node-form').attr('action', data.node_url)
      .attr('method', 'PUT').removeClass('new_node edit_node')
      .addClass('edit_node').attr('id', 'edit_node')
    form.find('button').text('Update Node')
    form.find('.destroy-link').attr('href', data.node_url).removeClass('hidden')
    for attr, value of data
      input = $('.' + attr).find('input')
      if input != undefined && input.length > 0
        input.val(value)
    populateRequirements(data.available_requirements, data.requirements)


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

  getNodeDetails = (node)->
    nodeUrl = $(node)[0].__data__.node_url
    $.getJSON nodeUrl, (data) ->
      if window.location.pathname.match(/\/trees\/\d+\/edit/)
        populateForm(data)
        displayMaterials(data.learning_materials)
      else
        $('.node-icon-show').find('img').attr('src', data.image_url)
        $('.node-header').find('h2').text(data.full_name)
        $('.node-learning-materials').html('')
        for lm in data.learning_materials
          container = $('<div class="lm-content"></div>').appendTo('.node-learning-materials')
          container.append('<h4 class="white-font">'+lm.name+'</h4>')
          container.append('<p class="white-font lm-description">'+lm.description+'</p>')
        $('.lm-description').linkify();
        $('.complete-link, .uncomplete-link').attr('href', data.completion_url)
        if data.completed
          $('.complete-link').addClass('hidden')
          $('.uncomplete-link').removeClass('hidden')
        else
          $('.complete-link').removeClass('hidden')
          $('.uncomplete-link').addClass('hidden')

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
        else
          nodes = $('.node[data-completed="true"]')
          if nodes.length > 0
            names = nodes.map(()->
              return $(this).data('name')
            ).get();
            console.log names
            techTree.activateNodes(names)

  redrawTree = ->
    if $('.tree').length > 0
      techTree.deleteTree()
      drawTree()

  if $('.tree').length > 0
    drawTree()

  $(".chzn-select").chosen({width: '100%'})

  $('.new-node-link').click (e)->
    e.preventDefault()
    clearForm();

  $('.destroy-link').click (e)->
    e.preventDefault()
    if confirm('This will destroy the node and all dependent nodes. Do you wish to proceed?')
      url = $(this).attr('href')
      $.ajax({
        url: url,
        type: 'DELETE',
        success: (data)->
          redrawTree()
          clearForm()
      })

  $(document).on 'click', '.destroy-lm-link', (e)->
    e.preventDefault()
    link = $(this)
    url = link.attr('href')
    $.ajax({
      url: url,
      type: 'DELETE',
      success: (data)->
        link.closest('.lm-content').remove()
    })

  $('.lm-description').linkify();

  $('.complete-link').click (e)->
    e.preventDefault()
    url = $(this).attr('href')
    $.ajax({
      url: url,
      type: 'POST',
      success: (data)->
        redrawTree()
        $('.complete-link').addClass('hidden')
        $('.uncomplete-link').removeClass('hidden')
    })

  $('.uncomplete-link').click (e)->
    e.preventDefault()
    url = $(this).attr('href')
    $.ajax({
      url: url,
      type: 'DELETE',
      success: (data)->
        redrawTree()
        $('.complete-link').removeClass('hidden')
        $('.uncomplete-link').addClass('hidden')
    })

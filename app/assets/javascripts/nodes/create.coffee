$ ->
  window.submitNodeForm = ->
    $('form.node-form').ajaxSubmit ()->
      window.redrawTree()
      window.clearForm()

  $('#submitButton').click( (e)->
    window.submitNodeForm();
  )

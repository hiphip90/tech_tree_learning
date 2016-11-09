jQuery.fn.d3Click = ->
  this.each (i, e)->
    evt = new MouseEvent("click")
    e.dispatchEvent(evt)

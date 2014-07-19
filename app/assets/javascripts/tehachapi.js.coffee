$(document).ready ->

  $("a#hotels_js").click (event) ->
    event.preventDefault()
    event.stopPropagation()
    $.ajax({url: "tehachapi/hotels", type: 'GET', success: (data)->
      $('#results').html(data)
    })

  $("a#restaurants_js").click (event) ->
    event.preventDefault()
    event.stopPropagation()
    $.ajax({url: "tehachapi/restaurants", type: 'GET', success: (data)->
      $('#results').html(data)
    })
return

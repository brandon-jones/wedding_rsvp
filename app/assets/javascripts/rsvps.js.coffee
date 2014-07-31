# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


$(document).ready ->
  console.log "do some work ready"

  col_click()
  
  attending_radio()

  $('.notice').delay(4000).fadeOut(200);

  $("#visible_options").change ->
    p = 'show='+$("#visible_options").val()+'&sort_by='+$("#sort_by").val()+'&order_by='+$("#order_by").val()+'&js=true'
    $.get("/rsvps?", p).done (data) ->
      $("#table-js").html(data)
      col_click()

  if $("input[type=radio]:checked").val() is "true"
    $("#party_size_js").fadeTo(0, 1)

col_click = ->
  $('.sort_col').click ->
    event.preventDefault();
    event.stopPropagation();
    ob = if $("#order_by").val() == 'asc' then 'desc' else 'asc'
    p = 'show='+$("#visible_options").val()+'&sort_by='+$(this).html().toLowerCase()+'&order_by='+ob+'&js=true'
    $.get("/rsvps?", p).done (data) ->
      $("#table-js").html(data)
      col_click()

attending_radio = ->
  $("input:radio").on "change", ->
    if $("input[type=radio]:checked").val() is "true"
      $("#party_size_js").fadeTo(500, 1)
    else
      $("#party_size_js").fadeTo(500, 0)
      $("#party_size_js").css("display","none")

export_js = ->
  $(document).bind "ajaxSuccess", "form.export-form", (event, xhr, settings) ->
    $thing_form = $(event.data)
    $error_container = $("#error_explanation", $thing_form)
    $error_container_ul = $("ul", $error_container)
    $("<p>").html(xhr.responseJSON.title + " saved.").appendTo $thing_form
    if $("li", $error_container_ul).length
      $("li", $error_container_ul).remove()
      $error_container.hide()
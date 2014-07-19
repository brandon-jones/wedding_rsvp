# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


$(document).ready ->
  $("input:radio").on "change", ->
    if $("input[type=radio]:checked").val() is "yes"
      $("#party_size_js").removeClass("disabled")
    else
      $("#party_size_js").addClass("disabled")
return

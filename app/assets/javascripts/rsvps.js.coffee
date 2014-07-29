# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


$(document).ready ->

	$("input:radio").on "change", ->
    if $("input[type=radio]:checked").val() is "true"
      $("#party_size_js").fadeTo(500, 1)
    else
      $("#party_size_js").fadeTo(500, 0)
      $("#party_size_js").css("display","none")

  $('.notice').delay(4000).fadeOut(200);

	if $("input[type=radio]:checked").val() is "true"
		$("#party_size_js").fadeTo(0, 1)

  
return

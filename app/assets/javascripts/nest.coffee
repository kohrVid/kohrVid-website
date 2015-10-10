# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


$(window).load ->
  if window.innerWidth < 450
    $("#logo").attr "x", "0px"
    yp = (window.innerHeight - 35) + "px"
    $("#logo").attr "y", yp
    $(".container").css
       left: "3px"
  else
    xp = (window.innerWidth * 0.5) + "px"
    $("#logo").attr "x", xp
    yp = (window.outerHeight - (window.innerHeight * 0.4)) + "px"
    $("#logo").attr "y", yp
    return

$(window).resize ->
  if window.innerWidth < 450
    $("#logo").attr "x", "0px"
    yp = (window.innerHeight - 35) + "px"
    $("#logo").attr "y", yp
    $(".container").css
       left: "3px"
  else
    xp = (window.innerWidth * 0.5) + "px"
    $("#logo").attr "x", xp
    yp = (window.outerHeight - (window.innerHeight * 0.4)) + "px"
    $("#logo").attr "y", yp
    return




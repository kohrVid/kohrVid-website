# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


$(window).load ->
  $("#dropdown").hide()
  if window.innerWidth < 450
    $("#logo").attr "x", "0px"
    yp = (window.innerHeight - 35) + "px"
    $("#logo").attr "y", yp
    cw = (window.innerWidth - 125) + "px"
    $(".container").css
       left: "3px"
       width: cw
  else if window.innerWidth < 750
    xp = (window.innerWidth - 370) + "px"
    $("#logo").attr "x", xp
    yp = (window.innerHeight - 35) + "px"
    $("#logo").attr "y", yp
  else
    xp = (window.innerWidth * 0.5) + "px"
    $("#logo").attr "x", xp
    yp = (window.outerHeight - (window.innerHeight * 0.4)) + "px"
    $("#logo").attr "y", yp

$(window).resize ->
  if window.innerWidth < 450
    $("#logo").attr "x", "0px"
    yp = (window.innerHeight - 35) + "px"
    $("#logo").attr "y", yp
    cw = (window.innerWidth - 125) + "px"
    $(".container").css
       left: "3px"
       width: cw
  else if window.innerWidth < 750
    xp = (window.innerWidth - 370) + "px"
    $("#logo").attr "x", xp
    yp = (window.innerHeight - 35) + "px"
    $("#logo").attr "y", yp
    $(".container").css
       left: "50px"
       width: "350px"
  else
    xp = (window.innerWidth * 0.5) + "px"
    $("#logo").attr "x", xp
    yp = (window.outerHeight - (window.innerHeight * 0.4)) + "px"
    $("#logo").attr "y", yp
    return
    $(".container").css
       left: "50px"
       width: "350px"

$(window).bind('orientationchange', $(window).resize)

  
$(document).ready ->
  $("#menu").click ->
    $("#dropdown").toggle()




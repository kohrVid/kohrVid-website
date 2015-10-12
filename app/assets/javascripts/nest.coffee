# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

small = () ->
  $("#logo").attr "x", "0px"
  yp = (window.innerHeight - 35) + "px"
  $("#logo").attr "y", yp
  cw = (window.innerWidth - 125) + "px"
  $(".container").css
     left: "3px"
     width: cw
  $(".contact input, .contact textarea").css
     width: "95%"

medium = () ->
  xp = (window.innerWidth - 370) + "px"
  $("#logo").attr "x", xp
  yp = (window.innerHeight - 35) + "px"
  $("#logo").attr "y", yp
  $(".container").css
     left: "50px"
     width: "350px"
  $(".contact input, .contact textarea").css
     width: "150%"


big = () ->
  xp = (window.innerWidth * 0.5) + "px"
  $("#logo").attr "x", xp
  yp = (window.outerHeight - (window.innerHeight * 0.4)) + "px"
  $("#logo").attr "y", yp
  $(".container").css
     left: "50px"
     width: "400px"
  $(".contact input, .contact textarea").css
     width: "180%"

$(window).load ->
  $("#dropdown").hide()
  if window.innerWidth < 500
    small()
  else if window.innerWidth < 750
    medium()
  else
    big()

adaptive = () ->
  if window.innerWidth < 500
    small()  
  else if window.innerWidth < 750
    medium()
  else
    big()

$(window).resize ->
  adaptive()

  
$(document).ready ->
  $("#menu").click ->
    $("#dropdown").toggle()




# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


$(window).load ->
  xp = (window.innerWidth * 0.5) + "px"
  $("#logo").attr "x", xp
  yp = (window.outerHeight - (window.innerHeight * 0.4)) + "px"
  $("#logo").attr "y", yp
  return

$(window).resize ->
  xp = (window.innerWidth * 0.5) + "px"
  $("#logo").attr "x", xp
  yp = (window.outerHeight - (window.innerHeight * 0.4)) + "px"
  $("#logo").attr "y", yp
  return




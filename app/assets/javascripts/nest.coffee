# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

		#Nest.Café#

#Define Dimensions#
small = () ->
  $("#logo").attr "x", "0px"
  yp = (window.innerHeight - 35) + "px"
  $("#logo").attr "y", yp
  cw = (window.innerWidth - 142) + "px"
  $(".container").css
     left: "3px"
     width: cw
     height: "52%"
  $(".contact input, .contact textarea").css
     width: "95%"
  $(".clients li").css
     width: "70%"
     height: "70%"

medium = () ->
  xp = (window.innerWidth - 370) + "px"
  $("#logo").attr "x", xp
  yp = (window.innerHeight - 35) + "px"
  $("#logo").attr "y", yp
  $(".container").css
     left: "50px"
     width: "350px"
     height: "52%"
  $(".contact input, .contact textarea").css
     width: "150%"
  $(".clients li").css
     width: "40%"
     height: "58%"

mediumLarge = () ->
  xp = (window.innerWidth * 0.5) + "px"
  $("#logo").attr "x", xp
  yp = (window.outerHeight - (window.innerHeight * 0.4)) + "px"
  $("#logo").attr "y", yp
  $(".container").css
     left: "50px"
     width: "350px"
     height: "60%"
  $(".contact input, .contact textarea").css
     width: "150%"
  $(".clients li").css
     width: "23%"
     height: "154px"

big = () ->
  xp = (window.innerWidth * 0.5) + "px"
  $("#logo").attr "x", xp
  yp = (window.outerHeight - (window.innerHeight * 0.4)) + "px"
  $("#logo").attr "y", yp
  $(".container").css
     left: "50px"
     width: "400px"
     height: "60%"
  $(".contact input, .contact textarea").css
     width: "180%"
  $(".clients li").css
     width: "23%"
     height: "154px"

#Adaptive Layout#
$(window).load ->
  $("#dropdown").hide()
  if window.innerWidth < 500
    small()
  else if window.innerWidth <840
    medium()
  else if window.innerWidth < 950
    mediumLarge()
  else
    big()

adaptive = () ->
  if window.innerWidth < 500
    small()  
  else if window.innerWidth <840
    medium()
  else if window.innerWidth < 950
    mediumLarge()
  else
    big()

$(window).resize ->
  adaptive()

#Navigation Bar#  
$(document).ready ->
  $("#menu").click ->
    $("#dropdown").slideToggle()

#Close buttons#
$(document).ready ->
  $(".close").click ->
    $(".alerts").hide()
    $(".description").fadeOut()
  $(".close_image").click ->
    $(".screenshot").fadeOut("slow")
    


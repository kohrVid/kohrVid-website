# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

		#Nest.Café#

#Define Dimensions#

smallSVG = () ->
  $("#logo").attr "x", "0px"
  svgTop = (window.innerHeight - 35) + "px"
  $("#logo").attr "y", svgTop
  cw = (window.innerWidth - 142) + "px"

smallContainer = () ->
  $(".container").css
     left: "3px"
     width: cw
     height: "52%"

smallContact = () ->
  $(".contact input, .contact textarea").css
     width: "95%"

smallClient =() ->
  $(".clients li").css
     width: "70%"
     height: "75%"

smallScreen = () ->
  smallSVG()
  smallContainer()
  smallContact()
  smallClient()

mediumSVG = () ->
  svgLeft = (window.innerWidth - 370) + "px"
  $("#logo").attr "x", svgLeft
  svgTop = (window.innerHeight - 35) + "px"
  $("#logo").attr "y", svgTop

mediumContainer = () ->
  $(".container").css
     left: "50px"
     width: "350px"
     height: "52%"
mediumContact = () ->
  $(".contact input, .contact textarea").css
     width: "150%"

mediumContact = () ->
  $(".clients li").css
     width: "40%"
     height: "240px"

mediumScreen = () ->
  mediumSVG()
  mediumContainer()
  mediumContact()
  mediumClient()

mediumLargeSVG = () ->
  svgLeft = (window.innerWidth * 0.5) + "px"
  $("#logo").attr "x", svgLeft
  svgTop = (window.outerHeight - (window.innerHeight * 0.4)) + "px"
  $("#logo").attr "y", svgTop

mediumLargeContainer = () ->
  $(".container").css
     left: "50px"
     width: "350px"
     height: "60%"

mediumLargeClient = () ->
  $(".clients li").css
     width: "23%"
     height: "189px"

mediumLargeScreen = () ->
  mediumLargeSVG()
  mediumLargeContainer()
  mediumContact()
  mediumLargeClient()


largeSVG = () ->
  svgLeft = (window.innerWidth * 0.5) + "px"
  $("#logo").attr "x", svgLeft
  svgTop = (window.outerHeight - (window.innerHeight * 0.4)) + "px"
  $("#logo").attr "y", svgTop

largeContainer = () ->
  $(".container").css
     left: "50px"
     width: "400px"
     height: "60%"

largeContact = () ->
  $(".contact input, .contact textarea").css
     width: "180%"
  $(".clients li").css
     width: "23%"
     height: "189px"

largeClient = () ->
  $(".clients li").css
     width: "23%"
     height: "189px"

largeScreen = () ->
  largeSVG()
  largeContainer()
  largeContact()
  largeClient()

#Adaptive Layout#
adaptive = () ->
  if window.innerWidth < 500
    smallScreen()
  else if window.innerWidth <840
    mediumScreen()
  else if window.innerWidth < 950
    mediumLargeScreen()
  else
    largeScreen()

$(window).load ->
  $("#dropdown").hide()
  adaptive()

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

		#Nest.Café#

#Define Dimensions#

smallSVG = () ->
  $("#logo").attr "x", "0px"
  svgTop = (window.innerHeight - 35) + "px"
  $("#logo").attr "y", svgTop

mediumSVG = () ->
  svgLeft = (window.innerWidth - 370) + "px"
  $("#logo").attr "x", svgLeft
  svgTop = (window.innerHeight - 35) + "px"
  $("#logo").attr "y", svgTop

mediumLargeSVG = () ->
  svgLeft = (window.innerWidth * 0.5) + "px"
  $("#logo").attr "x", svgLeft
  svgTop = (window.outerHeight - (window.innerHeight * 0.4)) + "px"
  $("#logo").attr "y", svgTop


largeSVG = () ->
  svgLeft = (window.innerWidth * 0.5) + "px"
  $("#logo").attr "x", svgLeft
  svgTop = (window.outerHeight - (window.innerHeight * 0.4)) + "px"
  $("#logo").attr "y", svgTop

#Adaptive Layout#
adaptive = () ->
  if window.innerWidth < 500
    smallSVG()
  else if window.innerWidth <840
    mediumSVG()
  else if window.innerWidth < 950
    mediumLargeSVG()
  else
    largeSVG()

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

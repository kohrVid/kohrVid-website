#Nest.Café##☕#☕#☕#☕#

$(document).ready ->
  $(".close").click ->
    $(".alerts").hide()

$(window).resize ->
  navigation()
$(window).scroll ->
  navigation()

navigation = () ->
  menu = $('#hide-on-scroll')
  navbar = $('#navbar')
  if window.innerWidth < 768
    if $(this).scrollTop().valueOf() >= navbar.height()
      navbar.removeClass("position-relative")
      navbar.addClass("position-fixed")
      menu.addClass("hidden")
    else if $(this).scrollTop().valueOf() == 0 || window.innerWidth >= 768
      navUnfix(navbar)
  else if  window.innerWidth >= 768
    navUnfix(navbar)
    menu.removeClass("hidden")

navUnfix = (navbar) ->
  navbar.removeClass("position-fixed")
  navbar.addClass("position-relative")

#$(document).ready(function(){
  #$(window).bind('orientationchange', function(){
    #adaptive();
  #});
  #$(".blog_archive_year").accordion({ active: $(".blog_archive_year div:first-child"), collapsible: true});
  #$(".blog_archive_month").accordion({ active: $(".blog_archive_month div"), collapsible: true});
  #$(".blog_archive_draft").accordion({ active: $(".blog_archive_draft div"), collapsible: true});
#});

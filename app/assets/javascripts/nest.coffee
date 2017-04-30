##Nest.Café##☕#☕#☕#☕#

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
    else if $(this).scrollTop().valueOf() <= 3
      navUnfix(navbar, menu)
  else if  window.innerWidth >= 768
    navUnfix(navbar, menu)

navUnfix = (navbar, menu) ->
  navbar.removeClass("position-fixed")
  navbar.addClass("position-relative")
  menu.removeClass("hidden")

#$(document).ready(function(){
  #$(window).bind('orientationchange', function(){
    #adaptive();
  #});
  #$(".blog_archive_year").accordion({ active: $(".blog_archive_year div:first-child"), collapsible: true});
  #$(".blog_archive_month").accordion({ active: $(".blog_archive_month div"), collapsible: true});
  #$(".blog_archive_draft").accordion({ active: $(".blog_archive_draft div"), collapsible: true});
#});

/*#Client screenshot#
screenshotLarge = () ->
  h = window.innerHeight + "px"
  w = window.innerWidth + "px"
  hi = (window.innerHeight - 100) + "px"
  wi = (window.innerWidth - 100) + "px"
  if $(".screenshot").is(":visible")
    $(".screenshot").show()
    $(".screenshot img").css
       height: hi
       width: wi

$(document).ready ->
  $("#client_image").click ->
  screenshotLarge()


*/

function screenshotLarge() {
	var $h = window.innerHeight + "px";
	var $w = window.innerWidth + "px";
	var $hi = (window.innerHeight - 100) + "px";
	var $wi = (window.innerWidth - 100) + "px";
	if ($(".screenshot").is(":hidden")){
		$(".screenshot").show();
		$(".screenshot img").css("height", $hi); 
		$(".screenshot img").css("width", $wi);
	}
}

$(document).ready(function(){
/*	$( ".screenshot" ).dialog({
		autoOpen: false,
		show: {
			effect: "blind",
		        duration: 1000
		},
	        hide: {
			effect: "explode",
			duration: 1000
		}
	});
*/	$( "#client_image" ).click(function() {
		screenshotLarge();
        	//$( ".description" ).dialog( "open" );
	});

	$(window).bind('orientationchange', function(){
		adaptive();
		if ($(".screenshot").is(":visible")){
			screenshotLarge();
		}
	});
	$(window).bind('resize', function(){
		if ($(".screenshot").is(":visible")){
			screenshotLarge();
		}

	});
});





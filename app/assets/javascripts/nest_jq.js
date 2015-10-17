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
/*	$(" .screenshot_image").css("height", "75%");
	$(" .screenshot_image").css("width", "75%");
*/	var w = $(".screenshot_image").width();
	var h = $(".screenshot_image").height();
//	var wr = (w / window.innerWidth) - 100;
//	var hr = h / window.innerHeight;
/*	var wi = (w/window.innerWidth) - 100;
	var hi = (h/w) * wi;
	$(".screenshot_image").height(h);
	$(".screenshot_image").width(w);
*/	if ($(".screenshot").is(":hidden")){
/*		$(".screenshot").height(window.innerHeight); 
		$(".screenshot").width(window.innerWidth);
*/		$(".screenshot").fadeIn("slow");
//		$(".screenshot_image").show();
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





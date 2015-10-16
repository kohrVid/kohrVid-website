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
	var $w = $(".screenshot img").attr("width");
	var $h = $(".screenshot img").attr("height");
	var $hi = (($h/($h / window.innerHeight)) - 350) + "px";
	var $wi = (($w/($w / window.innerWidth)) - 350) + "px";
	if ($(".screenshot").is(":hidden")){
		$(".screenshot").show();
		$(".screenshot img").height($hi); 
		$(".screenshot img").width($wi);
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





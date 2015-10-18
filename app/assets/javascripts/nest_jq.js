
function screenshotLarge() {
	var w = $(".screenshot_image").width();
	var h = $(".screenshot_image").height();
	if ($(".screenshot").is(":hidden")){
		$(".screenshot").fadeIn("slow");
	}
}

$(document).ready(function(){
	$( "#client_image" ).click(function() {
		screenshotLarge();
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





$(document).ready(function(){

	$(window).bind('orientationchange', function(){
		adaptive();
	});
});

//#Remotipart#
$(form).on("ajax:remotipartComplete", function(e, data){
  console.log(e, data)
});


$(document).ready(function(){
	$(window).bind('orientationchange', function(){
		adaptive();
	});
	$(".blog_archive_year").accordion({ active: $(".blog_archive_year div:first-child"), collapsible: true});
	$(".blog_archive_month").accordion({ active: $(".blog_archive_month div"), collapsible: true});
	$(".blog_archive_draft").accordion({ active: $(".blog_archive_draft div"), collapsible: true});
});


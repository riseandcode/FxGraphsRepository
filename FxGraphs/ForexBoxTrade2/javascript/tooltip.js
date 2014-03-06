$(document).ready(function(){

    $("#hometab a,#advisortab a,#helptab a").hover(function () {
	$(this).next("em").stop(true, true).animate({opacity: "show", top: "-60"}, "slow");
	}, function() {
	$(this).next("em").animate({opacity: "hide", top: "-70"}, "fast");
	});
 
});
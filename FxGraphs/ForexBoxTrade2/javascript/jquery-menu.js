var navObject = {
	padLeft : '20px',
	padLeftHover : '40px',
	goRight : function(obj) {
		if (!obj.parent('li').hasClass('active')) {
			obj.stop(true, true).animate({ 'padding-left' : this.padLeftHover }, 'fast');
		}
	},
	goLeft : function(obj) {
		if (!obj.parent('li').hasClass('active')) {
			obj.stop(true, true).animate({ 'padding-left' : this.padLeft }, 'fast');
		}
	},
	makeActive : function(obj) {
		obj.siblings().each(function() {
			if ($(this).hasClass('active')) {
				$(this).removeClass('active');
				navObject.goLeft($(this).children('a'));
			}
		});
		if (!obj.hasClass('active')) {
			obj.addClass('active');
		}
	}
	

}
$(function() {
	
	$('.navigation li a').hover(function() {
		navObject.goRight($(this));
	}, function() {
		navObject.goLeft($(this));
	});	
	
	$('.navigation li a').click(function() {
		
		navObject.makeActive($(this).parent('li'));
		return false;
		
	});
	
});







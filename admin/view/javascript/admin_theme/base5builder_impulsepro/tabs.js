$.fn.tabs = function() {
	var selector = this;
	
	this.each(function() {
		var obj = $(this); 
		
		$(obj.attr('href')).hide();
		
		$(obj).click(function() {
			$(selector).removeClass('selected');
			
			$(selector).each(function(i, element) {
				$($(element).attr('href')).hide();
			});
			
			$(this).addClass('selected');
			
			$($(this).attr('href')).show();
			
			return false;
		});
	});

	$(this).show();
	
	$(this).first().click();
};

$.fn.tabsoption = function() {
	var selector = this;
	
	this.each(function() {
		var obj = $(this); 
		
		$(obj.attr('href')).show();
		
		$(obj).click(function() {
			$(selector).removeClass('selected');
			
			$(selector).each(function(i, element) {
				$($(element).attr('href')).show();
			});
			
			$(this).addClass('selected');
			
			$($(this).attr('href')).show();
			
			return false;
		});
	});

	$(this).show();
	
	$(this).first().click();
};
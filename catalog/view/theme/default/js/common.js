jQuery(document).ready(function() {
    /* Search */
    jQuery('button.btn.btn-default').on('click', function() {
        url = jQuery('base').attr('href') + 'index.php?route=product/search';
                 
        var search = jQuery('input[name=\'search\']').prop('value');
        
        if (search) {
            url += '&search=' + encodeURIComponent(search);
        }
        
        location = url;
    });

	jQuery('input[name=\'search\']').bind('keydown', function(e) {
		if (e.keyCode == 13) {
			url = jQuery('base').attr('href');

			var search = jQuery(this).attr('value');
			if (search) {
				url += 'search/?filter_name=' + encodeURIComponent(search);
			}

			location = url;
		}
	});

	
		// Ajax Cart Fixes

		jQuery('#cart > .dropdown-toggle').live('click hover', function() {
		jQuery('#cart').addClass('active');
		jQuery('#cart').load('index.php?route=module/cart #cart > *');
		jQuery('#cart').live('mouseleave', function() {
			jQuery(this).removeClass('active');
		});
	});
	
	// IE6 & IE7 Fixes
	if (jQuery.browser.msie) {
		if (jQuery.browser.version <= 6) {
			jQuery('#column-left + #column-right + #content, #column-left + #content').css('margin-left', '185px');
			
			jQuery('#column-right + #content').css('margin-right', '185px');
		
			jQuery('.box-category ul li a.active + ul').css('display', 'block');	
		}
	}
	
	jQuery('.success img, .warning img, .attention img, .information img').live('click', function() {
		jQuery(this).parent().fadeOut('slow', function() {
			jQuery(this).remove();
		});
	});	
});

function getURLVar(key) {
	var value = [];
	
	var query = String(document.location).split('?');
	
	if (query[1]) {
		var part = query[1].split('&');

		for (i = 0; i < part.length; i++) {
			var data = part[i].split('=');
			
			if (data[0] && data[1]) {
				value[data[0]] = data[1];
			}
		}
		
		if (value[key]) {
			return value[key];
		} else {
			return '';
		}
	}
} 

function addToCart(product_id, quantity) {
	quantity = typeof(quantity) != 'undefined' ? quantity : 1;

	jQuery.ajax({
		url: 'index.php?route=checkout/cart/add',
		type: 'post',
		data: 'product_id=' + product_id + '&quantity=' + quantity,
		dataType: 'json',
		success: function(json) {
			jQuery('.success, .warning, .attention, .information, .error').remove();
			
			if (json['redirect']) {
				location = json['redirect'];
			}
			
			if (json['success']) {
				jQuery('#notification').html('<div class="success" style="display: none;">' + json['success'] + '<img src="catalog/view/theme/default/image/close.png" alt="" class="close" /></div>');
				
				jQuery('.success').fadeIn('slow');
				
				jQuery('#cart-total').html(json['total']);
				
				jQuery('html, body').animate({ scrollTop: 0 }, 'slow'); 
			}	
		}
	});
}
function addToWishList(product_id) {
	jQuery.ajax({
		url: 'index.php?route=account/wishlist/add',
		type: 'post',
		data: 'product_id=' + product_id,
		dataType: 'json',
		success: function(json) {
			jQuery('.success, .warning, .attention, .information').remove();
						
			if (json['success']) {
				jQuery('#notification').html('<div class="success" style="display: none;">' + json['success'] + '<img src="catalog/view/theme/default/image/close.png" alt="" class="close" /></div>');
				
				jQuery('.success').fadeIn('slow');
				
				jQuery('#wishlist-total').html(json['total']);
				
				jQuery('html, body').animate({ scrollTop: 0 }, 'slow');
			}	
		}
	});
}

function addToCompare(product_id) { 
	jQuery.ajax({
		url: 'index.php?route=product/compare/add',
		type: 'post',
		data: 'product_id=' + product_id,
		dataType: 'json',
		success: function(json) {
			jQuery('.success, .warning, .attention, .information').remove();
						
			if (json['success']) {
				jQuery('#notification').html('<div class="success" style="display: none;">' + json['success'] + '<img src="catalog/view/theme/default/image/close.png" alt="" class="close" /></div>');
				
				jQuery('.success').fadeIn('slow');
				
				jQuery('#compare-total').html(json['total']);
				
				jQuery('html, body').animate({ scrollTop: 0 }, 'slow'); 
			}	
		}
	});


}

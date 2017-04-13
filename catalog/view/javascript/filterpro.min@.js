var fIID = 0;
var interval = 1;
var $cookie = function(){};
var container = ".product-{view}";
jQuery.fn.exists = function(){return this.length > 0;}
/**
 * fixs for IE
 */
if (!Array.prototype.indexOf) {
    Array.prototype.indexOf = function(obj, start) {
        for (var i = (start || 0), j = this.length; i < j; i++) {
            if (this[i] === obj) {
                return i;
            }
        }
        return -1;
    }
}
function escapeHtml(text) {
  return text
      .replace(/&/g, "&amp;")
      .replace(/</g, "&lt;")
      .replace(/>/g, "&gt;")
      .replace(/"/g, "&quot;");
}
String.prototype.hashCode = function(){
    var hash = 0, i, ch;
    if (this.length == 0) return hash;
    for (i = 0; i < this.length; i++) {
        ch = this.charCodeAt(i);
        hash = ((hash<<5)-hash)+ch;
        hash = hash & hash; // Convert to 32bit integer
    }
    return hash;
};
var tag_tmpl = jQuery.template(null, '<tr><td><input id="tag_${tag}" class="filtered" type="checkbox" name="tags[]" value="${tag}" {{if checked}} checked="checked" {{/if}}></td>' +
    '<td><label for="tag_${tag}">${name}</label></td></tr>');
var cat_tmpl = jQuery.template(null, '<tr><td><input id="cat_${category_id}" class="filtered" type="checkbox" name="categories[]" value="${category_id}" {{if checked}} checked="checked" {{/if}}></td>'+
				'<td><label for="cat_${category_id}">${name}</label></td></tr>');
jQuery("#slider").on("change", ".price_limit", (function () {
    var b = parseInt(jQuery("#min_price").val());
    var a = parseInt(jQuery("#max_price").val());
    jQuery('.slider-range').slider("values", [b, a]);
    iF()
}));
function synchronizeImgCheckboxes() {
    jQuery("#filterpro input.filtered[type=\"checkbox\"]").each(function() {
        var $img = jQuery(this).next('img');
        if ($img.length) {
            if (jQuery(this).is(":checked")) {
                $img.addClass("selected");
            } else {
                $img.removeClass("selected");
            }
        }
    });
}
jQuery(document).ready(function(){
    jQuery("#filterpro .filtered").on("change", (function () {
        //iF();
    }));
});
jQuery(function () {
    try {
        jQuery('.slider-range').slider({range:true, min:0, max:0, values:[0, 0], stop:function (a, b) {
            //iF() /*автоматический поиск*/
        }, slide:function (a, b) {
            jQuery("#min_price").val(b.values[0]);
            jQuery("#max_price").val(b.values[1])
        }});
        jQuery("#min_price").val(jQuery('.slider-range').slider("values", 0));
        jQuery("#max_price").val(jQuery('.slider-range').slider("values", 1));
    } catch(e) {}
});
function iF() {
    clearTimeout(fIID);
    jQuery("#filterpro_page").val(0);
    fIID = setTimeout("doFilter(false)", interval)
}
function success(g, b) {
    if ($cookie){
        var view = $cookie("display");
    }
    if (!view) {
        view = "list";
    }
    var hash = window.location.hash.substr(1);
    if (g.result_html && hash) {
        if (jQuery('.product-list').length)
            jQuery('.product-list').html(g.result_html);
        else
            jQuery('.products-ul').html(g.result_html);
        afterload();

        jQuery(".pagination").html(g.pagination);
    }
    if (g.result_html =='') {
        if (jQuery('.product-list').length)
            jQuery('.product-list').html('Ничего не найдено');
        else
            jQuery('.products-ul').html('Ничего не найдено');
        afterload();

        jQuery(".pagination").html('');
    }
	if (g.pagination){
        jQuery(".pagination").html(g.pagination);
    }
    if (b && g.min_price == g.max_price) {
        jQuery('.price_slider').hide();
    }
    if (!g.min_price) g.min_price = 0;
    if (!g.max_price) g.max_price = 0;
    var d = parseInt(g.min_price);
    var c = Math.ceil(parseFloat(g.max_price));
    if (typeof(display) != "undefined") {
        view ? display(view) : display("list");
    }
    if (b) {
        if (jQuery("#max_price").val() >= 1) {
            d = parseInt(jQuery("#min_price").val());
            c = parseInt(jQuery("#max_price").val())
        }
        try {
        jQuery('.slider-range').slider("option", {min:d, max:c});
        jQuery('.slider-range').slider("option", {values:[d, c]});
        } catch(e) {}
        jQuery("#min_price").val(d);
        jQuery("#max_price").val(c)
    }
    if (g.totals_data) {
        if (g.totals_data.tags.length) {
            jQuery('#filter_tags').html('');
            jQuery.tmpl(tag_tmpl, g.totals_data.tags).appendTo('#filter_tags');
            jQuery('#filter_tags').parents('.option_box').show();
        } else {
            jQuery('#filter_tags').parents('.option_box').hide();
        }
        jQuery('#filter_categories').html('');
        if (g.totals_data.categories.length) {
            jQuery.tmpl(cat_tmpl, g.totals_data.categories).appendTo('#filter_categories');
            jQuery('#filter_categories').parents('.option_box').show();
        } else {
            jQuery('#filter_categories').parents('.option_box').hide();
        }
        var atts = {};
        jQuery.each(g.totals_data.attributes, function(k, v) {
            atts[(v.id + "_" + v.text).replace(/\s/g, '_')] = v.t;
        });
        jQuery('.a_name').each(function (k, v) {
            var at_v_i = jQuery(v).attr('at_v_i').replace(/\s/g, '_');
            var at_v_i_e = escapeHtml(at_v_i);
            if (atts[at_v_i]) {
                jQuery('[at_v_t="' + at_v_i_e + '"]').text(jQuery('[at_v_t="' + at_v_i_e + '"]').attr('data-value') + " (" + atts[at_v_i] + ")");
                jQuery(v).removeAttr("disabled");
            } else {
                jQuery('[at_v_t="' + at_v_i_e + '"]').text(jQuery('[at_v_t="' + at_v_i_e + '"]').attr('data-value'));
                //jQuery(v).attr("disabled", "disabled");
                //jQuery(v).removeAttr('checked');
                //jQuery(v).removeAttr(':selected');
            }
        });
        var h = [];
        jQuery.each(g.totals_data.manufacturers, function (f, k) {
            if (k.id) {
                h[h.length] = k.id;
                var j = jQuery("#manufacturer_" + k.id);
                j.removeAttr("disabled");
                if (j.get(0).tagName == "OPTION") {
                    j.text(jQuery("#m_" + k.id).val() + " (" + k.t + ")")
                } else {
                    jQuery('label[for="manufacturer_' + k.id + '"]').text(jQuery("#m_" + k.id).val() + " (" + k.t + ")")
                }
            }
        });
        jQuery(".manufacturer_value").each(function (f, k) {
            var j = jQuery(this);
            var l = j.attr("id").match(/manufacturer_(\d+)/);
            if (jQuery.inArray(l[1], h) < 0) {
                j.attr("disabled", "disabled");
                if (this.tagName == "OPTION") {
                    j.text(jQuery("#m_" + l[1]).val());
                    j.prop("selected", false)
                } else {
                    jQuery('label[for="manufacturer_' + l[1] + '"]').text(jQuery("#m_" + l[1]).val());
                    j.prop("checked", false)
                }
            }
        });
        var e = [];
        jQuery.each(g.totals_data.options, function (j, k) {
            if (k.id) {
                e[e.length] = k.id;
                var f = jQuery("#option_value_" + k.id);
                if (f.length) {
                    f.removeAttr("disabled");
                    if (f.get(0).tagName == "OPTION") {
                        f.text(jQuery("#o_" + k.id).val() + " (" + k.t + ")")
                    } else {
                        jQuery('label[for="option_value_' + k.id + '"]').text(jQuery("#o_" + k.id).val() + " (" + k.t + ")")
                    }
                }
            }
        });
        jQuery(".option_value").each(function (j, k) {
            var f = jQuery(this);
            var l = f.attr("id").match(/option_value_(\d+)/);
            if (jQuery.inArray(l[1], e) < 0) {
                //f.attr("disabled", "disabled");
                if (this.tagName == "OPTION") {
                    f.text(jQuery("#o_" + l[1]).val());
                    f.attr("selected", false)
                } else {
                    jQuery('label[for="option_value_' + l[1] + '"]').text(jQuery("#o_" + l[1]).val());
                    f.attr("checked", false)
                }
            }
        });
    }
    var top = 0;
    if (jQuery('.products-list').length) top = jQuery('.products-list').offset().top;
    else if (jQuery('.products-ul').length) top = jQuery('.products-ul').offset().top;
    //jQuery('body, html').animate({'scrollTop':1000},400);
}
function getCont(){
    if ($cookie){
        var view = $cookie("display");
    }
    if (!view) {view = "grid";}
	var container = ".product-{view}";
    var cont = container.replace('{view}', view);
    if (!jQuery(cont).exists()){
        cont = container.replace('{view}', 'grid');
    }
    return cont;
}
var cache = [];
function doFilter(b) {
    var a = jQuery("#filterpro").serialize().replace(/[^&]+=\.?(?:&|$)/g, "").replace(/&+$/, "");
    price = jQuery('#pricesort').attr('data-sort');
    valuta_rub = jQuery('#valutesort_rub').attr('data-valute-rub');
	valuta_usd = jQuery('#valutesort_usd').attr('data-valute-usd');
	var price_change = jQuery('select#budjet').val();
	
	if(price_change == 250000000 || price_change == 100000){
		a +='&'+price+'&valute='+valuta_rub+valuta_usd;
    }else{
		a +='&'+price+'&valute='+valuta_rub; 
	}
	
    var limit = jQuery('#pricesort').attr('data-limit');
    if (limit && limit>0) {
        a+='&limit='+limit;
    }
    if (!b && a.indexOf('&path=')<0) {
        window.location.href='/sale#'+a;
    }
    if (!b) {
        window.location.hash = a
    }
    var h = a.hashCode();
    if (cache[h]){
        success(cache[h]);
    }  else {
        var cont = getCont();
        jQuery(cont).mask();
        jQuery(".filterpro").mask();

        jQuery.ajax({url:"index.php?route=module/filterpro/getproducts", type:"POST", data:a + (b ? "&getPriceLimits=true" : ""), dataType:"json",
            success:function (g) {
                success(g, b);
                cache[h] = g;
                var cont = getCont();
                jQuery(cont).unmask();
                jQuery(".filterpro").unmask();
            },
            error:function(jqXHR, textStatus, errorThrown) {
                var cont = getCont();
                jQuery(cont).unmask();
                jQuery(".filterpro").unmask();
            }
        });
    }
}
jQuery(document).ready(function () {
    container = jQuery('#filterpro_container').val();
    if (jQuery.totalStorage!=undefined){
        $cookie = jQuery.totalStorage;
    } else if (jQuery.cookie != undefined){
        $cookie = jQuery.cookie;
    }
    jQuery(".option_box .option_name").click(function () {
        jQuery(this).siblings(".collapsible").toggle();
        jQuery(this).toggleClass("hided")
    });
    jQuery(".option_box .attribute_group_name").click(function () {
        jQuery(this).siblings(".attribute_box").toggle();
        jQuery(this).toggleClass("hided")
    });
    jQuery(".clear_filter").click(function () {
        jQuery("#filterpro img").removeClass("selected");
        jQuery("#filterpro select").val("");
        jQuery("#filterpro :input").each(function () {
            if (jQuery(this).is(":checked")) {
                jQuery(this).attr("checked", false)
            }
        });
        var b = jQuery('.slider-range').slider("option", "min");
        var a = jQuery('.slider-range').slider("option", "max");
        jQuery('.slider-range').slider("option", {values:[b, a]});
        jQuery("#min_price").val(b);
        jQuery("#max_price").val(a);
	jQuery("div[class^=slider-range-]").each(function(index, element) {
	    var id = this.id.replace(/[^\d]/g, '');
	    var b = jQuery(element).slider("option", "min");
	    var a = jQuery(element).slider("option", "max");
	    hs = jQuery(element).slider();
	    hs.slider("option", {values:[b, a]});
	    hs.slider("option","slide").call(hs, null, { handle: jQuery(".ui-slider-handle", hs), values:[b, a] });
	    jQuery("#attribute_value_"+id+"_min").val('');
	    jQuery("#attribute_value_"+id+"_max").val('');
	});
        iF()
    });
    jQuery(".pagination a").live("click", (function () {
        var a = jQuery(this).attr("href");
        var b = a.match(/page=(\d+)/);
        jQuery("#filterpro_page").val(b[1]);
        doFilter(false);
        var cont = getCont();
        jQuery('html, body').animate({ scrollTop: jQuery(cont).offset().top }, 'slow');
        return false;
    }));
    if(jQuery(".sort select").length){
        jQuery(".sort select").get(0).onchange = null;
        jQuery(".sort select").change(function () {
            var d = jQuery(this).val();
            var a = gUV(d, "sort");
            var b = gUV(d, "order");
            jQuery("#filterpro_sort").val(a);
            jQuery("#filterpro_order").val(b);
            iF()
        });
    }
    if (jQuery(".limit select").length) {
        jQuery(".limit select").get(0).onchange = null;
        jQuery(".limit select").change(function () {
            jQuery("#filterpro_limit").val(gUV(jQuery(this).val(), "limit"));
            iF()
        });
    }
// deserialize
    var i = jQuery.noConflict();
    var hash = window.location.hash.substr(1);
    if (hash && i('instock').is(':visible') && i('instock').is(':checked')) {
        i('instock').attr("checked", false);
    }
    i("#filterpro").deserialize(hash);
    if (hash) {
        var valuta = i( "input:radio[name=valute]:checked" ).val();
        i('#valutesort_rub').attr('data-valute-rub',valuta);
		i('#valutesort_usd').attr('data-valute-usd',valuta);
        var sort = hash.match('sort=([^&]+)');
        var order = hash.match('order=([^&]+)');
        if (sort && order) {
            var data = 'sort='+sort[1]+'&order='+order[1];
            i('#pricesort').attr('data-sort',data);
        }
    }
    synchronizeImgCheckboxes();
    i("#filterpro img").bind("click", function() {
        var $input = i(this).prev("input");
        if ($input.attr("disabled")) {
            return;
        }
        i(this).toggleClass("selected");
        $input.prop('checked', !$input.prop('checked'));
        iF();
    });
    i("div[class^=slider-range-]").each(function(index, element) {
	var id = this.id.replace(/[^\d]/g, '');
	var arr = window['attr_arr_'+id];
	var b = parseInt(i("#attribute_value_"+id+"_min").val());
	var a = parseInt(i("#attribute_value_"+id+"_max").val());
	b = arr.indexOf(b);
	a = arr.indexOf(a);
	if (a >= 0 && b >= 0){
	    hs = i(element).slider();
	    hs.slider("option", {values:[b, a]});
	    hs.slider("option","slide").call(hs, null, { handle: i(".ui-slider-handle", hs), values:[b, a] });
	}
    });
    if (i(".sort select").length) {
        if (i("#filterpro_sort").val()) {
            i(".sort select").each(function(i, e) {
                if (gUV(i(this).val(), "sort") == i("#filterpro_sort").val() && gUV(i(this).val(), "order") == i("#filterpro_order").val()) {
                    i(".sort select").val(i(this).val());
                    return;
                }
            });
        } else {
            $val = i(".sort select").val();
            i("#filterpro_sort").val(gUV($val, "sort"));
            i("#filterpro_order").val(gUV($val, "order"))
        }
    }
    if (i("#filterpro_limit").length) {
        if (i("#filterpro_limit").val()) {
            i(".limit select").val(i("#filterpro_limit").val());
        } else {
            i("#filterpro_limit").val(gUV(i(".limit select").val(), "limit"));
        }
    }
    doFilter(true)
});
function gUV(e,f){var c=String(e).split("?");var a="";if(c[1]){var b=c[1].split("&");for(var g=0;g<=(b.length);g++){if(b[g]){var d=b[g].split("=");if(d[0]&&d[0]==f){a=d[1]}}}}return a}
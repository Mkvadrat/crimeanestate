<?php echo $header; ?><?php echo $column_left; ?><?php echo $column_right; ?>

<?php echo $content_top; ?>

<div class="content">

<div class="conteiner">

  <div class="breadcrumb">
    <?php foreach ($breadcrumbs as $breadcrumb) { ?>
    <?php echo $breadcrumb['separator']; ?><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a>
    <?php } ?>
  </div>

    <h1 class="search-caption"><?php echo $heading_title; ?></h1>
</div>

<div class="search_form_inputs">
<div class="conteiner">

  <b><?php //echo $text_critea; ?></b>
  <div class="content">
    <form action="/search" method="get">
    <p>
      <div class="float-left">
      <?php echo $entry_search; ?>
      <?php if ($filter_name) { ?>
      <input type="text" name="filter_name" value="<?php echo $filter_name; ?>" />
      <?php } else { ?>
      <input type="text" name="filter_name" value="<?php echo $filter_name; ?>" onclick="this.value = '';" onkeydown="this.style.color = '000000'" style="color: #999;" />
      <?php } ?>
      </div>
      <select name="filter_category_id">
        <option value="0"><?php echo $text_category; ?></option>
        <?php foreach ($categories as $category_1) { ?>
        <?php if ($category_1['category_id'] == $filter_category_id) { ?>
        <option value="<?php echo $category_1['category_id']; ?>" selected="selected"><?php echo $category_1['name']; ?></option>
        <?php } else { ?>
        <option value="<?php echo $category_1['category_id']; ?>"><?php echo $category_1['name']; ?></option>
        <?php } ?>
        <?php foreach ($category_1['children'] as $category_2) { ?>
        <?php if ($category_2['category_id'] == $filter_category_id) { ?>
        <option value="<?php echo $category_2['category_id']; ?>" selected="selected">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<?php echo $category_2['name']; ?></option>
        <?php } else { ?>
        <option value="<?php echo $category_2['category_id']; ?>">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<?php echo $category_2['name']; ?></option>
        <?php } ?>
        <?php foreach ($category_2['children'] as $category_3) { ?>
        <?php if ($category_3['category_id'] == $filter_category_id) { ?>
        <option value="<?php echo $category_3['category_id']; ?>" selected="selected">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<?php echo $category_3['name']; ?></option>
        <?php } else { ?>
        <option value="<?php echo $category_3['category_id']; ?>">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<?php echo $category_3['name']; ?></option>
        <?php } ?>
        <?php } ?>
        <?php } ?>
        <?php } ?>
      </select>
      <div class="block">
      <?php if ($filter_sub_category) { ?>
      <input type="checkbox" name="filter_sub_category" value="1" id="sub_category" checked="checked" />
      <?php } else { ?>
      <input type="checkbox" name="filter_sub_category" value="1" id="sub_category" />
      <?php } ?>
      <label for="sub_category"><?php echo $text_sub_category; ?></label>
      </div>
    </p>
    <?php if ($filter_description) { ?>
    <input type="checkbox" name="filter_description" value="1" id="description" checked="checked" />
    <?php } else { ?>
    <input type="checkbox" name="filter_description" value="1" id="description" />
    <?php } ?>
    <label for="description"><?php echo $entry_description; ?></label>
    <div class="buttons">
        <div class="right"><input type="submit" value="<?php echo $button_search; ?>" id="button-search" class="button" /></div>
    </div>
        <input type="hidden" name="search_all" value="1" />
    </form>
  </div>


  <?php if (false && $products) { ?>
  <div class="product-filter">
      <!--<div class="display"><b><?php echo $text_display; ?></b> <?php echo $text_list; ?> <b>/</b> <a onclick="display('grid');"><?php echo $text_grid; ?></a></div>-->
      <div class="limit"><?php echo $text_limit; ?>
          <select onchange="location = this.value;">
              <?php foreach ($limits as $limits) { ?>
                  <?php if ($limits['value'] == $limit) { ?>
                      <option value="<?php echo $limits['href']; ?>" selected="selected"><?php echo $limits['text']; ?></option>
                  <?php } else { ?>
                      <option value="<?php echo $limits['href']; ?>"><?php echo $limits['text']; ?></option>
                  <?php } ?>
              <?php } ?>
          </select>
      </div>
      <div class="sort"><?php echo $text_sort; ?>
          <select onchange="location = this.value;">
              <?php foreach ($sorts as $sorts) { ?>
                  <?php if ($sorts['value'] == $sort . '-' . $order) { ?>
                      <option value="<?php echo $sorts['href']; ?>" selected="selected"><?php echo $sorts['text']; ?></option>
                  <?php } else { ?>
                      <option value="<?php echo $sorts['href']; ?>"><?php echo $sorts['text']; ?></option>
                  <?php } ?>
              <?php } ?>
          </select>
      </div>
  </div>
  <div class="product-compare"><!--<a href="<?php echo $compare; ?>" id="compare-total"><?php echo $text_compare; ?></a>--></div>
    <?php } ?>

  </div>
</div>

<div class="conteiner">
  <?php if ($products) { ?>
      <div class="block-3">
      <ul class="products-ul">
          <?php foreach ($products as $product) { ?>
          <li>
              <div class="novostroyki-img">
                  <?php if ($product['thumb']) { ?>
                      <img src="<?php echo $product['thumb']; ?>" alt="<?php echo $product['name']; ?>"/>
                  <?php } else { ?>
                      <img src="/catalog/view/theme/default/img/nophoto.png" alt="Нет изображения"/>
                  <?php } ?>
                  <div class="novostroyki-cena">
                      <?php if (!$product['special']) { ?>
                          Цена <?php echo $product['rub']; ?> руб. / <?php echo $product['price']; ?> $
                      <?php } else { ?>
                          <span class="price-old"><?php echo $product['price']; ?></span> <span class="price-new"><?php echo $product['special']; ?></span>
                      <?php } ?>
                  </div>
              </div>
              <h3><?php echo $product['name']; ?></h3>
              <p>
                  <?php echo $product['description'] ?>
              </p>
              <a href="<?php echo $product['href']; ?>">Читать описание полностью</a>

              <div class="novostroyki-media">
                  <a href="<?php echo $product['href']; ?>&show=video"><img src="/catalog/view/theme/default/img/Video_play.png" alt=""/></a>
                  <a href="<?php echo $product['href']; ?>&show=gallery"><img src="/catalog/view/theme/default/img/images_play.png" alt=""/></a>
              </div>

          </li>
          <?php } ?>
      </ul>
      </div>
  <div class="pagination"><?php echo $pagination; ?></div>
  <?php } else { ?>
  <div class="block-3"><?php echo $text_empty; ?></div>
  <?php }?>

</div>
</div>
<?php echo $content_bottom; ?>

<script type="text/javascript"><!--
jQuery('#content input[name=\'filter_name\']').keydown(function(e) {
	if (e.keyCode == 13) {
		jQuery('#button-search').trigger('click');
	}
});

jQuery('#button-search').bind('click', function() {
	url = 'index.php?route=product/search';
	
	var filter_name = jQuery('#content input[name=\'filter_name\']').attr('value');
	
	if (filter_name) {
		url += '&filter_name=' + encodeURIComponent(filter_name);
	}

	var filter_category_id = jQuery('#content select[name=\'filter_category_id\']').attr('value');
	
	if (filter_category_id > 0) {
		url += '&filter_category_id=' + encodeURIComponent(filter_category_id);
	}
	
	var filter_sub_category = jQuery('#content input[name=\'filter_sub_category\']:checked').attr('value');
	
	if (filter_sub_category) {
		url += '&filter_sub_category=true';
	}
		
	var filter_description = jQuery('#content input[name=\'filter_description\']:checked').attr('value');
	
	if (filter_description) {
		url += '&filter_description=true';
	}

	location = url;
});

/*function display(view) {
	if (view == 'list') {
		jQuery('.product-grid').attr('class', 'product-list');
		
		jQuery('.product-list > div').each(function(index, element) {
			html  = '<div class="right">';
			html += '  <div class="cart">' + jQuery(element).find('.cart').html() + '</div>';
			html += '  <div class="wishlist">' + jQuery(element).find('.wishlist').html() + '</div>';
			html += '  <div class="compare">' + jQuery(element).find('.compare').html() + '</div>';
			html += '</div>';			
			
			html += '<div class="left">';
			
			var sale = jQuery(element).find('.sale').html();
			
			if (sale != null) { 
				html += '<div class="sale">' + sale + '</div>';
			}
			
			var image = jQuery(element).find('.image').html();
			
			if (image != null) { 
				html += '<div class="image">' + image + '</div>';
			}
			
			var price = jQuery(element).find('.price').html();
			
			if (price != null) {
				html += '<div class="price">' + price  + '</div>';
			}
						
			html += '  <div class="name">' + jQuery(element).find('.name').html() + '</div>';
			html += '  <div class="description">' + jQuery(element).find('.description').html() + '</div>';
			
			var rating = $(element).find('.rating').html();
			
			if (rating != null) {
				html += '<div class="rating">' + rating + '</div>';
			}
				
			html += '</div>';

						
			$(element).html(html);
		});		
		
		jQuery('.display').html('<b><?php echo $text_display; ?></b> <?php echo $text_list; ?> <b>/</b> <a onclick="display(\'grid\');"><?php echo $text_grid; ?></a>');
		
		jQuery.cookie('display', 'list'); 
	} else {
		jQuery('.product-list').attr('class', 'product-grid');
		
		jQuery('.product-grid > div').each(function(index, element) {
			html = '';
			
			var sale = jQuery(element).find('.sale').html();
			
			if (sale != null) { 
				html += '<div class="sale">' + sale + '</div>';
			}
			
			var image = jQuery(element).find('.image').html();
			
			if (image != null) {
				html += '<div class="image">' + image + '</div>';
			}
			
			html += '<div class="name">' + jQuery(element).find('.name').html() + '</div>';
			html += '<div class="description">' + jQuery(element).find('.description').html() + '</div>';
			
			var price = jQuery(element).find('.price').html();
			
			if (price != null) {
				html += '<div class="price">' + price  + '</div>';
			}	
					
			var rating = jQuery(element).find('.rating').html();
			
			if (rating != null) {
				html += '<div class="rating">' + rating + '</div>';
			}
						
			html += '<div class="cart">' + jQuery(element).find('.cart').html() + '</div>';
			html += '<div class="wishlist">' + jQuery(element).find('.wishlist').html() + '</div>';
			html += '<div class="compare">' + jQuery(element).find('.compare').html() + '</div>';
			
			jQuery(element).html(html);
		});	
					
		jQuery('.display').html('<b><?php echo $text_display; ?></b> <a onclick="display(\'list\');"><?php echo $text_list; ?></a> <b>/</b> <?php echo $text_grid; ?>');
		
		jQuery.cookie('display', 'grid');
	}
}

view = jQuery.cookie('display');

if (view) {
	display(view);
} else {
	display('list');
}*/
//--></script>

<?php echo $footer; ?>
<?php echo $header; ?>

  <?php if ($categories) { ?>

    <?php if ($heading_title == '_Аренда')  { ?>

        <div class="row">
            <div class="conteiner arenda-top">
                <ul>
                <?php foreach ($categories as $category) { ?>
                    <li>
                    <?php if ($category['thumb'] && $category['name'] != 'Специальное предложение') { ?>
                        <p><span><?php echo $category['name'] ?></span></p>
                        <img src="<?php echo $category['thumb'] ?>" alt="<?php echo $category['name'] ?>"/>
                        <a href="<?php echo $category['href']; ?>">СМОТРЕТЬ</a>
                    <?php } else { ?>
                        <a href="<?php echo $category['href']; ?>" class="a-spec1">
                            <p class="arenda-spec-pred">
                                <?php if ($category['name'] == 'Специальное предложение') { ?>
                                <img class="anim-sp" src="/catalog/view/theme/default/img/icon-spec.png" alt=""/>
                                <?php } ?>
                                <?php echo $category['name'] ?>
                            </p>
                        </a>
                    <?php } ?>
                    </li>
                <?php } ?>
                </ul>
            </div>
        </div>

    <?php } else if ($heading_title == 'Найм') { ?>

        <div class="row">
            <div class="conteiner top-rent">
                <div class="top-rent-left">
                    <ul>
                    <?php $special_cat = null; ?>
                    <?php foreach ($categories as $category) { ?>
                        <?php if ($category['name'] == 'Специальное предложение') {
                            $special_cat = $category;
                            continue;
                        }
                        ?>
                        <li>
                        <?php if ($category['thumb']) { ?>
                            <img src="<?php echo $category['thumb']; ?>" alt="<?php echo $category['name']; ?>"/>
                            <div class="top-rent-left-fon"></div>
                            <div class="top-rent-left-text"><div><?php echo $category['name']; ?></div></div>
                            <a class="top-rent-but" href="<?php echo $category['href']; ?>">СМОТРЕТЬ</a>
                        <?php } else { ?>
                            <a class="sale-sp" href="<?php echo $category['href']; ?>">
                                <div>
                                    <?php echo $category['name']; ?>
                                </div>
                            </a>
                        <?php } ?>
                        </li>
                    <?php } ?>
                    </ul>
                </div>
                <div class="top-rent-right">
                    <?php if ($special_cat) { ?>
                    <a href="<?php echo $special_cat['href']; ?>">
                        <img src="/catalog/view/theme/default/img/rent10.png" alt="<?php echo $special_cat['name']; ?>"/>
                        <div class="top-rent-right-fon"></div>
                        <div class="top-rent-right-text">
                            <div><img class="anim-sp" src="/catalog/view/theme/default/img/icon-spec.png" alt=""/><?php echo $special_cat['name']; ?></div>
                        </div>
                    </a>
                    <?php } ?>
                </div>
            </div>
        </div>

    <?php } else { ?>

        <div class="row">
        <div class="conteiner top-rent">
            <div class="top-sale-left">
            <ul>
            <?php foreach ($categories as $category) { ?>
			<?php if ($category['thumb'] ) { ?>
                <li class="top-sale-left-li">
                        <img src="<?php echo $category['thumb']; ?>" alt="<?php echo $category['name']; ?>"/>
                        <div class="top-sale-left-fon"></div>
                        <div class="top-sale-left-text"><div><?php echo $category['name']; ?></div></div>
                        <a class="top-sale-but" href="<?php echo $category['href']; ?>">СМОТРЕТЬ</a>
				</li>
                <?php } ?>
            <?php } ?>
            </ul>
			<!--Элитная или бюджетная недвижимость-->
			<?php if($category_id != 20 && $category_id != 94){ ?>
			<div class="category_switch">
			<!--<table border="1">
			<tr>-->
			<?php foreach($certain_category_array as $certain_category){ ?>
			<?php if($certain_category["name"]) {?>
			<!--<td class="certain_category_td">-->
			        <div class="certain_category"><a href="<?php echo $certain_category["href"]; ?>"><?php echo $certain_category["name"]; ?></a></div>
			<!--</td>-->
		    <?php } ?>
			<?php } ?>
			<!--</tr>
			</table>-->
			</div>
			<?php } ?>
            </div>
        </div>
        </div>

        <?php } ?>
  <?php } ?>

  <?php if ($thumb && (
        $heading_title == 'Специальное предложение' ||
        $heading_title == 'Лучшие предложения' ||
        $heading_title == 'Эксклюзивы'
    )) { ?>
    <?php
    $class='top-ban-text-3';
    if ($heading_title == 'Эксклюзивы') $class = 'top-ban-text-2';
    if ($heading_title == 'Лучшие предложения') $class = 'top-ban-text';
    ?>
    <div class="row">
        <div class="conteiner">
            <div class="top-ban">
                <img src="<?php echo $thumb; ?>" class="" />
                <p class="<?php echo $class ?>">
                    <?php if ( $heading_title == 'Специальное предложение') { ?>
                    <img src="/catalog/view/theme/default/img/icon-spec.png" class="" />
                    <?php } ?>
                    <?php echo $heading_title; ?>
                </p>
            </div>
        </div>
    </div>
<?php } ?>

        <?php //echo $subCatInfo ?>

<?php echo $content_top; ?>

<div class="content">
<div class="conteiner">
    <div class="breadcrumb">
        <?php
        $count = count($breadcrumbs);
        $i=1;
        foreach ($breadcrumbs as $breadcrumb) {
            if($i!=$count){
                echo $breadcrumb['separator']; ?>
                <a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a>
            <?php
            }
            else{
                echo $breadcrumb['separator']; ?><?php echo $breadcrumb['text']; ?>
            <?php }
            $i++;
        } ?>
    </div>
    <!--<?php if ($description) { ?>
	<?php if ($quantity_column == 0) { ?>
    <div class="text-col-1">
        <?php echo $description; ?>
    </div>
	<?php }else{ ?>
	<div class="text-col-2">
        <?php echo $description; ?>
    </div>
	<?php } ?>
    <?php } ?>-->

  <?php if ($products) { ?>

      <div class="row">
          <div class="arenda-nav" style="margin-top:0px">
              <div class="nav-arenda-grid-line">
                  <a class="nav-arenda-grid" href="#"></a>
                  <a class="nav-arenda-line" href="#"><img href="img/line1.png" alt=""/></a>
              </div>
              <?php if (!empty($pages_total)): ?>
              <p>ВСЕГО ПРЕДЛОЖЕНИЙ: <span><?php echo $pages_total; ?></span></p>
              <?php endif; ?>
              <div class="nav-arenda-select">
                  <p>СОРТИРОВАТЬ ПО:</p>
                  <div class="s5">
                  <select id="select5" class="selector" onchange="change_list_sorting()">
                      <option value="rating">ПОПУЛЯРНОСТИ</option>
                      <option value="price-asc"><span>ЦЕНЕ</span> (от меньшей к большей)</option>
                      <option value="price-desc"><span>ЦЕНЕ</span> (от большей к меньшей)</option>
                  </select>
                  </div>
              </div>
              <div class="nav-arenda-select2">
                  <p>ПОКАЗАТЬ ПО:</p>
                  <div class="s6">
                  <select id="select6" class="selector" onchange="change_list_limit()">
                      <option value="10">10</option>
                      <option value="20">20</option>
                      <option value="50">50</option>
                  </select>
                  </div>
              </div>
              <div class="nav-arenda-page">
                  <div class="pagination"><?php echo $pagination; ?></div>
              </div>
          </div>
      </div>

  <div class="block-3" id="grid-line-modifier">
  <ul class="products-ul">
  <div class="product-list">
<?php foreach ($products as $product) { ?>
        <li>
            <div class="novostroyki-img">
            <?php if ($product['thumb']) { ?>
                <a href="<?php echo $product['href']; ?>"><img src="<?php echo $product['thumb']; ?>" alt="<?php echo $product['name']; ?>"/></a>
            <?php } else { ?>
                <a href="<?php echo $product['href']; ?>"><img src="/catalog/view/theme/default/img/nophoto.png" alt="Нет изображения"/></a>
            <?php } ?>
			
			<?php if($product['badge'] && trim($product['badge'])!='sold'){ ?>
                <?php if(empty($product['price']) || empty($product['rub'])){ ?>
                    <div class="novostroyki-cena">Цена по запросу&nbsp;&nbsp;</div>
				<?php } ?>
				<?php if(!empty($product['price']) || !empty($product['rub'])){ ?>
				<div class="novostroyki-cena">
				<?php if($product['view_price_from'] == 0){ ?>
				        <?php if (!$product['special']) { ?>
                            Цена <?php echo $product['rub'] . '&nbsp;&nbsp;руб.' . '&nbsp;/&nbsp;' . $product['price'] . '&nbsp;&nbsp;$'; ?>
                        <?php } else { ?>
                        <?php if ($product['currency_id'] == 1){ ?>
                            Цена <span class="price-old"><?php echo $product['rub']; ?>  руб.</span> / <span class="price-new"><?php echo $product['special_rub']; ?>  руб.</span>
                        <?php }else{ ?>
                            Цена <span class="price-old"><?php echo $product['price']; ?>  $</span> / <span class="price-new"><?php echo $product['special']; ?>  $</span>
                        <?php } ?>
                        <?php } ?>
				<?php }else if($product['view_price_from'] == 1){ ?>
					    <?php if (!$product['special']) { ?>
                            Цена в месяц от <?php echo $product['rub'] . '&nbsp;&nbsp;руб.' . '&nbsp;/&nbsp;' . $product['price'] . '&nbsp;&nbsp;$'; ?>
                        <?php } else { ?>
                        <?php if ($product['currency_id'] == 1){ ?>
                            Цена в месяц от <span class="price-old"><?php echo $product['rub']; ?>  руб.</span> / <span class="price-new"><?php echo $product['special_rub']; ?>  руб.</span>
                        <?php }else{ ?>
                            Цена в месяц от <span class="price-old"><?php echo $product['price']; ?>  $</span> / <span class="price-new"><?php echo $product['special']; ?>  $</span>
                        <?php } ?>
                        <?php } ?>
				<?php }elseif($product['view_price_from'] == 2){ ?>
						<?php if (!$product['special']) { ?>
                            Цена в сутки от <?php echo $product['rub'] . '&nbsp;&nbsp;руб.' . '&nbsp;/&nbsp;' . $product['price'] . '&nbsp;&nbsp;$'; ?>
                        <?php } else { ?>
                        <?php if ($product['currency_id'] == 1){ ?>
                            Цена в сутки от <span class="price-old"><?php echo $product['rub']; ?>  руб.</span> / <span class="price-new"><?php echo $product['special_rub']; ?>  руб.</span>
                        <?php }else{ ?>
                            Цена в сутки от <span class="price-old"><?php echo $product['price']; ?>  $</span> / <span class="price-new"><?php echo $product['special']; ?>  $</span>
                        <?php } ?>
                        <?php } ?>
				<?php } ?>
				</div>
				<?php } ?>
			<?php }else{ ?>
			    <div class="badge-sold"><img src="/catalog/view/theme/default/images/pr-min.png" alt=""/></div>
			<?php } ?>
			
			<?php if($product['badge'] && trim($product['badge'])=='new'){ ?>
			    <div class="badge-new"><img src="/catalog/view/theme/default/images/new-min.png" alt=""/></div>
			<?php } ?>
			
			<?php if($product['badge'] && trim($product['badge'])=='exclusive'){ ?>
			    <div class="badge-exclusive"><img src="/catalog/view/theme/default/images/ex-min-min.png" alt=""/></div>
			<?php } ?>

			</div>
			
            <a href="<?php echo $product['href']; ?>"><h3><?php echo $product['name']; ?></h3></a>
            <p>
                <?php echo $product['description'] ?>
            </p>
            <!--<a href="<?php echo $product['href']; ?>">Читать описание полностью</a>-->

            <!--<div class="novostroyki-media">
                <?php if ($product['video']): ?>
                <a href="<?php echo $product['video_href']; ?>"><img src="/catalog/view/theme/default/img/Video_play.png" alt=""/></a>
                <?php endif; ?>
                <?php if ($product['thumb']): ?>
                <a href="<?php echo $product['gallery_href']; ?>"><img src="/catalog/view/theme/default/img/images_play.png" alt=""/></a>
               <?php endif; ?>
            </div>-->

        </li>
    
    <?php } ?>
	</div>
  </ul>
  </div>

  <div class="pagination"><?php echo $pagination; ?></div>
  <?php } ?>


  <?php if (!$categories && !$products) { ?>
  <div class="content block-3"><?php echo $text_empty; ?></div>
  <?php } ?>

  <?php if ($description) { ?>
  <div class="description-category-block">
  <h1><?php echo $heading_title; ?></h1>
  <?php if ($quantity_column == 0) { ?>
    <div class="text-col-1">
        <?php echo $description; ?>
    </div>
  <?php }else{ ?>
	<div class="text-col-2">
        <?php echo $description; ?>
    </div>
  <?php } ?>
  </div>
  <?php } ?>
  
  
</div>
</div>

<?php echo $content_bottom; ?>

<?php echo $footer; ?>


<script type="text/javascript"><!--
var jQuery = jQuery.noConflict();
function display(view) {
	if (view == 'list') {
		jQuery('.product-grid').attr('class', 'product-list');
		
		/*jQuery('.product-list > div').each(function(index, element) {
			html  = '<div class="right">';
			html += '  <div class="cart">' + jQuery(element).find('.cart').html() + '</div>';
			html += '  <div class="wishlist">' + jQuery(element).find('.wishlist').html() + '</div>';
			html += '  <div class="compare">' + jQuery(element).find('.compare').html() + '</div>';
			html += '</div>';			
			
			html += '<div class="left">';
			
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
			
			var rating = jQuery(element).find('.rating').html();
			
			if (rating != null) {
				html += '<div class="rating">' + rating + '</div>';
			}
				
			html += '</div>';

						
			jQuery(element).html(html);
		});*/		
		
		jQuery('.display').html('<b><?php echo $text_display; ?></b> <?php echo $text_list; ?> <b>/</b> <a onclick="display(\'grid\');"><?php echo $text_grid; ?></a>');
		
		jQuery.cookie('display', 'list'); 
	} else {
		jQuery('.product-list').attr('class', 'product-grid');
		
		/*jQuery('.product-grid > div').each(function(index, element) {
			html = '';
			
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
		});	*/
					
		jQuery('.display').html('<b><?php echo $text_display; ?></b> <a onclick="display(\'list\');"><?php echo $text_list; ?></a> <b>/</b> <?php echo $text_grid; ?>');
		
		jQuery.cookie('display', 'grid');
	}
}

view = jQuery.cookie('display');

if (view) {
	display(view);
} else {
	display('list');
}
//--></script> 

<script type="text/javascript">
jQuery("div.top-rent-right-text").empty();
jQuery("a[href='http://crimean.estate/index.php?route=product/category&path=94_104']").attr('href', 'http://crimean.estate/exclusive');
jQuery("a[href='http://crimean.estate/index.php?route=product/category&path=105']").attr('href', 'http://crimean.estate/objects_company');
jQuery("a[href='http://crimean.estate/index.php?route=product/category&path=94_102']").attr('href', 'http://crimean.estate/hotels_start');
jQuery("a[href='http://crimean.estate/sale/hotels/']").attr('href', 'http://crimean.estate/hotels_start');


    var docCookies = {
        getItem: function (sKey) {
            if (!sKey) { return null; }
            return decodeURIComponent(document.cookie.replace(new RegExp("(?:(?:^|.*;)\\s*" + encodeURIComponent(sKey).replace(/[\-\.\+\*]/g, "\\$&") + "\\s*\\=\\s*([^;]*).*$)|^.*$"), "$1")) || null;
        },
        setItem: function (sKey, sValue, vEnd, sPath, sDomain, bSecure) {
            if (!sKey || /^(?:expires|max\-age|path|domain|secure)$/i.test(sKey)) { return false; }
            var sExpires = "";
            if (vEnd) {
                switch (vEnd.constructor) {
                    case Number:
                        sExpires = vEnd === Infinity ? "; expires=Fri, 31 Dec 9999 23:59:59 GMT" : "; max-age=" + vEnd;
                        break;
                    case String:
                        sExpires = "; expires=" + vEnd;
                        break;
                    case Date:
                        sExpires = "; expires=" + vEnd.toUTCString();
                        break;
                }
            }
            document.cookie = encodeURIComponent(sKey) + "=" + encodeURIComponent(sValue) + sExpires + (sDomain ? "; domain=" + sDomain : "") + (sPath ? "; path=" + sPath : "") + (bSecure ? "; secure" : "");
            return true;
        },
        removeItem: function (sKey, sPath, sDomain) {
            if (!this.hasItem(sKey)) { return false; }
            document.cookie = encodeURIComponent(sKey) + "=; expires=Thu, 01 Jan 1970 00:00:00 GMT" + (sDomain ? "; domain=" + sDomain : "") + (sPath ? "; path=" + sPath : "");
            return true;
        },
        hasItem: function (sKey) {
            if (!sKey) { return false; }
            return (new RegExp("(?:^|;\\s*)" + encodeURIComponent(sKey).replace(/[\-\.\+\*]/g, "\\$&") + "\\s*\\=")).test(document.cookie);
        },
        keys: function () {
            var aKeys = document.cookie.replace(/((?:^|\s*;)[^\=]+)(?=;|$)|^\s*|\s*(?:\=[^;]*)?(?:\1|$)/g, "").split(/\s*(?:\=[^;]*)?;\s*/);
            for (var nLen = aKeys.length, nIdx = 0; nIdx < nLen; nIdx++) { aKeys[nIdx] = decodeURIComponent(aKeys[nIdx]); }
            return aKeys;
        }
    };

    jQuery(document).ready(function(){
        jQuery('.nav-arenda-grid-line a.nav-arenda-grid').click(function(e){
           e.stopPropagation();
           e.preventDefault();

          jQuery('#grid-line-modifier').removeClass('wiev-line');
            jQuery('.nav-arenda-grid-line a').removeClass('active');
            jQuery(this).addClass('active');

            docCookies.setItem('gridlinevalue','grid', Infinity, '/', '.'+window.location.host);
        });
        jQuery('.nav-arenda-grid-line a.nav-arenda-line').click(function(e){
            e.stopPropagation();
            e.preventDefault();

            jQuery('#grid-line-modifier').addClass('wiev-line');
            jQuery('.nav-arenda-grid-line a').removeClass('active');
            jQuery(this).addClass('active');

            docCookies.setItem('gridlinevalue','line', Infinity, '/', '.'+window.location.host);
        });

        var gridlinevalue = docCookies.getItem('gridlinevalue');
        if (!gridlinevalue || gridlinevalue=='grid') {
            jQuery('.nav-arenda-grid-line a.nav-arenda-grid').addClass('active');
        } else if (gridlinevalue && gridlinevalue=='line') {
            jQuery('.nav-arenda-grid-line a.nav-arenda-line').trigger('click');
        }
    });

    function change_list_sorting() {
        var sorting = jQuery('#select5').val();

        if (sorting == 'price-asc') {
            setSort('sort=p.price&order=ASC');
        } else if (sorting == 'price-desc') {
            setSort('sort=p.price&order=DESC');
        } else {
            setSort('sort=p.sort_order&order=ASC');
        }
    }

    function change_list_limit() {
        var limit = jQuery('#select6').val();
        setLimit(limit);
    }
</script>
<?php echo $header; ?>
<div id="content">
  <div class="breadcrumb">
    <?php foreach ($breadcrumbs as $breadcrumb) { ?>
    <?php echo $breadcrumb['separator']; ?><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a>
    <?php } ?>
  </div>
  <?php if ($error_warning) { ?>
  <div class="warning"><?php echo $error_warning; ?></div>
  <?php } ?>
  <div class="box">
<div class="heading">
      <h1><img src="view/image/product.png" alt="" /> <?php echo $heading_title_product; ?><span class="prodname"></span></h1>
	  <!--Кнопка применить-->
      <!--<div class="buttons"><a onclick="$('#form').submit();" class="button"><?php echo $button_save; ?></a><a onclick="location = '<?php echo $cancel; ?>';" class="button"><?php echo $button_cancel; ?></a></div>-->
      <div class="buttons"><a onclick="sav_form();" class="button"><?php echo $button_save; ?></a><a onclick="sav_con()" class="button"><span><?php echo $button_save_continue; ?></span></a><a onclick="location = '<?php echo $cancel; ?>';" class="button"><?php echo $button_cancel; ?></a></div>
<script language="javascript">
	function sav_form(){
        $('#form').submit();
		
		$.ajax({
			url: 'index.php?route=catalog/product/getSync&token=<?php echo $token; ?>',
			type: 'POST',
			success: function(data) {
			}
		});
		
	}
    function sav_con(){
        $('#form').append('<input type="hidden" id="save_continue" name="save_continue" value="1"  />');

        $('#form').submit();
		
		$.ajax({
			url: 'index.php?route=catalog/product/getSync&token=<?php echo $token; ?>',
			type: 'POST',
			success: function(data) {
			}
		});
    }
</script>
	  <!--Кнопка применить-->
</div>
<!--ION TABS-->
<div class="content">
<form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form">
<div class="ionTabs" id="tabs_1" data-name="Tabs_Group_name">
    <ul class="ionTabs__head">
        <li class="ionTabs__tab" data-target="tab-general"><?php echo $tab_general; ?></li>
        <li class="ionTabs__tab" data-target="tab-data"><?php echo $tab_data; ?></li>
        <li class="ionTabs__tab" data-target="tab-links"><?php echo $tab_links; ?></li>
		<li class="ionTabs__tab" data-target="tab-attribute"><?php echo $tab_attribute; ?></li>
		<li class="ionTabs__tab" data-target="tab-option"><?php echo $tab_option; ?></li>
        <li class="ionTabs__tab" data-target="tab-special"><?php echo $tab_special; ?></li>
		<li class="ionTabs__tab" data-target="tab-interior">Интерьер</li>
		<li class="ionTabs__tab" data-target="tab-exterior">Экстерьер</li>
		<li class="ionTabs__tab" data-target="tab-more">Дополнительно</li>
		<!--<li class="ionTabs__tab" data-target="tab-image"><?php echo $tab_image; ?></li>-->
		<li class="ionTabs__tab" data-target="tab-video">Видео</li>
		<li class="ionTabs__tab" data-target="tab-plan">Планировки</li>
		<li class="ionTabs__tab" data-target="tab-design"><?php echo $tab_design; ?></li>
    </ul>
    <div class="ionTabs__body">

        <div class="ionTabs__item" data-name="tab-general">
          <div id="languages" class="htabs">
            <?php foreach ($languages as $language) { ?>
            <a href="#language<?php echo $language['language_id']; ?>"><img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" /> <?php echo $language['name']; ?></a>
            <?php } ?>
          </div>
          <?php foreach ($languages as $language) { ?>
          <div id="language<?php echo $language['language_id']; ?>">
            <table class="form">
              <tr>
                <td><span class="required">*</span> <?php echo $entry_name; ?></td>
                <td><input type="text" name="product_description[<?php echo $language['language_id']; ?>][name]" maxlength="255" size="100" value="<?php echo isset($product_description[$language['language_id']]) ? $product_description[$language['language_id']]['name'] : ''; ?>" />
                  <?php if (isset($error_name[$language['language_id']])) { ?>
                  <span class="error"><?php echo $error_name[$language['language_id']]; ?></span>
                  <?php } ?></td>
              </tr>
              <tr>
                <td><?php echo $entry_seo_h1; ?></td>
                <td><input type="text" name="product_description[<?php echo $language['language_id']; ?>][seo_h1]" maxlength="255" size="100" value="<?php echo isset($product_description[$language['language_id']]) ? $product_description[$language['language_id']]['seo_h1'] : ''; ?>" /></td>
              </tr>
              <tr>
                <td><?php echo $entry_seo_title; ?></td>
                <td><input type="text" name="product_description[<?php echo $language['language_id']; ?>][seo_title]" maxlength="255" size="100" value="<?php echo isset($product_description[$language['language_id']]) ? $product_description[$language['language_id']]['seo_title'] : ''; ?>" /></td>
              </tr>
              <tr>
                <td><?php echo $entry_meta_keyword; ?></td>
                <td><input type="text" name="product_description[<?php echo $language['language_id']; ?>][meta_keyword]" maxlength="255" size="100" value="<?php echo isset($product_description[$language['language_id']]) ? $product_description[$language['language_id']]['meta_keyword'] : ''; ?>" /></td>
              </tr>
              <tr>
                <td><?php echo $entry_meta_description; ?></td>
                <td><textarea name="product_description[<?php echo $language['language_id']; ?>][meta_description]" cols="100" rows="2"><?php echo isset($product_description[$language['language_id']]) ? $product_description[$language['language_id']]['meta_description'] : ''; ?></textarea></td>
              </tr>
              <tr>
                <td><?php echo $entry_description; ?></td>
                <td><textarea name="product_description[<?php echo $language['language_id']; ?>][description]" id="description<?php echo $language['language_id']; ?>"><?php echo isset($product_description[$language['language_id']]) ? $product_description[$language['language_id']]['description'] : ''; ?></textarea></td>
              </tr>
              <tr>
                <td>Теги обьекта:<br><span class="help">разделяются запятой</span></td>
                <td><input type="text" name="product_description[<?php echo $language['language_id']; ?>][tag]" value="<?php echo isset($product_description[$language['language_id']]) ? $product_description[$language['language_id']]['tag'] : ''; ?>" size="80" /></td>
              </tr>
            </table>
          </div>
          <?php } ?>
        </div>
        <div class="ionTabs__item" data-name="tab-data">
          <table class="form">
            <tr>
              <td><span class="required">*</span> <?php echo $entry_model; ?></td>
              <td width="200"><input type="text" id="model" name="model" value="<?php echo $model; ?>" />
			                  <input type="hidden" id="product_id" value="<?php echo $product_id; ?>" />
                <?php if ($error_model) { ?>
                <span class="error"><?php echo $error_model; ?></span>
                <?php } ?></td>
            </tr>
            <tr>
                <td>Выбрать Агента</td>
                <td><select name="agent" <?php if ($user_group_id!=1 && !empty($agent)) echo 'disabled="disabled"' ?>>
                        <?php foreach ($agents as $agentInfo) { ?>
                        <?php if ($agentInfo['user_id'] == $agent) { ?>
                        <option value="<?php echo $agentInfo['user_id'] ; ?>" selected="selected"><?php echo $agentInfo['firstname'].' '.$agentInfo['lastname']; ?></option>
                        <?php } else { ?>
                        <option value="<?php echo $agentInfo['user_id'] ; ?>"><?php echo $agentInfo['firstname'].' '.$agentInfo['lastname']; ?></option>
                        <?php } ?>
                        <?php } ?>
                    </select>
                    <?php if ($user_group_id!=1 && !empty($agent)): ?>
                    <input name="agent" type="hidden" value="<?php echo $agent ; ?>" />
                    <?php endif; ?>
                </td>
            </tr>
			<input type="hidden" name="sku" value="" />
            <!--<tr>
              <td><?php echo $entry_sku; ?></td>
              <td><input type="text" name="sku" value="<?php echo $sku; ?>" /></td>
            </tr>-->
            <tr>
              <td><?php echo $entry_upc; ?></td>
              <td><!--<input type="text" name="upc" value="<?php echo $upc; ?>" />-->
			<select name="upc" style="width: 192px;">
			<?php foreach($badge_value as $value => $name){?>
			<?php if($value == $view_badge){ ?>
                <option value="<?php echo $value; ?>" selected="selected"><?php echo $name; ?></option>
			<?php }else{ ?>
			    <option value="<?php echo $value; ?>"><?php echo $name; ?></option>
			<?php } ?>
			<?php } ?>
            </select>
			  </td>
            </tr>
            <tr>
              <td><?php echo $entry_ean; ?></td>
              <td>
			  <input type="text" name="ean" value="<?php echo $ean; ?>" /> *Для пользования маркером поле Yandex-карта должно быть пустым!</td>
            </tr>
			            <tr>
              <td><?php echo $entry_lat_lng; ?></td>
              <td>
			  <script src="http://api-maps.yandex.ru/2.0/?load=package.full&lang=ru-RU" type="text/javascript"></script>
<script type="text/javascript">
 
	var myMap, myPlacemark, coords;
 
	ymaps.ready(init);
 
        function init () {
 
		//Определяем начальные параметры карты
            myMap = new ymaps.Map('YMapsID', {
                    center: [<?php if(!empty($lat_lng)){ ?><?php echo $lat_lng; ?><?php }else{ echo '56.326944, 44.0075'; } ?>], 
                    zoom: 15
                });	
 
			//Определяем элемент управления поиск по карте	
			var SearchControl = new ymaps.control.SearchControl({noPlacemark:true});	
 
			//Добавляем элементы управления на карту
			 myMap.controls
				.add(SearchControl)                
                .add('zoomControl')                
                .add('typeSelector')                 
                .add('mapTools');
 
			coords = [<?php if(!empty($lat_lng)){ ?><?php echo $lat_lng; ?><?php }else{ echo '56.326944, 44.0075'; } ?>];
 
			//Определяем метку и добавляем ее на карту				
			myPlacemark = new ymaps.Placemark([<?php if(!empty($lat_lng)){ ?><?php echo $lat_lng; ?><?php }else{ echo '56.326944, 44.0075'; } ?>],{}, {preset: "twirl#redIcon", draggable: true});	
 
			myMap.geoObjects.add(myPlacemark);			
 
			//Отслеживаем событие перемещения метки
			myPlacemark.events.add("dragend", function (e) {			
			coords = this.geometry.getCoordinates();
			savecoordinats();
			}, myPlacemark);
 
			//Отслеживаем событие щелчка по карте
			myMap.events.add('click', function (e) {        
            coords = e.get('coordPosition');
			savecoordinats();
			});	
 
	//Отслеживаем событие выбора результата поиска
	SearchControl.events.add("resultselect", function (e) {
		coords = SearchControl.getResultsArray()[0].geometry.getCoordinates();
		savecoordinats();
	});
 
	//Ослеживаем событие изменения области просмотра карты - масштаб и центр карты
	myMap.events.add('boundschange', function (event) {
    if (event.get('newZoom') != event.get('oldZoom')) {		
        savecoordinats();
    }
	  if (event.get('newCenter') != event.get('oldCenter')) {		
        savecoordinats();
    }
 
	});
 
    }
 
	//Функция для передачи полученных значений в форму
	function savecoordinats (){	
		var new_coords = [coords[0].toFixed(4), coords[1].toFixed(4)];	
		myPlacemark.getOverlay().getData().geometry.setCoordinates(new_coords);
		document.getElementById("latlongmet").value = new_coords;
		//document.getElementById("mapzoom").value = myMap.getZoom();
		//var center = myMap.getCenter();
		//var new_center = [center[0].toFixed(4), center[1].toFixed(4)];	
		//document.getElementById("latlongcenter").value = new_center;	
	}
 
</script>
<div id="YMapsID" style="width:1170px; height:400px"></div>
			  
			  <input type="text" id="latlongmet" name="lat_lng" value="<?php echo $lat_lng; ?>" />*Маркер нельзя устанавливать на водоемы, поиск работает только по суше!</td>
            </tr>
            <tr>
            <tr>
              <td><?php echo $entry_price; ?></td>
              <td>
			<select name="price_from" style="width: 192px;">
			<?php foreach($price_array as $value => $name){?>
			<?php if($value == $view_price_from){ ?>
                <option value="<?php echo $value; ?>" selected="selected"><?php echo $name; ?></option>
			<?php }else{ ?>
			    <option value="<?php echo $value; ?>"><?php echo $name; ?></option>
			<?php } ?>
			<?php } ?>
            </select>
			<!--<select name="tax_class_id" id="input-tax-class" class="form-control">
            <option value="0"><?php echo $text_none; ?></option>
            <?php foreach ($tax_classes as $tax_class) { ?>
            <?php if ($tax_class['tax_class_id'] == $tax_class_id) { ?>
            <option value="<?php echo $tax_class['tax_class_id']; ?>" selected="selected"><?php echo $tax_class['title']; ?></option>
            <?php } else { ?>
            <option value="<?php echo $tax_class['tax_class_id']; ?>"><?php echo $tax_class['title']; ?></option>
            <?php } ?>
            <?php } ?>
            </select>-->
			<input type="text" name="price" value="<?php echo $price; ?>" />
			  </td>
            </tr>
                  <td>Валюта</td>
                  <td>
                      <select name="currency">
                      <?php foreach ($currencies as $_currency): ?>
                        <?php if ($_currency['currency_id']==$currency): ?>
                              <option value="<?php echo $_currency['currency_id'] ?>" selected><?php echo $_currency['title'] ?></option>
                        <?php else: ?>
                              <option value="<?php echo $_currency['currency_id'] ?>"><?php echo $_currency['title'] ?></option>
                        <?php endif; ?>
                        <?php endforeach; ?>
                          </select>
                  </td>
              </tr>
            <tr>
              <td><?php echo $entry_quantity; ?></td>
              <td><input type="text" name="quantity" value="<?php echo $quantity; ?>" size="2" /></td>
            </tr>
			<input type="hidden" name="subtract" value="0" />
            <!--<tr>
              <td><?php echo $entry_subtract; ?></td>
              <td><select name="subtract">
                  <?php if ($subtract) { ?>
                  <option value="1" selected="selected"><?php echo $text_yes; ?></option>
                  <option value="0"><?php echo $text_no; ?></option>
                  <?php } else { ?>
                  <option value="1"><?php echo $text_yes; ?></option>
                  <option value="0" selected="selected"><?php echo $text_no; ?></option>
                  <?php } ?>
                </select></td>
            </tr>-->
            <tr>
              <td><?php echo $entry_keyword; ?></td>
              <td><input type="text" name="keyword" value="<?php echo $keyword; ?>" /></td>
            </tr>
            <tr>
              <td>Изображение обьекта</td>
              <td><div class="image"><img src="<?php echo $thumb; ?>" alt="" id="thumb" /><br />
                  <input type="hidden" name="image" value="<?php echo $image; ?>" id="image" />
                  <a onclick="image_upload('image', 'thumb');"><?php echo $text_browse; ?></a>&nbsp;&nbsp;|&nbsp;&nbsp;<a onclick="$('#thumb').attr('src', '<?php echo $no_image; ?>'); $('#image').attr('value', '');"><?php echo $text_clear; ?></a></div></td>
			</tr>
            <tr>
              <td><?php echo $entry_date_available; ?></td>
              <td><input type="text" name="date_available" value="<?php echo $date_available; ?>" size="12" class="date" /></td>
            </tr>
            <tr>
              <td><?php echo $entry_status; ?></td>
              <td><select name="status">
                  <?php if ($status) { ?>
                  <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                  <option value="0"><?php echo $text_disabled; ?></option>
                  <?php } else { ?>
                  <option value="1"><?php echo $text_enabled; ?></option>
                  <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                  <?php } ?>
                </select></td>
            </tr>
			<input type="hidden" name="length" value="0" />
            <input type="hidden" name="width" value="0" />
            <input type="hidden" name="height" value="0" />
            <!--<tr>
              <td><?php echo $entry_dimension; ?></td>
              <td><input type="text" name="length" value="<?php echo $length; ?>" size="4" />
                <input type="text" name="width" value="<?php echo $width; ?>" size="4" />
                <input type="text" name="height" value="<?php echo $height; ?>" size="4" /></td>
            </tr>-->
            <tr>
              <td>Единица измерения:</td>
              <td><select name="length_class_id">
                  <?php foreach ($length_classes as $length_class) { ?>
                  <?php if ($length_class['length_class_id'] == $length_class_id) { ?>
                  <option value="<?php echo $length_class['length_class_id']; ?>" selected="selected"><?php echo $length_class['title']; ?></option>
                  <?php } else { ?>
                  <option value="<?php echo $length_class['length_class_id']; ?>"><?php echo $length_class['title']; ?></option>
                  <?php } ?>
                  <?php } ?>
                </select></td>
            </tr>
            <tr>
              <td><?php echo $entry_sort_order; ?></td>
              <td><input type="text" name="sort_order" value="<?php echo $sort_order; ?>" size="2" /></td>
            </tr>
          </table>
        </div>
       <div class="ionTabs__item" data-name="tab-links">
          <table class="form">
            <tr>
              <td><?php echo $entry_manufacturer; ?></td>
              <td width="1"><select name="manufacturer_id">
                  <option value="0" selected="selected"><?php echo $text_none; ?></option>
                  <?php foreach ($manufacturers as $manufacturer) { ?>
                  <?php if ($manufacturer['manufacturer_id'] == $manufacturer_id) { ?>
                  <option value="<?php echo $manufacturer['manufacturer_id']; ?>" selected="selected"><?php echo $manufacturer['name']; ?></option>
                  <?php } else { ?>
                  <option value="<?php echo $manufacturer['manufacturer_id']; ?>"><?php echo $manufacturer['name']; ?></option>
                  <?php } ?>
                  <?php } ?>
                </select></td>
			  <td><?php echo $info_manufacturer; ?></td>
            </tr>
            <tr>
              <td><?php echo $entry_main_category; ?></td>
              <td><select name="main_category_id">
                <option value="0" selected="selected"><?php echo $text_none; ?></option>
                <?php foreach ($categories as $category) { ?>
                <?php if ($category['category_id'] == $main_category_id) { ?>
                <option value="<?php echo $category['category_id']; ?>" selected="selected"><?php echo $category['name']; ?></option>
                <?php } else { ?>
                <option value="<?php echo $category['category_id']; ?>"><?php echo $category['name']; ?></option>
                <?php } ?>
                <?php } ?>
              </select></td>
			  <td><?php echo $info_main_category; ?></td>
            </tr>
            <tr>
              <td><?php echo $entry_category; ?></td>
              <td><div class="scrollbox">
                  <?php $class = 'odd'; ?>
                  <?php foreach ($categories as $category) { ?>
                  <?php $class = ($class == 'even' ? 'odd' : 'even'); ?>
                  <div class="<?php echo $class; ?>">
                    <?php if (in_array($category['category_id'], $product_category)) { ?>
                    <input type="checkbox" name="product_category[]" value="<?php echo $category['category_id']; ?>" checked="checked" />
                    <?php echo $category['name']; ?>
                    <?php } else { ?>
                    <input type="checkbox" name="product_category[]" value="<?php echo $category['category_id']; ?>" />
                    <?php echo $category['name']; ?>
                    <?php } ?>
                  </div>
                  <?php } ?>
                </div>
                <a onclick="$(this).parent().find(':checkbox').attr('checked', true);"><?php echo $text_select_all; ?></a> / <a onclick="$(this).parent().find(':checkbox').attr('checked', false);"><?php echo $text_unselect_all; ?></a></td>
               <td><?php echo $info_category; ?></td>
			</tr>
			<tr>
              <td>Обьект компании:</td>
				<td>
			<select name="product_company">
			<?php foreach($product_company_value as $value => $name){?>
			<?php if($value == $product_company_active){ ?>
                <option value="<?php echo $value; ?>" selected="selected"><?php echo $name; ?></option>
			<?php }else{ ?>
			    <option value="<?php echo $value; ?>"><?php echo $name; ?></option>
			<?php } ?>
			<?php } ?>
            </select>
				</td>
			</tr>
            <tr>
              <td><?php echo $entry_store; ?></td>
              <td><div class="scrollbox">
                  <?php $class = 'even'; ?>
                  <div class="<?php echo $class; ?>">
                    <?php if (in_array(0, $product_store)) { ?>
                    <input type="checkbox" name="product_store[]" value="0" checked="checked" />
                    <?php echo $text_default; ?>
                    <?php } else { ?>
                    <input type="checkbox" name="product_store[]" value="0" />
                    <?php echo $text_default; ?>
                    <?php } ?>
                  </div>
                  <?php foreach ($stores as $store) { ?>
                  <?php $class = ($class == 'even' ? 'odd' : 'even'); ?>
                  <div class="<?php echo $class; ?>">
                    <?php if (in_array($store['store_id'], $product_store)) { ?>
                    <input type="checkbox" name="product_store[]" value="<?php echo $store['store_id']; ?>" checked="checked" />
                    <?php echo $store['name']; ?>
                    <?php } else { ?>
                    <input type="checkbox" name="product_store[]" value="<?php echo $store['store_id']; ?>" />
                    <?php echo $store['name']; ?>
                    <?php } ?>
                  </div>
                  <?php } ?>
                </div></td>
            </tr>
            <tr>
              <td><?php echo $entry_download; ?></td>
              <td><div class="scrollbox">
                  <?php $class = 'odd'; ?>
                  <?php foreach ($downloads as $download) { ?>
                  <?php $class = ($class == 'even' ? 'odd' : 'even'); ?>
                  <div class="<?php echo $class; ?>">
                    <?php if (in_array($download['download_id'], $product_download)) { ?>
                    <input type="checkbox" name="product_download[]" value="<?php echo $download['download_id']; ?>" checked="checked" />
                    <?php echo $download['name']; ?>
                    <?php } else { ?>
                    <input type="checkbox" name="product_download[]" value="<?php echo $download['download_id']; ?>" />
                    <?php echo $download['name']; ?>
                    <?php } ?>
                  </div>
                  <?php } ?>
                </div></td>
			  <td><?php echo $info_download; ?></td>
            </tr>
		  </table>
		  <table class="form">
            <tr>
              <td>Похожие товары:</td>
              <td>
			    <table>
                  <tr>
                    <td style="padding: 0;" colspan="3"><select id="category" style="margin-bottom: 5px;" onchange="getProducts();">
                      <?php foreach ($categories as $category) { ?>
                      <option value="<?php echo $category['category_id']; ?>"><?php echo $category['name']; ?></option>
                      <?php } ?>
                    </select></td>
                  </tr>
                  <tr>
                    <td style="padding: 0;"><select multiple="multiple" id="product" size="10" style="width: 350px;">
                      </select></td>
                    <td style="vertical-align: middle;"><input type="button" value=">>" onclick="addRelated();" />
                      <br />
                      <input type="button" value="<<" onclick="removeRelated();" /></td>
                    <td style="padding: 0;"><select multiple="multiple" id="related" size="10" style="width: 350px;">
                      </select></td>
					<td> Похожие обьекты</td>
                  </tr>
                </table>
                <div id="product_related">
			      <?php if($product_related){?>
					<?php foreach ($product_related as $related_id) { ?>
					  <input type="hidden" name="product_related[]" value="<?php echo $related_id; ?>" />
					<?php } ?>
				  <?php }else{ ?>
				    <?php echo $info_related_no; ?>
				  <?php } ?>
                </div>
			  </td>
            </tr>
          </table>
        </div>
        <div class="ionTabs__item" data-name="tab-attribute">
          <table id="attribute" class="list">
            <thead>
              <tr>
                <td class="left"><?php echo $entry_attribute; ?> <?php echo $info_attribute; ?></td>
                <td class="left"><?php echo $entry_text; ?></td>
                <td></td>
              </tr>
            </thead>
            <?php $attribute_row = 0; ?>
            <?php foreach ($product_attributes as $product_attribute) { ?>
            <tbody id="attribute-row<?php echo $attribute_row; ?>">
              <tr>
                <td class="left"><input type="text" name="product_attribute[<?php echo $attribute_row; ?>][name]" value="<?php echo $product_attribute['name']; ?>" />
                  <input type="hidden" name="product_attribute[<?php echo $attribute_row; ?>][attribute_id]" value="<?php echo $product_attribute['attribute_id']; ?>" />
				</td>
                <td class="left"><?php foreach ($languages as $language) { ?>
                  <textarea name="product_attribute[<?php echo $attribute_row; ?>][product_attribute_description][<?php echo $language['language_id']; ?>][text]" cols="40" rows="5"><?php echo isset($product_attribute['product_attribute_description'][$language['language_id']]) ? $product_attribute['product_attribute_description'][$language['language_id']]['text'] : ''; ?></textarea>
                  <img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" align="top" /><br />
                  <?php } ?></td>
                <td class="left"><a onclick="$('#attribute-row<?php echo $attribute_row; ?>').remove();" class="button"><?php echo $button_remove; ?></a></td>
              </tr>
            </tbody>
            <?php $attribute_row++; ?>
            <?php } ?>
            <tfoot>
              <tr>
                <td colspan="2"></td>
                <td class="left"><a onclick="addAttribute();" class="button"><?php echo $button_add_attribute; ?></a></td>
              </tr>
            </tfoot>
          </table>
        </div>
		<div class="ionTabs__item" data-name="tab-option">
        <div id="tab-option">
          <div id="vtab-option" class="vtabs">
		    <!--Выбор основных опций объекта-->
		    <select name="main_option_value" style="width: 192px;">
                <option value="0">Не вабрано</option>
                <option value="1">Основные опции для вилл</option>
				<option value="2">Основные опции для таунхаусов</option>
				<option value="3">Основные опции для апартаментов</option>
				<option value="4">Основные опции для зем. участков</option>
				<option value="5">Основные опции для коммерч. недвиж</option>
				<option value="6">Основные опции для дома</option>
				<option value="7">Основные опции для квартиры</option>
            </select>
		    <!--Выбор основных опций объекта-->
            <?php $option_row = 0; ?>
            <?php foreach ($product_options as $product_option) { ?>
            <a href="#tab-option-<?php echo $option_row; ?>" id="option-<?php echo $option_row; ?>"><?php echo $product_option['name']; ?>&nbsp;<img src="view/image/delete.png" alt="" onclick="$('#vtabs a:first').trigger('click'); $('#option-<?php echo $option_row; ?>').remove(); $('#tab-option-<?php echo $option_row; ?>').remove(); return false;" /></a>
            <?php $option_row++; ?>
            <?php } ?>
            <span id="option-add">
            <input name="option" value="" style="width: 130px;" />
            &nbsp;<img src="view/image/add.png" alt="<?php echo $button_add_option; ?>" title="<?php echo $button_add_option; ?>" /></span></div>
          <?php $option_row = 0; ?>
          <?php $option_value_row = 0; ?>
          <?php foreach ($product_options as $product_option) { ?>
		  <div class="optionname"><?php echo $product_option['name']; ?></div>
          <div id="tab-option-<?php echo $option_row; ?>" class="vtabs-content">
            <input type="hidden" name="product_option[<?php echo $option_row; ?>][product_option_id]" value="<?php echo $product_option['product_option_id']; ?>" />
            <input type="hidden" name="product_option[<?php echo $option_row; ?>][name]" value="<?php echo $product_option['name']; ?>" />
            <input type="hidden" name="product_option[<?php echo $option_row; ?>][option_id]" value="<?php echo $product_option['option_id']; ?>" />
            <input type="hidden" name="product_option[<?php echo $option_row; ?>][type]" value="<?php echo $product_option['type']; ?>" />
		  </div>
		<div class="vtabs-content">
            <table class="form">
              <tr>
                <td><?php echo $entry_required; ?></td>
                <td><select name="product_option[<?php echo $option_row; ?>][required]">
                    <?php if ($product_option['required']) { ?>
                    <option value="1" selected="selected"><?php echo $text_yes; ?></option>
                    <option value="0"><?php echo $text_no; ?></option>
                    <?php } else { ?>
                    <option value="1"><?php echo $text_yes; ?></option>
                    <option value="0" selected="selected"><?php echo $text_no; ?></option>
                    <?php } ?>
                  </select></td>
              </tr>
			  <tr>
                <td>Сортировка</td>
                <td><input type="text" name="product_option[<?php echo $option_row; ?>][product_sort_option_id]" value="<?php echo $product_option['product_sort_option_id']; ?>" /></td>
              </tr>
              <?php if ($product_option['type'] == 'text') { ?>
              <tr>
                <td><?php echo $entry_option_value; ?></td>
                <td><input type="text" name="product_option[<?php echo $option_row; ?>][option_value]" value="<?php echo $product_option['option_value']; ?>" /></td>
              </tr>
              <?php } ?>
              <?php if ($product_option['type'] == 'textarea') { ?>
              <tr>
                <td><?php echo $entry_option_value; ?></td>
                <td><textarea name="product_option[<?php echo $option_row; ?>][option_value]" cols="40" rows="5"><?php echo $product_option['option_value']; ?></textarea></td>
              </tr>
              <?php } ?>
              <?php if ($product_option['type'] == 'file') { ?>
              <tr>
                <td><?php echo $entry_option_value; ?></td>
                <td><input type="text" name="product_option[<?php echo $option_row; ?>][option_value]" value="<?php echo $product_option['option_value']; ?>" /></td>
              </tr>
              <?php } ?>
              <?php if ($product_option['type'] == 'date') { ?>
              <tr>
                <td><?php echo $entry_option_value; ?></td>
                <td><input type="text" name="product_option[<?php echo $option_row; ?>][option_value]" value="<?php echo $product_option['option_value']; ?>" class="date" /></td>
              </tr>
              <?php } ?>
              <?php if ($product_option['type'] == 'datetime') { ?>
              <tr>
                <td><?php echo $entry_option_value; ?></td>
                <td><input type="text" name="product_option[<?php echo $option_row; ?>][option_value]" value="<?php echo $product_option['option_value']; ?>" class="datetime" /></td>
              </tr>
              <?php } ?>
              <?php if ($product_option['type'] == 'time') { ?>
              <tr>
                <td><?php echo $entry_option_value; ?></td>
                <td><input type="text" name="product_option[<?php echo $option_row; ?>][option_value]" value="<?php echo $product_option['option_value']; ?>" class="time" /></td>
              </tr>
              <?php } ?>
            </table>
            <?php if ($product_option['type'] == 'select' || $product_option['type'] == 'radio' || $product_option['type'] == 'checkbox' || $product_option['type'] == 'image') { ?>
            <table id="option-value<?php echo $option_row; ?>" class="list">
              <thead>
                <tr>
                  <td class="left"><?php echo $entry_option_value; ?></td>
                  <!--<td class="right"></td>
                  <td class="left"></td>
                  <td class="right"></td>
                  <td class="right"></td>
                  <td class="right"></td>-->
                  <td></td>
                </tr>
              </thead>
              <?php foreach ($product_option['product_option_value'] as $product_option_value) { ?>
              <tbody id="option-value-row<?php echo $option_value_row; ?>">
                <tr>
                  <td class="left"><select name="product_option[<?php echo $option_row; ?>][product_option_value][<?php echo $option_value_row; ?>][option_value_id]">
                      <?php if (isset($option_values[$product_option['option_id']])) { ?>
                      <?php foreach ($option_values[$product_option['option_id']] as $option_value) { ?>
                      <?php if ($option_value['option_value_id'] == $product_option_value['option_value_id']) { ?>
                      <option value="<?php echo $option_value['option_value_id']; ?>" selected="selected"><?php echo $option_value['name']; ?></option>
                      <?php } else { ?>
                      <option value="<?php echo $option_value['option_value_id']; ?>"><?php echo $option_value['name']; ?></option>
                      <?php } ?>
                      <?php } ?>
                      <?php } ?>
                    </select>
                    <input type="hidden" name="product_option[<?php echo $option_row; ?>][product_option_value][<?php echo $option_value_row; ?>][product_option_value_id]" value="<?php echo $product_option_value['product_option_value_id']; ?>" /></td>
                  <!--<td class="right"></td>
                  <td class="left"></td>
                  <td class="right"></td>
                  <td class="right"></td>
                  <td class="right"></td>-->
                  <td class="left"><a onclick="$('#option-value-row<?php echo $option_value_row; ?>').remove();" class="button"><?php echo $button_remove; ?></a></td>
                </tr>
              </tbody>
              <?php $option_value_row++; ?>
              <?php } ?>
              <tfoot>
                <tr>
                  <td></td>
                  <td class="left"><a onclick="addOptionValue('<?php echo $option_row; ?>');" class="button"><?php echo $button_add_option_value; ?></a></td>
                </tr>
              </tfoot>
            </table>
            <select id="option-values<?php echo $option_row; ?>" style="display:none;">
              <?php if (isset($option_values[$product_option['option_id']])) { ?>
              <?php foreach ($option_values[$product_option['option_id']] as $option_value) { ?>
              <option value="<?php echo $option_value['option_value_id']; ?>"><?php echo $option_value['name']; ?></option>
              <?php } ?>
              <?php } ?>
            </select>
            <?php } ?>
        </div>
          <?php $option_row++; ?>
          <?php } ?>
        </div>
		</div>
        <div class="ionTabs__item" data-name="tab-special">
          <table id="special" class="list">
            <thead>
              <tr>
                <td class="left"><?php echo $entry_customer_group; ?></td>
                <td class="right"><?php echo $entry_priority; ?></td>
                <td class="right"><?php echo $entry_price; ?></td>
                <td class="left"><?php echo $entry_date_start; ?></td>
                <td class="left"><?php echo $entry_date_end; ?></td>
                <td></td>
              </tr>
            </thead>
            <?php $special_row = 0; ?>
            <?php foreach ($product_specials as $product_special) { ?>
            <tbody id="special-row<?php echo $special_row; ?>">
              <tr>
                <td class="left"><select name="product_special[<?php echo $special_row; ?>][customer_group_id]">
                    <?php foreach ($customer_groups as $customer_group) { ?>
                    <?php if ($customer_group['customer_group_id'] == $product_special['customer_group_id']) { ?>
                    <option value="<?php echo $customer_group['customer_group_id']; ?>" selected="selected"><?php echo $customer_group['name']; ?></option>
                    <?php } else { ?>
                    <option value="<?php echo $customer_group['customer_group_id']; ?>"><?php echo $customer_group['name']; ?></option>
                    <?php } ?>
                    <?php } ?>
                  </select></td>
                <td class="right"><input type="text" name="product_special[<?php echo $special_row; ?>][priority]" value="<?php echo $product_special['priority']; ?>" size="2" /></td>
                <td class="right"><input type="text" name="product_special[<?php echo $special_row; ?>][price]" value="<?php echo $product_special['price']; ?>" /></td>
                <td class="left"><input type="text" name="product_special[<?php echo $special_row; ?>][date_start]" value="<?php echo $product_special['date_start']; ?>" class="date" /></td>
                <td class="left"><input type="text" name="product_special[<?php echo $special_row; ?>][date_end]" value="<?php echo $product_special['date_end']; ?>" class="date" /></td>
                <td class="left"><a onclick="$('#special-row<?php echo $special_row; ?>').remove();" class="button"><?php echo $button_remove; ?></a></td>
              </tr>
            </tbody>
            <?php $special_row++; ?>
            <?php } ?>
            <tfoot>
              <tr>
                <td colspan="5"></td>
                <td class="left"><a onclick="addSpecial();" class="button"><?php echo $button_add_special; ?></a></td>
              </tr>
            </tfoot>
          </table>
        </div>
		
		<div class="ionTabs__item" data-name="tab-interior">
          <table id="interior" class="list">
            <thead>
              <tr>
			    <td></td>
                <td class="left">Изображения обьекта</td>
                <td class="right"><?php echo $entry_sort_order; ?></td>
                <td></td>
              </tr>
            </thead>
            <?php $interior_image_row = 0; ?>
            <?php foreach ($product_images_interior as $product_image_interior) { ?>
            <tbody id="interior-image-row<?php echo $interior_image_row; ?>">
              <tr class="fa-move">
			    <td><i class="fa fa-bars"></i></td>
                <td class="left"><div class="image"><img src="<?php echo $product_image_interior['thumb']; ?>" alt="" id="interior-thumb<?php echo $interior_image_row; ?>" />
                    <input type="hidden" name="product_image_interior[<?php echo $interior_image_row; ?>][image]" value="<?php echo $product_image_interior['image']; ?>" id="interior-image<?php echo $interior_image_row; ?>" />
                    <br />
                    <a onclick="image_upload('interior-image<?php echo $interior_image_row; ?>', 'interior-thumb<?php echo $interior_image_row; ?>');"><?php echo $text_browse; ?></a>&nbsp;&nbsp;|&nbsp;&nbsp;<a onclick="$('#interior-thumb<?php echo $interior_image_row; ?>').attr('src', '<?php echo $no_image; ?>'); $('#interior-image<?php echo $interior_image_row; ?>').attr('value', '');"><?php echo $text_clear; ?></a></div></td>
                <td class="right"><input type="text" name="product_image_interior[<?php echo $interior_image_row; ?>][sort_order]" value="<?php echo $product_image_interior['sort_order']; ?>" size="2" /></td>
                <td class="left"><a onclick="$('#interior-image-row<?php echo $interior_image_row; ?>').remove();" class="button"><?php echo $button_remove; ?></a></td>
              </tr>
            </tbody>
            <?php $interior_image_row++; ?>
            <?php } ?>
            <tfoot>
              <tr>
                <td colspan="3"></td>
                <td class="left"><a onclick="addImageInterior();" class="button"><?php echo $button_add_image; ?></a></br>
				                <a onclick="addAllImageInterior();" id="click_interior" class="button">Добавить все изображения из папки</a>
								<div id="error_interior"></div>	
				</td>
              </tr>
            </tfoot>
          </table>
        </div>
		
	    <div class="ionTabs__item" data-name="tab-exterior">
          <table id="exterior" class="list">
            <thead>
              <tr>
			    <td></td>
                <td class="left">Изображения обьекта</td>
                <td class="right"><?php echo $entry_sort_order; ?></td>
                <td></td>
              </tr>
            </thead>
            <?php $exterior_image_row = 0; ?>
            <?php foreach ($product_images_exterior as $product_image_exterior) { ?>
            <tbody id="exterior-image-row<?php echo $exterior_image_row; ?>">
              <tr class="fa-move">
			    <td><i class="fa fa-bars"></i></td>
                <td class="left"><div class="image"><img src="<?php echo $product_image_exterior['thumb']; ?>" alt="" id="exterior-thumb<?php echo $exterior_image_row; ?>" />
                    <input type="hidden" name="product_image_exterior[<?php echo $exterior_image_row; ?>][image]" value="<?php echo $product_image_exterior['image']; ?>" id="exterior-image<?php echo $exterior_image_row; ?>" />
                    <br />
                    <a onclick="image_upload('exterior-image<?php echo $exterior_image_row; ?>', 'exterior-thumb<?php echo $exterior_image_row; ?>');"><?php echo $text_browse; ?></a>&nbsp;&nbsp;|&nbsp;&nbsp;<a onclick="$('#exterior-thumb<?php echo $exterior_image_row; ?>').attr('src', '<?php echo $no_image; ?>'); $('#exterior-image<?php echo $exterior_image_row; ?>').attr('value', '');"><?php echo $text_clear; ?></a></div></td>
                <td class="right"><input type="text" name="product_image_exterior[<?php echo $exterior_image_row; ?>][sort_order]" value="<?php echo $product_image_exterior['sort_order']; ?>" size="2" /></td>
                <td class="left"><a onclick="$('#exterior-image-row<?php echo $exterior_image_row; ?>').remove();" class="button"><?php echo $button_remove; ?></a></td>
              </tr>
            </tbody>
            <?php $exterior_image_row++; ?>
            <?php } ?>
            <tfoot>
              <tr>
                <td colspan="3"></td>
                <td class="left"><a onclick="addImageExterior();" class="button"><?php echo $button_add_image; ?></a></br>
								 <a onclick="addAllImageExterior();" id="click_exterior" class="button">Добавить все изображения из папки</a>
								 <div id="error_exterior"></div>	
				</td>
              </tr>
            </tfoot>
          </table>
        </div>
		
        <div class="ionTabs__item" data-name="tab-more">
		<label>Выбор объекта</label>
		<select name="lots_value" style="width: 192px;">
		<?php foreach($this_lots as $value => $name){?>
		<?php if($value == $view_lots){ ?>
			<option value="<?php echo $value; ?>" selected="selected"><?php echo $name; ?></option>
		<?php }else{ ?>
			<option value="<?php echo $value; ?>"><?php echo $name; ?></option>
		<?php } ?>
		<?php } ?>
		</select><br><br>
          <table id="more" class="list">
            <thead>
              <tr>
			    <td></td>
                <td class="left">Изображения обьекта</td>
                <td class="right"><?php echo $entry_sort_order; ?></td>
                <td></td>
              </tr>
            </thead>
            <?php $more_image_row = 0; ?>
            <?php foreach ($product_images_more as $product_image_more) { ?>
            <tbody id="more-image-row<?php echo $more_image_row; ?>">
              <tr class="fa-move">
			    <td><i class="fa fa-bars"></i></td>
                <td class="left"><div class="image"><img src="<?php echo $product_image_more['thumb']; ?>" alt="" id="more-thumb<?php echo $more_image_row; ?>" />
                    <input type="hidden" name="product_image_more[<?php echo $more_image_row; ?>][image]" value="<?php echo $product_image_more['image']; ?>" id="more-image<?php echo $more_image_row; ?>" />
                    <br />
                    <a onclick="image_upload('more-image<?php echo $more_image_row; ?>', 'more-thumb<?php echo $more_image_row; ?>');"><?php echo $text_browse; ?></a>&nbsp;&nbsp;|&nbsp;&nbsp;<a onclick="$('#more-thumb<?php echo $more_image_row; ?>').attr('src', '<?php echo $no_image; ?>'); $('#more-image<?php echo $more_image_row; ?>').attr('value', '');"><?php echo $text_clear; ?></a></div></td>
                <td class="right"><input type="text" name="product_image_more[<?php echo $more_image_row; ?>][sort_order]" value="<?php echo $product_image_more['sort_order']; ?>" size="2" /></td>
                <td class="left"><a onclick="$('#more-image-row<?php echo $more_image_row; ?>').remove();" class="button"><?php echo $button_remove; ?></a></td>
              </tr>
            </tbody>
            <?php $more_image_row++; ?>
            <?php } ?>
            <tfoot>
              <tr>
                <td colspan="3"></td>
                <td class="left"><a onclick="addImagemore();" class="button"><?php echo $button_add_image; ?></a></br>
								 <a onclick="addAllImageMore();" id="click_more" class="button">Добавить все изображения из папки</a>
								 <div id="error_more"></div>
				</td>
              </tr>
            </tfoot>
          </table>
        </div>

        <div class="ionTabs__item" data-name="tab-video">
            <!--<table id="video" class="list">
                <thead>
                <tr>
                    <td class="left">Код Embed</td>
                </tr>
                </thead>

                    <tbody id="video_row">
                    <tr>
                        <td class="left">
                            <textarea name="video" rows="10" cols="80"><?php echo $video ?></textarea>
                        </td>
                    </tr>
                    </tbody>
                <tfoot></tfoot>
            </table>-->
			
			<table id="videos" class="list">
                <thead>
                <tr>
                    <td class="left">Код Embed</td>
                    <td class="right">Порядок сортировки:</td>
                    <td></td>
                </tr>
                </thead>
				<?php $product_video_row = 0; ?>
                <?php foreach ($product_videos as $product_video) { ?>
					<tbody id="video-row<?php echo $product_video_row; ?>">
                    <tr>
                <td class="left"><div class="video">
				    <textarea name="product_video[<?php echo $product_video_row; ?>][video]" rows="10" cols="80"><?php echo $product_video['video']; ?></textarea>
                    <!--<input type="text" name="product_video[<?php echo $product_video_row; ?>][video]" value="<?php echo $product_video['video']; ?>" /></div>-->
                </td>
                <td class="right"><input type="text" name="product_video[<?php echo $product_video_row; ?>][sort_order]" value="<?php echo $product_video['sort_order']; ?>" size="2" /></td>
                <td class="left"><a onclick="$('#video-row<?php echo $product_video_row; ?>').remove();" class="button"><?php echo $button_remove; ?></a></td>
                    </tr>
                    </tbody>
					<?php $product_video_row++; ?>
                <?php } ?>
                <tfoot>
                <tr>
                    <td colspan="2"></td>
                    <td class="left"><a onclick="addVideo();" class="button">Добавить видео</a></td>
                </tr>
                </tfoot>
            </table>	
        </div>
        <div class="ionTabs__item" data-name="tab-plan">
            <table id="plans" class="list">
                <thead>
                <tr>
                    <td class="left">Планировка</td>
                    <td class="right">Порядок сортировки:</td>
                    <td></td>
                </tr>
                </thead>
                <?php $plan_image_row = 0; ?>
                <?php foreach ($product_plans as $product_plan) { ?>
                    <tbody id="plan-image-row<?php echo $plan_image_row; ?>">
                    <tr>
                        <td class="left"><div class="image"><img src="<?php echo $product_plan['thumb']; ?>" alt="" id="plan-thumb<?php echo $plan_image_row; ?>" />
                                <input type="hidden" name="product_plan[<?php echo $plan_image_row; ?>][image]" value="<?php echo $product_plan['image']; ?>" id="plan-image<?php echo $plan_image_row; ?>" />
                                <br />
                                <a onclick="image_upload('plan-image<?php echo $plan_image_row; ?>', 'plan-thumb<?php echo $plan_image_row; ?>');"><?php echo $text_browse; ?></a>&nbsp;&nbsp;|&nbsp;&nbsp;<a onclick="$('#plan-thumb<?php echo $plan_image_row; ?>').attr('src', '<?php echo $no_image; ?>'); $('#plan-image<?php echo $plan_image_row; ?>').attr('value', '');"><?php echo $text_clear; ?></a></div></td>
                        <td class="right"><input type="text" name="product_plan[<?php echo $plan_image_row; ?>][sort_order]" value="<?php echo $product_plan['sort_order']; ?>" size="2" /></td>
                        <td class="left"><a onclick="$('#plan-image-row<?php echo $plan_image_row; ?>').remove();" class="button"><?php echo $button_remove; ?></a></td>
                    </tr>
                    </tbody>
                    <?php $plan_image_row++; ?>
                <?php } ?>
                <tfoot>
                <tr>
                    <td colspan="2"></td>
                    <td class="left"><a onclick="addPlanImage();" class="button"><?php echo $button_add_image; ?></a></td>
                </tr>
                </tfoot>
            </table>
        </div>
        <div class="ionTabs__item" data-name="tab-design">
          <table class="list">
            <thead>
              <tr>
                <td class="left"><?php echo $entry_store; ?></td>
                <td class="left"><?php echo $entry_layout; ?></td>
              </tr>
            </thead>
            <tbody>
              <tr>
                <td class="left"><?php echo $text_default; ?></td>
                <td class="left"><select name="product_layout[0][layout_id]">
                    <option value=""></option>
                    <?php foreach ($layouts as $layout) { ?>
                    <?php if (isset($product_layout[0]) && $product_layout[0] == $layout['layout_id']) { ?>
                    <option value="<?php echo $layout['layout_id']; ?>" selected="selected"><?php echo $layout['name']; ?></option>
                    <?php } else { ?>
                    <option value="<?php echo $layout['layout_id']; ?>"><?php echo $layout['name']; ?></option>
                    <?php } ?>
                    <?php } ?>
                  </select></td>
              </tr>
            </tbody>
            <?php foreach ($stores as $store) { ?>
            <tbody>
              <tr>
                <td class="left"><?php echo $store['name']; ?></td>
                <td class="left"><select name="product_layout[<?php echo $store['store_id']; ?>][layout_id]">
                    <option value=""></option>
                    <?php foreach ($layouts as $layout) { ?>
                    <?php if (isset($product_layout[$store['store_id']]) && $product_layout[$store['store_id']] == $layout['layout_id']) { ?>
                    <option value="<?php echo $layout['layout_id']; ?>" selected="selected"><?php echo $layout['name']; ?></option>
                    <?php } else { ?>
                    <option value="<?php echo $layout['layout_id']; ?>"><?php echo $layout['name']; ?></option>
                    <?php } ?>
                    <?php } ?>
                  </select></td>
              </tr>
            </tbody>
            <?php } ?>
          </table>
        </div>
		
		<!--<div class="ionTabs__item" data-name="Tab_3_name">
            Контент вкладки 3
        </div>
				 <div class="ionTabs__item" data-name="Tab_3_name">
            Контент вкладки 3
        </div>
				 <div class="ionTabs__item" data-name="Tab_3_name">
            Контент вкладки 3
        </div>
				 <div class="ionTabs__item" data-name="Tab_3_name">
            Контент вкладки 3
        </div>-->
        <div class="ionTabs__preloader"></div>
    </div>
</div>
</form>
</div>

<script type="text/javascript"><!--
$.ionTabs("#tabs_1, #tabs_2, #tabs_3, #tabs_4", {
    type: "storage",                    // hash, storage или none
    onChange: function(obj){            // функция обратного вызова
        //console.log(obj);
    }
});
//--></script>
<!--ION TABS-->
  </div>
</div>

<script type="text/javascript"><!--
function addAllImageInterior() {	
	$.ajax({
		url: 'index.php?route=catalog/product/addAllImageInterior&token=<?php echo $token; ?>',
		type: 'POST',
		dataType: 'json',
		data: {'model_id' : $('#model').attr('value'), 'product_id' : $('#product_id').attr('value')},
		success: function(json) {  
            if($('#product_id').attr('value') == ''){	
	 		    $('#error_interior').replaceWith(json[0].error);
			}else{
				/*alert('Готово');
				*/
          
                /*for (i = 0; i < json.length; i++) {
	                var interior_image_row = <?php echo $interior_image_row; ?>;

                    html  = '<tbody id="interior-image-row' + interior_image_row + '">';
	                html += '  <tr>';
	                html += '    <td class="left"><div class="image"><img src="' + json[i].thumb + '" alt="" id="interior-thumb' + interior_image_row + '" /><input type="hidden" name="" value="" id="interior-image' + interior_image_row + '" /><br /><a onclick="image_upload(\'interior-image' + interior_image_row + '\', \'interior-thumb' + interior_image_row + '\');"><?php echo $text_browse; ?></a>&nbsp;&nbsp;|&nbsp;&nbsp;<a onclick="$(\'#interior-thumb' + interior_image_row + '\').attr(\'src\', \'<?php echo $no_image; ?>\'); $(\'#interior-image' + interior_image_row + '\').attr(\'value\', \'\');"><?php echo $text_clear; ?></a></div></td>';
	                html += '    <td class="right"><input type="text" name="" value="' + json[i].sort_order + '" size="2" /></td>';
	                html += '    <td class="left"><a onclick="$(\'#interior-image-row' + interior_image_row  + '\').remove();" class="button"><?php echo $button_remove; ?></a></td>';
	                html += '  </tr>';
	                html += '</tbody>';
	
	                $('#interior tfoot').before(html);
	
	                interior_image_row++;  
	            }*/
				
				window.location.reload();
			}
		}
	});
}
//--></script> 

<script type="text/javascript"><!--
function addAllImageExterior() {	
	$.ajax({
		url: 'index.php?route=catalog/product/addAllImageExterior&token=<?php echo $token; ?>',
		type: 'POST',
		dataType: 'json',
		data: {'model_id' : $('#model').attr('value'), 'product_id' : $('#product_id').attr('value')},
		success: function(json) {  
            if($('#product_id').attr('value') == ''){	
	 		    $('#error_exterior').replaceWith(json[0].error);
			}else{
				/*alert('Готово');
				*/
          
                /*for (i = 0; i < json.length; i++) {
					var exterior_image_row = <?php echo $exterior_image_row; ?>;

                    html  = '<tbody id="exterior-image-row' + exterior_image_row + '">';
	                html += '  <tr>';
	                html += '    <td class="left"><div class="image"><img src="' + json[i].thumb + '" alt="" id="exterior-thumb' + exterior_image_row + '" /><input type="hidden" name="" value="" id="exterior-image' + exterior_image_row + '" /><br /><a onclick="image_upload(\'exterior-image' + exterior_image_row + '\', \'exterior-thumb' + exterior_image_row + '\');"><?php echo $text_browse; ?></a>&nbsp;&nbsp;|&nbsp;&nbsp;<a onclick="$(\'#exterior-thumb' + exterior_image_row + '\').attr(\'src\', \'<?php echo $no_image; ?>\'); $(\'#exterior-image' + exterior_image_row + '\').attr(\'value\', \'\');"><?php echo $text_clear; ?></a></div></td>';
	                html += '    <td class="right"><input type="text" name="" value="' + json[i].sort_order + '" size="2" /></td>';
	                html += '    <td class="left"><a onclick="$(\'#exterior-image-row' + exterior_image_row  + '\').remove();" class="button"><?php echo $button_remove; ?></a></td>';
	                html += '  </tr>';
	                html += '</tbody>';
	
	                $('#exterior tfoot').before(html);
	
	                exterior_image_row++;
	            }*/
				
				window.location.reload();
			}
		}
	});
}
//--></script> 

<script type="text/javascript"><!--
function addAllImageMore() {	
	$.ajax({
		url: 'index.php?route=catalog/product/addAllImageMore&token=<?php echo $token; ?>',
		type: 'POST',
		dataType: 'json',
		data: {'model_id' : $('#model').attr('value'), 'product_id' : $('#product_id').attr('value')},
		success: function(json) {  
            if($('#product_id').attr('value') == ''){	
	 		    $('#error_more').replaceWith(json[0].error);
			}else{
				/*alert('Готово');
				*/
          
                /*for (i = 0; i < json.length; i++) {
					var more_image_row = <?php echo $more_image_row; ?>;

                    html  = '<tbody id="more-image-row' + more_image_row + '">';
	                html += '  <tr>';
	                html += '    <td class="left"><div class="image"><img src="' + json[i].thumb + '" alt="" id="more-thumb' + more_image_row + '" /><input type="hidden" name="product_image_more[' + more_image_row + '][image]" value="" id="more-image' + more_image_row + '" /><br /><a onclick="image_upload(\'more-image' + more_image_row + '\', \'more-thumb' + more_image_row + '\');"><?php echo $text_browse; ?></a>&nbsp;&nbsp;|&nbsp;&nbsp;<a onclick="$(\'#more-thumb' + more_image_row + '\').attr(\'src\', \'<?php echo $no_image; ?>\'); $(\'#more-image' + more_image_row + '\').attr(\'value\', \'\');"><?php echo $text_clear; ?></a></div></td>';
	                html += '    <td class="right"><input type="text" name="" value="' + json[i].sort_order + '" size="2" /></td>';
	                html += '    <td class="left"><a onclick="$(\'#more-image-row' + more_image_row  + '\').remove();" class="button"><?php echo $button_remove; ?></a></td>';
	                html += '  </tr>';
	                html += '</tbody>';
	
	                $('#more tfoot').before(html);
	
	                more_image_row++;
	            }*/
				
				window.location.reload();
			}
		}
	});
}
//--></script> 


<script type="text/javascript" src="view/javascript/ckeditor/ckeditor.js"></script> 
<script type="text/javascript"><!--
<?php foreach ($languages as $language) { ?>
CKEDITOR.replace('description<?php echo $language['language_id']; ?>', {
	filebrowserBrowseUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
	filebrowserImageBrowseUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
	filebrowserFlashBrowseUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
	filebrowserUploadUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
	filebrowserImageUploadUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
	filebrowserFlashUploadUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>'
});
<?php } ?>
//--></script> 
<script type="text/javascript"><!--
$('input[name=\'related\']').autocomplete({
	delay: 0,
	source: function(request, response) {
		$.ajax({
			url: 'index.php?route=catalog/product/autocomplete&token=<?php echo $token; ?>&filter_name=' +  encodeURIComponent(request.term),
			dataType: 'json',
			success: function(json) {		
				response($.map(json, function(item) {
					return {
						label: item.name,
						value: item.product_id
					}
				}));
			}
		});
		
	}, 
	select: function(event, ui) {
		$('#product-related' + ui.item.value).remove();
		
		$('#product-related').append('<div id="product-related' + ui.item.value + '">' + ui.item.label + '<img src="view/image/delete.png" /><input type="hidden" name="product_related[]" value="' + ui.item.value + '" /></div>');

		$('#product-related div:odd').attr('class', 'odd');
		$('#product-related div:even').attr('class', 'even');
				
		return false;
	},
	focus: function(event, ui) {
      return false;
	}
});

$('#product-related div img').live('click', function() {
	$(this).parent().remove();
	
	$('#product-related div:odd').attr('class', 'odd');
	$('#product-related div:even').attr('class', 'even');	
});
//--></script> 
<script type="text/javascript"><!--
var attribute_row = <?php echo $attribute_row; ?>;

function addRelated() {
	$('#product :selected').each(function() {
		$(this).remove();
		
		$('#related option[value=\'' + $(this).attr('value') + '\']').remove();
		
		$('#related').append('<option value="' + $(this).attr('value') + '">' + $(this).text() + '</option>');
		
		$('#product_related input[value=\'' + $(this).attr('value') + '\']').remove();
		
		$('#product_related').append('<input type="hidden" name="product_related[]" value="' + $(this).attr('value') + '" />');
	});
}

function removeRelated() {
	$('#related :selected').each(function() {
		$(this).remove();
		
		$('#product_related input[value=\'' + $(this).attr('value') + '\']').remove();
	});
}

function getProducts() {
	$('#product option').remove();
	
	$.ajax({
		url: 'index.php?route=catalog/product/category&token=<?php echo $token; ?>&category_id=' + $('#category').attr('value'),
		dataType: 'json',
		success: function(data) {
			for (i = 0; i < data.length; i++) {
	 			$('#product').append('<option value="' + data[i]['product_id'] + '">' + data[i]['name'] + ' (' + data[i]['model'] + ') </option>');
			}
		}
	});
}

function getRelated() {
	$('#related option').remove();
	
	$.ajax({
		url: 'index.php?route=catalog/product/related&token=<?php echo $token; ?>',
		type: 'POST',
		dataType: 'json',
		data: $('#product_related input'),
		success: function(data) {
			$('#product_related input').remove();
			
			for (i = 0; i < data.length; i++) {
	 			$('#related').append('<option value="' + data[i]['product_id'] + '">' + data[i]['name'] + ' (' + data[i]['model'] + ') </option>');
				
				$('#product_related').append('<input type="hidden" name="product_related[]" value="' + data[i]['product_id'] + '" />');
			} 
		}
	});
}

getProducts();
getRelated();

function addAttribute() {
	html  = '<tbody id="attribute-row' + attribute_row + '">';
    html += '  <tr>';
	html += '    <td class="left"><input type="text" name="product_attribute[' + attribute_row + '][name]" value="" /><input type="hidden" name="product_attribute[' + attribute_row + '][attribute_id]" value="" /></td>';
	html += '    <td class="left">';
	<?php foreach ($languages as $language) { ?>
	html += '<textarea name="product_attribute[' + attribute_row + '][product_attribute_description][<?php echo $language['language_id']; ?>][text]" cols="40" rows="5"></textarea><img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" align="top" /><br />';
    <?php } ?>
	html += '    </td>';
	html += '    <td class="left"><a onclick="$(\'#attribute-row' + attribute_row + '\').remove();" class="button"><?php echo $button_remove; ?></a></td>';
    html += '  </tr>';	
    html += '</tbody>';
	
	$('#attribute tfoot').before(html);
	
	attributeautocomplete(attribute_row);
	
	attribute_row++;
}

$.widget('custom.catcomplete', $.ui.autocomplete, {
	_renderMenu: function(ul, items) {
		var self = this, currentCategory = '';
		
		$.each(items, function(index, item) {
			if (item.category != currentCategory) {
				ul.append('<li class="ui-autocomplete-category">' + item.category + '</li>');
				
				currentCategory = item.category;
			}
			
			self._renderItem(ul, item);
		});
	}
});

function attributeautocomplete(attribute_row) {
	$('input[name=\'product_attribute[' + attribute_row + '][name]\']').catcomplete({
		delay: 0,
		source: function(request, response) {
			$.ajax({
				url: 'index.php?route=catalog/attribute/autocomplete&token=<?php echo $token; ?>&filter_name=' +  encodeURIComponent(request.term),
				dataType: 'json',
				success: function(json) {	
					response($.map(json, function(item) {
						return {
							category: item.attribute_group,
							label: item.name,
							value: item.attribute_id
						}
					}));
				}
			});
		}, 
		select: function(event, ui) {
			$('input[name=\'product_attribute[' + attribute_row + '][name]\']').attr('value', ui.item.label);
			$('input[name=\'product_attribute[' + attribute_row + '][attribute_id]\']').attr('value', ui.item.value);
			
			return false;
		},
		focus: function(event, ui) {
      		return false;
		}
	});
}

$('#attribute tbody').each(function(index, element) {
	attributeautocomplete(index);
});
//--></script> 
<script type="text/javascript"><!--	
var option_row = <?php echo $option_row; ?>;

$('input[name=\'option\']').catcomplete({
	delay: 0,
	source: function(request, response) {
		$.ajax({
			url: 'index.php?route=catalog/option/autocomplete&token=<?php echo $token; ?>&filter_name=' +  encodeURIComponent(request.term),
			dataType: 'json',
			success: function(json) {
				response($.map(json, function(item) {
					return {
						category: item.category,
						label: item.name,
						value: item.option_id,
						type: item.type,
						option_value: item.option_value
					}
				}));
			}
		});
	}, 
	select: function(event, ui) {
		html  = '<div id="tab-option-' + option_row + '" class="vtabs-content">';
		html += '	<input type="hidden" name="product_option[' + option_row + '][product_option_id]" value="" />';
		html += '	<input type="hidden" name="product_option[' + option_row + '][name]" value="' + ui.item.label + '" />';
		html += '	<input type="hidden" name="product_option[' + option_row + '][option_id]" value="' + ui.item.value + '" />';
		html += '	<input type="hidden" name="product_option[' + option_row + '][type]" value="' + ui.item.type + '" />';
		html += '   <div class="optionname-js">' +  ui.item.label + '</div>';
		html += '	<table class="form">';
		html += '	  <tr>';
		html += '		<td><?php echo $entry_required; ?></td>';
		html += '       <td><select name="product_option[' + option_row + '][required]">';
		html += '	      <option value="1"><?php echo $text_yes; ?></option>';
		html += '	      <option value="0"><?php echo $text_no; ?></option>';
		html += '	    </select></td>';
		html += '     </tr>';
		html += '	  <tr>';
		html += '	  <td>Сортировка</td>';
		html += '     <td><input type="text" name="product_option[' + option_row + '][product_sort_option_id]" value="" /></td>';
		html += '     </tr>';
		
		if (ui.item.type == 'text') {
			html += '     <tr>';
			html += '       <td><?php echo $entry_option_value; ?></td>';
			html += '       <td><input type="text" name="product_option[' + option_row + '][option_value]" value="" /></td>';
			html += '     </tr>';
		}
		
		if (ui.item.type == 'textarea') {
			html += '     <tr>';
			html += '       <td><?php echo $entry_option_value; ?></td>';
			html += '       <td><textarea name="product_option[' + option_row + '][option_value]" cols="40" rows="5"></textarea></td>';
			html += '     </tr>';						
		}
		 
		if (ui.item.type == 'file') {
			html += '     <tr>';
			html += '       <td><?php echo $entry_option_value; ?></td>';
			html += '       <td><input type="text" name="product_option[' + option_row + '][option_value]" value="" /></td>';
			html += '     </tr>';			
		}
						
		if (ui.item.type == 'date') {
			html += '     <tr>';
			html += '       <td><?php echo $entry_option_value; ?></td>';
			html += '       <td><input type="text" name="product_option[' + option_row + '][option_value]" value="" class="date" /></td>';
			html += '     </tr>';			
		}
		
		if (ui.item.type == 'datetime') {
			html += '     <tr>';
			html += '       <td><?php echo $entry_option_value; ?></td>';
			html += '       <td><input type="text" name="product_option[' + option_row + '][option_value]" value="" class="datetime" /></td>';
			html += '     </tr>';			
		}
		
		if (ui.item.type == 'time') {
			html += '     <tr>';
			html += '       <td><?php echo $entry_option_value; ?></td>';
			html += '       <td><input type="text" name="product_option[' + option_row + '][option_value]" value="" class="time" /></td>';
			html += '     </tr>';			
		}
		
		html += '  </table>';
			
		if (ui.item.type == 'select' || ui.item.type == 'radio' || ui.item.type == 'checkbox' || ui.item.type == 'image') {
			html += '  <table id="option-value' + option_row + '" class="list">';
			html += '  	 <thead>'; 
			html += '      <tr>';
			html += '        <td class="left"><?php echo $entry_option_value; ?></td>';
			html += '        <td colspan="6"></td>';
			html += '      </tr>';
			html += '  	 </thead>';
			html += '    <tfoot>';
			html += '      <tr>';
			html += '        <td colspan="6"></td>';
			html += '        <td class="left"><a onclick="addOptionValue(' + option_row + ');" class="button"><?php echo $button_add_option_value; ?></a></td>';
			html += '      </tr>';
			html += '    </tfoot>';
			html += '  </table>';
            html += '  <select style="display:none;" id="option-values' + option_row + '">';
			
            for (i = 0; i < ui.item.option_value.length; i++) {
				html += '  <option value="' + ui.item.option_value[i]['option_value_id'] + '">' + ui.item.option_value[i]['name'] + '</option>';
            }

            html += '  </select>';			
			html += '</div>';	
		}
		
		$('#tab-option').append(html);
		
		$('#option-add').before('<a href="#tab-option-' + option_row + '" id="option-' + option_row + '">' + ui.item.label + '&nbsp;<img src="view/image/delete.png" alt="" onclick="$(\'#vtab-option a:first\').trigger(\'click\'); $(\'#option-' + option_row + '\').remove(); $(\'#tab-option-' + option_row + '\').remove(); return false;" /></a>');
		
		$('#vtab-option a').tabsoption();
		
		$('#option-' + option_row).trigger('click');		
		
		$('.date').datepicker({dateFormat: 'yy-mm-dd'});
		$('.datetime').datetimepicker({
			dateFormat: 'yy-mm-dd',
			timeFormat: 'h:m'
		});	
			
		$('.time').timepicker({timeFormat: 'h:m'});	
				
		option_row++;
		
		return false;
	},
	focus: function(event, ui) {
      return false;
	}
});
//--></script> 
<script type="text/javascript"><!--		
var option_value_row = <?php echo $option_value_row; ?>;

function addOptionValue(option_row) {	
	html  = '<tbody id="option-value-row' + option_value_row + '">';
	html += '  <tr>';
	html += '    <td class="left"><select name="product_option[' + option_row + '][product_option_value][' + option_value_row + '][option_value_id]">';
	html += $('#option-values' + option_row).html();
	html += '    </select><input type="hidden" name="product_option[' + option_row + '][product_option_value][' + option_value_row + '][product_option_value_id]" value="" /></td>';
	html += '    <td colspan="6"><a onclick="$(\'#option-value-row' + option_value_row + '\').remove();" class="button"><?php echo $button_remove; ?></a></td>';
	html += '  </tr>';
	html += '</tbody>';
	
	$('#option-value' + option_row + ' tfoot').before(html);

	option_value_row++;
}
//--></script> 
<script type="text/javascript"><!--
/*
var discount_row = <?php echo $discount_row; ?>;

function addDiscount() {
	html  = '<tbody id="discount-row' + discount_row + '">';
	html += '  <tr>'; 
    html += '    <td class="left"><select name="product_discount[' + discount_row + '][customer_group_id]">';
    <?php foreach ($customer_groups as $customer_group) { ?>
    html += '      <option value="<?php echo $customer_group['customer_group_id']; ?>"><?php echo $customer_group['name']; ?></option>';
    <?php } ?>
    html += '    </select></td>';		
    html += '    <td class="right"><input type="text" name="product_discount[' + discount_row + '][quantity]" value="" size="2" /></td>';
    html += '    <td class="right"><input type="text" name="product_discount[' + discount_row + '][priority]" value="" size="2" /></td>';
	html += '    <td class="right"><input type="text" name="product_discount[' + discount_row + '][price]" value="" /></td>';
    html += '    <td class="left"><input type="text" name="product_discount[' + discount_row + '][date_start]" value="" class="date" /></td>';
	html += '    <td class="left"><input type="text" name="product_discount[' + discount_row + '][date_end]" value="" class="date" /></td>';
	html += '    <td class="left"><a onclick="$(\'#discount-row' + discount_row + '\').remove();" class="button"><?php echo $button_remove; ?></a></td>';
	html += '  </tr>';	
    html += '</tbody>';
	
	$('#discount tfoot').before(html);
		
	$('#discount-row' + discount_row + ' .date').datepicker({dateFormat: 'yy-mm-dd'});
	
	discount_row++;
}*/
//--></script> 
<script type="text/javascript"><!--
var special_row = <?php echo $special_row; ?>;

function addSpecial() {
	html  = '<tbody id="special-row' + special_row + '">';
	html += '  <tr>'; 
    html += '    <td class="left"><select name="product_special[' + special_row + '][customer_group_id]">';
    <?php foreach ($customer_groups as $customer_group) { ?>
    html += '      <option value="<?php echo $customer_group['customer_group_id']; ?>"><?php echo $customer_group['name']; ?></option>';
    <?php } ?>
    html += '    </select></td>';		
    html += '    <td class="right"><input type="text" name="product_special[' + special_row + '][priority]" value="" size="2" /></td>';
	html += '    <td class="right"><input type="text" name="product_special[' + special_row + '][price]" value="" /></td>';
    html += '    <td class="left"><input type="text" name="product_special[' + special_row + '][date_start]" value="" class="date" /></td>';
	html += '    <td class="left"><input type="text" name="product_special[' + special_row + '][date_end]" value="" class="date" /></td>';
	html += '    <td class="left"><a onclick="$(\'#special-row' + special_row + '\').remove();" class="button"><?php echo $button_remove; ?></a></td>';
	html += '  </tr>';
    html += '</tbody>';
	
	$('#special tfoot').before(html);
 
	$('#special-row' + special_row + ' .date').datepicker({dateFormat: 'yy-mm-dd'});
	
	special_row++;
}
//--></script> 
<script type="text/javascript"><!--
function image_upload(field, thumb) {
	$('#dialog').remove();
	
	$('#content').prepend('<div id="dialog" style="padding: 3px 0px 0px 0px;"><iframe src="index.php?route=common/filemanager&token=<?php echo $token; ?>&field=' + encodeURIComponent(field) + '" style="padding:0; margin: 0; display: block; width: 100%; height: 100%;" frameborder="no" scrolling="auto"></iframe></div>');
	
	$('#dialog').dialog({
		title: '<?php echo $text_image_manager; ?>',
		close: function (event, ui) {
			if ($('#' + field).attr('value')) {
				$.ajax({
					url: 'index.php?route=common/filemanager/image&token=<?php echo $token; ?>&image=' + encodeURIComponent($('#' + field).attr('value')),
					dataType: 'text',
					success: function(text) {
						$('#' + thumb).replaceWith('<img src="' + text + '" alt="" id="' + thumb + '" />');
					}
				});
			}
		},	
		bgiframe: false,
		width: 960,
		height: 550,
		resizable: false,
		modal: false,
		dialogClass: 'dlg'
	});
};
//--></script> 

<script type="text/javascript"><!--
var interior_image_row = <?php echo $interior_image_row; ?>;

function addImageInterior() {
    html  = '<tbody id="interior-image-row' + interior_image_row + '">';
	html += '  <tr class="fa-move">';
	html += '    <td><i class="fa fa-bars"></i></td>';
	html += '    <td class="left"><div class="image"><img src="<?php echo $no_image; ?>" alt="" id="interior-thumb' + interior_image_row + '" /><input type="hidden" name="product_image_interior[' + interior_image_row + '][image]" value="" id="interior-image' + interior_image_row + '" /><br /><a onclick="image_upload(\'interior-image' + interior_image_row + '\', \'interior-thumb' + interior_image_row + '\');"><?php echo $text_browse; ?></a>&nbsp;&nbsp;|&nbsp;&nbsp;<a onclick="$(\'#interior-thumb' + interior_image_row + '\').attr(\'src\', \'<?php echo $no_image; ?>\'); $(\'#interior-image' + interior_image_row + '\').attr(\'value\', \'\');"><?php echo $text_clear; ?></a></div></td>';
	html += '    <td class="right"><input type="text" name="product_image_interior[' + interior_image_row + '][sort_order]" value="" size="2" /></td>';
	html += '    <td class="left"><a onclick="$(\'#interior-image-row' + interior_image_row  + '\').remove();" class="button"><?php echo $button_remove; ?></a></td>';
	html += '  </tr>';
	html += '</tbody>';
	
	$('#interior tfoot').before(html);
	
	interior_image_row++;
}
//--></script>

<script type="text/javascript"><!--
$(document).ready(function()
			{
				$('#interior').sortable({
					axis: 'y',
					forcePlaceholderSize: true,
					placeholder: 'group_move_placeholder',
					stop: function(event, ui)
					{
						$('#interior input[name$="[sort_order]"]').each(function(i)
						{
							$(this).val(i);
						});			
					}
				});
			});
			
//--></script>

<script type="text/javascript"><!--
var exterior_image_row = <?php echo $exterior_image_row; ?>;

function addImageExterior() {
    html  = '<tbody id="exterior-image-row' + exterior_image_row + '">';
	html += '  <tr class="fa-move">';
	html += '    <td><i class="fa fa-bars"></i></td>';
	html += '    <td class="left"><div class="image"><img src="<?php echo $no_image; ?>" alt="" id="exterior-thumb' + exterior_image_row + '" /><input type="hidden" name="product_image_exterior[' + exterior_image_row + '][image]" value="" id="exterior-image' + exterior_image_row + '" /><br /><a onclick="image_upload(\'exterior-image' + exterior_image_row + '\', \'exterior-thumb' + exterior_image_row + '\');"><?php echo $text_browse; ?></a>&nbsp;&nbsp;|&nbsp;&nbsp;<a onclick="$(\'#exterior-thumb' + exterior_image_row + '\').attr(\'src\', \'<?php echo $no_image; ?>\'); $(\'#exterior-image' + exterior_image_row + '\').attr(\'value\', \'\');"><?php echo $text_clear; ?></a></div></td>';
	html += '    <td class="right"><input type="text" name="product_image_exterior[' + exterior_image_row + '][sort_order]" value="" size="2" /></td>';
	html += '    <td class="left"><a onclick="$(\'#exterior-image-row' + exterior_image_row  + '\').remove();" class="button"><?php echo $button_remove; ?></a></td>';
	html += '  </tr>';
	html += '</tbody>';
	
	$('#exterior tfoot').before(html);
	
	exterior_image_row++;
}
//--></script>

<script type="text/javascript"><!--
$(document).ready(function()
			{
				$('#exterior').sortable({
					axis: 'y',
					forcePlaceholderSize: true,
					placeholder: 'group_move_placeholder',
					stop: function(event, ui)
					{
						$('#exterior input[name$="[sort_order]"]').each(function(i)
						{
							$(this).val(i);
						});			
					}
				});
			});
			
//--></script>

<script type="text/javascript"><!--
var more_image_row = <?php echo $more_image_row; ?>;

function addImagemore() {
    html  = '<tbody id="more-image-row' + more_image_row + '">';
	html += '  <tr class="fa-move">';
	html += '    <td><i class="fa fa-bars"></i></td>';
	html += '    <td class="left"><div class="image"><img src="<?php echo $no_image; ?>" alt="" id="more-thumb' + more_image_row + '" /><input type="hidden" name="product_image_more[' + more_image_row + '][image]" value="" id="more-image' + more_image_row + '" /><br /><a onclick="image_upload(\'more-image' + more_image_row + '\', \'more-thumb' + more_image_row + '\');"><?php echo $text_browse; ?></a>&nbsp;&nbsp;|&nbsp;&nbsp;<a onclick="$(\'#more-thumb' + more_image_row + '\').attr(\'src\', \'<?php echo $no_image; ?>\'); $(\'#more-image' + more_image_row + '\').attr(\'value\', \'\');"><?php echo $text_clear; ?></a></div></td>';
	html += '    <td class="right"><input type="text" name="product_image_more[' + more_image_row + '][sort_order]" value="" size="2" /></td>';
	html += '    <td class="left"><a onclick="$(\'#more-image-row' + more_image_row  + '\').remove();" class="button"><?php echo $button_remove; ?></a></td>';
	html += '  </tr>';
	html += '</tbody>';
	
	$('#more tfoot').before(html);
	
	more_image_row++;
}
//--></script>

<script type="text/javascript"><!--
$(document).ready(function()
			{
				$('#more').sortable({
					axis: 'y',
					forcePlaceholderSize: true,
					placeholder: 'group_move_placeholder',
					stop: function(event, ui)
					{
						$('#more input[name$="[sort_order]"]').each(function(i)
						{
							$(this).val(i);
						});			
					}
				});
			});
			
//--></script>

<!--<script type="text/javascript"><!--
var image_row = <?php echo $image_row; ?>;

function addImage() {
    html  = '<tbody id="image-row' + image_row + '">';
	html += '  <tr>';
	html += '    <td class="left"><div class="image"><img src="<?php echo $no_image; ?>" alt="" id="thumb' + image_row + '" /><input type="hidden" name="product_image[' + image_row + '][image]" value="" id="image' + image_row + '" /><br /><a onclick="image_upload(\'image' + image_row + '\', \'thumb' + image_row + '\');"><?php echo $text_browse; ?></a>&nbsp;&nbsp;|&nbsp;&nbsp;<a onclick="$(\'#thumb' + image_row + '\').attr(\'src\', \'<?php echo $no_image; ?>\'); $(\'#image' + image_row + '\').attr(\'value\', \'\');"><?php echo $text_clear; ?></a></div></td>';
	html += '    <td class="right"><input type="text" name="product_image[' + image_row + '][sort_order]" value="" size="2" /></td>';
	html += '    <td class="left"><a onclick="$(\'#image-row' + image_row  + '\').remove();" class="button"><?php echo $button_remove; ?></a></td>';
	html += '  </tr>';
	html += '</tbody>';
	
	$('#images tfoot').before(html);
	
	image_row++;
}
//--></script>

<script type="text/javascript"><!--
    var plan_image_row = <?php echo $plan_image_row; ?>;

    function addPlanImage() {
        html  = '<tbody id="plan-image-row' + plan_image_row + '">';
        html += '  <tr>';
        html += '    <td class="left"><div class="image"><img src="<?php echo $no_image; ?>" alt="" id="plan-thumb' + plan_image_row + '" /><input type="hidden" name="product_plan[' + plan_image_row + '][image]" value="" id="plan-image' + plan_image_row + '" /><br /><a onclick="image_upload(\'plan-image' + plan_image_row + '\', \'plan-thumb' + plan_image_row + '\');"><?php echo $text_browse; ?></a>&nbsp;&nbsp;|&nbsp;&nbsp;<a onclick="$(\'#plan-thumb' + plan_image_row + '\').attr(\'src\', \'<?php echo $no_image; ?>\'); $(\'#plan-image' + plan_image_row + '\').attr(\'value\', \'\');"><?php echo $text_clear; ?></a></div></td>';
        html += '    <td class="right"><input type="text" name="product_plan[' + plan_image_row + '][sort_order]" value="" size="2" /></td>';
        html += '    <td class="left"><a onclick="$(\'#plan-image-row' + plan_image_row  + '\').remove();" class="button"><?php echo $button_remove; ?></a></td>';
        html += '  </tr>';
        html += '</tbody>';

        $('#plans tfoot').before(html);

        plan_image_row++;
    }
//--></script>
	
<script type="text/javascript"><!--
    var product_video_row = <?php echo $product_video_row; ?>;

    function addVideo() {
        html  = '<tbody id="video-row' + product_video_row + '">';
        html += '  <tr>';
        html += '    <td><div class="video"><textarea name="product_video[' + product_video_row  + '][video]" rows="10" cols="80"></textarea></div></td>';
        html += '    <td class="right"><input type="text" name="product_video[' + product_video_row  + '][sort_order]" value="" size="2" /></td>';
        html += '    <td class="left"><a onclick="$(\'#video-row' + product_video_row  + '\').remove();" class="button"><?php echo $button_remove; ?></a></td>';
        html += '  </tr>';
        html += '</tbody>';

        $('#videos tfoot').before(html);

        product_video_row++;
    }
//--></script>

<script type="text/javascript" src="view/javascript/jquery/ui/jquery-ui-timepicker-addon.js"></script>

<script type="text/javascript"><!--
$('.date').datepicker({dateFormat: 'yy-mm-dd'});
$('.datetime').datetimepicker({
	dateFormat: 'yy-mm-dd',
	timeFormat: 'h:m'
});
$('.time').timepicker({timeFormat: 'h:m'});
//--></script> 
<script type="text/javascript"><!--
$('#tabs a').tabs(); 
$('#languages a').tabs(); 
$('#vtab-option a').tabs();
//--></script>
<script type="text/javascript"><!--
$prodname = $('input[name="product_description[<?php echo $this->config->get('config_language_id'); ?>][name]"]'); 
	$title = $('.prodname');

	if ($prodname.val() != '') {
		$title.html(' - ' + $prodname.val()); 
	}

	$prodname.keyup(function() {
		if ($prodname.val() != '') {
			$title.html(' - ' + $prodname.val()); 
		} else {
			$title.html('');
		}
	});
//--></script>  
<?php echo $footer; ?>
<?php if(true || $attributes || $price_slider) { ?>
<div class="wrap-filter">
    <div class="conteiner"><div class="row">
        <form id="filterpro" class="filter">
        <div class="row">
            <h3>ПОИСК НЕДВИЖИМОСТИ:</h3>
        </div>
		
    <input type="hidden" name="page" id="filterpro_page" value="0">
    <input type="hidden" name="path" value="<?php echo $path ?>">
    <input type="hidden" name="sort" id="filterpro_sort" value="">
    <input type="hidden" name="order" id="filterpro_order" value="">
    <input type="hidden" name="limit" id="filterpro_limit" value="">
	
	<?php if($category_id !== false) { ?>
    <input type="hidden" id="search_object" name="category_id" value="<?php echo $category_id ?>">
    <?php } ?>
	
<table>
<tr>
<td class="row_one">
<?php if($attributes) { ?>
<?php foreach($attributes as $attribute_group_id => $attribute) { ?>
<?php if($attr_group) { ?>
<div class="option_box">
    <?php } ?>
    <?php foreach($attribute['attribute_values'] as $attribute_value_id => $attribute_value) { ?>
<div class="attribute_box">

<div>
<?php if($attribute_value['display'] == 'select') { ?>

<div class="selector_filter">
	<?php if($attribute_value_id == 36){ ?>
	<div>
        <select class="selector" name="attribute_value[36][]">
            <option value="" class="main_filtered">Расположение</option>
			<option value="" class="main_filtered">Все</option>
            <?php foreach($attribute_value['values'] as $i => $value) { ?>
            <option class="a_name"
                    at_v_i="<?php echo $attribute_value_id . '_' . $value ?>"
                    at_v_t="<?php echo $attribute_value_id . '_' . htmlspecialchars(preg_replace('/\s+|\n|\r|\s+$/m', '_', $value)) ?>"
                    data-value="<?php echo $value ?>"
                    value="<?php echo $value ?>"><?php echo $value ?></option>
            <?php } ?>
        </select>
    </div>
    <?php } ?>
	
	<?php if($attribute_value_id == 37){ ?>
		<?php //var_dump($attribute_value['values'][1])?>
    <div>
        <select id="search_value" class="selector" name="attribute_value[37][]">
            <option value="" class="main_filtered">Тип недвижимости</option>
			<option value="" class="main_filtered">Все</option>
            <?php foreach($attribute_value['values'] as $i => $value) { ?>
            <option class="a_name"
                    at_v_i="<?php echo $attribute_value_id . '_' . $value ?>"
                    at_v_t="<?php echo $attribute_value_id . '_' . htmlspecialchars(preg_replace('/\s+|\n|\r|\s+$/m', '_', $value)) ?>"
                    data-value="<?php echo $value ?>"
                    value="<?php echo $value ?>"><?php echo $value ?></option>
            <?php }?>
        </select>
	</div>
	<?php } ?>
</div>
	
<?php } elseif($attribute_value['display'] == 'slider') { ?>

	<?php if($category_id == 20){ ?>
	<?php if($attribute_value_id == 38){ ?>
    <div class="room_filter change_class">
    <div class="name_filter_left">Количество комнат:</div>
    <div class="room_filter_left">
        <span>от</span>
		<input class="room_limit" type="text" id="attribute_value_38_min" name="attr_slider[38][min]" value="" placeholder="1">
    </div>
    <div class="room_filter_left">
        <span>до</span>
		<input class="room_limit" type="text" id="attribute_value_38_max" name="attr_slider[38][max]" value="" placeholder="Более">
    </div>
    </div> 
	<?php } ?>
	<?php } ?>
		
	<?php if($category_id != 78){ ?>	
	<?php foreach($get_parent_sale as $category_parent_sale){ ?>
    <?php if($category_id == $category_parent_sale){ ?>
    <?php if($attribute_value_id == 39){ ?>
    <div class="room_filter change_class">
    <div class="room_filter_left">Количество комнат:</div>
    <div class="room_filter_left">
        <span>от</span>
		<input class="room_limit" type="text" id="attribute_value_38_min" name="attr_slider[38][min]" value="" placeholder="1">
    </div>
    <div class="room_filter_left">
        <span>до</span>
		<input class="room_limit" type="text" id="attribute_value_38_max" name="attr_slider[38][max]" value="" placeholder="Более">
    </div>
    </div> 
	<?php } ?>
    <?php } ?>
    <?php } ?>
    <?php } ?>
	
	<?php if($category_id == 78){ ?>
	<?php if($attribute_value_id == 40){ ?>
    <div class="room_filter">
    <div class="name_filter_left">Количество соток:</div>
    <div class="room_filter_left">
        <span>от</span>
		<input class="room_limit" type="text" id="attribute_value_40_min" name="attr_slider[40][min]" value="" placeholder="1">
    </div>
    <div class="room_filter_left">
        <span>до</span>
		<input class="room_limit" type="text" id="attribute_value_40_max" name="attr_slider[40][max]" value="" placeholder="Более">
    </div>
    </div> 
	<?php } ?>
	<?php } ?>

	<?php if($attribute["attribute_values"][39]){ ?>
	<?php if($category_id == 94){ ?>
	<?php if($attribute_value_id == 39){ ?>
    <div class="bedroom_filter">
    <div class="bedroom_filter_left">Количество спален:</div>
    <div class="bedroom_filter_left">
        <span>от</span>
		<input class="room_limit" type="text" id="attribute_value_39_min" name="attr_slider[39][min]" value="" placeholder="1">
    </div>
    <div class="bedroom_filter_left">
        <span>до</span>
		<input class="room_limit" type="text" id="attribute_value_39_max" name="attr_slider[39][max]" value="" placeholder="Более">
    </div>
    </div> 
	<?php } ?>
	<?php } ?>
	
	<?php foreach($get_parent_rent as $category_parent_rent){ ?>
	<?php if($attribute_value_id == 39){ ?>
    <?php if($category_id == $category_parent_rent){ ?>

    <div class="bedroom_filter">
    <div class="bedroom_filter_left">Количество спален:</div>
    <div class="bedroom_filter_left">
        <span>от</span>
		<input class="room_limit" type="text" id="attribute_value_39_min" name="attr_slider[39][min]" value="" placeholder="1">
    </div>
    <div class="bedroom_filter_left">
        <span>до</span>
		<input class="room_limit" type="text" id="attribute_value_39_max" name="attr_slider[39][max]" value="" placeholder="Более">
    </div>
    </div> 
    <?php } ?>
    <?php } ?>
    <?php } ?>
    <?php } ?>
    
<?php } ?>
</div>
</div>

<?php } ?>
<?php if($attr_group) { ?>
</div>
<?php } ?>
<?php } ?>
<?php } ?>
</td>

<td class="row_three" rowspan="2">
    <a href="javascript:void(0)" onclick="reset_filter_form(); getAddDelimitr();" class="rash">ОЧИСТИТЬ СПИСОК</a>
    <button onclick="setSort('sort=p.price&order=ASC'); getReset(); return false;">ИСКАТЬ</button>
</td>
</tr>

<tr>
<td class="row_two">
<div class="price_filter">
    <div class="name_price_filter_left">Цена:</div>
    <div class="price_filter_left">
        <span>от</span>
        <input class="price_limit" type="text" name="min_price" value="0" id="min_price" />
    </div>
    <div class="price_filter_left">
        <span>до</span>
        <input class="price_limit" type="text" name="max_price" value="0" id="max_price" />
    </div>
    <div class="price_filter_radio_left">
        <input class="inp_valuta" type="radio" name="valute" value="rub" />
        <span>руб.</span>
        <input class="inp_valuta" type="radio" name="valute" value="usd" checked="checked" />
        <span>$</span>
    </div>
</div>		
		
<div class="image_video_filter">
    <div class="filter-left">
        <input class="inp_valuta" type="checkbox" name="with_photo" value="1" />
        <span>с фото</span>
        <input class="inp_valuta" type="checkbox" name="with_video" value="1" />
        <span>с видео</span>
    </div>
</div>
</td>
</tr>

</table>	
	
<div class="row extra-row filter-clear">
    <!--<i id="pricesort" style="display:none;" data-sort="sort=p.price&order=ASC"></i>-->
	<i id="pricesort" style="display:none;" data-sort="sort"></i>
    <i id="valutesort" style="display:none;" data-valute="usd"></i>
</div>

</form>
</div></div>

<script>
	jQuery(document).ready(function(){

		jQuery("#search_value").change(function () { 
			if(jQuery(this).val() != 'Земельный участок') return false;
				jQuery(".change_class").replaceWith('<div class="room_filter change_class" id="change_class"><div class="name_filter_left">Количество соток: </div><div class="room_filter_left"><span>от</span> <input class="room_limit" type="text" id="attribute_value_40_min" name="attr_slider[40][min]" value="" placeholder="1"></div><div class="room_filter_left"><span>до</span> <input class="room_limit" type="text" id="attribute_value_40_max" name="attr_slider[40][max]" value="" placeholder="Более"></div></div> ');
			});
			
			return false;
	});

var jQuery = jQuery.noConflict();
	function getReset(){
		jQuery('#search_object').remove();
		jQuery('#filterpro_limit').after('<?php if(array_search($category_id, $category_normal_sale) || $category_id == 20 ){ ?><input type="hidden" id="search_object" name="category_id" value="20"><?php } ?>');
		jQuery('#filterpro_order').after('<?php if(array_search($category_id, $category_normal_rent) || $category_id == 94 ){ ?><input type="hidden" id="search_object" name="category_id" value="94"><?php } ?>');

		iF();
	}
	
	function getAddDelimitr(){
		jQuery('#filterpro_limit').after('<?php if($category_id !== false) { ?><input type="hidden" id="search_object" name="category_id" value="<?php echo $category_id ?>"><?php } ?>');
		
		jQuery("#change_class").replaceWith('<div class="room_filter change_class"><div class="room_filter_left">Количество комнат: </div><div class="room_filter_left"><span>от</span> <input class="room_limit" type="text" id="attribute_value_38_min" name="attr_slider[38][min]" value="" placeholder="1"></div><div class="room_filter_left"><span>до</span> <input class="room_limit" type="text" id="attribute_value_38_max" name="attr_slider[38][max]" value="" placeholder="Более"></div></div>'); 
		
		iF();
	}


    function setSort(data){
        jQuery('#pricesort').attr('data-sort',data);
        valuta = jQuery( "input:radio[name=valute]:checked" ).val();
        jQuery('#valutesort').attr('data-valute',valuta);
        iF();
    }

    function setLimit(data){
        jQuery('#pricesort').attr('data-limit',data);
        iF();
    }

    function reset_filter_form() {
        jQuery('#filterpro').get(0).reset();

        jQuery('select.selector').each(function(){
            jQuery(this).selecter('update');
        });
    }

    function set_filter_budjet() {
        var price = jQuery('select#budjet').val();
        jQuery('#filterpro #min_price').val(0);
        jQuery('#filterpro #max_price').val(price);
        jQuery('#filterpro [name=valute][value=usd]').attr('checked','checked');
    }
</script>

</div>
<?php } ?>
<?php echo $header; ?><?php echo $column_right; ?>
<?php echo $content_top; ?>
<div class="content">
<div class="conteiner relative mob-conteiner">
<div class="row product">
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

  <h2><?php echo $heading_title; ?></h2>

  <?php
  $price_str='';
  if ($price) {
      if (!$special) {
        $price_str .= $rub.' руб. / '.$price.' $';
      } else {
          if ($currency_id == 1) {
              $price_str .= '<strike>'.$rub.' руб.</strike> / '.$special_rub.' руб.';
          } else {
            $price_str .= '<strike>'.$price.' $</strike> / '.$special.' $';
          }
      }
  }
  ?>
  
<?php if($this_lots == 0){ ?>
    <div id="tabs" class="htabs">
<?php if($images_exterior){?>
        <a href="#tab-exterior" class="tab-exterior">Экстерьер</a>
<?php } ?>

<?php if($images_interior){?>
	    <a href="#tab-interior" class="tab-interior">Интерьер</a>
<?php } ?>

<?php if($images_more){?>
        <a href="#tab-more" class="tab-more">Дополнительно</a>
<?php } ?>
    </div>

<?php if($images_exterior){?>
<div id="tab-exterior" class="tab-content">
    <div class="wrap-ft">
        <div class="obj_model" id="hide"><?php echo $model ?> </div>
		
<!--JGallery-->
<div class="gallery">
    <div class="album">

    <?php foreach ($images_exterior as $image) { ?>

			     <a href="<?php echo $image['orig'] ?>"><img src="<?php echo $image['orig'] ?>" alt="
			<?php if(empty($price) || empty($rub)){ ?>
                    <?php echo 'Цена по запросу&nbsp;&nbsp;'; ?>
	        <?php } ?>
		    <?php if(!empty($price) || !empty($rub)){ ?>
		        <?php if($view_price_from == 0){ ?>
				    <?php echo $price_str; ?>
		        <?php }elseif($view_price_from == 1){ ?>
				    <?php echo 'Цена в месяц от' .'&nbsp;'. $price_str; ?>
				<?php }elseif($view_price_from == 2){ ?>
				    <?php echo 'Цена в сутки от' .'&nbsp;'. $price_str; ?>
				<?php } ?>
            <?php } ?>
				 " /></a>
    <?php } ?>
       <div class="price"></div>

    </div>
</div>

    </div>

</div>
<?php } ?>

<?php if($images_interior){?>
<div id="tab-interior" class="tab-content">
    <div class="wrap-ft">
        <div class="obj_model" id="hide"><?php echo $model ?> </div>
		
<!--JGallery-->
<div class="gallery">
    <div class="album">
	<!--<?php if ($thumb_orig) { ?>
	             <a href="<?php echo $thumb_orig ?>"><img src="<?php echo $thumb_orig ?>" alt="
		    <?php if(empty($price) || empty($rub)){ ?>
                    <?php echo 'Цена по запросу&nbsp;&nbsp;'; ?>
	        <?php } ?>
		    <?php if(!empty($price) || !empty($rub)){ ?>
		        <?php if($view_price_from == 0){ ?>
				    <?php echo $price_str; ?>
		        <?php }elseif($view_price_from == 1){ ?>
				    <?php echo 'Цена в месяц от' .'&nbsp;'. $price_str; ?>
				<?php }elseif($view_price_from == 2){ ?>
				    <?php echo 'Цена в сутки от' .'&nbsp;'. $price_str; ?>
				<?php } ?>
            <?php } ?>
				 " /></a>
			 <div class="price"></div>
			 <?php } ?>-->

    <?php foreach ($images_interior as $image) { ?>

			     <a href="<?php echo $image['orig'] ?>"><img src="<?php echo $image['orig'] ?>" alt="
			<?php if(empty($price) || empty($rub)){ ?>
                    <?php echo 'Цена по запросу&nbsp;&nbsp;'; ?>
	        <?php } ?>
		    <?php if(!empty($price) || !empty($rub)){ ?>
		        <?php if($view_price_from == 0){ ?>
				    <?php echo $price_str; ?>
		        <?php }elseif($view_price_from == 1){ ?>
				    <?php echo 'Цена в месяц от' .'&nbsp;'. $price_str; ?>
				<?php }elseif($view_price_from == 2){ ?>
				    <?php echo 'Цена в сутки от' .'&nbsp;'. $price_str; ?>
				<?php } ?>
            <?php } ?>
				 " /></a>
    <?php } ?>
       <div class="price"></div>

    </div>
</div>

        <!--<div class="fotorama"
             data-fit="cover"
             data-width="940"
             data-height="560"
             data-nav="thumbs"
             data-allowfullscreen="true"
             data-thumbwidth="118px"
             data-thumbheight="82px">
			 
            <?php if ($thumb_orig) { ?>
                <img src="<?php echo $thumb_orig ?>" data-caption="<?php echo $price_str; ?>"/>
            <?php } ?>
            <?php foreach ($images as $image) { ?>
            <img src="<?php echo $image['orig'] ?>" data-caption="<?php echo $price_str; ?>"/>
            <?php } ?>
        </div>-->
    </div>
</div>
<?php } ?>

<?php if($images_more){?>
<div id="tab-more" class="tab-content">
    <div class="wrap-ft">
        <div class="obj_model" id="hide"><?php echo $model ?> </div>
		
<!--JGallery-->
<div class="gallery">
    <div class="album">

    <?php foreach ($images_more as $image) { ?>

			     <a href="<?php echo $image['orig'] ?>"><img src="<?php echo $image['orig'] ?>" alt="
			<?php if(empty($price) || empty($rub)){ ?>
                    <?php echo 'Цена по запросу&nbsp;&nbsp;'; ?>
	        <?php } ?>
		    <?php if(!empty($price) || !empty($rub)){ ?>
		        <?php if($view_price_from == 0){ ?>
				    <?php echo $price_str; ?>
		        <?php }elseif($view_price_from == 1){ ?>
				    <?php echo 'Цена в месяц от' .'&nbsp;'. $price_str; ?>
				<?php }elseif($view_price_from == 2){ ?>
				    <?php echo 'Цена в сутки от' .'&nbsp;'. $price_str; ?>
				<?php } ?>
            <?php } ?>
				 " /></a>
    <?php } ?>
       <div class="price"></div>
	 
    </div>
</div>

    </div>

</div>
<?php } ?>
<?php }else{ ?>

<?php if($images_more){?>
    <div class="wrap-ft">
        <div class="obj_model" id="hide"><?php echo $model ?> </div>
		
		<!--JGallery-->
		<div class="gallery">
			<div class="album">

			<?php foreach ($images_more as $image) { ?>

						 <a href="<?php echo $image['orig'] ?>"><img src="<?php echo $image['orig'] ?>" alt="
					<?php if(empty($price) || empty($rub)){ ?>
							<?php echo 'Цена по запросу&nbsp;&nbsp;'; ?>
					<?php } ?>
					<?php if(!empty($price) || !empty($rub)){ ?>
						<?php if($view_price_from == 0){ ?>
							<?php echo $price_str; ?>
						<?php }elseif($view_price_from == 1){ ?>
							<?php echo 'Цена в месяц от' .'&nbsp;'. $price_str; ?>
						<?php }elseif($view_price_from == 2){ ?>
							<?php echo 'Цена в сутки от' .'&nbsp;'. $price_str; ?>
						<?php } ?>
					<?php } ?>
						 " /></a>
			<?php } ?>
			   <div class="price"></div>
			 
			</div>
		</div>

    </div>
<?php } ?>

<?php } ?>


















	
    <?php //} ?>
	<!--Блок раздела видео-->
	<div class="video-in-object">
	<style>
			    .video-product iframe {
                    width: 940px;
                    height: 461px;
                }
    </style>
	<ul>
	<?php foreach($product_video as $video) {?>
	<?php if ($video) { ?>
	<li class="video-product"><?php echo $video["video"]; ?></li>
	<?php } ?>
	<?php } ?>
	</ul>
	</div>
	<?php //if ($video) { ?>
            <!--<style>
                iframe {
                    width: 275px !important;
                    height: 180px !important;
                }
            </style>-->
			<!--<style>
			    .prod-col-right-vid iframe {
                    width: 940px !important;
                    height: 461px !important;
                }
		    </style>
            <div class="prod-col-right-vid">
                <?php echo $video ?>
            </div>-->
        <?php //} ?>
	<!--Блок раздела видео-->
</div>

<?php
$main_options_ids = array(
    13 => 'Тип недвижимости',
    14 => 'Тип сделки',
    19 => 'Площадь общая',
    20 => 'Здание, в котором находится объект',
    21 => 'Принадлежность',
//    43 => 'Количество комнат',
//    56 => 'Количество спален',
//    48 => 'Количество спальных мест',
//    57 => 'Количество этажей',
//    84 => 'Окончание строительства',
//    63 => 'Целевое назначение',
//    64 => 'Строения',
//    83 => 'Количество квартир',
);

$location_options_ids = array(
    15 => 'Город',
    16 => 'Улица',
    17 => 'Номер дома',
);

$specification_options_ids = array(
    96 => 'Дата последнего ремонта',
//    22 => 'Стадия строительства',
//    18 => ' Срок сдачи',
    23 => 'Жилая площадь',
    24 => 'Площадь кухни',
    25 => 'Площадь по комнатам',
//    58 => 'Площадь участка',
//    73 => 'Площаль залов',
//    74 => 'Открытая площадка',
//    77 => 'Площадь торговых залов',
//    78 => 'Площадь складских помещений',
//    79 => 'Площадь полезная',
    26 => 'Материал стен',
    27 => 'Отделка',
    28 => 'Этажность',
    29 => 'Этаж',
    30 => 'Высота потолков',
    31 => 'Паркинг во дворе или в доме',
    32 => 'Лифт',
    33 => 'Санузел',
    34 => 'Балкон/лоджия',
    35 => 'Охранная сигнализация',
    36 => 'Возможность ипотеки',
    37 => 'Возможность рассрочки',
    38 => 'Вид из окна',
    39 => 'Инфраструктура района',
    40 => 'Окружение',
    41 => 'Оператор телефонной связи',
    42 => 'Интернет - провайдер',
//    65 => 'Электричество',
//    66 => 'газ',
//    67 => 'Холодная вода',
//    68 => 'Канализация',
//    69 => 'Закрытая территория',
//    70 => 'Участок находится',
//    71 => 'Подъездные пути',
//    44 => 'Тип рынка',
//    75 => 'Паркинг/Парковка',
//    33 => 'Количество санузлов',
//    59 => 'Продается',
//    45 => 'Общее состояние',
//    60 => 'Гараж/паркоместо',
//    46 => 'Тип квартиры',
//    93 => 'Окна',
//    88 => 'Горячая вода',
//    85 => 'Расстояние до моря',
//    94 => 'Удаленность от центра',
//    86 => 'Квартиры',
//    89 => 'Квартирные приборы учета',
//    87 => ' Отопление',
//    91 => 'Стены',
//    92 => 'Фасад',
//    90 => 'Здание',
//    49 => 'Мебель',
//    50 => 'Кухня',
//    51 => 'Холодильник',
//    52 => 'Стиральная машина',
//    53 => 'Кондиционер',
//    54 => 'Телевидение',
//    55 => 'Интернет',
//    61 => 'Аренда',
);

if ($root_category == 94) {
    $add_specification_options_ids = array(
        22 => 'Стадия строительства',
        18 => ' Срок сдачи',
    );

    $specification_options_ids = $add_specification_options_ids + $specification_options_ids;
}

$main_extra_options = array(
    19 => array(
      'type' => 'text',
      'name' => 'Цена',
      'option_value' => $price_str
    )
);
$location_extra_options = array(
    17 => array(
        'type' => 'text',
        'name' => 'Карта',
        'option_value' => '<p>Показать на карте </p><a href="javascript:void(0)" onclick="show_map();"><img src="/catalog/view/theme/default/images/map_icon.png" /></a>'
    )
);
$specification_extra_options = array();

$main_options = array();
$location_options = array();
$specification_options = array();
$other_options = array();
$_main_options = array();
$_location_options = array();
$_specification_options = array();
$_other_options = array();

$structure_option_id = 47;
$structure = '';

if ($all_options) {
    $main_options_ids = array();
    $location_options_ids = array();
    $specification_options_ids = array();
    foreach($all_options as $option) {
        if ($option['sort_order']>=2000) {
            $main_options_ids[$option['option_id']] = $option['name'];
        } else if ($option['sort_order']>=1000 && $option['sort_order']<2000) {
            $location_options_ids[$option['option_id']] = $option['name'];
        } else {
            $specification_options_ids[$option['option_id']] = $option['name'];
        }
    }
}

if ($options) {
    foreach ($options as $option) {
        //if (empty($option['required'])) continue;
        if (array_key_exists($option['option_id'], $main_options_ids)) {
            $_main_options[$option['option_id']]=$option;
        } else if (array_key_exists($option['option_id'], $location_options_ids)) {
            $_location_options[$option['option_id']]=$option;
        } else if (array_key_exists($option['option_id'], $specification_options_ids)) {
            $_specification_options[$option['option_id']]=$option;
        } else if ($option['option_id'] == $structure_option_id) {
            $structure = $option['option_value'];
        } else {
            $_other_options[$option['option_id']]=$option;
        }
    }

    foreach ($main_options_ids as $option_id=>$option_name) {
        if (array_key_exists($option_id,$_main_options)) {
            if (empty($_main_options[$option_id]['required'])) continue;
            $main_options[]=$_main_options[$option_id];
        } else {
            $main_options[]=array(
                'option_id' => $option_id,
                'type' => 'text',
                'name' => $option_name,
                'option_value' => ''
            );
        }
    }
    foreach ($location_options_ids as $option_id=>$option_name) {
        if (array_key_exists($option_id,$_location_options)) {
            if (empty($_location_options[$option_id]['required'])) continue;
            $location_options[]=$_location_options[$option_id];
        } else {
            $location_options[]=array(
                'option_id' => $option_id,
                'type' => 'text',
                'name' => $option_name,
                'option_value' => ''
            );
        }
    }
    foreach ($specification_options_ids as $option_id=>$option_name) {
        if (array_key_exists($option_id,$_specification_options)) {
            if (empty($_specification_options[$option_id]['required'])) continue;
            $specification_options[]=$_specification_options[$option_id];
        } else {
            $specification_options[]=array(
                'option_id' => $option_id,
                'type' => 'text',
                'name' => $option_name,
                'option_value' => ''
            );
        }
    }
}

function template_include_extra_options(&$options,&$extra_options) {
    $_options = array();
    foreach($options as $option) {
        $_options[]=$option;
        if (array_key_exists($option['option_id'], $extra_options)) {
            $_options[]=$extra_options[$option['option_id']];
            $extra_options[$option['option_id']] = null;
        }
    }
    $options = $_options;
    $_options = null;
    foreach ($extra_options as $option) {
        if (!$option) continue;
        $options[]=$option;
    }
}

function template_render_options_row($option, $tr = true) {
    $html = '';
    if ($option['type'] == 'select' || $option['type'] == 'radio' || $option['type'] == 'checkbox') {
        if ($tr) $html.='<tr>';
        $html.='<td style="color:#919191;">'.$option['name'].'</td>';
        $html.='<td style="color:#000000">';
        foreach ($option['option_value'] as $option_value) {
            $html.='<div>'.$option_value['name'].'</div>';
        }
        $html.='</td>';
        if ($tr) $html.='</tr>';
    }
    if ($option['type'] == 'text' || $option['type'] == 'textarea' || $option['type'] == 'date' || $option['type'] == 'datetime' || $option['type'] == 'time') {
        if ($option['type'] == 'date') $option['option_value'] = date('d.m.Y',strtotime($option['option_value']));
        if ($option['type'] == 'datetime') $option['option_value'] = date('d.m.Y H:i:s',strtotime($option['option_value']));
        if ($tr) $html.='<tr>';
        $html.='<td style="color:#919191;">'.$option['name'].'</td>';
        $html.='<td style="color:#000000">'.$option['option_value'].'</td>';
        if ($tr) $html.='</tr>';
    }
    if ($option['type'] == 'image') {
        if ($tr) $html.='<tr>';
        $html.='<td>'.$option['name'].'</td>';
        $html.='<td>';
        foreach ($option['option_value'] as $option_value) {
            $html.='<div><img src="'.$option_value['image'].'" alt="'.$option_value['name'].'" /></div>';
        }
        $html.='</td>';
        if ($tr) $html.='</tr>';
    }
    return $html;
}

template_include_extra_options($main_options, $main_extra_options);
template_include_extra_options($location_options, $location_extra_options);
template_include_extra_options($specification_options, $specification_extra_options);
?>
<div class="row">
    <div class="prod-col-right">
        <div class="prod-col-right-1">
            <img src="<?php if($agent['image']){ echo $agent['image'];}else{echo '/catalog/view/theme/default/img/agent.png';} ?>" alt=""/>
            <p class="prod-col-right-1-text1"><?php echo $agent['firstname']; ?> <?php echo $agent['lastname']; ?></p>
            <p class="prod-col-right-1-text2">Специалист<br/>по продаже недвижимости</p>
            <p class="prod-col-right-1-text3"><?php echo $agent['phone_1']; ?></p>
            <a href="#otpr-s" class="sing-in">ОТПРАВИТЬ СООБЩЕНИЕ</a>
            <input type="hidden" name="agent-user-id" value="<?php echo $agent['user_id'] ?>" readonly="readonly" />
			<input type="hidden" name="object_id" value="<?php echo $model ?>" readonly="readonly" />
			<a href="<?php echo $link_product; ?>">Объекты агента</a>
        </div>
        <?php if (!$is_favorite): ?>
            <a class="prod-col-right-izbr" id="add-to-favorite" href="javascript:void(0)">добавить в избранное</a>
        <?php else: ?>
            <a class="prod-col-right-izbr" id="remove-from-favorite" href="javascript:void(0)">удалить из избранного</a>
        <?php endif; ?>
        <a class="prod-col-right-pdf" href="<?php echo $pdf_url ?>">скачать PDF</a>
        <div class="prod-col-right-2">	
<script type="text/javascript">(function() {
       if (window.pluso)if (typeof window.pluso.start == "function") return;
       if (window.ifpluso==undefined) { window.ifpluso = 1;
       var d = document, s = d.createElement('script'), g = 'getElementsByTagName';
       s.type = 'text/javascript'; s.charset='UTF-8'; s.async = true;
       s.src = ('https:' == window.location.protocol ? 'https' : 'http')  + '://share.pluso.ru/pluso-like.js';
       var h=d[g]('body')[0];
       h.appendChild(s);
       }})();</script>
<div class="pluso" data-background="transparent" data-options="small,square,line,horizontal,nocounter,theme=04" data-services="vkontakte,odnoklassniki,facebook,twitter,google,moimir,email,print"></div>
	   </div>	
    </div>
    <div class="prod-col-left">
        <?php if (!empty($main_options)) { ?>
            <h3>Основная информация</h3>
            <table border="1">
            <?php foreach ($main_options as $option) { ?>
                <?php echo template_render_options_row($option); ?>
            <?php } ?>
            </table>
        <?php } ?>
        <?php if (!empty($location_options)) { ?>
            <h3>Расположение</h3>
            <table border="1">
            <?php foreach ($location_options as $option) { ?>
                <?php echo template_render_options_row($option); ?>
            <?php } ?>
            </table>
        <?php } ?>
		
        <?php if (!empty($get_options) || !empty($other_options)) { ?>
            </div>
            <div class="col-wide">
            <h3>Характеристики и описание</h3>
            <table border="1" class="table-for-big-screen">
		        
                <?php for($i=0; $i<count($get_options); $i+=2){ ?>
                    <tr>
                    <?php $option = $get_options[$i]; ?>
					
                    <?php echo template_render_options_row($option,false); ?>

                    <?php if (isset($get_options[$i+1])) { ?>
                    <?php $option = $get_options[$i+1]; ?>
                    <?php echo template_render_options_row($option,false); ?>
                    <?php } else { ?>
                        <td></td><td></td>
                    <?php } ?>
                    </tr>
                <?php } ?>
				

                <?php //foreach ($other_options as $option) { ?>
                    <?php //echo template_render_options_row($option); ?>
                <?php //} ?>
            </table>

            <table class="table-for-small-screen">
                <tbody>
				<?php foreach($get_options as $get_option){ ?>
				<tr>
                        <td><?php echo $get_option['name']; ?></td>
				
                        <td><?php echo $get_option['option_value']; ?></td>
                </tr>
				<?php } ?>
                </tbody>
            </table>
<script type="text/javascript">
    /*jQuery(document).ready(function(){
        var t = jQuery('.prod-col-right').offset().top;
        var t2 = jQuery('.col-wide').offset().top;
        jQuery(window).scroll(function(e){
            if (jQuery(window).scrollTop()>=t) {
                jQuery('.prod-col-right').addClass('col-right-fixed');
            } else {
                jQuery('.prod-col-right').removeClass('col-right-fixed');
            }
            if (jQuery(window).scrollTop()>=t2-400) {
                jQuery('.prod-col-right').hide();
            } else {
                jQuery('.prod-col-right').show();
            }
        })
    });*/
</script>	
        <?php } ?>

    </div>


</div>
<div class="pow">
    <div class="container">
        <div class="prod-opis">
            <h3>ОПИСАНИЕ</h3>
            <?php echo $description; ?>

            <?php if (!empty($structure)): ?>
                <h3 style="margin-top:40px">МЕСТОПОЛОЖЕНИЕ, ИНФРАСТРУКТУРА</h3>
                <div style="margin:20px 0px 40px">
                <span><?php echo $structure; ?></span>
                </div>
            <?php endif; ?>

            <?php if (!empty($plans)): ?>
            <div class="prod-plan">
                <h3>ПЛАНИРОВКА</h3>
                <?php foreach($plans as $plan): ?>
                <img src="<?php echo $plan['orig'] ?>"/>
                <?php endforeach; ?>
            </div>
            <?php endif; ?>

            <div class="prod-kart">
                <h3>КАРТА</h3>
                <div id="map" style="width:968px; height:328px"></div>

                <script src="http://api-maps.yandex.ru/2.0/?load=package.standard&lang=ru-RU" type="text/javascript"></script>
                <?php if($ean || $lat_lng){ ?>
                    <script type="text/javascript">
                        var myMap;
						
                        ymaps.ready(init);
                        function init()
                        {
						<?php if($ean){ ?>
						    ymaps.geocode('<?php echo $ean; ?>', {
                                results: 1
                            })
						<?php }else{ ?>
                        var myCoords = [<?php echo $lat_lng; ?>];  
                        var myGeocoder = ymaps.geocode(myCoords);
                        myGeocoder
						<?php } ?>
						.then(
                                function (res)
                                {
                                    var firstGeoObject = res.geoObjects.get(0),
                                        myMap = new ymaps.Map
                                        ("map",
                                            {
                                                center: firstGeoObject.geometry.getCoordinates(),
                                                zoom: 15
                                            }
                                        );
                                    var myPlacemark = new ymaps.Placemark
                                    (
                                        firstGeoObject.geometry.getCoordinates(),
                                        {
                                            iconContent: ''
                                        },
                                        {
                                            preset: 'twirl#blueStretchyIcon'
                                        }
                                    );
                                    myMap.geoObjects.add(myPlacemark);
                                    myMap.controls.add(new ymaps.control.ZoomControl()).add(new ymaps.control.ScaleLine()).add('typeSelector');
                                },
                                function (err)
                                {
                                    alert(err.message);
                                }
                            );
                        }
                    </script>
  	            <?php } ?>
            </div>
        </div>
    </div>
</div>

</div>
</div>

<?php if (!empty($products)) { ?>
<div class="row bg-slider-prod">
    <div class="conteiner">
        <h3>похожие объекты</h3>
        <div class="slider2">
            <?php foreach($products as $product) { ?>
            <div class="slide">
                <a href="<?php echo $product['href'] ?>">
                    <div class="slider2-img">
                        <?php if ($product['thumb']) { ?>
                            <img src="<?php echo $product['thumb']; ?>" alt="<?php echo $product['name']; ?>"/>
                        <?php } else { ?>
                            <img src="/catalog/view/theme/default/img/nophoto.png" alt="Нет изображения"/>
                        <?php } ?>
                        <div class="slider2-img-text">
                            <?php if (!$product['special']) { ?>
                                <!--<?php echo $product['rub']; ?> руб. / <?php echo $product['price']; ?> $-->
                                <?php echo $product['price']; ?> $
                            <?php } else { ?>
                                <!--<span class="price-old"><?php echo $product['price']; ?></span>--> <span class="price-new"><?php echo $product['special']; ?></span>
                            <?php } ?>
                        </div>
                        <div class="slider2-img-av"><img src="<?php echo (!empty($product['agent']['image']) ? $product['agent']['image'] : '/catalog/view/theme/default/img/agent.png'); ?>" alt=""/></div>
                    </div>
                </a>
                <p class="slider2-text1"><?php echo $product['name'] ?></p>
                <p class="slider2-text2"></p>
            </div>
            <?php } ?>
        </div>
    </div>
</div>

<script>
    jQuery(document).ready(function(){
        jQuery('.slider2').bxSlider({
            slideWidth: 280,
            minSlides: 3,
            maxSlides: 3,
            moveSlides: 1,
            pager: false,
            slideMargin: 10
        });
    });
</script>
<?php } ?>

<?php echo $content_bottom; ?>

<script type="text/javascript">
    function show_map() {
        jQuery('body, html').animate({'scrollTop':$('#map').offset().top},400);
    }
</script>

<script type="text/javascript">
//$('#review .pagination a').live('click', function() {
jQuery('#review').on('click', '.pagination a',function() {
	jQuery('#review').fadeOut('slow');
		
	jQuery('#review').load(this.href);
	
	jQuery('#review').fadeIn('slow');
	
	return false;
});			

jQuery('#review').load('index.php?route=product/product/review&product_id=<?php echo $product_id; ?>');

jQuery('#button-review').bind('click', function() {
	jQuery.ajax({
		url: 'index.php?route=product/product/write&product_id=<?php echo $product_id; ?>',
		type: 'post',
		dataType: 'json',
		data: 'name=' + encodeURIComponent($('input[name=\'name\']').val()) + '&text=' + encodeURIComponent($('textarea[name=\'text\']').val()) + '&rating=' + encodeURIComponent($('input[name=\'rating\']:checked').val() ? $('input[name=\'rating\']:checked').val() : '') + '&captcha=' + encodeURIComponent($('input[name=\'captcha\']').val()),
		beforeSend: function() {
			jQuery('.success, .warning').remove();
			jQuery('#button-review').attr('disabled', true);
			jQuery('#review-title').after('<div class="attention"><img src="catalog/view/theme/default/image/loading.gif" alt="" /> <?php echo $text_wait; ?></div>');
		},
		complete: function() {
			jQuery('#button-review').attr('disabled', false);
			jQuery('.attention').remove();
		},
		success: function(data) {
			if (data['error']) {
				jQuery('#review-title').after('<div class="warning">' + data['error'] + '</div>');
			}
			
			if (data['success']) {
				jQuery('#review-title').after('<div class="success">' + data['success'] + '</div>');
								
				jQuery('input[name=\'name\']').val('');
				jQuery('textarea[name=\'text\']').val('');
				jQuery('input[name=\'rating\']:checked').attr('checked', '');
				jQuery('input[name=\'captcha\']').val('');
			}
		}
	});
});
</script>

<script type="text/javascript">
    jQuery(document).ready(function(){
       jQuery('#add-to-favorite').click(function(e){
           e.stopPropagation();
           e.preventDefault();

           jQuery.post(
               '/index.php?route=module/favorites',
               {
                   'sess_id': '<?php echo $sess_id ?>',
                   'product_id': '<?php echo $product_id ?>'
               },
               function(response) {
                   if (!response) return;
                   if (response.status) {
                       jQuery('#add-to-favorite').text('добавлено в избранное');
                       jQuery('#add-to-favorite').unbind('click');
                       jQuery('#add-to-favorite').attr('href','/index.php?route=module/favorites/favorites');
                   }
               },
               'json'
           )
       });
    });

    jQuery(document).ready(function(){
        jQuery('#remove-from-favorite').click(function(e){
            e.stopPropagation();
            e.preventDefault();

            jQuery.post(
                '/index.php?route=module/favorites/remove',
                {
                    'sess_id': '<?php echo $sess_id ?>',
                    'product_id': '<?php echo $product_id ?>'
                },
                function(response) {
                    if (!response) return;
                    if (response.status) {
                        jQuery('#remove-from-favorite').text('удалено из избранного');
                        jQuery('#remove-from-favorite').unbind('click');
                        jQuery('#remove-from-favorite').attr('href','/index.php?route=module/favorites/favorites');
                    }
                },
                'json'
            )
        });
    });
</script>

<script type="text/javascript"><!--
jQuery('#tabs a').tabs();
//--></script> 

<?php if($this_lots == 0){ ?>
<?php if($images_interior || $images_exterior || $images_more){ ?>
<script type="text/javascript">
jQuery( '.gallery' ).jGallery();
jQuery('.fa.change-mode').on('click', function(){ 
    jQuery("#hide").toggleClass('hideble'); 
});

jQuery('.tab-interior').click(function(){
    jQuery( '.gallery' ).jGallery({ mode: 'standard', autostart: true, autostartAtImage: 1, autostartAtAlbum: 1,});
});

jQuery('.tab-exterior').click(function(){
    jQuery( '.gallery' ).jGallery({ mode: 'standard', autostart: true, autostartAtImage: 1,  autostartAtAlbum: 1, });
});

jQuery('.tab-more').click(function(){
    jQuery( '.gallery' ).jGallery({ mode: 'standard', autostart: true, autostartAtImage: 1, autostartAtAlbum: 1, });
});
</script>
<?php } ?>
<?php }else{ ?>

<script type="text/javascript">
	jQuery( '.gallery' ).jGallery();
</script>

<?php } ?>

<?php echo $footer; ?>
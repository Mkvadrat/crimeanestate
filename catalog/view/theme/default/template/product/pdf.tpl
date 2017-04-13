<h2><?php echo $heading_title; ?></h2>
<?php if ($thumb_orig) { ?>
    <?php /*$f = $_SERVER['DOCUMENT_ROOT'].$thumb_orig; ?>
    <?php if (file_exists($f)) { ?>
    <?php $size = getimagesize($f); ?>
    <?php if ($size) { ?>
    <?php $width = 630; ?>
    <?php $height = $size[1] * $width / $size[0];*/ ?>
    <img src="<?php echo $thumb_orig ?>" width="<?php //echo $width ?>" height="<?php //echo $height ?>" />
    <?php //} ?>
    <?php //} ?>
<?php } ?>

<?php //var_dump($thumb_orig); ?>

&nbsp;
<br />
<?php
$count = count($breadcrumbs);
$i=1;
foreach ($breadcrumbs as $breadcrumb) {
if ($i==1) {
    $i++;
    continue;
}
if($i!=$count){
    if ($i>2) echo '&nbsp;&rsaquo;'; ?>
    <?php echo $breadcrumb['text']; ?>
<?php
}
$i++;
} ?>


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
<h3>Цена: <?php echo $price_str ?></h3>
<p>Онлайн версия страницы: <a href="<?php echo $href ?>"><?php echo $href ?></a></p>
<!--break-->



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
if ($ean) {
    $location_extra_options = array(
        17 => array(
            'type' => 'text',
            'name' => 'Карта',
            'option_value' => '<a href="https://maps.yandex.com/?text='.urlencode($ean).'">Показать на карте</a>'
        )
    );
} else {
    $location_extra_options = array();
}
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

function template_render_options_row($option, $iter=0) {
    $style=' style="background-color:'.($iter%2!=0 ? '#efefef' : '#ffffff').'"';
    $html = '';
    if ($option['type'] == 'select' || $option['type'] == 'radio' || $option['type'] == 'checkbox') {
        foreach ($option['option_value'] as $option_value) {
            $html.='<tr'.$style.'>';
            $html.='<td>'.$option['name'].'</td>';
            $html.='<td>'.$option_value['name'].'</td>';
            $html.='</tr>';
        }
    }
    if ($option['type'] == 'text' || $option['type'] == 'textarea' || $option['type'] == 'date' || $option['type'] == 'datetime' || $option['type'] == 'time') {
        if ($option['type'] == 'date') $option['option_value'] = date('d.m.Y',strtotime($option['option_value']));
        if ($option['type'] == 'datetime') $option['option_value'] = date('d.m.Y H:i:s',strtotime($option['option_value']));
        $html.='<tr'.$style.'>';
        $html.='<td>'.$option['name'].'</td>';
        $html.='<td>'.$option['option_value'].'</td>';
        $html.='</tr>';
    }
    if ($option['type'] == 'image') {
        foreach ($option['option_value'] as $option_value) {
            $html.='<tr'.$style.'>';
            $html.='<td>'.$option['name'].'</td>';
            $html.='<td><img src="'.$option_value['image'].'" alt="'.$option_value['name'].'" /></td>';
            $html.='</tr>';
        }
    }
    return $html;
}

template_include_extra_options($main_options, $main_extra_options);
template_include_extra_options($location_options, $location_extra_options);
template_include_extra_options($specification_options, $specification_extra_options);
?>


<?php if (!empty($main_options)) { ?>
    <h3>Основная информация</h3>
    <table border="1" style="padding:10px">
        <?php $co = 0; ?>
        <?php foreach ($main_options as $option) { ?>
            <?php echo template_render_options_row($option,$co); ?>
            <?php $co++; ?>
        <?php } ?>
    </table>
<?php } ?>
<?php if (!empty($location_options)) { ?>
    <br />
    <h3>Расположение</h3>
    <table border="1" style="padding:10px">
        <?php $co = 0; ?>
        <?php foreach ($location_options as $option) { ?>
            <?php echo template_render_options_row($option,$co); ?>
            <?php $co++; ?>
        <?php } ?>
    </table>
<?php } ?>
<?php if (!empty($specification_options) || !empty($other_options)) { ?>
    <br />
    <h3>Характеристики и описание</h3>
    <table border="1" style="padding:10px">
        <?php $co = 0; ?>
        <?php foreach ($specification_options as $option) { ?>
            <?php echo template_render_options_row($option,$co); ?>
            <?php $co++; ?>
        <?php } ?>

        <?php //foreach ($other_options as $option) { ?>
            <?php //echo template_render_options_row($option,$co); ?>
            <?php //$co++; ?>
        <?php //} ?>
    </table>
<?php } ?>
<!--break-->

<h3>ОПИСАНИЕ</h3>
<?php echo nl2br(strip_tags($description)); ?>

<?php if (!empty($structure)): ?>
    <br />
    <h3 style="margin-top:40px">МЕСТОПОЛОЖЕНИЕ, ИНФРАСТРУКТУРА</h3>
    <?php echo $structure; ?>
<?php endif; ?>
<!--break-->
<?php if (!empty($plans)): ?>
    <h3>ПЛАНИРОВКА</h3>
    <?php foreach($plans as $plan): ?>
        <img src="<?php echo $plan['orig'] ?>"/>
    <?php endforeach; ?>
<?php endif; ?>
<!--break-->
<!--<?php if ($images) { ?>
    <h3>ГАЛЕРЕЯ</h3>
    <?php foreach ($images as $image) { ?>
        <?php $f = $_SERVER['DOCUMENT_ROOT'].$image['orig']; ?>
        <?php if (!file_exists($f)) continue; ?>
        <?php $size = getimagesize($f); ?>
        <?php if (!$size) continue; ?>
        <?php $width = 630; ?>
        <?php $height = $size[1] * $width / $size[0]; ?>
        <?php if ($height>400) { ?>
        <?php $width = $width * 400 / $height; ?>
        <?php $height = 400; ?>
        <?php } ?>
        <img src="<?php echo $image['orig'] ?>" width="<?php echo $width ?>" height="<?php echo $height ?>" />
    <?php } ?>
<?php } ?>-->

<!--<?php if($images_interior){?>
	<h3>ИНТЕРЬЕР</h3>
	<?php $i = 0;?>
	<?php foreach ($images_interior as $image) { ?>
	<?php $i++; if($i > 4) break;?>
	<img src="<?php echo $image['orig'] ?>" />
	<?php } ?>
<?php } ?>

<?php if($images_exterior){?>
	<h3>ЭКСТЕРЬЕР</h3>
	<?php $i = 0;?>
	<?php foreach ($images_exterior as $image) { ?>
	<?php $i++; if($i > 4) break;?>
	<img src="<?php echo $image['orig'] ?>" />
	<?php } ?>
<?php } ?>

<?php if($images_more){?>
	<h3>ДОПОЛНИТЕЛЬНО</h3>
	<?php $i = 0;?>
	<?php foreach ($images_more as $image) { ?>
	<?php $i++; if($i > 4) break;?>
	<img src="<?php echo $image['orig'] ?>" />
	<?php } ?>
<?php } ?>-->

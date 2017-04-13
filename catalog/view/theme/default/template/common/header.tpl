<!DOCTYPE html>
<html dir="<?php echo $direction; ?>" lang="<?php echo $lang; ?>">
<head>
    <meta charset="UTF-8" />
    <title><?php echo $title; ?></title>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="format-detection" content="telephone=no">

    <title><?php echo $title; ?></title>
    <base href="<?php echo $base; ?>" />
    <?php if ($description) { ?>
    <meta name="description" content="<?php echo $description; ?>" />
    <?php } ?>
    <?php if ($keywords) { ?>
    <meta name="keywords" content="<?php echo $keywords; ?>" />
    <?php } ?>
    <?php if ($icon) { ?>
    <link href="<?php echo $icon; ?>" rel="icon" />
    <?php } ?>
    <?php foreach ($links as $link) { ?>
    <link href="<?php echo $link['href']; ?>" rel="<?php echo $link['rel']; ?>" />
    <?php } ?>

    <?php foreach ($styles as $style) { ?>
    <link rel="<?php echo $style['rel']; ?>" type="text/css" href="<?php echo $style['href']; ?>" media="<?php echo $style['media']; ?>" />
    <?php } ?>

    <link href="/catalog/view/theme/default/css/camera.css" rel="stylesheet">
    <link href="/catalog/view/theme/default/css/jquery.fs.selecter.css" rel="stylesheet">
    <link href="/catalog/view/theme/default/css/jquery.bxslider.css" rel="stylesheet" />
    <link href="/catalog/view/theme/default/css/jquery.fs.boxer.css" rel="stylesheet" />
    <link href="/catalog/view/theme/default/css/style.css" rel="stylesheet">
    <link href="/catalog/view/theme/default/css/media.css" rel="stylesheet">

    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">

    <!--<script src="/catalog/view/theme/default/js/jquery.min.js"></script>-->
    <script src="catalog/view/javascript/jquery/jquery-1.7.1.min.js"></script>
    <?php if($category_path){ ?>
    <script src="catalog/view/javascript/jquery/ui/external/jquery.cookie.js"></script>
    <script src="catalog/view/javascript/jquery/jquery.tmpl.min.js"></script>
    <script src="catalog/view/javascript/jquery/jquery.deserialize.min.js"></script>
    <script src="catalog/view/javascript/jquery/jquery.loadmask.min.js"></script>
    <script src="catalog/view/javascript/filterpro.min.js"></script>
    <?php } ?>

    <script src='/catalog/view/theme/default/js/jquery.mobile.customized.min.js'></script>
    <script src='/catalog/view/theme/default/js/jquery.easing.1.3.js'></script>
    <script src='/catalog/view/theme/default/js/camera.min.js'></script>
    <script src='/catalog/view/theme/default/js/jquery.fs.selecter.min.js'></script>
    <script src="/catalog/view/theme/default/js/jquery.bxslider.min.js"></script>
    <script src="/catalog/view/theme/default/js/jquery.fs.boxer.js"></script>
    <script src="/catalog/view/javascript/jquery/tabs.js"></script>

    <!--Gallery-->
    <!--js-->
    <script src="/catalog/view/theme/default/gallery/js/touchswipe.min.js"></script>
    <script src="/catalog/view/theme/default/gallery/js/touchswipe.js"></script>
    <script src="/catalog/view/theme/default/gallery/js/tinycolor-0.9.16.min.js"></script>
    <script src="/catalog/view/theme/default/gallery/js/jgallery.min.js"></script>
    <script src="/catalog/view/theme/default/gallery/js/jgallery.js"></script>
    <!--css-->
    <!--<link href="/catalog/view/theme/default/gallery/css/jgallery.min.css" rel="stylesheet" />-->
    <link href="/catalog/view/theme/default/gallery/css/jgallery.css" rel="stylesheet" />
    <link href="/catalog/view/theme/default/gallery/css/font-awesome.min.css" rel="stylesheet" />

    <!--Popup-image-->
    <!--js-->
	<!--<link rel="stylesheet" type="text/css" href="/catalog/view/javascript/fancybox/jquery.fancybox.css?v=2.1.5" media="screen" />
	<link rel="stylesheet" type="text/css" href="/catalog/view/javascript/fancybox/helpers/jquery.fancybox-thumbs.css?v=1.0.7" />
	<link rel="stylesheet" type="text/css" href="/catalog/view/javascript/fancybox/helpers/jquery.fancybox-buttons.css?v=1.0.5" />-->
	<!--css-->
	<!--<script type="text/javascript" src="/catalog/view/javascript/fancybox/jquery.fancybox.js?v=2.1.5"></script>
	<script type="text/javascript" src="/catalog/view/javascript/fancybox/helpers/jquery.fancybox-buttons.js?v=1.0.5"></script>
	<script type="text/javascript" src="/catalog/view/javascript/fancybox/helpers/jquery.fancybox-thumbs.js?v=1.0.7"></script>
	<script type="text/javascript" src="/catalog/view/javascript/fancybox/helpers/jquery.fancybox-media.js?v=1.0.6"></script>-->
	

    <?php foreach ($scripts as $script) { ?>
    <script type="text/javascript" src="<?php echo $script; ?>"></script>
    <?php } ?>

    <script>
        (function($) {
            jQuery(function() {
                jQuery('#up').click(function() {
                    jQuery('html, body').animate({scrollTop: 0},500);
                    return false;
                })
            })
        })(jQuery);
    </script>

<!--<?php if(preg_match( "#sale#", $_SERVER['REQUEST_URI']) || preg_match( "#hire#", $_SERVER['REQUEST_URI']) || preg_match( "#category#", $_SERVER['REQUEST_URI'])){ ?>
    <script>
	    $(document).ready(function(){
            $('select.selector').each(function(){
                $(this).selecter({
                    mobile: true,
                    label: $(this).attr('title')
                });
            });
        });	
    </script>
<?php } else {?>
    <script>
	    jQuery(document).ready(function(){
            jQuery('select.selector').each(function(){
                jQuery(this).selecter({
                    mobile: true,
                    label: $(this).attr('title')
                });
            });
        });	
    </script>
    <?php } ?>-->

    <script>
       jQuery(document).ready(function(){
        jQuery('select.selector').each(function(){
            jQuery(this).selecter({
                mobile: true,
                label: jQuery(this).attr('title')
            });
        });
    });	
</script>

<?php //echo $google_analytics; ?>



<!-- BOOTSTRAP -->

  <!--<link href="/catalog/view/theme/default/css/bootstrap.min.css" rel="stylesheet">
  <script src="/catalog/view/theme/default/js/javascript/bootstrap.min.js"></script>-->

</head>
<body>
    <div class="wrapper">
        <header>

            <div class="conteiner">
                <div class="row">
                  <div class="head-block-1-3"><a href="/"><img src="image/data/LOGO/logo_ce.png" alt=""/></a></div>
                  <div class="head-block-1">
                    <div class="head-block-1-1">
                        <ul>
                            <li><a href="https://www.instagram.com/CrimeanyEstaten" target="_blank"><img src="/catalog/view/theme/default/img/instagram.png" alt=""/></a></li>
                            <li><a href="https://rutube.ru/video/person/1239203/" target="_blank"><img src="/catalog/view/theme/default/img/rutube.png" alt=""/></a></li>
                            <li><a href="https://vk.com/crimeanestate" target="_blank"><img src="/catalog/view/theme/default/img/vk.png" alt=""/></a></li>
                            <li><a href="https://www.youtube.com/channel/UCpbsVZiZHxrkCbZ6oWGdL8A" target="_blank"><img src="/catalog/view/theme/default/img/youtube.png" alt=""/></a></li>
                            <li><a href="https://plus.google.com/111437357471813844386" target="_blank"><img src="/catalog/view/theme/default/img/google.png" alt=""/></a></li>
                            <li><a href="https://www.facebook.com/krimskaya.nedvigimost" target="_blank"><img src="/catalog/view/theme/default/img/facebook.png" alt=""/></a></li>
                            <li><a href="https://www.linkedin.com/pub/%D0%BA%D1%80%D1%8B%D0%BC%D1%81%D0%BA%D0%B0%D1%8F-%D0%BD%D0%B5%D0%B4%D0%B2%D0%B8%D0%B6%D0%B8%D0%BC%D0%BE%D1%81%D1%82%D1%8C/bb/658/b88" target="_blank"><img src="/catalog/view/theme/default/img/linkedin.png" alt=""/></a></li>
                        </ul>
                    </div>
                    <div class="head-block-1-2"></div>
                    <div class="head-block-1-4">&nbsp;&nbsp;8 (800) 234-78-99<br/>+7 (978) 807-00-67<br/>+7 (978) 807-00-57</div>

                    <div class="head-block-1-4-mobile">
                        <p>8 (800) 234-78-99 </p>
                        <p>+7 (978) 807-00-67</p>
                        <p>+7 (978) 807-00-57</p>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="wrap-head-menu">
                    <div class="head-menu">
                        <ul>
                        <?php
                            $menu = array(
                                '/sale' => 'ПРОДАЖА',
                                //'/rent' => 'АРЕНДА',
                                '/hire' => 'АРЕНДА И НАЙМ',
                                '/safety' => 'БЕЗОПАСНАЯ ПОКУПКА',
                                '/about_us' => 'КОМПАНИЯ',
								'/contact' => 'КОНТАКТЫ',
                            );
                        ?>
                            <?php foreach ($menu as $url=>$title): ?>
                                <li><a href="<?php echo $url; ?>"<?php if ($url==$request_uri){ echo 'class="active"';}?>><?php echo $title; ?></a></li>
                            <?php endforeach; ?>
                        </ul>
                    </div>

					<form class="head-search-form" action="/search" method="get">
						<input type="search" class="search-input" placeholder="ID ОБЪЕКТА" name="filter_name" />
						<button></button>
					</form>

                    <ul class="accordion">
                        <li class="accordion_item">
                            <label class="accordion_trigger" for="toggle-01"><i class="fa fa-bars" aria-hidden="true"></i></label>
                            <input type="checkbox" class="accordion_toggle" name="accordion-01" id="toggle-01"/>
                            <div class="accordion_target">
                                <ul>
                        <?php
                            $menu = array(
                                '/sale' => 'ПРОДАЖА',
                                //'/rent' => 'АРЕНДА',
                                '/hire' => 'АРЕНДА И НАЙМ',
                                '/safety' => 'БЕЗОПАСНАЯ ПОКУПКА',
                                '/about_us' => 'КОМПАНИЯ',
								'/contact' => 'КОНТАКТЫ',
                            );
                        ?>
                            <?php foreach ($menu as $url=>$title): ?>
                                <li><a href="<?php echo $url; ?>"<?php if ($url==$request_uri){ echo 'class="active"';}?>><?php echo $title; ?></a></li>
                            <?php endforeach; ?>
                                </ul>
                            </div>
                        </li>
                    </ul>
                </div>
            </div>
        </div>

    </header><!-- header -->

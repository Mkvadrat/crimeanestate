<?php

if(isset($this->request->get['route'])){
	$current_location = explode("/", $this->request->get['route']);
	if($current_location[0] == "common"){
		$is_homepage = TRUE;
	}else{
		$is_homepage = FALSE;
	}
}else{
	$is_homepage = FALSE;
}

$get_url = explode("&", $_SERVER['QUERY_STRING']);

$get_route = substr($get_url[0], 6);

$get_route = explode("/", $get_route);

$page_name = array("shoppica2","journal_banner","journal_bgslider","journal_cp","journal_filter","journal_gallery","journal_menu","journal_product_slider","journal_product_tabs","journal_rev_slider","journal_slider");

// array_push($page_name, "EDIT-ME");

if(array_intersect($page_name, $get_route)){
	$is_custom_page = TRUE;
}else{
	$is_custom_page = FALSE;
}

?>
<?php echo '<?xml version="1.0" encoding="UTF-8"?>' . "\n"; ?>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" dir="<?php echo $direction; ?>" lang="<?php echo $lang; ?>" xml:lang="<?php echo $lang; ?>">
<head>
	<meta charset="utf-8" />
	<title><?php echo $title; ?></title>
	<base href="<?php echo $base; ?>" />
	<?php if ($description) { ?>
	<meta name="description" content="<?php echo $description; ?>" />
	<?php } ?>
	<?php if ($keywords) { ?>
	<meta name="keywords" content="<?php echo $keywords; ?>" />
	<?php } ?>
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	<meta name="description" content="" />
	<meta name="author" content="" />
	<?php foreach ($links as $link) { ?>
	<link href="<?php echo $link['href']; ?>" rel="<?php echo $link['rel']; ?>" />
	<?php } ?>
    
	<!--Ion tabs style-->
	<link type="text/css" href="view/stylesheet/admin_theme/base5builder_impulsepro/ion-tabs/ion.tabs.css" rel="stylesheet" />
	<link type="text/css" href="view/stylesheet/admin_theme/base5builder_impulsepro/ion-tabs/ion.tabs.skinBordered.css" rel="stylesheet" />
	<!--<link type="text/css" href="view/stylesheet/admin_theme/base5builder_impulsepro/ion-tabs/ion.tabs.skinFlat.css" rel="stylesheet" />-->
	<!--Ion tabs style-->
	
	<!-- Le styles -->
	<?php if(!$is_custom_page){ ?>
	<link type="text/css" href="view/stylesheet/admin_theme/base5builder_impulsepro/bootstrap.css" rel="stylesheet" />
	<link type="text/css" href="view/stylesheet/admin_theme/base5builder_impulsepro/style.css" rel="stylesheet" />
	<link type="text/css" href="view/stylesheet/admin_theme/base5builder_impulsepro/bootstrap-responsive.css" rel="stylesheet" />
	<link type="text/css" href="view/stylesheet/admin_theme/base5builder_impulsepro/style-responsive.css" rel="stylesheet" />

	<?php }else{ ?>
	<link rel="stylesheet" type="text/css" href="view/stylesheet/stylesheet.css" />
	<link type="text/css" href="view/stylesheet/admin_theme/base5builder_impulsepro/style-custom-page.css" rel="stylesheet" />
	<?php
}
?>
<link type="text/css" href="http://fonts.googleapis.com/css?family=Raleway' rel='stylesheet" />
<link type="text/css" href="view/javascript/admin_theme/base5builder_impulsepro/ui/themes/ui-lightness/jquery-ui-1.8.20.custom-min.css" rel="stylesheet" />
	  <!--[if IE 7]>
	  <link type="text/css" href="view/stylesheet/admin_theme/base5builder_impulsepro/style-ie7.css" rel="stylesheet">
	  <![endif]-->
	  <!--[if IE 8]>
	  <link type="text/css" href="view/stylesheet/admin_theme/base5builder_impulsepro/style-ie8.css" rel="stylesheet">
	  <![endif]-->
	  <script type="text/javascript" src="view/javascript/admin_theme/base5builder_impulsepro/jquery.js"></script>
	  <script type="text/javascript" src="view/javascript/admin_theme/base5builder_impulsepro/ui/jquery-ui-1.8.20.custom.min.js"></script>
	  <script type="text/javascript" src="view/javascript/admin_theme/base5builder_impulsepro/tabs.js"></script>
	  
	  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.6.1/css/font-awesome.min.css">

	  <!--Ion tabs js-->
	  <script type="text/javascript" src="view/javascript/admin_theme/base5builder_impulsepro/ion-tabs/ion.tabs.min.js"></script>
	  <script type="text/javascript" src="view/javascript/admin_theme/base5builder_impulsepro/ion-tabs/ion.tabs.js"></script>
	  <!--Ion tabs js-->
	  
	  <!--CKEDITOR-->
	  <script type="text/javascript" src="view/javascript/ckeditorforsetting/ckeditor.js"></script>
	  <!--CKEDITOR-->
	  <?php foreach ($styles as $style) { ?>
	  <link rel="<?php echo $style['rel']; ?>" type="text/css" href="<?php echo $style['href']; ?>" media="<?php echo $style['media']; ?>" />
	  <?php } ?>
	  <?php foreach ($scripts as $script) { ?>
	  <script type="text/javascript" src="<?php echo $script; ?>"></script>
	  <?php } ?>
	  <?php if($this->user->getUserName() && $is_homepage){ ?>
	  <script type="text/javascript" src="view/javascript/admin_theme/base5builder_impulsepro/flot/jquery.flot.min.js"></script>
	  <script type="text/javascript" src="view/javascript/admin_theme/base5builder_impulsepro/flot/jquery.flot.pie.min.js"></script>
	  <script type="text/javascript" src="view/javascript/admin_theme/base5builder_impulsepro/flot/curvedLines.min.js"></script>
	  <script type="text/javascript" src="view/javascript/admin_theme/base5builder_impulsepro/flot/jquery.flot.tooltip.min.js"></script>
	  <script type="text/javascript" src="view/javascript/admin_theme/base5builder_impulsepro/modernizr.js"></script>
		<!--[if lte IE 8]>
		<script type="text/javascript" src="view/javascript/admin_theme/base5builder_impulsepro/excanvas.min.js"></script>
		<![endif]-->
		<?php } ?>
		<script type="text/javascript">
		$(document).ready(function(){

		// Signin - Button

		$(".form-signin-body-right input").click(function(){
			$(".form-signin").submit();
		});

		// Signin - Enter Key

		$('.form-signin input').keydown(function(e) {
			if (e.keyCode == 13) {
				$('.form-signin').submit();
			}
		});

	    // Confirm Delete
	    $('#form').submit(function(){
	    	if ($(this).attr('action').indexOf('delete',1) != -1) {
	    		if (!confirm('<?php echo $text_confirm; ?>')) {
	    			return false;
	    		}
	    	}
	    });

		// Confirm Uninstall
		$('a').click(function(){
			if ($(this).attr('href') != null && $(this).attr('href').indexOf('uninstall', 1) != -1) {
				if (!confirm('<?php echo $text_confirm; ?>')) {
					return false;
				}
			}
		});
	});
		</script>

		<!-- HTML5 shim, for IE6-8 support of HTML5 elements -->
  <!--[if lt IE 9]>
  <script type="text/javascript" src="view/javascript/admin_theme/base5builder_impulsepro/html5shiv.js"></script>
  <![endif]-->

  <!-- Fav and touch icons -->
  <!--<link rel="shortcut icon" href="view/image/admin_theme/base5builder_impulsepro/favicon.png" />-->
  
  
  
  <script type="text/javascript" src="view/javascript/fileuploader.js"></script>
  <link rel="stylesheet" type="text/css" href="view/stylesheet/fileuploader.css" />
</head>

<body>

	<div class="container-fluid">

		<?php if ($logged) { ?>

		<div id="left-column">
			<div class="sidebar-logo">
				<a href="<?php echo $home; ?>">
					<img src="/image/data/LOGO/logo-for-admin.jpg" />
				</a>
			</div>
			<div id="mainnav">
				<ul class="mainnav">
					<li id="menu-control">
						<div class="menu-control-outer">
							<div class="menu-control-inner">
								<span class="icon-bar"></span>
								<span class="icon-bar"></span>
								<span class="icon-bar"></span>
							</div>
						</div>
					</li>
					<?php if(!$is_custom_page){ ?>
					<li id="dashboard"><a href="<?php echo $home; ?>" class="top"><?php echo $text_dashboard; ?></a></li>
					<li id="catalog"><a class="top"><?php echo $text_catalog; ?></a>
						<ul>
							<li><a href="<?php echo $category; ?>"><?php echo $text_category; ?></a></li>
							<li><a href="<?php echo $product; ?>"><?php echo $text_product; ?></a></li>
							<li><a class="parent"><?php echo $text_attribute; ?></a>
								<ul>
									<li><a href="<?php echo $attribute; ?>"><?php echo $text_attribute; ?></a></li>
									<li><a href="<?php echo $attribute_group; ?>"><?php echo $text_attribute_group; ?></a></li>
								</ul>
							</li>
							<li><a href="<?php echo $option; ?>"><?php echo $text_option; ?></a></li>
							<li><a href="<?php echo $manufacturer; ?>"><?php echo $text_manufacturer; ?></a></li>
							<li><a href="<?php echo $download; ?>"><?php echo $text_download; ?></a></li>
							<li><a href="<?php echo $review; ?>"><?php echo $text_review; ?></a></li>
							<li><a href="<?php echo $customer_reviews; ?>"><?php echo $text_customer_reviews; ?></a></li>
							<li><a href="<?php echo $information; ?>"><?php echo $text_information; ?></a></li>
                            <li><a href="<?php echo $gallery; ?>">Галерея</a></li>
							<li><a href="<?php echo $news_list; ?>"><?php echo $news; ?></a></li>
						</ul>
					</li>
					<li id="extension"><a class="top"><?php echo $text_extension; ?></a>
						<ul>
							<li><a href="<?php echo $module; ?>"><?php echo $text_module; ?></a></li>
							<li><a href="<?php echo $shipping; ?>"><?php echo $text_shipping; ?></a></li>
							<li><a href="<?php echo $payment; ?>"><?php echo $text_payment; ?></a></li>
							<li><a href="<?php echo $total; ?>"><?php echo $text_total; ?></a></li>
							<li><a href="<?php echo $feed; ?>"><?php echo $text_feed; ?></a></li>
							<li><a href="<?php echo $sitemap; ?>"><?php echo $text_sitemap; ?></a></li> 
						</ul>
					</li>
					<li id="sale"><a class="top"><?php echo $text_sale; ?></a>
						<ul>
							<li><a href="<?php echo $order; ?>"><?php echo $text_order; ?></a></li>
							<li><a href="<?php echo $return; ?>"><?php echo $text_return; ?></a></li>
							<li><a class="parent"><?php echo $text_customer; ?></a>
								<ul>
									<li><a href="<?php echo $customer; ?>"><?php echo $text_customer; ?></a></li>
									<li><a href="<?php echo $customer_group; ?>"><?php echo $text_customer_group; ?></a></li>
									<li><a href="<?php echo $customer_blacklist; ?>"><?php echo $text_customer_blacklist; ?></a></li>
								</ul>
							</li>
							<li><a href="<?php echo $affiliate; ?>"><?php echo $text_affiliate; ?></a></li>
							<li><a href="<?php echo $coupon; ?>"><?php echo $text_coupon; ?></a></li>
							<li><a class="parent"><?php echo $text_voucher; ?></a>
								<ul>
									<li><a href="<?php echo $voucher; ?>"><?php echo $text_voucher; ?></a></li>
									<li><a href="<?php echo $voucher_theme; ?>"><?php echo $text_voucher_theme; ?></a></li>
								</ul>
							</li>
							<li><a href="<?php echo $contact; ?>"><?php echo $text_contact; ?></a></li>
						</ul>
					</li>
					<li id="system"><a class="top"><?php echo $text_system; ?></a>
						<ul>
							<li><a href="<?php echo $setting; ?>"><?php echo $text_setting; ?></a></li>
							<li><a class="parent"><?php echo $text_design; ?></a>
								<ul>
									<li><a href="<?php echo $layout; ?>"><?php echo $text_layout; ?></a></li>
									<li><a href="<?php echo $banner; ?>"><?php echo $text_banner; ?></a></li>
								</ul>
							</li>
							<li><a class="parent"><?php echo $text_users; ?></a>
								<ul>
									<li><a href="<?php echo $user; ?>"><?php echo $text_user; ?></a></li>
									<li><a href="<?php echo $user_group; ?>"><?php echo $text_user_group; ?></a></li>
								</ul>
							</li>
							<li><a class="parent"><?php echo $text_localisation; ?></a>
								<ul>
									<li><a href="<?php echo $language; ?>"><?php echo $text_language; ?></a></li>
									<li><a href="<?php echo $currency; ?>"><?php echo $text_currency; ?></a></li>
									<li><a href="<?php echo $stock_status; ?>"><?php echo $text_stock_status; ?></a></li>
									<li><a href="<?php echo $order_status; ?>"><?php echo $text_order_status; ?></a></li>
									<li><a class="parent"><?php echo $text_return; ?></a>
										<ul>
											<li><a href="<?php echo $return_status; ?>"><?php echo $text_return_status; ?></a></li>
											<li><a href="<?php echo $return_action; ?>"><?php echo $text_return_action; ?></a></li>
											<li><a href="<?php echo $return_reason; ?>"><?php echo $text_return_reason; ?></a></li>
										</ul>
									</li>
									<li><a href="<?php echo $country; ?>"><?php echo $text_country; ?></a></li>
									<li><a href="<?php echo $zone; ?>"><?php echo $text_zone; ?></a></li>
									<li><a href="<?php echo $geo_zone; ?>"><?php echo $text_geo_zone; ?></a></li>
									<li><a class="parent"><?php echo $text_tax; ?></a>
										<ul>
											<li><a href="<?php echo $tax_class; ?>"><?php echo $text_tax_class; ?></a></li>
											<li><a href="<?php echo $tax_rate; ?>"><?php echo $text_tax_rate; ?></a></li>
										</ul>
									</li>
									<li><a href="<?php echo $length_class; ?>"><?php echo $text_length_class; ?></a></li>
									<li><a href="<?php echo $weight_class; ?>"><?php echo $text_weight_class; ?></a></li>
								</ul>
							</li>
							<li><a href="<?php echo $error_log; ?>"><?php echo $text_error_log; ?></a></li>
							<li><a href="<?php echo $backup; ?>"><?php echo $text_backup; ?></a></li>
                            <?php if ($sync_allowed): ?><li><a href="<?php echo $sync; ?>"><?php echo $text_sync; ?></a></li><?php endif; ?>
						</ul>
					</li>
					<li id="reports"><a class="top"><?php echo $text_reports; ?></a>
						<ul>
							<li><a class="parent"><?php echo $text_sale; ?></a>
								<ul>
									<li><a href="<?php echo $report_sale_order; ?>"><?php echo $text_report_sale_order; ?></a></li>
									<li><a href="<?php echo $report_sale_tax; ?>"><?php echo $text_report_sale_tax; ?></a></li>
									<li><a href="<?php echo $report_sale_shipping; ?>"><?php echo $text_report_sale_shipping; ?></a></li>
									<li><a href="<?php echo $report_sale_return; ?>"><?php echo $text_report_sale_return; ?></a></li>
									<li><a href="<?php echo $report_sale_coupon; ?>"><?php echo $text_report_sale_coupon; ?></a></li>
								</ul>
							</li>
							<li><a class="parent"><?php echo $text_product; ?></a>
								<ul>
									<li><a href="<?php echo $report_product_viewed; ?>"><?php echo $text_report_product_viewed; ?></a></li>
									<li><a href="<?php echo $report_product_purchased; ?>"><?php echo $text_report_product_purchased; ?></a></li>
								</ul>
							</li>
							<li><a class="parent"><?php echo $text_customer; ?></a>
								<ul>
									<li><a href="<?php echo $report_customer_online; ?>"><?php echo $text_report_customer_online; ?></a></li>
									<li><a href="<?php echo $report_customer_order; ?>"><?php echo $text_report_customer_order; ?></a></li>
									<li><a href="<?php echo $report_customer_reward; ?>"><?php echo $text_report_customer_reward; ?></a></li>
									<li><a href="<?php echo $report_customer_credit; ?>"><?php echo $text_report_customer_credit; ?></a></li>
								</ul>
							</li>
							<li><a class="parent"><?php echo $text_affiliate; ?></a>
								<ul>
									<li><a href="<?php echo $report_affiliate_commission; ?>"><?php echo $text_report_affiliate_commission; ?></a></li>
								</ul>
							</li>
						</ul>
					</li>
					<li id="help"><a class="top"><?php echo $text_help; ?></a>
						<ul>
							<li><a onClick="window.open('http://www.opencart.com');"><?php echo $text_opencart; ?></a></li>
							<li><a onClick="window.open('http://www.opencart.com/index.php?route=documentation/introduction');"><?php echo $text_documentation; ?></a></li>
							<li><a onClick="window.open('http://forum.opencart.com');"><?php echo $text_support; ?></a></li>
						</ul>
					</li>
					<?php }else{ ?>
					<li id="extension"><a class="top" href="<?php echo $module; ?>"><?php echo $text_module; ?></a></li>
					<?php } ?>
				</ul>
			</div>


			<div class="sidebar copyright">
				<div class="sidebar-base5builder">

				</div>

			</div>
		</div>
		<div class="right-header-content clearfix">
			<div class="secondary-menu">
				<ul>
					<li id="store">
						<a class="top"><span><?php echo $text_front; ?></span></a>
						<ul>
							<li><a  href="<?php echo $store; ?>" target="_blank" class="top"><?php echo $this->config->get('config_name'); ?></a></li>
							<?php foreach ($stores as $stores) { ?>
							<li><a href="<?php echo $stores['href']; ?>" target="_blank"><?php echo $stores['name']; ?></a></li>
							<?php } ?>
						</ul>
					</li>
					<li id="logout"><a class="top" href="<?php echo $logout; ?>"><span><?php echo $text_logout; ?></span></a></li>
				</ul>
			</div>
			<div class="admin-info"><?php echo $logged; ?></div>
		</div>
		<?php } ?>
<?php  

class ControllerProductProduct extends Controller {

	private $error = array(); 

	

	public function index() { 

		$this->language->load('product/product');

	

		$this->data['breadcrumbs'] = array();



		$this->data['breadcrumbs'][] = array(

			'text'      => $this->language->get('text_home'),

			'href'      => $this->url->link('common/home'),			

			'separator' => false

		);


		$this->load->model('catalog/category');	

		
        $root_category = 0;
		if (isset($this->request->get['path'])) {

			$path = '';

				

			foreach (explode('_', $this->request->get['path']) as $path_id) {

				if (!$path) {

					$path = $path_id;
                    $root_category = intval($path_id);

				} else {

					$path .= '_' . $path_id;

				}

				

				$category_info = $this->model_catalog_category->getCategory($path_id);

				

				if ($category_info) {

					$this->data['breadcrumbs'][] = array(

						'text'      => $category_info['name'],

						'href'      => $this->url->link('product/category', 'path=' . $path),

						'separator' => $this->language->get('text_separator')

					);

				}

			}

		}
        $this->data['root_category'] = $root_category;

		

		$this->load->model('catalog/manufacturer');	

		

		if (isset($this->request->get['manufacturer_id'])) {

			$this->data['breadcrumbs'][] = array( 

				'text'      => $this->language->get('text_brand'),

				'href'      => $this->url->link('product/manufacturer'),

				'separator' => $this->language->get('text_separator')

			);	

				

			$manufacturer_info = $this->model_catalog_manufacturer->getManufacturer($this->request->get['manufacturer_id']);



			if ($manufacturer_info) {	

				$this->data['breadcrumbs'][] = array(

					'text'	    => $manufacturer_info['name'],

					'href'	    => $this->url->link('product/manufacturer/info', 'manufacturer_id=' . $this->request->get['manufacturer_id']),					

					'separator' => $this->language->get('text_separator')

				);

			}

		}

		

		if (isset($this->request->get['filter_name']) || isset($this->request->get['filter_tag'])) {

			$url = '';

			

			if (isset($this->request->get['filter_name'])) {

				$url .= '&filter_name=' . $this->request->get['filter_name'];

			}

						

			if (isset($this->request->get['filter_tag'])) {

				$url .= '&filter_tag=' . $this->request->get['filter_tag'];

			}

						

			if (isset($this->request->get['filter_description'])) {

				$url .= '&filter_description=' . $this->request->get['filter_description'];

			}

			

			if (isset($this->request->get['filter_category_id'])) {

				$url .= '&filter_category_id=' . $this->request->get['filter_category_id'];

			}	

						

			$this->data['breadcrumbs'][] = array(

				'text'      => $this->language->get('text_search'),

				'href'      => $this->url->link('product/search', $url),

				'separator' => $this->language->get('text_separator')

			);	

		}

		

		if (isset($this->request->get['product_id'])) {

			$product_id = (int)$this->request->get['product_id'];

		} else {

			$product_id = 0;

		}

		

		$this->load->model('catalog/product');
		
		

		$product_info = $this->model_catalog_product->getProduct($product_id);

	    

		if ($product_info) {

			$url = '';

			

			if (isset($this->request->get['path'])) {

				$url .= '&path=' . $this->request->get['path'];

			}

			

			if (isset($this->request->get['manufacturer_id'])) {

				$url .= '&manufacturer_id=' . $this->request->get['manufacturer_id'];

			}			



			if (isset($this->request->get['filter_name'])) {

				$url .= '&filter_name=' . $this->request->get['filter_name'];

			}

						

			if (isset($this->request->get['filter_tag'])) {

				$url .= '&filter_tag=' . $this->request->get['filter_tag'];

			}

			

			if (isset($this->request->get['filter_description'])) {

				$url .= '&filter_description=' . $this->request->get['filter_description'];

			}	

						

			if (isset($this->request->get['filter_category_id'])) {

				$url .= '&filter_category_id=' . $this->request->get['filter_category_id'];

			}

												

			$this->data['breadcrumbs'][] = array(

				'text'      => $product_info['name'],

				'href'      => $this->url->link('product/product', $url . '&product_id=' . $this->request->get['product_id']),

				'separator' => $this->language->get('text_separator')

			);			



			if ($product_info['seo_title']) {

				$this->document->setTitle($product_info['seo_title']);

			} else {

				$this->document->setTitle($product_info['name']);

			}



			$this->document->setDescription($product_info['meta_description']);

			$this->document->setKeywords($product_info['meta_keyword']);

			$this->document->addLink($this->url->link('product/product', 'product_id=' . $this->request->get['product_id']), 'canonical');

			

			if ($product_info['seo_h1']) {

				$this->data['heading_title'] = $product_info['seo_h1'];

			} else {

				$this->data['heading_title'] = $product_info['name'];

			}
			
			/*Раздел обьекты агента*/	
            $this->data['link_product'] = $this->url->link('product/agentproduct', 'path=' . $product_info['agent']);
			
            $this->data['agent'] = $this->model_catalog_product->Agent($product_info['agent']);
			
			$this->data['price_from'] = $this->model_catalog_product->getPriceFrom($product_id);

			$this->data['text_select'] = $this->language->get('text_select');

			$this->data['text_manufacturer'] = $this->language->get('text_manufacturer');

			$this->data['text_model'] = $this->language->get('text_model');

			$this->data['text_weight'] = $this->language->get('text_weight');

			$this->data['text_location'] = $this->language->get('text_location');

			$this->data['text_sku'] = $this->language->get('text_sku');

			$this->data['text_upc'] = $this->language->get('text_upc');

			$this->data['text_ean'] = $this->language->get('text_ean');

			$this->data['text_jan'] = $this->language->get('text_jan');

			$this->data['text_isbn'] = $this->language->get('text_isbn');

			$this->data['text_mpn'] = $this->language->get('text_mpn');

			$this->data['text_reward'] = $this->language->get('text_reward');

			$this->data['text_points'] = $this->language->get('text_points');	

			$this->data['text_discount'] = $this->language->get('text_discount');

			$this->data['text_stock'] = $this->language->get('text_stock');

			$this->data['text_price'] = $this->language->get('text_price');

			$this->data['text_tax'] = $this->language->get('text_tax');

			$this->data['text_discount'] = $this->language->get('text_discount');

			$this->data['text_option'] = $this->language->get('text_option');

			$this->data['text_qty'] = $this->language->get('text_qty');

			$this->data['text_minimum'] = sprintf($this->language->get('text_minimum'), $product_info['minimum']);

			$this->data['text_or'] = $this->language->get('text_or');

			$this->data['text_write'] = $this->language->get('text_write');

			$this->data['text_note'] = $this->language->get('text_note');

			$this->data['text_share'] = $this->language->get('text_share');

			$this->data['text_wait'] = $this->language->get('text_wait');

			$this->data['text_tags'] = $this->language->get('text_tags');

			$this->data['text_saving'] = $this->language->get('text_saving');

			

			$this->data['entry_name'] = $this->language->get('entry_name');

			$this->data['entry_review'] = $this->language->get('entry_review');

			$this->data['entry_rating'] = $this->language->get('entry_rating');

			$this->data['entry_good'] = $this->language->get('entry_good');

			$this->data['entry_bad'] = $this->language->get('entry_bad');

			$this->data['entry_captcha'] = $this->language->get('entry_captcha');

			

			$this->data['button_cart'] = $this->language->get('button_cart');

			$this->data['button_wishlist'] = $this->language->get('button_wishlist');

			$this->data['button_compare'] = $this->language->get('button_compare');			

			$this->data['button_upload'] = $this->language->get('button_upload');

			$this->data['button_continue'] = $this->language->get('button_continue');

			

			$this->load->model('catalog/review');



			$this->data['tab_description'] = $this->language->get('tab_description');

			$this->data['tab_attribute'] = $this->language->get('tab_attribute');

			$this->data['tab_review'] = sprintf($this->language->get('tab_review'), $this->model_catalog_review->getTotalReviewsByProductId($this->request->get['product_id']));

			$this->data['tab_related'] = $this->language->get('tab_related');

			

			$this->data['product_id'] = $this->request->get['product_id'];

			$this->data['manufacturer'] = $product_info['manufacturer'];

			$this->data['manufacturers'] = $this->url->link('product/manufacturer/info', 'manufacturer_id=' . $product_info['manufacturer_id']);

			$this->data['model'] = $product_info['model'];

            $agent = $product_info['agent'];

			$this->data['reward'] = $product_info['reward'];

			$this->data['points'] = $product_info['points'];

			$this->data['sku'] = $product_info['sku'];

			$this->data['upc'] = $product_info['upc'];

			$this->data['ean'] = $product_info['ean'];
			
			$this->data['lat_lng'] = $product_info['lat_lng'];

			$this->data['jan'] = $product_info['jan'];

			$this->data['isbn'] = $product_info['isbn'];

			$this->data['mpn'] = $product_info['mpn'];

			$this->data['location'] = $product_info['location'];
			
			$this->data['this_lots'] = $product_info['this_lots'];

			if ($product_info['weight']) {

			$this->data['weight'] = $this->weight->format($product_info['weight'], $product_info['weight_class_id'], $this->language->get('decimal_point'), $this->language->get('thousand_point'));

			} else {

				$this->data['weight'] = '';

			}

			

			if ($product_info['quantity'] <= 0) {

				$this->data['stock'] = $product_info['stock_status'];

			} elseif ($this->config->get('config_stock_display')) {

				$this->data['stock'] = $product_info['quantity'];

			} else {

				$this->data['stock'] = $this->language->get('text_instock');

			}

			

			$this->load->model('tool/image');
            $this->load->model('tool/object');


			if ($product_info['image']) {

				$this->data['popup'] = $this->model_tool_object->resize($product_info['image'], $this->config->get('config_image_popup_width'), $this->config->get('config_image_popup_height'));

			} else {

				$this->data['popup'] = '';

			}

			

			if ($product_info['image']) {

				$this->data['thumb'] = $this->model_tool_object->resize($product_info['image'], $this->config->get('config_image_thumb_width'), $this->config->get('config_image_thumb_height'));

			} else {

				$this->data['thumb'] = '';

			}

			

			$this->data['thumb2'] = $this->model_tool_object->resize($product_info['image'], $this->config->get('config_image_thumb_width'), $this->config->get('config_image_thumb_height'));

			$this->data['thumb1'] = $this->model_tool_object->resize($product_info['image'], $this->config->get('config_image_additional_width'), $this->config->get('config_image_additional_height'));

            /*list($width_orig, $height_orig) = getimagesize(DIR_IMAGE . $product_info['image']);
            if ($width_orig>900) {
                $height_orig = $height_orig * 900 / $width_orig;
                $width_orig = 900;
            }*/
            $this->data['thumb_orig'] = $this->model_tool_object->resize($product_info['image'], $width_orig, $height_orig);
            //$this->data['thumb_orig'] = !empty($product_info['image']) && file_exists(DIR_IMAGE.$product_info['image']) ? '/image/'.$product_info['image'] : '';
            $this->data['product_video'] = $this->model_catalog_product->getProductVideo($this->request->get['product_id']);
			$this->data['view_price_from'] = $this->model_catalog_product->getPriceFrom($this->request->get['product_id']);


            $this->data['images_interior'] = array();

			$this->data['images_exterior'] = array();
			
			$this->data['images_more'] = array();

			$results_interior = $this->model_catalog_product->getProductImagesInterior($this->request->get['product_id']);

			$results_exterior = $this->model_catalog_product->getProductImagesExterior($this->request->get['product_id']);
			
			$results_more = $this->model_catalog_product->getProductImagesMore($this->request->get['product_id']);

			foreach ($results_interior as $result) {

                /*if (!file_exists(DIR_IMAGE . $result['image'])) continue;

                list($width_orig, $height_orig) = getimagesize(DIR_IMAGE . $result['image']);
                if ($width_orig>900) {
                    $height_orig = $height_orig * 900 / $width_orig;
                    $width_orig = 900;
                }*/

				$this->data['images_interior'][] = array(

					'popup' => $this->model_tool_object->resize($result['image'], $this->config->get('config_image_popup_width'), $this->config->get('config_image_popup_height')),

					'thumb' => $this->model_tool_object->resize($result['image'], $this->config->get('config_image_additional_width'), $this->config->get('config_image_additional_height')),

					'thumb1' => $this->model_tool_object->resize($result['image'], $this->config->get('config_image_additional_width'), $this->config->get('config_image_additional_height')),

					'thumb2' => $this->model_tool_object->resize($result['image'], $this->config->get('config_image_thumb_width'), $this->config->get('config_image_thumb_height')),

                    'full' => $this->model_tool_image->resize($result['image'], 680, 360),

                    'orig' => $this->model_tool_object->resize($result['image'], $width_orig, $height_orig),
                    //'orig' => !empty($result['image']) && file_exists(DIR_IMAGE.$result['image']) ? '/image/'.$result['image'] : ''

            );

			}
			
			foreach ($results_exterior as $result) {

				$this->data['images_exterior'][] = array(

					'popup' => $this->model_tool_object->resize($result['image'], $this->config->get('config_image_popup_width'), $this->config->get('config_image_popup_height')),

					'thumb' => $this->model_tool_object->resize($result['image'], $this->config->get('config_image_additional_width'), $this->config->get('config_image_additional_height')),

					'thumb1' => $this->model_tool_object->resize($result['image'], $this->config->get('config_image_additional_width'), $this->config->get('config_image_additional_height')),

					'thumb2' => $this->model_tool_object->resize($result['image'], $this->config->get('config_image_thumb_width'), $this->config->get('config_image_thumb_height')),

                    'full' => $this->model_tool_image->resize($result['image'], 680, 360),

                    'orig' => $this->model_tool_object->resize($result['image'], $width_orig, $height_orig),
                    //'orig' => !empty($result['image']) && file_exists(DIR_IMAGE.$result['image']) ? '/image/'.$result['image'] : ''

            );

			}
			
			foreach ($results_more as $result) {

				$this->data['images_more'][] = array(

					'popup' => $this->model_tool_object->resize($result['image'], $this->config->get('config_image_popup_width'), $this->config->get('config_image_popup_height')),

					'thumb' => $this->model_tool_object->resize($result['image'], $this->config->get('config_image_additional_width'), $this->config->get('config_image_additional_height')),

					'thumb1' => $this->model_tool_object->resize($result['image'], $this->config->get('config_image_additional_width'), $this->config->get('config_image_additional_height')),

					'thumb2' => $this->model_tool_object->resize($result['image'], $this->config->get('config_image_thumb_width'), $this->config->get('config_image_thumb_height')),

                    'full' => $this->model_tool_image->resize($result['image'], 680, 360),

                    'orig' => $this->model_tool_object->resize($result['image'], $width_orig, $height_orig),
                    //'orig' => !empty($result['image']) && file_exists(DIR_IMAGE.$result['image']) ? '/image/'.$result['image'] : ''

            );

			}

            $this->data['plans'] = array();

            $plan_results = $this->model_catalog_product->getProductPlans($this->request->get['product_id']);



            foreach ($plan_results as $result) {

                /*if (!file_exists(DIR_IMAGE . $result['image'])) continue;

                list($width_orig, $height_orig) = getimagesize(DIR_IMAGE . $result['image']);
                if ($width_orig>960) {
                    $height_orig = $height_orig * 960 / $width_orig;
                    $width_orig = 960;
                }*/

                $this->data['plans'][] = array(

                    'orig' => $this->model_tool_object->resize($result['image'], $width_orig, $height_orig),

                );

            }



//            $this->data['price'] = $this->currency->format($this->tax->calculate($product_info['price'], $product_info['tax_class_id'], $this->config->get('config_tax')));
//            $rub = $this->currency->convert($product_info['price'], 'USD', 'RUB');
//            $this->data['rub'] = $this->currency->format($this->tax->calculate($rub, $product_info['tax_class_id'], $this->config->get('config_tax')));

            $this->load->model('localisation/currency');

            if ($product_info['currency_id'] != 1) {
                $currency = $this->model_localisation_currency->getCurrency($product_info['currency_id']);
                $price = $this->currency->convert($product_info['price'], $currency['code'], 'RUB');
                $this->data['rub'] = $this->currency->format($this->tax->calculate($price, $product_info['tax_class_id'], $this->config->get('config_tax')));
            } else {
                $this->data['rub'] = $this->currency->format($this->tax->calculate($product_info['price'], $product_info['tax_class_id'], $this->config->get('config_tax')));
            }
            if ($product_info['currency_id'] != 2) {
                $currency = $this->model_localisation_currency->getCurrency($product_info['currency_id']);
                $price = $this->currency->convert($product_info['price'], $currency['code'], 'USD');
                $this->data['price'] = $this->currency->format($this->tax->calculate($price, $product_info['tax_class_id'], $this->config->get('config_tax')));
            } else {
                $this->data['price'] = $this->currency->format($this->tax->calculate($product_info['price'], $product_info['tax_class_id'], $this->config->get('config_tax')));
            }



			if ((float)$product_info['special']) {

				$this->data['special'] = $this->currency->format($this->tax->calculate($product_info['special'], $product_info['tax_class_id'], $this->config->get('config_tax')));

                if ($product_info['currency_id'] != 1) {
                    $currency = $this->model_localisation_currency->getCurrency($product_info['currency_id']);
                    $special = $this->currency->convert($product_info['special'], $currency['code'], 'RUB');
                    $this->data['special_rub'] = $this->currency->format($this->tax->calculate($special, $product_info['tax_class_id'], $this->config->get('config_tax')));
                } else {
                    $this->data['special_rub'] = $this->currency->format($this->tax->calculate($product_info['special'], $product_info['tax_class_id'], $this->config->get('config_tax')));
                }
                if ($product_info['currency_id'] != 2) {
                    $currency = $this->model_localisation_currency->getCurrency($product_info['currency_id']);
                    $special = $this->currency->convert($product_info['special'], $currency['code'], 'USD');
                    $this->data['special'] = $this->currency->format($this->tax->calculate($special, $product_info['tax_class_id'], $this->config->get('config_tax')));
                } else {
                    $this->data['special'] = $this->currency->format($this->tax->calculate($product_info['special'], $product_info['tax_class_id'], $this->config->get('config_tax')));
                }
			} else {

				$this->data['special'] = false;
                $this->data['special_rub'] = false;

			}

            $this->data['currency_id'] = $product_info['currency_id'];

			

			if ((float)$product_info['special']) {

				$this->data['saving'] = $this->currency->format(($this->tax->calculate($product_info['price'], $product_info['tax_class_id'], $this->config->get('config_tax')))-($this->tax->calculate($product_info['special'], $product_info['tax_class_id'], $this->config->get('config_tax'))));

			} else {

				$this->data['special'] = false;

			}

			

			if ((float)$product_info['special']) {

				$this->data['percent'] = round((($product_info['price'] - $product_info['special'])/$product_info['price'])*100, 0);

			} else {

				$this->data['special'] = false;

			}

			

			if ($this->config->get('config_tax')) {

				$this->data['tax'] = $this->currency->format((float)$product_info['special'] ? $product_info['special'] : $product_info['price']);

			} else {

				$this->data['tax'] = false;

			}

			

			$discounts = $this->model_catalog_product->getProductDiscounts($this->request->get['product_id']);

			

			$this->data['discounts'] = array(); 

			

			foreach ($discounts as $discount) {

				$this->data['discounts'][] = array(

					'quantity' => $discount['quantity'],

					'price'    => $this->currency->format($this->tax->calculate($discount['price'], $product_info['tax_class_id'], $this->config->get('config_tax')))

				);

			}

			$this->data['options'] = array();
			
            //Вывод всех опций (с $Required = 1) только разрешенных на вывод
			$this->data['get_options'] = $this->model_catalog_product->GetRequiredOptions($this->request->get['product_id']);
			//Вывод всех опций (с $Required = 1) только разрешенных на вывод

			foreach ($this->model_catalog_product->getProductOptions($this->request->get['product_id']) as $option) { 

				if ($option['type'] == 'select' || $option['type'] == 'radio' || $option['type'] == 'checkbox' || $option['type'] == 'image') { 

					$option_value_data = array();

					

					foreach ($option['option_value'] as $option_value) {

						if (!$option_value['subtract'] || ($option_value['quantity'] > 0)) {

							if ((($this->config->get('config_customer_price') && $this->customer->isLogged()) || !$this->config->get('config_customer_price')) && (float)$option_value['price']) {

								$price = $this->currency->format($this->tax->calculate($option_value['price'], $product_info['tax_class_id'], $this->config->get('config_tax')));

							} else {

								$price = false;

							}

							

							$option_value_data[] = array(

								'product_option_value_id' => $option_value['product_option_value_id'],

								'option_value_id'         => $option_value['option_value_id'],

								'name'                    => $option_value['name'],

								'image'                   => $this->model_tool_image->resize($option_value['image'], 50, 50),

								'price'                   => $price,

								'price_prefix'            => $option_value['price_prefix']

							);

						}

					}

					

					$this->data['options'][] = array(

						'product_option_id' => $option['product_option_id'],

						'option_id'         => $option['option_id'],

						'name'              => $option['name'],

						'type'              => $option['type'],

						'option_value'      => $option_value_data,

						'required'          => $option['required']

					);					

				} elseif ($option['type'] == 'text' || $option['type'] == 'textarea' || $option['type'] == 'file' || $option['type'] == 'date' || $option['type'] == 'datetime' || $option['type'] == 'time') {

					$this->data['options'][] = array(

						'product_option_id' => $option['product_option_id'],

						'option_id'         => $option['option_id'],

						'name'              => $option['name'],

						'type'              => $option['type'],

						'option_value'      => $option['option_value'],

						'required'          => $option['required']

					);						

				}

			}

            $this->data['all_options'] = $this->model_catalog_product->getAllOptions();
							

			if ($product_info['minimum']) {

				$this->data['minimum'] = $product_info['minimum'];

			} else {

				$this->data['minimum'] = 1;

			}

			

			$this->data['review_status'] = $this->config->get('config_review_status');

			$this->data['reviews'] = sprintf($this->language->get('text_reviews'), (int)$product_info['reviews']);

			$this->data['rating'] = (int)$product_info['rating'];

			$this->data['description'] = html_entity_decode($product_info['description'], ENT_QUOTES, 'UTF-8');

			$this->data['attribute_groups'] = $this->model_catalog_product->getProductAttributes($this->request->get['product_id']);

			$this->data['category_id'] = $this->model_catalog_product->getCategories($this->request->get['product_id']);

            //$this->data['video'] = html_entity_decode($product_info['video'], ENT_QUOTES, 'UTF-8');


			$this->data['products'] = array();

			

			$results = $this->model_catalog_product->getProductRelated($this->request->get['product_id']);



			foreach ($results as $result) {

				if ($result['image']) {

					//$image = $this->model_tool_image->resize($result['image'], $this->config->get('config_image_related_width'), $this->config->get('config_image_related_height'));
                    $image = $this->model_tool_image->resize($result['image'], 280, 167);

				} else {

					$image = false;

				}



				if (($this->config->get('config_customer_price') && $this->customer->isLogged()) || !$this->config->get('config_customer_price')) {
                    //$price = $this->currency->format($this->tax->calculate($result['price'], $result['tax_class_id'], $this->config->get('config_tax')));
                    if ($result['currency_id'] != 1) {
                        $currency = $this->model_localisation_currency->getCurrency($result['currency_id']);
                        $price = $this->currency->convert($result['price'], $currency['code'], 'RUB');
                        $rub = $this->currency->format($this->tax->calculate($price, $result['tax_class_id'], $this->config->get('config_tax')));
                    } else {
                        $rub = $this->currency->format($this->tax->calculate($result['price'], $result['tax_class_id'], $this->config->get('config_tax')));
                    }
                    if ($result['currency_id'] != 2) {
                        $currency = $this->model_localisation_currency->getCurrency($result['currency_id']);
                        $price = $this->currency->convert($result['price'], $currency['code'], 'USD');
                        $price = $this->currency->format($this->tax->calculate($price, $result['tax_class_id'], $this->config->get('config_tax')));
                    } else {
                        $price = $this->currency->format($this->tax->calculate($result['price'], $result['tax_class_id'], $this->config->get('config_tax')));
                    }
				} else {
					$price = false;
                    $rub = false;
				}





				if ((float)$result['special']) {

					$special = $this->currency->format($this->tax->calculate($result['special'], $result['tax_class_id'], $this->config->get('config_tax')));

                    if ($result['currency_id'] != 1) {
                        $currency = $this->model_localisation_currency->getCurrency($result['currency_id']);
                        $special = $this->currency->convert($result['special'], $currency['code'], 'RUB');
                        $special_rub = $this->currency->format($this->tax->calculate($special, $result['tax_class_id'], $this->config->get('config_tax')));
                    } else {
                        $special_rub = $this->currency->format($this->tax->calculate($result['special'], $result['tax_class_id'], $this->config->get('config_tax')));
                    }
                    if ($result['currency_id'] != 2) {
                        $currency = $this->model_localisation_currency->getCurrency($result['currency_id']);
                        $special = $this->currency->convert($result['special'], $currency['code'], 'USD');
                        $special = $this->currency->format($this->tax->calculate($special, $result['tax_class_id'], $this->config->get('config_tax')));
                    } else {
                        $special = $this->currency->format($this->tax->calculate($result['special'], $result['tax_class_id'], $this->config->get('config_tax')));
                    }
				} else {

					$special = false;
                    $special_rub = false;

				}

				

				if ($this->config->get('config_review_status')) {

					$rating = (int)$result['rating'];

				} else {

					$rating = false;

				}

                $agent = $this->model_catalog_product->Agent($result['agent']);

							

				$this->data['products'][] = array(

					'product_id' => $result['product_id'],

					'thumb'   	 => $image,

					'name'    	 => $result['name'],

					'price'   	 => $price,

                    'rub'       => $rub,

					'special' 	 => $special,

                    'special_rub' => $special_rub,

                    'currency_id' => $result['currency_id'],

					'percent'	 => round((($result['price'] - $result['special'])/$result['price'])*100, 0),

					'rating'     => $rating,

                    'agent'     => $agent,

					'reviews'    => sprintf($this->language->get('text_reviews'), (int)$result['reviews']),

					'href'    	 => $this->url->link('product/product', 'product_id=' . $result['product_id']),

				);

			}	

			

			$this->data['tags'] = array();

							

			$tags = explode(',', $product_info['tag']);

			

			foreach ($tags as $tag) {

				$this->data['tags'][] = array(

					'tag'  => trim($tag),

					'href' => $this->url->link('product/search', 'filter_tag=' . trim($tag))

				);

			}

            $this->data['sess_id'] = $this->model_catalog_product->generateUniqSessId();
            $this->data['is_favorite'] = $this->model_catalog_product->isFavorite(intval($this->customer->getId()),$this->data['sess_id'],$this->data['product_id']);

            $this->data['pdf_url'] = $this->url->link('product/product/pdf', 'path=' . $this->request->get['path'] . '&product_id=' . $this->data['product_id']);

			$this->model_catalog_product->updateViewed($this->request->get['product_id']);

            //$this->document->addScript('catalog/view/javascript/jquery.colorbox-min.js');
            //$this->document->addScript('catalog/view/theme/default/js/additionalimage.js');
            //$this->document->addStyle('catalog/view/theme/default/stylesheet/colorbox.css');
			if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/product/product.tpl')) {

				$this->template = $this->config->get('config_template') . '/template/product/product.tpl';

			} else {

				$this->template = 'default/template/product/product.tpl';

			}

            $this->document->addStyle('catalog/view/theme/default/css/fotorama.css');
            $this->document->addScript('catalog/view/theme/default/js/fotorama.js');

			$this->children = array(

				'common/column_left',

				'common/column_right',

				'common/content_top',

				'common/content_bottom',

				'common/footer',

				'common/header'

			);

						

			$this->response->setOutput($this->render());

		} else {

			$url = '';

			

			if (isset($this->request->get['path'])) {

				$url .= '&path=' . $this->request->get['path'];

			}

			

			if (isset($this->request->get['manufacturer_id'])) {

				$url .= '&manufacturer_id=' . $this->request->get['manufacturer_id'];

			}			



			if (isset($this->request->get['filter_name'])) {

				$url .= '&filter_name=' . $this->request->get['filter_name'];

			}	

					

			if (isset($this->request->get['filter_tag'])) {

				$url .= '&filter_tag=' . $this->request->get['filter_tag'];

			}

							

			if (isset($this->request->get['filter_description'])) {

				$url .= '&filter_description=' . $this->request->get['filter_description'];

			}

					

			if (isset($this->request->get['filter_category_id'])) {

				$url .= '&filter_category_id=' . $this->request->get['filter_category_id'];

			}

								

      		$this->data['breadcrumbs'][] = array(

        		'text'      => $this->language->get('text_error'),

				'href'      => $this->url->link('product/product', $url . '&product_id=' . $product_id),

        		'separator' => $this->language->get('text_separator')

      		);			

		

      		$this->document->setTitle($this->language->get('text_error'));



      		$this->data['heading_title'] = $this->language->get('text_error');



      		$this->data['text_error'] = $this->language->get('text_error');



      		$this->data['button_continue'] = $this->language->get('button_continue');



      		$this->data['continue'] = $this->url->link('common/home');



			if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/error/not_found.tpl')) {

				$this->template = $this->config->get('config_template') . '/template/error/not_found.tpl';

			} else {

				$this->template = 'default/template/error/not_found.tpl';

			}

			

			$this->children = array(

				'common/column_left',

				'common/column_right',

				'common/content_top',

				'common/content_bottom',

				'common/footer',

				'common/header'

			);

						

			$this->response->setOutput($this->render());

    	}

  	}

    public function gallery() {

        $this->language->load('product/product');



        $this->data['breadcrumbs'] = array();



        $this->data['breadcrumbs'][] = array(

            'text'      => $this->language->get('text_home'),

            'href'      => $this->url->link('common/home'),

            'separator' => false

        );



        $this->load->model('catalog/category');



        if (isset($this->request->get['path'])) {

            $path = '';



            foreach (explode('_', $this->request->get['path']) as $path_id) {

                if (!$path) {

                    $path = $path_id;

                } else {

                    $path .= '_' . $path_id;

                }



                $category_info = $this->model_catalog_category->getCategory($path_id);



                if ($category_info) {

                    $this->data['breadcrumbs'][] = array(

                        'text'      => $category_info['name'],

                        'href'      => $this->url->link('product/category', 'path=' . $path),

                        'separator' => $this->language->get('text_separator')

                    );

                }

            }

        }



        $this->load->model('catalog/manufacturer');


        if (isset($this->request->get['product_id'])) {

            $product_id = (int)$this->request->get['product_id'];

        } else {

            $product_id = 0;

        }



        $this->load->model('catalog/product');



        $product_info = $this->model_catalog_product->getProduct($product_id);



        if ($product_info) {

            $url = '';



            if (isset($this->request->get['path'])) {

                $url .= '&path=' . $this->request->get['path'];

            }



            if (isset($this->request->get['manufacturer_id'])) {

                $url .= '&manufacturer_id=' . $this->request->get['manufacturer_id'];

            }



            if (isset($this->request->get['filter_name'])) {

                $url .= '&filter_name=' . $this->request->get['filter_name'];

            }



            if (isset($this->request->get['filter_tag'])) {

                $url .= '&filter_tag=' . $this->request->get['filter_tag'];

            }



            if (isset($this->request->get['filter_description'])) {

                $url .= '&filter_description=' . $this->request->get['filter_description'];

            }



            if (isset($this->request->get['filter_category_id'])) {

                $url .= '&filter_category_id=' . $this->request->get['filter_category_id'];

            }



            $this->data['breadcrumbs'][] = array(

                'text'      => $product_info['name'],

                'href'      => $this->url->link('product/product', $url . '&product_id=' . $this->request->get['product_id']),

                'separator' => $this->language->get('text_separator')

            );


            $this->data['breadcrumbs'][] = array(

                'text'      => 'Галерея',

                'href'      => $this->url->link('product/product/gallery', $url . '&product_id=' . $this->request->get['product_id']),

                'separator' => $this->language->get('text_separator')

            );


            if ($product_info['seo_title']) {

                $this->document->setTitle($product_info['seo_title']);

            } else {

                $this->document->setTitle($product_info['name']);

            }



            $this->document->setDescription($product_info['meta_description']);

            $this->document->setKeywords($product_info['meta_keyword']);

            $this->document->addLink($this->url->link('product/product', 'product_id=' . $this->request->get['product_id']), 'canonical');



            if ($product_info['seo_h1']) {

                $this->data['heading_title'] = $product_info['seo_h1'];

            } else {

                $this->data['heading_title'] = $product_info['name'];

            }



            $this->data['product_id'] = $this->request->get['product_id'];

            $this->data['manufacturer'] = $product_info['manufacturer'];

            $this->data['manufacturers'] = $this->url->link('product/manufacturer/info', 'manufacturer_id=' . $product_info['manufacturer_id']);

            $this->data['model'] = $product_info['model'];

            $agent = $product_info['agent'];

            $this->data['reward'] = $product_info['reward'];

            $this->data['points'] = $product_info['points'];

            $this->data['sku'] = $product_info['sku'];

            $this->data['upc'] = $product_info['upc'];

            $this->data['ean'] = $product_info['ean'];

            $this->data['jan'] = $product_info['jan'];

            $this->data['isbn'] = $product_info['isbn'];

            $this->data['mpn'] = $product_info['mpn'];

            $this->data['location'] = $product_info['location'];

            if ($product_info['weight']) {

                $this->data['weight'] = $this->weight->format($product_info['weight'], $product_info['weight_class_id'], $this->language->get('decimal_point'), $this->language->get('thousand_point'));

            } else {

                $this->data['weight'] = '';

            }



            if ($product_info['quantity'] <= 0) {

                $this->data['stock'] = $product_info['stock_status'];

            } elseif ($this->config->get('config_stock_display')) {

                $this->data['stock'] = $product_info['quantity'];

            } else {

                $this->data['stock'] = $this->language->get('text_instock');

            }



            $this->load->model('tool/image');
			$this->load->model('tool/object');



            if ($product_info['image']) {

                $this->data['popup'] = $this->model_tool_object->resize($product_info['image'], $this->config->get('config_image_popup_width'), $this->config->get('config_image_popup_height'));

            } else {

                $this->data['popup'] = '';

            }



            if ($product_info['image']) {

                $this->data['thumb'] = $this->model_tool_object->resize($product_info['image'], $this->config->get('config_image_thumb_width'), $this->config->get('config_image_thumb_height'));

            } else {

                $this->data['thumb'] = '';

            }



            $this->data['thumb2'] = $this->model_tool_object->resize($product_info['image'], $this->config->get('config_image_thumb_width'), $this->config->get('config_image_thumb_height'));

            $this->data['thumb1'] = $this->model_tool_object->resize($product_info['image'], $this->config->get('config_image_additional_width'), $this->config->get('config_image_additional_height'));


            /*list($width_orig, $height_orig) = getimagesize(DIR_IMAGE . $product_info['image']);
            if ($width_orig>1280) {
                $height_orig = $height_orig * 1280 / $width_orig;
                $width_orig = 1280;
            }*/
            $this->data['thumb_orig'] = $this->model_tool_object->resize($product_info['image'], $width_orig, $height_orig);
            //$this->data['thumb_orig'] = !empty($product_info['image']) && file_exists(DIR_IMAGE.$product_info['image']) ? '/image/'.$product_info['image'] : '';



            $this->data['images'] = array();



            $results = $this->model_catalog_product->getProductImages($this->request->get['product_id']);



            foreach ($results as $result) {

                /*if (!file_exists(DIR_IMAGE . $result['image'])) continue;

                list($width_orig, $height_orig) = getimagesize(DIR_IMAGE . $result['image']);
                if ($width_orig>1280) {
                    $height_orig = $height_orig * 1280 / $width_orig;
                    $width_orig = 1280;
                }*/

                $this->data['images'][] = array(

                    'popup' => $this->model_tool_object->resize($result['image'], $this->config->get('config_image_popup_width'), $this->config->get('config_image_popup_height')),

                    'thumb' => $this->model_tool_object->resize($result['image'], $this->config->get('config_image_additional_width'), $this->config->get('config_image_additional_height')),

                    'thumb1' => $this->model_tool_object->resize($result['image'], $this->config->get('config_image_additional_width'), $this->config->get('config_image_additional_height')),

                    'thumb2' => $this->model_tool_object->resize($result['image'], $this->config->get('config_image_thumb_width'), $this->config->get('config_image_thumb_height')),

                    'full' => $this->model_tool_image->resize($result['image'], 680, 360),

                    'orig' => $this->model_tool_object->resize($result['image'], $width_orig, $height_orig),
                    //'orig' => !empty($result['image']) && file_exists(DIR_IMAGE.$result['image']) ? '/image/'.$result['image'] : ''

                );

            }


            if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/product/gallery.tpl')) {

                $this->template = $this->config->get('config_template') . '/template/product/gallery.tpl';

            } else {

                $this->template = 'default/template/product/gallery.tpl';

            }

            $this->document->addStyle('catalog/view/theme/default/css/galleriffic-2.css');
            $this->document->addScript('catalog/view/theme/default/js/jquery.opacityrollover.js');
            $this->document->addScript('catalog/view/theme/default/js/jquery.galleriffic.js');


            $this->children = array(

                'common/column_left',

                'common/column_right',

                'common/content_top',

                'common/content_bottom',

                'common/footer',

                'common/header'

            );



            $this->response->setOutput($this->render());
        }
    }

    public function video() {

        $this->language->load('product/product');



        $this->data['breadcrumbs'] = array();



        $this->data['breadcrumbs'][] = array(

            'text'      => $this->language->get('text_home'),

            'href'      => $this->url->link('common/home'),

            'separator' => false

        );



        $this->load->model('catalog/category');



        if (isset($this->request->get['path'])) {

            $path = '';



            foreach (explode('_', $this->request->get['path']) as $path_id) {

                if (!$path) {

                    $path = $path_id;

                } else {

                    $path .= '_' . $path_id;

                }



                $category_info = $this->model_catalog_category->getCategory($path_id);



                if ($category_info) {

                    $this->data['breadcrumbs'][] = array(

                        'text'      => $category_info['name'],

                        'href'      => $this->url->link('product/category', 'path=' . $path),

                        'separator' => $this->language->get('text_separator')

                    );

                }

            }

        }



        $this->load->model('catalog/manufacturer');


        if (isset($this->request->get['product_id'])) {

            $product_id = (int)$this->request->get['product_id'];

        } else {

            $product_id = 0;

        }



        $this->load->model('catalog/product');



        $product_info = $this->model_catalog_product->getProduct($product_id);



        if ($product_info) {

            $url = '';



            if (isset($this->request->get['path'])) {

                $url .= '&path=' . $this->request->get['path'];

            }



            if (isset($this->request->get['manufacturer_id'])) {

                $url .= '&manufacturer_id=' . $this->request->get['manufacturer_id'];

            }



            if (isset($this->request->get['filter_name'])) {

                $url .= '&filter_name=' . $this->request->get['filter_name'];

            }



            if (isset($this->request->get['filter_tag'])) {

                $url .= '&filter_tag=' . $this->request->get['filter_tag'];

            }



            if (isset($this->request->get['filter_description'])) {

                $url .= '&filter_description=' . $this->request->get['filter_description'];

            }



            if (isset($this->request->get['filter_category_id'])) {

                $url .= '&filter_category_id=' . $this->request->get['filter_category_id'];

            }



            $this->data['breadcrumbs'][] = array(

                'text'      => $product_info['name'],

                'href'      => $this->url->link('product/product', $url . '&product_id=' . $this->request->get['product_id']),

                'separator' => $this->language->get('text_separator')

            );

            $this->data['breadcrumbs'][] = array(

                'text'      => 'Видео',

                'href'      => $this->url->link('product/product/video', $url . '&product_id=' . $this->request->get['product_id']),

                'separator' => $this->language->get('text_separator')

            );



            if ($product_info['seo_title']) {

                $this->document->setTitle($product_info['seo_title']);

            } else {

                $this->document->setTitle($product_info['name']);

            }



            $this->document->setDescription($product_info['meta_description']);

            $this->document->setKeywords($product_info['meta_keyword']);

            $this->document->addLink($this->url->link('product/product', 'product_id=' . $this->request->get['product_id']), 'canonical');



            if ($product_info['seo_h1']) {

                $this->data['heading_title'] = $product_info['seo_h1'];

            } else {

                $this->data['heading_title'] = $product_info['name'];

            }



            $this->data['product_id'] = $this->request->get['product_id'];

            $this->data['manufacturer'] = $product_info['manufacturer'];

            $this->data['manufacturers'] = $this->url->link('product/manufacturer/info', 'manufacturer_id=' . $product_info['manufacturer_id']);

            $this->data['model'] = $product_info['model'];

            $agent = $product_info['agent'];

            $this->data['reward'] = $product_info['reward'];

            $this->data['points'] = $product_info['points'];

            $this->data['sku'] = $product_info['sku'];

            $this->data['upc'] = $product_info['upc'];

            $this->data['ean'] = $product_info['ean'];

            $this->data['jan'] = $product_info['jan'];

            $this->data['isbn'] = $product_info['isbn'];

            $this->data['mpn'] = $product_info['mpn'];

            $this->data['location'] = $product_info['location'];

            if ($product_info['weight']) {

                $this->data['weight'] = $this->weight->format($product_info['weight'], $product_info['weight_class_id'], $this->language->get('decimal_point'), $this->language->get('thousand_point'));

            } else {

                $this->data['weight'] = '';

            }



            if ($product_info['quantity'] <= 0) {

                $this->data['stock'] = $product_info['stock_status'];

            } elseif ($this->config->get('config_stock_display')) {

                $this->data['stock'] = $product_info['quantity'];

            } else {

                $this->data['stock'] = $this->language->get('text_instock');

            }

            //$this->data['video'] = html_entity_decode($product_info['video'], ENT_QUOTES, 'UTF-8');


            if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/product/video.tpl')) {

                $this->template = $this->config->get('config_template') . '/template/product/video.tpl';

            } else {

                $this->template = 'default/template/product/video.tpl';

            }


            $this->children = array(

                'common/column_left',

                'common/column_right',

                'common/content_top',

                'common/content_bottom',

                'common/footer',

                'common/header'

            );



            $this->response->setOutput($this->render());
        }
    }

   public function review() {

    	$this->language->load('product/product');

		

		$this->load->model('catalog/review');



		$this->data['text_on'] = $this->language->get('text_on');

		$this->data['text_no_reviews'] = $this->language->get('text_no_reviews');



		if (isset($this->request->get['page'])) {

			$page = $this->request->get['page'];

		} else {

			$page = 1;

		}  

		

		$this->data['reviews'] = array();

		

		$review_total = $this->model_catalog_review->getTotalReviewsByProductId($this->request->get['product_id']);

			

		$results = $this->model_catalog_review->getReviewsByProductId($this->request->get['product_id'], ($page - 1) * 5, 5);

      		

		foreach ($results as $result) {

        	$this->data['reviews'][] = array(

        		'author'     => $result['author'],

				'text'       => $result['text'],

				'rating'     => (int)$result['rating'],

        		'reviews'    => sprintf($this->language->get('text_reviews'), (int)$review_total),

        		'date_added' => date($this->language->get('date_format_short'), strtotime($result['date_added']))

        	);

      	}			

			

		$pagination = new Pagination();

		$pagination->total = $review_total;

		$pagination->page = $page;

		$pagination->limit = 5; 

		$pagination->text = $this->language->get('text_pagination');

		$pagination->url = $this->url->link('product/product/review', 'product_id=' . $this->request->get['product_id'] . '&page={page}');

			

		$this->data['pagination'] = $pagination->render();

		

		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/product/review.tpl')) {

			$this->template = $this->config->get('config_template') . '/template/product/review.tpl';

		} else {

			$this->template = 'default/template/product/review.tpl';

		}

		

		$this->response->setOutput($this->render());

	}

	

	public function write() {

		$this->language->load('product/product');

		

		$this->load->model('catalog/review');

		

		$json = array();

		

		if ($this->request->server['REQUEST_METHOD'] == 'POST') {

			if ((utf8_strlen($this->request->post['name']) < 3) || (utf8_strlen($this->request->post['name']) > 25)) {

				$json['error'] = $this->language->get('error_name');

			}

			

			if ((utf8_strlen($this->request->post['text']) < 25) || (utf8_strlen($this->request->post['text']) > 1000)) {

				$json['error'] = $this->language->get('error_text');

			}

	

			if (empty($this->request->post['rating'])) {

				$json['error'] = $this->language->get('error_rating');

			}

	

			if (empty($this->session->data['captcha']) || ($this->session->data['captcha'] != $this->request->post['captcha'])) {

				$json['error'] = $this->language->get('error_captcha');

			}

				

			if (!isset($json['error'])) {

				$this->model_catalog_review->addReview($this->request->get['product_id'], $this->request->post);

				

				$json['success'] = $this->language->get('text_success');

			}

		}

		

		$this->response->setOutput(json_encode($json));

	}

	

	public function captcha() {

		$this->load->library('captcha');

		

		$captcha = new Captcha();

		

		$this->session->data['captcha'] = $captcha->getCode();

		

		$captcha->showImage();

	}

	

	public function upload() {

		$this->language->load('product/product');

		

		$json = array();

		

		if (!empty($this->request->files['file']['name'])) {

			$filename = basename(preg_replace('/[^a-zA-Z0-9\.\-\s+]/', '', html_entity_decode($this->request->files['file']['name'], ENT_QUOTES, 'UTF-8')));

			

			if ((utf8_strlen($filename) < 3) || (utf8_strlen($filename) > 64)) {

        		$json['error'] = $this->language->get('error_filename');

	  		}	  	

			

			$allowed = array();

			

			$filetypes = explode(',', $this->config->get('config_upload_allowed'));

			

			foreach ($filetypes as $filetype) {

				$allowed[] = trim($filetype);

			}

			

			if (!in_array(substr(strrchr($filename, '.'), 1), $allowed)) {

				$json['error'] = $this->language->get('error_filetype');

       		}	

						

			if ($this->request->files['file']['error'] != UPLOAD_ERR_OK) {

				$json['error'] = $this->language->get('error_upload_' . $this->request->files['file']['error']);

			}

		} else {

			$json['error'] = $this->language->get('error_upload');

		}

		

		if (!$json) {

			if (is_uploaded_file($this->request->files['file']['tmp_name']) && file_exists($this->request->files['file']['tmp_name'])) {

				$file = basename($filename) . '.' . md5(mt_rand());

				

				// Hide the uploaded file name so people can not link to it directly.

				$json['file'] = $this->encryption->encrypt($file);

				

				move_uploaded_file($this->request->files['file']['tmp_name'], DIR_DOWNLOAD . $file);

			}

						

			$json['success'] = $this->language->get('text_upload');

		}	

		

		$this->response->setOutput(json_encode($json));		

	}


    public function pdf() {

        $this->language->load('product/product');



        $this->data['breadcrumbs'] = array();



        $this->data['breadcrumbs'][] = array(

            'text'      => $this->language->get('text_home'),

            'href'      => $this->url->link('common/home'),

            'separator' => false

        );



        $this->load->model('catalog/category');


        $root_category = 0;
        if (isset($this->request->get['path'])) {

            $path = '';



            foreach (explode('_', $this->request->get['path']) as $path_id) {

                if (!$path) {

                    $path = $path_id;
                    $root_category = intval($path_id);

                } else {

                    $path .= '_' . $path_id;

                }



                $category_info = $this->model_catalog_category->getCategory($path_id);



                if ($category_info) {

                    $this->data['breadcrumbs'][] = array(

                        'text'      => $category_info['name'],

                        'href'      => $this->url->link('product/category', 'path=' . $path),

                        'separator' => $this->language->get('text_separator')

                    );

                }

            }

        }
        $this->data['root_category'] = $root_category;



        $this->load->model('catalog/manufacturer');



        if (isset($this->request->get['manufacturer_id'])) {

            $this->data['breadcrumbs'][] = array(

                'text'      => $this->language->get('text_brand'),

                'href'      => $this->url->link('product/manufacturer'),

                'separator' => $this->language->get('text_separator')

            );



            $manufacturer_info = $this->model_catalog_manufacturer->getManufacturer($this->request->get['manufacturer_id']);



            if ($manufacturer_info) {

                $this->data['breadcrumbs'][] = array(

                    'text'	    => $manufacturer_info['name'],

                    'href'	    => $this->url->link('product/manufacturer/info', 'manufacturer_id=' . $this->request->get['manufacturer_id']),

                    'separator' => $this->language->get('text_separator')

                );

            }

        }



        if (isset($this->request->get['filter_name']) || isset($this->request->get['filter_tag'])) {

            $url = '';



            if (isset($this->request->get['filter_name'])) {

                $url .= '&filter_name=' . $this->request->get['filter_name'];

            }



            if (isset($this->request->get['filter_tag'])) {

                $url .= '&filter_tag=' . $this->request->get['filter_tag'];

            }



            if (isset($this->request->get['filter_description'])) {

                $url .= '&filter_description=' . $this->request->get['filter_description'];

            }



            if (isset($this->request->get['filter_category_id'])) {

                $url .= '&filter_category_id=' . $this->request->get['filter_category_id'];

            }



            $this->data['breadcrumbs'][] = array(

                'text'      => $this->language->get('text_search'),

                'href'      => $this->url->link('product/search', $url),

                'separator' => $this->language->get('text_separator')

            );

        }



        if (isset($this->request->get['product_id'])) {

            $product_id = (int)$this->request->get['product_id'];

        } else {

            $product_id = 0;

        }



        $this->load->model('catalog/product');



        $product_info = $this->model_catalog_product->getProduct($product_id);



        if ($product_info) {

            $url = '';



            if (isset($this->request->get['path'])) {

                $url .= '&path=' . $this->request->get['path'];

            }



            if (isset($this->request->get['manufacturer_id'])) {

                $url .= '&manufacturer_id=' . $this->request->get['manufacturer_id'];

            }



            if (isset($this->request->get['filter_name'])) {

                $url .= '&filter_name=' . $this->request->get['filter_name'];

            }



            if (isset($this->request->get['filter_tag'])) {

                $url .= '&filter_tag=' . $this->request->get['filter_tag'];

            }



            if (isset($this->request->get['filter_description'])) {

                $url .= '&filter_description=' . $this->request->get['filter_description'];

            }



            if (isset($this->request->get['filter_category_id'])) {

                $url .= '&filter_category_id=' . $this->request->get['filter_category_id'];

            }



            $this->data['breadcrumbs'][] = array(

                'text'      => $product_info['name'],

                'href'      => $this->url->link('product/product', $url . '&product_id=' . $this->request->get['product_id']),

                'separator' => $this->language->get('text_separator')

            );



            if ($product_info['seo_title']) {

                $this->document->setTitle($product_info['seo_title']);

            } else {

                $this->document->setTitle($product_info['name']);

            }



            $this->document->setDescription($product_info['meta_description']);

            $this->document->setKeywords($product_info['meta_keyword']);

            $this->document->addLink($this->url->link('product/product', 'product_id=' . $this->request->get['product_id']), 'canonical');



            if ($product_info['seo_h1']) {

                $this->data['heading_title'] = $product_info['seo_h1'];

            } else {

                $this->data['heading_title'] = $product_info['name'];

            }

            $this->data['agent'] = $this->model_catalog_product->Agent($product_info['agent']);

            $this->data['text_select'] = $this->language->get('text_select');

            $this->data['text_manufacturer'] = $this->language->get('text_manufacturer');

            $this->data['text_model'] = $this->language->get('text_model');

            $this->data['text_weight'] = $this->language->get('text_weight');

            $this->data['text_location'] = $this->language->get('text_location');

            $this->data['text_sku'] = $this->language->get('text_sku');

            $this->data['text_upc'] = $this->language->get('text_upc');

            $this->data['text_ean'] = $this->language->get('text_ean');

            $this->data['text_jan'] = $this->language->get('text_jan');

            $this->data['text_isbn'] = $this->language->get('text_isbn');

            $this->data['text_mpn'] = $this->language->get('text_mpn');

            $this->data['text_reward'] = $this->language->get('text_reward');

            $this->data['text_points'] = $this->language->get('text_points');

            $this->data['text_discount'] = $this->language->get('text_discount');

            $this->data['text_stock'] = $this->language->get('text_stock');

            $this->data['text_price'] = $this->language->get('text_price');

            $this->data['text_tax'] = $this->language->get('text_tax');

            $this->data['text_discount'] = $this->language->get('text_discount');

            $this->data['text_option'] = $this->language->get('text_option');

            $this->data['text_qty'] = $this->language->get('text_qty');

            $this->data['text_minimum'] = sprintf($this->language->get('text_minimum'), $product_info['minimum']);

            $this->data['text_or'] = $this->language->get('text_or');

            $this->data['text_write'] = $this->language->get('text_write');

            $this->data['text_note'] = $this->language->get('text_note');

            $this->data['text_share'] = $this->language->get('text_share');

            $this->data['text_wait'] = $this->language->get('text_wait');

            $this->data['text_tags'] = $this->language->get('text_tags');

            $this->data['text_saving'] = $this->language->get('text_saving');



            $this->data['entry_name'] = $this->language->get('entry_name');

            $this->data['entry_review'] = $this->language->get('entry_review');

            $this->data['entry_rating'] = $this->language->get('entry_rating');

            $this->data['entry_good'] = $this->language->get('entry_good');

            $this->data['entry_bad'] = $this->language->get('entry_bad');

            $this->data['entry_captcha'] = $this->language->get('entry_captcha');



            $this->data['button_cart'] = $this->language->get('button_cart');

            $this->data['button_wishlist'] = $this->language->get('button_wishlist');

            $this->data['button_compare'] = $this->language->get('button_compare');

            $this->data['button_upload'] = $this->language->get('button_upload');

            $this->data['button_continue'] = $this->language->get('button_continue');



            $this->load->model('catalog/review');



            $this->data['tab_description'] = $this->language->get('tab_description');

            $this->data['tab_attribute'] = $this->language->get('tab_attribute');

            $this->data['tab_review'] = sprintf($this->language->get('tab_review'), $this->model_catalog_review->getTotalReviewsByProductId($this->request->get['product_id']));

            $this->data['tab_related'] = $this->language->get('tab_related');



            $this->data['product_id'] = $this->request->get['product_id'];

            $this->data['manufacturer'] = $product_info['manufacturer'];

            $this->data['manufacturers'] = $this->url->link('product/manufacturer/info', 'manufacturer_id=' . $product_info['manufacturer_id']);

            $this->data['model'] = $product_info['model'];

            $agent = $product_info['agent'];

            $this->data['reward'] = $product_info['reward'];

            $this->data['points'] = $product_info['points'];

            $this->data['sku'] = $product_info['sku'];

            $this->data['upc'] = $product_info['upc'];

            $this->data['ean'] = $product_info['ean'];

            $this->data['jan'] = $product_info['jan'];

            $this->data['isbn'] = $product_info['isbn'];

            $this->data['mpn'] = $product_info['mpn'];

            $this->data['location'] = $product_info['location'];

            if ($product_info['weight']) {

                $this->data['weight'] = $this->weight->format($product_info['weight'], $product_info['weight_class_id'], $this->language->get('decimal_point'), $this->language->get('thousand_point'));

            } else {

                $this->data['weight'] = '';

            }



            if ($product_info['quantity'] <= 0) {

                $this->data['stock'] = $product_info['stock_status'];

            } elseif ($this->config->get('config_stock_display')) {

                $this->data['stock'] = $product_info['quantity'];

            } else {

                $this->data['stock'] = $this->language->get('text_instock');

            }

			$this->load->model('tool/image');
            $this->load->model('tool/object');


			if ($product_info['image']) {

				$this->data['popup'] = $this->model_tool_object->resize($product_info['image'], $this->config->get('config_image_popup_width'), $this->config->get('config_image_popup_height'));

			} else {

				$this->data['popup'] = '';

			}

			

			if ($product_info['image']) {

				$this->data['thumb'] = $this->model_tool_object->resize($product_info['image'], $this->config->get('config_image_thumb_width'), $this->config->get('config_image_thumb_height'));

			} else {

				$this->data['thumb'] = '';

			}

			

			$this->data['thumb2'] = $this->model_tool_object->resize($product_info['image'], $this->config->get('config_image_thumb_width'), $this->config->get('config_image_thumb_height'));

			$this->data['thumb1'] = $this->model_tool_object->resize($product_info['image'], $this->config->get('config_image_additional_width'), $this->config->get('config_image_additional_height'));

            /*list($width_orig, $height_orig) = getimagesize(DIR_IMAGE . $product_info['image']);
            if ($width_orig>900) {
                $height_orig = $height_orig * 900 / $width_orig;
                $width_orig = 900;
            }*/
			
            $this->data['thumb_orig'] = $this->model_tool_object->resize($product_info['image'], $width_orig, $height_orig);
            //$this->data['thumb_orig'] = !empty($product_info['image']) && file_exists(DIR_IMAGE.$product_info['image']) ? '/image/'.$product_info['image'] : '';
            $this->data['product_video'] = $this->model_catalog_product->getProductVideo($this->request->get['product_id']);
			
			$this->data['view_price_from'] = $this->model_catalog_product->getPriceFrom($this->request->get['product_id']);
			
            $this->data['images_interior'] = array();

			$this->data['images_exterior'] = array();
			
			$this->data['images_more'] = array();

			$results_interior = $this->model_catalog_product->getProductImagesInterior($this->request->get['product_id']);

			$results_exterior = $this->model_catalog_product->getProductImagesExterior($this->request->get['product_id']);
			
			$results_more = $this->model_catalog_product->getProductImagesMore($this->request->get['product_id']);

			foreach ($results_interior as $result) {

                /*if (!file_exists(DIR_IMAGE . $result['image'])) continue;

                list($width_orig, $height_orig) = getimagesize(DIR_IMAGE . $result['image']);
                if ($width_orig>900) {
                    $height_orig = $height_orig * 900 / $width_orig;
                    $width_orig = 900;
                }*/

				$this->data['images_interior'][] = array(

					'popup' => $this->model_tool_object->resize($result['image'], $this->config->get('config_image_popup_width'), $this->config->get('config_image_popup_height')),

					'thumb' => $this->model_tool_object->resize($result['image'], $this->config->get('config_image_additional_width'), $this->config->get('config_image_additional_height')),

					'thumb1' => $this->model_tool_object->resize($result['image'], $this->config->get('config_image_additional_width'), $this->config->get('config_image_additional_height')),

					'thumb2' => $this->model_tool_object->resize($result['image'], $this->config->get('config_image_thumb_width'), $this->config->get('config_image_thumb_height')),

                    'full' => $this->model_tool_image->resize($result['image'], 680, 360),

                    'orig' => $this->model_tool_object->resize($result['image'], $width_orig, $height_orig),
                    //'orig' => !empty($result['image']) && file_exists(DIR_IMAGE.$result['image']) ? '/image/'.$result['image'] : ''

            );

			}
			
			foreach ($results_exterior as $result) {

				$this->data['images_exterior'][] = array(

					'popup' => $this->model_tool_object->resize($result['image'], $this->config->get('config_image_popup_width'), $this->config->get('config_image_popup_height')),

					'thumb' => $this->model_tool_object->resize($result['image'], $this->config->get('config_image_additional_width'), $this->config->get('config_image_additional_height')),

					'thumb1' => $this->model_tool_object->resize($result['image'], $this->config->get('config_image_additional_width'), $this->config->get('config_image_additional_height')),

					'thumb2' => $this->model_tool_object->resize($result['image'], $this->config->get('config_image_thumb_width'), $this->config->get('config_image_thumb_height')),

                    'full' => $this->model_tool_image->resize($result['image'], 680, 360),

                    'orig' => $this->model_tool_object->resize($result['image'], $width_orig, $height_orig),
                    //'orig' => !empty($result['image']) && file_exists(DIR_IMAGE.$result['image']) ? '/image/'.$result['image'] : ''

            );

			}
			
			foreach ($results_more as $result) {

				$this->data['images_more'][] = array(

					'popup' => $this->model_tool_object->resize($result['image'], $this->config->get('config_image_popup_width'), $this->config->get('config_image_popup_height')),

					'thumb' => $this->model_tool_object->resize($result['image'], $this->config->get('config_image_additional_width'), $this->config->get('config_image_additional_height')),

					'thumb1' => $this->model_tool_object->resize($result['image'], $this->config->get('config_image_additional_width'), $this->config->get('config_image_additional_height')),

					'thumb2' => $this->model_tool_object->resize($result['image'], $this->config->get('config_image_thumb_width'), $this->config->get('config_image_thumb_height')),

                    'full' => $this->model_tool_image->resize($result['image'], 680, 360),

                    'orig' => $this->model_tool_object->resize($result['image'], $width_orig, $height_orig),
                    //'orig' => !empty($result['image']) && file_exists(DIR_IMAGE.$result['image']) ? '/image/'.$result['image'] : ''

            );

			}

            $this->data['plans'] = array();

            $plan_results = $this->model_catalog_product->getProductPlans($this->request->get['product_id']);



            foreach ($plan_results as $result) {

                /*if (!file_exists(DIR_IMAGE . $result['image'])) continue;

                list($width_orig, $height_orig) = getimagesize(DIR_IMAGE . $result['image']);
                if ($width_orig>960) {
                    $height_orig = $height_orig * 960 / $width_orig;
                    $width_orig = 960;
                }*/

                $this->data['plans'][] = array(

                    'orig' => $this->model_tool_object->resize($result['image'], $width_orig, $height_orig),

                );

            }

//            $this->data['price'] = $this->currency->format($this->tax->calculate($product_info['price'], $product_info['tax_class_id'], $this->config->get('config_tax')));
//            $rub = $this->currency->convert($product_info['price'], 'USD', 'RUB');
//            $this->data['rub'] = $this->currency->format($this->tax->calculate($rub, $product_info['tax_class_id'], $this->config->get('config_tax')));

            $this->load->model('localisation/currency');

            if ($product_info['currency_id'] != 1) {
                $currency = $this->model_localisation_currency->getCurrency($product_info['currency_id']);
                $price = $this->currency->convert($product_info['price'], $currency['code'], 'RUB');
                $this->data['rub'] = $this->currency->format($this->tax->calculate($price, $product_info['tax_class_id'], $this->config->get('config_tax')));
            } else {
                $this->data['rub'] = $this->currency->format($this->tax->calculate($product_info['price'], $product_info['tax_class_id'], $this->config->get('config_tax')));
            }
            if ($product_info['currency_id'] != 2) {
                $currency = $this->model_localisation_currency->getCurrency($product_info['currency_id']);
                $price = $this->currency->convert($product_info['price'], $currency['code'], 'USD');
                $this->data['price'] = $this->currency->format($this->tax->calculate($price, $product_info['tax_class_id'], $this->config->get('config_tax')));
            } else {
                $this->data['price'] = $this->currency->format($this->tax->calculate($product_info['price'], $product_info['tax_class_id'], $this->config->get('config_tax')));
            }



            if ((float)$product_info['special']) {

                $this->data['special'] = $this->currency->format($this->tax->calculate($product_info['special'], $product_info['tax_class_id'], $this->config->get('config_tax')));

                if ($product_info['currency_id'] != 1) {
                    $currency = $this->model_localisation_currency->getCurrency($product_info['currency_id']);
                    $special = $this->currency->convert($product_info['special'], $currency['code'], 'RUB');
                    $this->data['special_rub'] = $this->currency->format($this->tax->calculate($special, $product_info['tax_class_id'], $this->config->get('config_tax')));
                } else {
                    $this->data['special_rub'] = $this->currency->format($this->tax->calculate($product_info['special'], $product_info['tax_class_id'], $this->config->get('config_tax')));
                }
                if ($product_info['currency_id'] != 2) {
                    $currency = $this->model_localisation_currency->getCurrency($product_info['currency_id']);
                    $special = $this->currency->convert($product_info['special'], $currency['code'], 'USD');
                    $this->data['special'] = $this->currency->format($this->tax->calculate($special, $product_info['tax_class_id'], $this->config->get('config_tax')));
                } else {
                    $this->data['special'] = $this->currency->format($this->tax->calculate($product_info['special'], $product_info['tax_class_id'], $this->config->get('config_tax')));
                }
            } else {

                $this->data['special'] = false;
                $this->data['special_rub'] = false;

            }

            $this->data['currency_id'] = $product_info['currency_id'];

            if ((float)$product_info['special']) {

                $this->data['saving'] = $this->currency->format(($this->tax->calculate($product_info['price'], $product_info['tax_class_id'], $this->config->get('config_tax')))-($this->tax->calculate($product_info['special'], $product_info['tax_class_id'], $this->config->get('config_tax'))));

            } else {

                $this->data['special'] = false;

            }



            if ((float)$product_info['special']) {

                $this->data['percent'] = round((($product_info['price'] - $product_info['special'])/$product_info['price'])*100, 0);

            } else {

                $this->data['special'] = false;

            }



            if ($this->config->get('config_tax')) {

                $this->data['tax'] = $this->currency->format((float)$product_info['special'] ? $product_info['special'] : $product_info['price']);

            } else {

                $this->data['tax'] = false;

            }



            $discounts = $this->model_catalog_product->getProductDiscounts($this->request->get['product_id']);



            $this->data['discounts'] = array();



            foreach ($discounts as $discount) {

                $this->data['discounts'][] = array(

                    'quantity' => $discount['quantity'],

                    'price'    => $this->currency->format($this->tax->calculate($discount['price'], $product_info['tax_class_id'], $this->config->get('config_tax')))

                );

            }



            $this->data['options'] = array();



            foreach ($this->model_catalog_product->getProductOptions($this->request->get['product_id']) as $option) {

                if ($option['type'] == 'select' || $option['type'] == 'radio' || $option['type'] == 'checkbox' || $option['type'] == 'image') {

                    $option_value_data = array();



                    foreach ($option['option_value'] as $option_value) {

                        if (!$option_value['subtract'] || ($option_value['quantity'] > 0)) {

                            if ((($this->config->get('config_customer_price') && $this->customer->isLogged()) || !$this->config->get('config_customer_price')) && (float)$option_value['price']) {

                                $price = $this->currency->format($this->tax->calculate($option_value['price'], $product_info['tax_class_id'], $this->config->get('config_tax')));

                            } else {

                                $price = false;

                            }



                            $option_value_data[] = array(

                                'product_option_value_id' => $option_value['product_option_value_id'],

                                'option_value_id'         => $option_value['option_value_id'],

                                'name'                    => $option_value['name'],

                                'image'                   => $this->model_tool_image->resize($option_value['image'], 50, 50),

                                'price'                   => $price,

                                'price_prefix'            => $option_value['price_prefix']

                            );

                        }

                    }



                    $this->data['options'][] = array(

                        'product_option_id' => $option['product_option_id'],

                        'option_id'         => $option['option_id'],

                        'name'              => $option['name'],

                        'type'              => $option['type'],

                        'option_value'      => $option_value_data,

                        'required'          => $option['required']

                    );

                } elseif ($option['type'] == 'text' || $option['type'] == 'textarea' || $option['type'] == 'file' || $option['type'] == 'date' || $option['type'] == 'datetime' || $option['type'] == 'time') {

                    $this->data['options'][] = array(

                        'product_option_id' => $option['product_option_id'],

                        'option_id'         => $option['option_id'],

                        'name'              => $option['name'],

                        'type'              => $option['type'],

                        'option_value'      => $option['option_value'],

                        'required'          => $option['required']

                    );

                }

            }

            $this->data['all_options'] = $this->model_catalog_product->getAllOptions();

            if ($product_info['minimum']) {

                $this->data['minimum'] = $product_info['minimum'];

            } else {

                $this->data['minimum'] = 1;

            }



            $this->data['review_status'] = $this->config->get('config_review_status');

            $this->data['reviews'] = sprintf($this->language->get('text_reviews'), (int)$product_info['reviews']);

            $this->data['rating'] = (int)$product_info['rating'];

            $this->data['description'] = html_entity_decode($product_info['description'], ENT_QUOTES, 'UTF-8');

            $this->data['attribute_groups'] = $this->model_catalog_product->getProductAttributes($this->request->get['product_id']);


            //$this->data['video'] = html_entity_decode($product_info['video'], ENT_QUOTES, 'UTF-8');


            $this->data['href'] = $this->url->link('product/product', 'path=' . $this->request->get['path'] . '&product_id=' . $this->data['product_id']);


            if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/product/pdf.tpl')) {

                $this->template = $this->config->get('config_template') . '/template/product/pdf.tpl';

            } else {

                $this->template = 'default/template/product/pdf.tpl';

            }


            $html = $this->render();

            $pages = explode('<!--break-->',$html);

            // Write to PDF

            require_once($_SERVER['DOCUMENT_ROOT'].'/tcpdf/config/tcpdf_config.php');
            require_once($_SERVER['DOCUMENT_ROOT'].'/tcpdf/tcpdf.php');

            $pdf = new TCPDF(PDF_PAGE_ORIENTATION, PDF_UNIT, PDF_PAGE_FORMAT, true, 'UTF-8', false);

            $pdf->SetCreator($_SERVER['HTTP_HOST']);
            $pdf->SetAuthor('Крымская Недвижимость');
            $pdf->SetTitle($this->data['heading_title']);
            $pdf->SetSubject($this->data['heading_title']);
            $pdf->SetKeywords('');

            $pdf->SetHeaderData(PDF_HEADER_LOGO, PDF_HEADER_LOGO_WIDTH, PDF_HEADER_TITLE, PDF_HEADER_STRING);


            $pdf->setHeaderFont(Array(PDF_FONT_NAME_MAIN, '', PDF_FONT_SIZE_MAIN));
            $pdf->setFooterFont(Array(PDF_FONT_NAME_DATA, '', PDF_FONT_SIZE_DATA));

            $pdf->SetDefaultMonospacedFont(PDF_FONT_MONOSPACED);


            $pdf->SetMargins(PDF_MARGIN_LEFT, PDF_MARGIN_TOP, PDF_MARGIN_RIGHT);
            $pdf->SetHeaderMargin(PDF_MARGIN_HEADER);
            $pdf->SetFooterMargin(PDF_MARGIN_FOOTER);


            $pdf->SetAutoPageBreak(TRUE, PDF_MARGIN_BOTTOM);


            $pdf->setImageScale(PDF_IMAGE_SCALE_RATIO);



            $pdf->SetFont('dejavusans', '', 10);

            foreach ($pages as $page) {
                $page= trim($page);
                if (empty($page)) continue;

                //$pdf->lastPage();
                $pdf->AddPage();

                $pdf->writeHTML($page, true, false, true, false, '');
            }


            $pdf->Output('object-'.$this->data['model'].'.pdf', 'D');

        } else {

            $url = '';



            if (isset($this->request->get['path'])) {

                $url .= '&path=' . $this->request->get['path'];

            }



            if (isset($this->request->get['manufacturer_id'])) {

                $url .= '&manufacturer_id=' . $this->request->get['manufacturer_id'];

            }



            if (isset($this->request->get['filter_name'])) {

                $url .= '&filter_name=' . $this->request->get['filter_name'];

            }



            if (isset($this->request->get['filter_tag'])) {

                $url .= '&filter_tag=' . $this->request->get['filter_tag'];

            }



            if (isset($this->request->get['filter_description'])) {

                $url .= '&filter_description=' . $this->request->get['filter_description'];

            }



            if (isset($this->request->get['filter_category_id'])) {

                $url .= '&filter_category_id=' . $this->request->get['filter_category_id'];

            }



            $this->data['breadcrumbs'][] = array(

                'text'      => $this->language->get('text_error'),

                'href'      => $this->url->link('product/product', $url . '&product_id=' . $product_id),

                'separator' => $this->language->get('text_separator')

            );



            $this->document->setTitle($this->language->get('text_error'));



            $this->data['heading_title'] = $this->language->get('text_error');



            $this->data['text_error'] = $this->language->get('text_error');



            $this->data['button_continue'] = $this->language->get('button_continue');



            $this->data['continue'] = $this->url->link('common/home');



            if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/error/not_found.tpl')) {

                $this->template = $this->config->get('config_template') . '/template/error/not_found.tpl';

            } else {

                $this->template = 'default/template/error/not_found.tpl';

            }



            $this->children = array(

                'common/column_left',

                'common/column_right',

                'common/content_top',

                'common/content_bottom',

                'common/footer',

                'common/header'

            );



            $this->response->setOutput($this->render());

        }

    }
}

?>
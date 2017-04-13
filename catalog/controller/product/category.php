<?php 
class ControllerProductCategory extends Controller {  

	public function index() { 

		$this->language->load('product/category');

		

		$this->load->model('catalog/category');

		

		$this->load->model('catalog/product');

		

		$this->load->model('tool/image'); 

		

		if (isset($this->request->get['sort'])) {

			$sort = $this->request->get['sort'];

		} else {

			$sort = 'p.sort_order';

		}



		if (isset($this->request->get['order'])) {

			$order = $this->request->get['order'];

		} else {

			$order = 'ASC';

		}

		

		if (isset($this->request->get['page'])) {

			$page = $this->request->get['page'];

		} else { 

			$page = 1;

		}	

							

		if (isset($this->request->get['limit'])) {

			$limit = $this->request->get['limit'];

		} else {

			$limit = $this->config->get('config_catalog_limit');

		}

					

		$this->data['breadcrumbs'] = array();



   		$this->data['breadcrumbs'][] = array(

       		'text'      => $this->language->get('text_home'),

			'href'      => $this->url->link('common/home'),

       		'separator' => false

   		);	



		if (isset($this->request->get['path'])) {

			$path = '';

		

			$parts = explode('_', (string)$this->request->get['path']);

		

			foreach ($parts as $path_id) {

				if (!$path) {

					$path = (int)$path_id;

				} else {

					$path .= '_' . (int)$path_id;

				}

	     $this->load->model('catalog/product');
		
		 $this->data['price_from'] = $this->model_catalog_product->getPriceFrom($product_id);		

	     $category_info = $this->model_catalog_category->getCategory($path_id);

				
				if ($category_info) {

	       			$this->data['breadcrumbs'][] = array(

   	    				'text'      => $category_info['name'],

						'href'      => $this->url->link('product/category', 'path=' . $path),

        				'separator' => $this->language->get('text_separator')

        			);

				}

			}		

		

			$category_id = (int)array_pop($parts);

		} else {

			$category_id = 0;

		}

		

		$category_info = $this->model_catalog_category->getCategory($category_id);

		if ($category_info) {

			if ($category_info['seo_title']) {

                if($category_info['parent_type']=='1'){

                    $this->data['subCatInfo'] = $category_info['seo_title'];

                }

                else{

                    $this->data['subCatInfo'] = '';

                }

		  		$this->document->setTitle($category_info['seo_title']);

			} else {

                $this->data['subCatInfo'] = '';

		  		$this->document->setTitle($category_info['name']);

			}



			$this->document->setDescription($category_info['meta_description']);

			$this->document->setKeywords($category_info['meta_keyword']);

            $this->data['category_id'] = $category_id;

            //ПРОДАЖА

            if($category_id=="60" || $category_id=="61" || $category_id=="62" || $category_id=="63"){



            }

			if ($category_info['seo_h1']) {

				$this->data['heading_title'] = $category_info['seo_h1'];

			} else {

				$this->data['heading_title'] = $category_info['name'];

			}

			

			$this->data['text_refine'] = $this->language->get('text_refine');

			$this->data['text_empty'] = $this->language->get('text_empty');			

			$this->data['text_quantity'] = $this->language->get('text_quantity');

			$this->data['text_manufacturer'] = $this->language->get('text_manufacturer');

			$this->data['text_model'] = $this->language->get('text_model');

			$this->data['text_price'] = $this->language->get('text_price');

			$this->data['text_tax'] = $this->language->get('text_tax');

			$this->data['text_points'] = $this->language->get('text_points');

			$this->data['text_compare'] = sprintf($this->language->get('text_compare'), (isset($this->session->data['compare']) ? count($this->session->data['compare']) : 0));

			$this->data['text_display'] = $this->language->get('text_display');

			$this->data['text_list'] = $this->language->get('text_list');

			$this->data['text_grid'] = $this->language->get('text_grid');

			$this->data['text_sort'] = $this->language->get('text_sort');

			$this->data['text_limit'] = $this->language->get('text_limit');

					

			$this->data['button_cart'] = $this->language->get('button_cart');

			$this->data['button_wishlist'] = $this->language->get('button_wishlist');

			$this->data['button_compare'] = $this->language->get('button_compare');

			$this->data['button_continue'] = $this->language->get('button_continue');
			
			/*Подкатегории для элетной и бюджетной недвижимости*/
			$this->data['certain_category'] = $this->model_catalog_category->getCategories($category_id);

			$this->data['certain_category_array'] = array();
			
			foreach($this->data['certain_category'] as $certain){
				$certain_category_id = $certain['category_id'];
				$certain_name = $certain['name'];
				
				$this->data['certain_category_array'][] = array(
			    'name' => $certain_name,
				'href' => $this->url->link('product/category', 'path=' . $this->request->get['path'] . '_' . $certain_category_id . $url),
			    );
			}
			
			if ($category_info['image']) {

				//$this->data['thumb'] = $this->model_tool_image->resize($category_info['image'], $this->config->get('config_image_category_width'), $this->config->get('config_image_category_height'));
                $this->data['thumb'] = !empty($category_info['image']) ? '/image/'.$category_info['image'] : '';

			} else {

				$this->data['thumb'] = '';

			}

									

			$this->data['description'] = html_entity_decode($category_info['description'], ENT_QUOTES, 'UTF-8');

			$this->data['compare'] = $this->url->link('product/compare');

			$this->data['quantity_column'] = $this->model_catalog_category->getQuantityColumn($category_id);

			$url = '';

			

			if (isset($this->request->get['sort'])) {

				$url .= '&sort=' . $this->request->get['sort'];

			}	



			if (isset($this->request->get['order'])) {

				$url .= '&order=' . $this->request->get['order'];

			}	

			

			if (isset($this->request->get['limit'])) {

				$url .= '&limit=' . $this->request->get['limit'];

			}

								

			$this->data['categories'] = array();

            if($category_info['parent_type']=='1'){

                $results = $this->model_catalog_category->getCategories($category_info['parent_id']);

            }

            else{

                $results = $this->model_catalog_category->getCategories($category_id);

            }

			foreach ($results as $result) {

				$data = array(

					'filter_category_id'  => $result['category_id'],

					'filter_sub_category' => true	

				);

							

				$product_total = $this->model_catalog_product->getTotalProducts($data);

				//$image = $this->model_tool_image->resize($result['image'], $this->config->get('config_image_category_width'), $this->config->get('config_image_category_height'));
                $image = !empty($result['image']) ? '/image/'.$result['image'] : '';

				

				$this->data['categories'][] = array(

					'name'  => $result['name'] . ($this->config->get('config_product_count') ? ' (' . $product_total . ')' : ''),

					'thumb' => $image,

					'href'  => $this->url->link('product/category', 'path=' . $this->request->get['path'] . '_' . $result['category_id'] . $url)

				);

			}



			$this->data['products'] = array();

			

			$data = array(

				'filter_category_id' => $category_id, 

				'sort'               => $sort,

				'order'              => $order,

				'start'              => ($page - 1) * $limit,

				'limit'              => $limit

			);

					

            if ($category_id == 105) {
                $data['filter_category_id'] = false;
				
                $product_total = $this->model_catalog_product->getTotalProductsCompany($data);
				
                $results = $this->model_catalog_product->getProductsCompany($data);
							
            } else if ( /*$category_id == 82 ||*/ $category_id == 69 || $category_id == 104) {
                /*if ($category_id == 82) {
                    $data['filter_category_id'] = 20;
                } else*/ if ($category_id == 69) {
                    $data['filter_category_id'] = 18;
                } else if ($category_id == 104) {
                    $data['filter_category_id'] = 94;
                }

                $data['filter_sub_category'] = true;

                $product_total = $this->model_catalog_product->getTotalSpecialProducts($data);

                $results = $this->model_catalog_product->getSpecialProducts($data);
            } else {
                $product_total = $this->model_catalog_product->getTotalProducts($data);

                $results = $this->model_catalog_product->getProducts($data);
            }


            $this->load->model('localisation/currency');
			$this->load->model('tool/object');

			foreach ($results as $result) {

                if($result['upc']){
                    $badge = $result['upc'];
                }else{
                    $badge = '';
                }

				if ($result['image']) {
                      $image = $this->model_tool_object->resize($result['image'], $this->config->get('config_image_product_width'), $this->config->get('config_image_product_height'));
					//$image = $this->model_tool_image->resize($result['image'], $this->config->get('config_image_product_width'), $this->config->get('config_image_product_height'));
                    //$image = file_exists($_SERVER['DOCUMENT_ROOT'].'/image/'.$result['image']) ? '/image/'.$result['image'] : '';

				} else {

					$image = false;

				}

				

//                $price = $this->currency->format($this->tax->calculate($result['price'], $result['tax_class_id'], $this->config->get('config_tax')));
//                $rub = $this->currency->convert($result['price'], 'USD', 'RUB');
//                $rub = $this->currency->format($this->tax->calculate($rub, $result['tax_class_id'], $this->config->get('config_tax')));



                if ($result['currency_id'] != 1) {
                    $currency = $this->model_localisation_currency->getCurrency($result['currency_id']);
                    $price_rub = $this->currency->convert($result['price'], $currency['code'], 'RUB');
                    $rub = $this->currency->format($this->tax->calculate($price_rub, $result['tax_class_id'], $this->config->get('config_tax')));
                } else {
                    $rub = $this->currency->format($this->tax->calculate($result['price'], $result['tax_class_id'], $this->config->get('config_tax')));
                }
                if ($result['currency_id'] != 2) {
                    $currency = $this->model_localisation_currency->getCurrency($result['currency_id']);
                    $price_dollar = $this->currency->convert($result['price'], $currency['code'], 'USD');
                    $price = $this->currency->format($this->tax->calculate($price_dollar, $result['tax_class_id'], $this->config->get('config_tax')));
                } else {
                    $price = $this->currency->format($this->tax->calculate($result['price'], $result['tax_class_id'], $this->config->get('config_tax')));
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

				if ($this->config->get('config_tax')) {

					$tax = $this->currency->format((float)$result['special'] ? $result['special'] : $result['price']);

				} else {

					$tax = false;

				}



				if ($this->config->get('config_review_status')) {

					$rating = (int)$result['rating'];

				} else {

					$rating = false;

				}
				
				$description_symbols = 300;

					$descr_plaintext = strip_tags(html_entity_decode($result['description'], ENT_QUOTES, 'UTF-8'));

				if( mb_strlen($descr_plaintext, 'UTF-8') > $description_symbols ) {

					$descr_plaintext = mb_substr($descr_plaintext, 0, $description_symbols, 'UTF-8') . '&nbsp;&hellip;';
				}
	
				$this->data['products'][] = array(

					'product_id'  => $result['product_id'],

                    'badge'        => $badge,

					'thumb'       => $image,

					'name'        => $result['name'],
					
					'tax_class_id' => $result['tax_class_id'],

                    'model'      => $result['model'],

					'description' => $descr_plaintext,

					'price'       => $price,
					
					'price_from'  => $result['price_from'],

                    'rub'         => $rub,

					'special'     => $special,

                    'special_rub' => $special_rub,

                    'currency_id' => $result['currency_id'],

					'saving' 	  => $this->currency->format(($this->tax->calculate($result['price'], $result['tax_class_id'], $this->config->get('config_tax')))-($this->tax->calculate($result['special'], $result['tax_class_id'], $this->config->get('config_tax')))),

					'tax'         => $tax,

					'rating'      => $result['rating'],

					'reviews'     => sprintf($this->language->get('text_reviews'), (int)$result['reviews']),

                    'video'     => html_entity_decode($result['video'], ENT_QUOTES, "UTF-8"),
					
					'view_price_from' => $this->model_catalog_product->getPriceFrom($result['product_id']),

                    'gallery_href'        => $this->url->link('product/product/gallery', 'path=' . $this->request->get['path'] . '&product_id=' . $result['product_id']),

                    'video_href'        => $this->url->link('product/product/video', 'path=' . $this->request->get['path'] . '&product_id=' . $result['product_id']),

                    'href'        => $this->url->link('product/product', 'path=' . $this->request->get['path'] . '&product_id=' . $result['product_id'])
                );

			}

			

			$url = '';

	

			if (isset($this->request->get['limit'])) {

				$url .= '&limit=' . $this->request->get['limit'];

			}

							

			$this->data['sorts'] = array();

			

			$this->data['sorts'][] = array(

				'text'  => $this->language->get('text_default'),

				'value' => 'p.sort_order-ASC',

				'href'  => $this->url->link('product/category', 'path=' . $this->request->get['path'] . '&sort=p.sort_order&order=ASC' . $url)

			);

			

			$this->data['sorts'][] = array(

				'text'  => $this->language->get('text_name_asc'),

				'value' => 'pd.name-ASC',

				'href'  => $this->url->link('product/category', 'path=' . $this->request->get['path'] . '&sort=pd.name&order=ASC' . $url)

			);



			$this->data['sorts'][] = array(

				'text'  => $this->language->get('text_name_desc'),

				'value' => 'pd.name-DESC',

				'href'  => $this->url->link('product/category', 'path=' . $this->request->get['path'] . '&sort=pd.name&order=DESC' . $url)

			);



			$this->data['sorts'][] = array(

				'text'  => $this->language->get('text_price_asc'),

				'value' => 'p.price-ASC',

				'href'  => $this->url->link('product/category', 'path=' . $this->request->get['path'] . '&sort=p.price&order=ASC' . $url)

			); 



			$this->data['sorts'][] = array(

				'text'  => $this->language->get('text_price_desc'),

				'value' => 'p.price-DESC',

				'href'  => $this->url->link('product/category', 'path=' . $this->request->get['path'] . '&sort=p.price&order=DESC' . $url)

			); 

			

			if ($this->config->get('config_review_status')) {

				$this->data['sorts'][] = array(

					'text'  => $this->language->get('text_rating_desc'),

					'value' => 'rating-DESC',

					'href'  => $this->url->link('product/category', 'path=' . $this->request->get['path'] . '&sort=rating&order=DESC' . $url)

				); 

				

				$this->data['sorts'][] = array(

					'text'  => $this->language->get('text_rating_asc'),

					'value' => 'rating-ASC',

					'href'  => $this->url->link('product/category', 'path=' . $this->request->get['path'] . '&sort=rating&order=ASC' . $url)

				);

			}

			

			$this->data['sorts'][] = array(

				'text'  => $this->language->get('text_model_asc'),

				'value' => 'p.model-ASC',

				'href'  => $this->url->link('product/category', 'path=' . $this->request->get['path'] . '&sort=p.model&order=ASC' . $url)

			);



			$this->data['sorts'][] = array(

				'text'  => $this->language->get('text_model_desc'),

				'value' => 'p.model-DESC',

				'href'  => $this->url->link('product/category', 'path=' . $this->request->get['path'] . '&sort=p.model&order=DESC' . $url)

			);

			

			$url = '';

	

			if (isset($this->request->get['sort'])) {

				$url .= '&sort=' . $this->request->get['sort'];

			}	



			if (isset($this->request->get['order'])) {

				$url .= '&order=' . $this->request->get['order'];

			}

			

			$this->data['limits'] = array();

			

			$this->data['limits'][] = array(

				'text'  => $this->config->get('config_catalog_limit'),

				'value' => $this->config->get('config_catalog_limit'),

				'href'  => $this->url->link('product/category', 'path=' . $this->request->get['path'] . $url . '&limit=' . $this->config->get('config_catalog_limit'))

			);

						

			$this->data['limits'][] = array(

				'text'  => 25,

				'value' => 25,

				'href'  => $this->url->link('product/category', 'path=' . $this->request->get['path'] . $url . '&limit=25')

			);

			

			$this->data['limits'][] = array(

				'text'  => 50,

				'value' => 50,

				'href'  => $this->url->link('product/category', 'path=' . $this->request->get['path'] . $url . '&limit=50')

			);



			$this->data['limits'][] = array(

				'text'  => 75,

				'value' => 75,

				'href'  => $this->url->link('product/category', 'path=' . $this->request->get['path'] . $url . '&limit=75')

			);

			

			$this->data['limits'][] = array(

				'text'  => 100,

				'value' => 100,

				'href'  => $this->url->link('product/category', 'path=' . $this->request->get['path'] . $url . '&limit=100')

			);

						

			$url = '';

	

			if (isset($this->request->get['sort'])) {

				$url .= '&sort=' . $this->request->get['sort'];

			}	



			if (isset($this->request->get['order'])) {

				$url .= '&order=' . $this->request->get['order'];

			}

	

			if (isset($this->request->get['limit'])) {

				$url .= '&limit=' . $this->request->get['limit'];

			}



			$pagination = new Pagination();

			$pagination->total = $product_total;

			$pagination->page = $page;

			$pagination->limit = $limit;

			$pagination->text = $this->language->get('text_pagination');

			$pagination->url = $this->url->link('product/category', 'path=' . $this->request->get['path'] . $url . '&page={page}');

		

			$this->data['pagination'] = $pagination->render();

            $this->data['pages_total'] = $pagination->total;

			$this->data['sort'] = $sort;

			$this->data['order'] = $order;

			$this->data['limit'] = $limit;

		

			$this->data['continue'] = $this->url->link('common/home');



			if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/product/category.tpl')) {

				$this->template = $this->config->get('config_template') . '/template/product/category.tpl';

			} else {

				$this->template = 'default/template/product/category.tpl';

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

    	} else {

			$url = '';

			

			if (isset($this->request->get['path'])) {

				$url .= '&path=' . $this->request->get['path'];

			}

									

			if (isset($this->request->get['sort'])) {

				$url .= '&sort=' . $this->request->get['sort'];

			}	



			if (isset($this->request->get['order'])) {

				$url .= '&order=' . $this->request->get['order'];

			}

				

			if (isset($this->request->get['page'])) {

				$url .= '&page=' . $this->request->get['page'];

			}

						

			if (isset($this->request->get['limit'])) {

				$url .= '&limit=' . $this->request->get['limit'];

			}

						

			$this->data['breadcrumbs'][] = array(

				'text'      => $this->language->get('text_error'),

				'href'      => $this->url->link('product/category', $url),

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
<?php 
class ControllerProductAgentProduct extends Controller {  

	public function index() { 
	    
		$this->language->load('product/agentproduct');
		
		$this->document->setTitle($this->language->get('heading_title'));

		$this->load->model('catalog/category');

		$this->load->model('catalog/product');

		$this->load->model('tool/image'); 
		
		$this->load->model('localisation/currency');
		
		$this->load->model('tool/object');
		
	    $this->data['breadcrumbs'] = array();

   		$this->data['breadcrumbs'][] = array(
       		'text'      => $this->language->get('text_home'),
			'href'      => $this->url->link('common/home'),
       		'separator' => false
   		);	
				
		if (isset($this->request->get['path'])) {
			
		$path = '';
		
		$parts = explode('=', $_SERVER['REQUEST_URI']);
		
		foreach ($parts as $path_id) {
		
				if (!$path) {
					$path = (int)$path_id;
				} else {
					$path .= '=' . (int)$path_id;
				}
		}	
		$category_info = $this->model_catalog_product->Agent($this->request->get['path']);
													
		if ($category_info) {
					$this->data['breadcrumbs'][] = array(
						'text'      => $category_info['firstname'] .'&nbsp;'. $category_info['lastname'],
						'href'      => $this->url->link('product/agentproduct', 'path=' . $path_id),
						'separator' => $this->language->get('text_separator')
					);
		}
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
		
		$category_info = $this->model_catalog_product->Agent($this->request->get['path']);
		
		$results = $this->model_catalog_product->getProductAgent($this->request->get['path'], ($page - 1) * $limit, $limit);
		
		$product_total = $this->model_catalog_product->getTotalProductAgent($this->request->get['path']);
		
		if($category_info){
												
		$this->data['agent_inf'] = array();
		
		$this->data['agent_inf'][] = array(
		    'user_id'  => $category_info['user_id'], 
		    'image'    => $category_info['image'], 
			'name'     => $category_info['firstname'] .'&nbsp;'. $category_info['lastname'],
			'skype'    => $category_info['skype'],
			'phone_1'  => $category_info['phone_1'],
			'phone_2'  => $category_info['phone_2'],
			'email'    => $category_info['email'],
		);
		
		$this->data['products'] = array();

			foreach ($results as $result) {
                if($result['upc']){
                    $badge = $result['upc'];
                } else {
                    $badge = '';
                }

				if ($result['image']) {
                      $image = $this->model_tool_object->resize($result['image'], $this->config->get('config_image_product_width'), $this->config->get('config_image_product_height'));
				} else {
					$image = false;
				}

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
                    'badge'       => $badge,
					'thumb'       => $image,
					'name'        => $result['name'],
                    'model'       => $result['model'],
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
                    'video'       => html_entity_decode($result['video'], ENT_QUOTES, "UTF-8"),			
					'view_price_from' => $this->model_catalog_product->getPriceFrom($result['product_id']),
                    'gallery_href'=> $this->url->link('product/product/gallery', 'path=' . $this->request->get['path'] . '&product_id=' . $result['product_id']),
                    'video_href'  => $this->url->link('product/product/video', 'path=' . $this->request->get['path'] . '&product_id=' . $result['product_id']),
                    'href'        => $this->url->link('product/product', 'path=' . $this->request->get['path'] . '&product_id=' . $result['product_id'])
                );
			}
			
		    $url = '';
			
			$pagination = new Pagination();

			$pagination->total = $product_total['COUNT(product_id)'];

			$pagination->page = $page;

			$pagination->limit = $limit;

			$pagination->text = $this->language->get('text_pagination');

			$pagination->url = $this->url->link('product/agentproduct', 'path=' . $this->request->get['path'] . '&page={page}');
			                   
			$this->data['pagination'] = $pagination->render();

		    if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/product/agentproduct.tpl')) {
				$this->template = $this->config->get('config_template') . '/template/product/agentproduct.tpl';
			} else {
				$this->template = 'default/template/product/agentproduct.tpl';
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
		}else{
			
			$url = '';

			$this->data['breadcrumbs'][] = array(
				'text'      => $this->language->get('text_error'),
				'href'      => $this->url->link('product/category', $url),
				'separator' => $this->language->get('text_separator')
			);

			$this->document->setTitle($this->language->get('text_error'));

      		$this->data['heading_title'] = $this->language->get('text_error');
			
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
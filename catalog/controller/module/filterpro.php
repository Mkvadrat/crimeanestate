<?php
class ControllerModuleFilterPro extends Controller {
	private $k = 1;

	protected function index($setting) {
		
	/*$this->document->addScript('catalog/view/javascript/jquery/jquery-1.7.1.min.js');
	$this->document->addScript('catalog/view/javascript/jquery/ui/external/jquery.cookie.js');
	$this->document->addScript('catalog/view/javascript/jquery/jquery.tmpl.min.js');
	$this->document->addScript('catalog/view/javascript/jquery/jquery.deserialize.min.js');
	$this->document->addScript('catalog/view/javascript/jquery/jquery.loadmask.min.js');
	$this->document->addScript('catalog/view/javascript/filterpro.min.js');*/
				
		if($setting['type'] == 1) {
			$this->language->load('product/filter');
			$this->data['text_display'] = $this->language->get('text_display');
			$this->data['text_list'] = $this->language->get('text_list');
			$this->data['text_grid'] = $this->language->get('text_grid');
			$this->data['text_sort'] = $this->language->get('text_sort');
			$this->data['text_limit'] = $this->language->get('text_limit');

			$sort = 'p.sort_order';
			$order = 'ASC';
			$limit = $this->config->get('config_catalog_limit');

			$url = '';

			if(isset($this->request->get['limit'])) {
				$url .= '&limit=' . $this->request->get['limit'];
			}

			$this->data['sorts'] = array();

			$this->data['sorts'][] = array(
				'text' => $this->language->get('text_default'),
				'value' => 'p.sort_order-ASC',
				'href' => $this->url->link('product/filter', 'sort=p.sort_order&order=ASC' . $url)
			);

			$this->data['sorts'][] = array(
				'text' => $this->language->get('text_name_asc'),
				'value' => 'pd.name-ASC',
				'href' => $this->url->link('product/filter', 'sort=pd.name&order=ASC' . $url)
			);

			$this->data['sorts'][] = array(
				'text' => $this->language->get('text_name_desc'),
				'value' => 'pd.name-DESC',
				'href' => $this->url->link('product/filter', 'sort=pd.name&order=DESC' . $url)
			);

			$this->data['sorts'][] = array(
				'text' => $this->language->get('text_price_asc'),
				'value' => 'p.price-ASC',
				'href' => $this->url->link('product/filter', 'sort=p.price&order=ASC' . $url)
			);

			$this->data['sorts'][] = array(
				'text' => $this->language->get('text_price_desc'),
				'value' => 'p.price-DESC',
				'href' => $this->url->link('product/filter', 'sort=p.price&order=DESC' . $url)
			);

			if($this->config->get('config_review_status')) {
				$this->data['sorts'][] = array(
					'text' => $this->language->get('text_rating_desc'),
					'value' => 'rating-DESC',
					'href' => $this->url->link('product/filter', 'sort=rating&order=DESC' . $url)
				);

				$this->data['sorts'][] = array(
					'text' => $this->language->get('text_rating_asc'),
					'value' => 'rating-ASC',
					'href' => $this->url->link('product/filter', 'sort=rating&order=ASC' . $url)
				);
			}

			$this->data['sorts'][] = array(
				'text' => $this->language->get('text_model_asc'),
				'value' => 'p.model-ASC',
				'href' => $this->url->link('product/filter', 'sort=p.model&order=ASC' . $url)
			);

			$this->data['sorts'][] = array(
				'text' => $this->language->get('text_model_desc'),
				'value' => 'p.model-DESC',
				'href' => $this->url->link('product/filter', 'sort=p.model&order=DESC' . $url)
			);

			$url = '';

			if(isset($this->request->get['sort'])) {
				$url .= 'sort=' . $this->request->get['sort'];
			}

			if(isset($this->request->get['order'])) {
				$url .= '&order=' . $this->request->get['order'];
			}

			$this->data['limits'] = array();

			$this->data['limits'][] = array(
				'text' => $this->config->get('config_catalog_limit'),
				'value' => $this->config->get('config_catalog_limit'),
				'href' => $this->url->link('product/filter', $url . '&limit=' . $this->config->get('config_catalog_limit'))
			);

			$this->data['limits'][] = array(
				'text' => 25,
				'value' => 25,
				'href' => $this->url->link('product/filter', $url . '&limit=25')
			);

			$this->data['limits'][] = array(
				'text' => 50,
				'value' => 50,
				'href' => $this->url->link('product/filter', $url . '&limit=50')
			);

			$this->data['limits'][] = array(
				'text' => 75,
				'value' => 75,
				'href' => $this->url->link('product/filter', $url . '&limit=75')
			);

			$this->data['limits'][] = array(
				'text' => 100,
				'value' => 100,
				'href' => $this->url->link('product/filter', $url . '&limit=100')
			);


			$this->data['sort'] = $sort;
			$this->data['order'] = $order;
			$this->data['limit'] = $limit;

			if(file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/module/filterpro_container.tpl')) {
				$this->template = $this->config->get('config_template') . '/template/module/filterpro_container.tpl';
			} else {
				$this->template = 'default/template/module/filterpro_container.tpl';
			}
		} else {
			$this->language->load('module/filterpro');

			$this->data['text_tax'] = $this->language->get('text_tax');
			$this->data['button_cart'] = $this->language->get('button_cart');
			$this->data['button_wishlist'] = $this->language->get('button_wishlist');
			$this->data['button_compare'] = $this->language->get('button_compare');
			$this->data['text_price_range'] = $this->language->get('text_price_range');
			$this->data['text_manufacturers'] = $this->language->get('text_manufacturers');
			$this->data['text_tags'] = $this->language->get('text_tags');
			$this->data['text_categories'] = $this->language->get('text_categories');
			$this->data['text_attributes'] = $this->language->get('text_attributes');
			$this->data['text_all'] = $this->language->get('text_all');
			$this->data['clear_filter'] = $this->language->get('clear_filter');
			$this->data['text_instock'] = $this->language->get('text_instock');

			$this->data['heading_title'] = $this->language->get('heading_title');

			$this->data['pds_sku'] = $this->language->get('pds_sku');
			$this->data['pds_upc'] = $this->language->get('pds_upc');
			$this->data['pds_location'] = $this->language->get('pds_location');
			$this->data['pds_model'] = $this->language->get('pds_model');
			$this->data['pds_brand'] = $this->language->get('pds_brand');
			$this->data['pds_stock'] = $this->language->get('pds_stock');
			$this->data['symbol_right'] = $this->currency->getSymbolRight();
			$this->data['symbol_left'] = $this->currency->getSymbolLeft();

			$this->data['setting'] = $setting;

			if(VERSION == '1.5.0') {
				$filterpro_setting = unserialize($this->config->get('filterpro_setting'));
			} else {
				$filterpro_setting = $this->config->get('filterpro_setting');
			}

			$category_id = false;
			$this->data['path'] = "";
			if(isset($this->request->get['path'])) {
				$this->data['path'] = $this->request->get['path'];
				$parts = explode('_', (string)$this->request->get['path']);
				$category_id = array_pop($parts);
			}

			$manufacturer_id = false;
			if(isset($this->request->get['manufacturer_id'])) {
				$manufacturer_id = $this->request->get['manufacturer_id'];
				$data = array(
					'filter_manufacturer_id' => $this->request->get['manufacturer_id']
				);
			} else {
				$data = array(
					'filter_category_id' => $category_id,
					'filter_sub_category' => false
				);
			}

			$this->load->model('catalog/product');
			//$product_total = $this->model_catalog_product->getTotalProducts($data);
			//if($product_total < 2) {
			//	return;
			//}
            
			$this->data['category_id'] = $category_id;
			
			$this->data['category_id_delim'] = $category_id;
			
			$this->load->model('module/filterpro');
			
			$this->data['get_parent_sale'] = $this->model_module_filterpro->getCategoriesByParentId(20);
			
			$this->data['get_parent_rent'] = $this->model_module_filterpro->getCategoriesByParentId(94);
			
			$get_parent_sale = $this->model_module_filterpro->getCategoriesByParentId(20);
			
			$get_parent_rent = $this->model_module_filterpro->getCategoriesByParentId(94);
			
			foreach($get_parent_sale as $category_parent_sale){ 
					$this->data['category_normal_sale'][] = $category_parent_sale;
			}
			
			foreach($get_parent_rent as $number_array => $category_parent_rent){ 
					$this->data['category_normal_rent'][] = $category_parent_rent;
			}
			
			$data = array('category_id' => $category_id, 'manufacturer_id' => $manufacturer_id);

			$this->load->model('module/filterpro');

			$this->data['manufacturers'] = false;
			if(isset($this->request->get['manufacturer_id'])) {
				$this->data['manufacturer_id'] = $this->request->get['manufacturer_id'];
			} else {
				if($filterpro_setting['display_manufacturer'] != 'none') {
					$this->data['manufacturers'] = $this->model_module_filterpro->getManufacturers($data);
					$this->data['display_manufacturer'] = $filterpro_setting['display_manufacturer'];
					$this->data['expanded_manufacturer'] = isset($filterpro_setting['expanded_manufacturer']) ? 1 : 0;
				}
			}

			//$this->data['options'] = $this->model_module_filterpro->getOptions($data);
            $this->data['options'] = $this->model_module_filterpro->getAllOptions($data);

			$this->load->model('tool/image');
			foreach($this->data['options'] as $i => $option) {
				if(!isset($filterpro_setting['display_option_' . $option['option_id']])) {
					$filterpro_setting['display_option_' . $option['option_id']] = 'none';
				}
				$display_option = $filterpro_setting['display_option_' . $option['option_id']];
				if($display_option != 'none') {
					$this->data['options'][$i]['display'] = $display_option;
					$this->data['options'][$i]['expanded'] = isset($filterpro_setting['expanded_option_' . $option['option_id']]) ? 1 : 0;
					foreach($this->data['options'][$i]['option_values'] as $j => $option_value) {
						$this->data['options'][$i]['option_values'][$j]['thumb'] = $this->model_tool_image->resize($this->data['options'][$i]['option_values'][$j]['image'], 20, 20);
					}
				} else {
					unset($this->data['options'][$i]);
				}
			}
			$this->data['tags'] = array();
			$version = array_map("intVal", explode(".", VERSION));
			if($version[2] < 4 && $filterpro_setting['display_tags'] != 'none') {
				$this->data['tags'] = $this->model_module_filterpro->getTags($data);
				$this->data['expanded_tags'] = isset($filterpro_setting['expanded_tags']) ? 1 : 0;
			}

			$this->data['categories'] = false;
			if($filterpro_setting['display_categories'] != 'none') {
				$this->data['categories'] = $this->model_module_filterpro->getSubCategories($data);
				$this->data['expanded_categories'] = isset($filterpro_setting['expanded_categories']) ? 1 : 0;
			}

			$this->data['attributes'] = $this->model_module_filterpro->getAttributes($data);


			foreach($this->data['attributes'] as $j => $attribute_group) {
				foreach($attribute_group['attribute_values'] as $attribute_id => $attribute) {
					if(!isset($filterpro_setting['display_attribute_' . $attribute_id])) {
						$filterpro_setting['display_attribute_' . $attribute_id] = 'none';
					}
					$display_attribute = $filterpro_setting['display_attribute_' . $attribute_id];
					if($display_attribute != 'none') {
						if($display_attribute == 'slider') {
							$values = $this->data['attributes'][$j]['attribute_values'][$attribute_id]['values'];
							$first = $values[0];
							$this->data['attributes'][$j]['attribute_values'][$attribute_id]['suffix'] = preg_replace("/^[0-9]*/", '', $first);

							$values = array_map('intVal', $values);
							$values = array_unique($values);
							sort($values);
							$this->data['attributes'][$j]['attribute_values'][$attribute_id]['values'] = $values;
						}
						$this->data['attributes'][$j]['attribute_values'][$attribute_id]['display'] = $display_attribute;
						$this->data['attributes'][$j]['attribute_values'][$attribute_id]['expanded'] = isset($filterpro_setting['expanded_attribute_' . $attribute_id]) ? 1 : 0;
					} else {
						unset($this->data['attributes'][$j]['attribute_values'][$attribute_id]);
						if(!$this->data['attributes'][$j]['attribute_values']) {
							unset($this->data['attributes'][$j]);
						}
					}
				}
			}

			$this->data['price_slider'] = $filterpro_setting['price_slider'];
			$this->data['attr_group'] = $filterpro_setting['attr_group'];

			$this->data['instock_checked'] = isset($filterpro_setting['instock_checked']) ? 1 : 0;
			$this->data['instock_visible'] = isset($filterpro_setting['instock_visible']) ? 1 : 0;

			if(true || $this->data['options'] || $this->data['manufacturers'] || $this->data['attributes'] || $this->data['price_slider']) {

//				if (isset($filterpro_setting['theme_mega'])){
//					$this->document->addStyle('catalog/view/theme/default/stylesheet/filterpro-mega.css');
//				} else{
//					$this->document->addStyle('catalog/view/theme/default/stylesheet/filterpro.css');
//				}
//				$this->document->addStyle('catalog/view/theme/default/stylesheet/jquery.loadmask.css');
				if($this->config->get('config_template') == 'shoppica2') {
					$this->document->addStyle('catalog/view/javascript/jquery/ui/themes/ui-lightness/jquery-ui-1.8.16.custom.css');
				}
			}

			$this->data['filterpro_container'] = $filterpro_setting['filterpro_container'];
			$this->data['filterpro_afterload'] = html_entity_decode($filterpro_setting['filterpro_afterload'], ENT_QUOTES, 'UTF-8');


            $this->data['city_option_values'] = $this->model_module_filterpro->getOptionValues(15);
            $this->data['estate_type_option_values'] = $this->model_module_filterpro->getOptionValues(13);
            $this->data['sale_type_option_values'] = $this->model_module_filterpro->getOptionValues(14);
            $this->data['rooms_option_values'] = $this->model_module_filterpro->getOptionValues(43);

			if(file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/module/filterpro.tpl')) {
				$this->template = $this->config->get('config_template') . '/template/module/filterpro.tpl';
			} else {
				$this->template = 'default/template/module/filterpro.tpl';
			}
		}
		$this->render();
	}

	private function array_clean(array $array) {
		foreach($array as $key => $value) {
			if(is_array($value)) {
				$array[$key] = $this->array_clean($value);
				if(!count($array[$key])) {
					unset($array[$key]);
				}
			} elseif(is_string($value)) {
				$value = trim($value);
				if(!$value) {
					unset($array[$key]);
				}
			}
		}
		return $array;
	}

	public function getProducts() {

		$this->language->load('module/filterpro');

		if(VERSION == '1.5.0') {
			$filterpro_setting = unserialize($this->config->get('filterpro_setting'));
		} else {
			$filterpro_setting = $this->config->get('filterpro_setting');
		}


		if((float)$filterpro_setting['tax'] > 0) {
			$this->k = 1 + (float)$filterpro_setting['tax'] / 100;
		}

		$page = 1;
		if(isset($this->request->post['page'])) {
			$page = (int)$this->request->post['page'];
		}

		if(isset($this->request->post['sort'])) {
			$sort = $this->request->post['sort'];
		} else {
			$sort = 'p.sort_order';
		}

		if(isset($this->request->post['order'])) {
			$order = $this->request->post['order'];
		} else {
			$order = 'ASC';
		}

		if(isset($this->request->post['limit'])) {
			$limit = $this->request->post['limit'];
		} else {
			$limit = $this->config->get('config_catalog_limit');
		}

		$this->load->model('module/filterpro');
		$this->load->model('catalog/product');
		$this->load->model('tool/image');

		$manufacturer = false;
		if(isset($this->request->post['manufacturer'])) {
			$manufacturer = $this->array_clean($this->request->post['manufacturer']);
			if(!count($manufacturer)) {
				$manufacturer = false;
			}
		}
		$manufacturer_id = false;
		if(isset($this->request->post['manufacturer_id'])) {
			$manufacturer_id = $this->request->post['manufacturer_id'];
			$manufacturer = array($manufacturer_id);
		}

		$option_value = false;
		if(isset($this->request->post['option_value'])) {
			$option_value = $this->array_clean($this->request->post['option_value']);
			if(!count($option_value)) {
				$option_value = false;
			}
		}

        $option_value_min_ranges = array();
        $option_value_max_ranges = array();
        $option_value_texts = array();

        if(!empty($this->request->post['city'])) {
            $option_value_texts[15] = $this->request->post['city'];
        }

        if(!empty($this->request->post['estate_type'])) {
            $option_value_texts[13] = $this->request->post['estate_type'];
        }

        if(!empty($this->request->post['sale_type'])) {
            $option_value_texts[14] = $this->request->post['sale_type'];
        }

        if(!isset($this->request->post['floor_chk'])) {
            if(!empty($this->request->post['min_floor'])) {
                $option_value_min_ranges[29] = intval($this->request->post['min_floor']);
            }

            if(!empty($this->request->post['max_floor'])) {
                $option_value_max_ranges[29] = intval($this->request->post['max_floor']);
            }
        } else {

        }

        if(!empty($this->request->post['min_square_total'])) {
            $option_value_min_ranges[19] = intval($this->request->post['min_square_total']);
        }

        if(!empty($this->request->post['max_square_total'])) {
            $option_value_max_ranges[19] = intval($this->request->post['max_square_total']);
        }

        if(!empty($this->request->post['min_square_live'])) {
            $option_value_min_ranges[23] = intval($this->request->post['min_square_live']);
        }

        if(!empty($this->request->post['max_square_live'])) {
            $option_value_max_ranges[23] = intval($this->request->post['max_square_live']);
        }

        if(!empty($this->request->post['rooms'])) {
            if ($this->request->post['rooms']!='more') {
                $option_value_min_ranges[43] = intval($this->request->post['rooms']);
                $option_value_max_ranges[43] = intval($this->request->post['rooms']);
            } else {
                $option_value_min_ranges[43] = 5;
            }
        }

        $with_photo = false;
        if(!empty($this->request->post['with_photo'])) {
            $with_photo = true;
        }

        $with_video = false;
        if(!empty($this->request->post['with_video'])) {
            $with_video = true;
        }

        if(isset($this->request->post['max_square_live'])) {
            $option_value_max_ranges[23] = intval($this->request->post['max_square_live']);
        }

		$attribute_value = array();
		if(isset($this->request->post['attribute_value'])) {
			$attribute_value = $this->array_clean($this->request->post['attribute_value']);
			if(!count($attribute_value)) {
				$attribute_value = array();
			}
		}

		$instock = false;
		if(isset($this->request->post['instock'])) {
			$instock = true;
		}

		$tags = false;
		if(isset($this->request->post['tags'])) {
			$tags = $this->array_clean($this->request->post['tags']);
			if(!count($tags)) {
				$tags = false;
			}
		}

		$categories = false;
		if(isset($this->request->post['categories'])) {
			$categories = $this->array_clean($this->request->post['categories']);
			if(!count($categories)) {
				$categories = false;
			}
		}

		$category_id = 0;
		if(isset($this->request->post['category_id'])) {
			$category_id = $this->request->post['category_id'];
		}
		if(!$categories && $category_id) {
			$categories = array($category_id);
		}

		$attr_slider = isset($this->request->post['attr_slider']) ? $this->request->post['attr_slider'] : false;
		//MKVADRAT
//        if($this->request->post['valute']=='rub'){
//            $min_rub = $this->currency->convert($this->request->post['min_price'], 'RUB','USD');
//            $max_rub = $this->currency->convert($this->request->post['max_price'], 'RUB','USD');
//            $mkvadrat_min_price=$min_rub;
//            $mkvadrat_max_price=$max_rub;
//        }
//        else
//        {
//            $mkvadrat_min_price=$this->request->post['min_price'];
//            $mkvadrat_max_price=$this->request->post['max_price'];
//        }
        $data = array(
			'instock' => $instock,
			'option_value' => $option_value,
            'option_value_min_ranges' => $option_value_min_ranges,
            'option_value_max_ranges' => $option_value_max_ranges,
            'option_value_texts' => $option_value_texts,
            'with_photo' => $with_photo,
            'with_video' => $with_video,
			'manufacturer' => $manufacturer,
			'attribute_value' => $attribute_value,
			'tags' => $tags,
			'categories' => $categories,
			'attr_slider' => $attr_slider,
			'min_price' => $this->request->post['min_price'],
			'max_price' => $this->request->post['max_price'],
            'valute' => $this->request->post['valute'],
			'start' => ($page - 1) * $limit,
			'limit' => $limit,
			'sort' => $sort,
			'order' => $order
		);

		if(isset($this->request->post['manufacturer_id']) || ($filterpro_setting['display_manufacturer'] == 'none')) {
			$totals_manufacturers = false;
		} else {
			$totals_manufacturers = $this->model_module_filterpro->getTotalManufacturers($data);
		}

		$totals_options = $this->model_module_filterpro->getTotalOptions($data);

		$totals_attributes = $this->model_module_filterpro->getTotalAttributes($data);
		foreach($attribute_value as $attribute_id => $values) {
			foreach($totals_attributes as $i => $attribute) {
				if($attribute['id'] == $attribute_id) {
					unset($totals_attributes[$i]);
				}
			}

			$temp_data = $data;
			unset($temp_data['attribute_value'][$attribute_id]);
			foreach($this->model_module_filterpro->getTotalAttributes($temp_data) as $attribute){
				if($attribute['id'] == $attribute_id) {
					$totals_attributes[] = $attribute;
				}
			}
		}

		$version = array_map("intVal", explode(".", VERSION));
		if($version[2] >= 4) {
			$totals_tags = array();
		} else {
			$totals_tags = $this->model_module_filterpro->getTotalTags($data);
		}
		$totals_categories = $this->model_module_filterpro->getTotalCategories($data, $category_id);

        if ($category_id == 105) {
            $data['categories'] = false;
			
			$this->load->model('catalog/product');
			
            $product_total = $this->model_catalog_product->getTotalProductsCompany($data);
				
            $results = $this->model_catalog_product->getProductsCompany($data);
			
        } else if (/*$category_id == 82 ||*/ $category_id == 69 || $category_id == 104) {
           /* if ($category_id == 82) {
                $category_id = 20;
            } else*/ if ($category_id == 69) {
                $category_id = 18;
            } else if ($category_id == 104) {
                $category_id = 94;
            }

            $implode_data = array();

            $implode_data[] = $category_id;

            $this->load->model('catalog/category');

            $categories = $this->model_catalog_category->getCategoriesByParentId($category_id);

            foreach ($categories as $category_id) {
                $implode_data[] = (int)$category_id;
            }

            $data['categories'] = $implode_data;

            $product_total = $this->model_catalog_product->getTotalSpecialProducts($data);

            $results = $this->model_catalog_product->getSpecialProducts($data);
        } else {
            $results = $this->model_module_filterpro->getProducts($data);
            $product_total = $this->model_module_filterpro->getTotalProducts($data);
        }

        if($order = 'ASC'){
            //var_dump($results);
        }else{
            //var_dump($results);
        }

		$min_price = false;
		$max_price = false;

		if(isset($this->request->post['getPriceLimits']) && $this->request->post['getPriceLimits']) {
			$priceLimits = $this->model_module_filterpro->getPriceLimits(array('category_id' => $category_id, 'manufacturer_id' => $manufacturer_id));
			$min_price = $priceLimits['min_price'];
			$max_price = $priceLimits['max_price'];
		}

		$this->request->get['path'] = isset($this->request->post['path']) ? $this->request->post['path'] : '';


		$pagination = new Pagination();
		$pagination->total = $product_total;
		$pagination->page = $page;
		$pagination->limit = $limit;
		$pagination->text = $this->language->get('text_pagination');
		$pagination->url = $this->url->link('product/category', 'path=' . $this->request->get['path'] . '&page={page}');
//MKVADRAT
        $pagination_html = $pagination->render();
//		$min_price = $this->currency->convert($min_price * $this->k, $this->config->get('config_currency'), $this->currency->getCode());
//		$max_price = $this->currency->convert($max_price * $this->k, $this->config->get('config_currency'), $this->currency->getCode());


		$result_html = $this->getHtmlProducts($results, $product_total);

		$json = json_encode(array('result_html' => $result_html, 'min_price' => $min_price, 'max_price' => $max_price, 'pagination' => $pagination_html,
								 'totals_data' => array('manufacturers' => $totals_manufacturers,
														'options' => $totals_options,
														'attributes' => $totals_attributes,
														'categories' => $totals_categories,
														'tags' => $totals_tags)));
		$this->response->setOutput($json);
	}

	private function getHtmlProducts($results, $product_total) {

		$this->language->load('product/category');
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

		$this->data['products'] = array();

        $this->load->model('localisation/currency');

		foreach ($results as $result) {
			if ($result['image']) {
				$image = $this->model_tool_image->resize($result['image'], $this->config->get('config_image_product_width'), $this->config->get('config_image_product_height'));
			} else {
				$image = false;
			}
            if ($result['upc']) {
                $badge = $result['upc'];
            } else {
                $badge = 'not_filled';
            }
//			if (($this->config->get('config_customer_price') && $this->customer->isLogged()) || !$this->config->get('config_customer_price')) {
//
//                $price = $this->currency->format($this->tax->calculate($result['price'], $result['tax_class_id'], $this->config->get('config_tax')));
//			} else {
//				$price = false;
//			}
//            $rub = $this->currency->convert($result['price'], 'USD', 'RUB');
//            $rub = $this->currency->format($this->tax->calculate($rub, $result['tax_class_id'], $this->config->get('config_tax')));



            if (($this->config->get('config_customer_price') && $this->customer->isLogged()) || !$this->config->get('config_customer_price')) {
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
            } else {
                $price = false;
                $rub = '';
            }




			/*if ((float)$result['special']) {
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
			}*/
			
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
			
			$this->load->model('catalog/product');
			
			$this->load->model('module/filterpro');
			
			$this->data['products'][] = array(
				'product_id'  => $result['product_id'],
				'thumb'       => $image,
				'name'        => $result['name'],
                'model'       => $result['model'],
				'description' => utf8_substr(strip_tags(html_entity_decode($result['description'], ENT_QUOTES, 'UTF-8')), 0, 300) . '..',
				'price'       => $price,
                'rub'         => $rub,
                'badge'       => $badge,
				'special'     => $special,
                'special_rub' => $special_rub,
                'currency_id' => $result['currency_id'],
				'tax'         => $tax,
				'view_price_from' => $this->model_catalog_product->getPriceFrom($result['product_id']),
				'rating'      => $result['rating'],
                'video'     => html_entity_decode($result['video'], ENT_QUOTES, "UTF-8"),
				'reviews'     => sprintf($this->language->get('text_reviews'), (int)$result['reviews']),
                'gallery_href'        => $this->url->link('product/product/gallery', 'path=' . $this->request->get['path'] . '&product_id=' . $result['product_id']),
                'video_href'        => $this->url->link('product/product/video', 'path=' . $this->request->get['path'] . '&product_id=' . $result['product_id']),
				'href'        => $this->url->link('product/product', 'path=' . $this->request->get['path'] . '&product_id=' . $result['product_id'])
			);
		}


			$this->template = 'default/template/module/filterpro_products.tpl';

		return $this->render();
	}
}

if(!function_exists('utf8_substr')) {
	function utf8_substr($string, $offset, $length = null) {
		return substr($string, $offset, $length);
	}
}
?>
<?php
class ModelCatalogProduct extends Model {
	public function addProduct($data) {
        if (!isset($data['points'])) $data['points'] = 0;
        if (!isset($data['video'])) $data['video'] = '';

		$this->db->query("INSERT INTO " . DB_PREFIX . "product SET model = '" . $this->db->escape($data['model']) . "', /*Выбор основных опций*/ main_option_value = '".(int)$data['main_option_value']."'  /*Выбор основных опций*/, company_value = '".(int)$data['product_company']."', agent = '" . $this->db->escape($data['agent']) . "', this_lots = '" . $this->db->escape($data['lots_value']) . "', sku = '" . $this->db->escape($data['sku']) . "', upc = '" . $this->db->escape($data['upc']) . "', ean = '" . $this->db->escape($data['ean']) . "', lat_lng = '" . $this->db->escape($data['lat_lng']) . "', price_from = '" . (int)$data['price_from'] . "', tax_class_id = '" . (int)$data['tax_class_id'] . "', quantity = '" . (int)$data['quantity'] . "', subtract = '" . (int)$data['subtract'] . "', date_available = '" . $this->db->escape($data['date_available']) . "', manufacturer_id = '" . (int)$data['manufacturer_id'] . "', price = '" . (float)$data['price'] . "', currency_id = '".(int)$data['currency']."', points = '" . (int)$data['points'] . "', length = '" . (float)$data['length'] . "', length_class_id = '" . (int)$data['length_class_id'] . "', status = '" . (int)$data['status'] . "', sort_order = '" . (int)$data['sort_order'] . "', /*video = '" . $this->db->escape($data['video']) . "',*/ date_added = NOW()");
		
		$product_id = $this->db->getLastId();
		
		if (isset($data['image'])) {
			$this->db->query("UPDATE " . DB_PREFIX . "product SET image = '" . $this->db->escape(html_entity_decode($data['image'], ENT_QUOTES, 'UTF-8')) . "' WHERE product_id = '" . (int)$product_id . "'");
		}
		
		foreach ($data['product_description'] as $language_id => $value) {
			$this->db->query("INSERT INTO " . DB_PREFIX . "product_description SET product_id = '" . (int)$product_id . "', language_id = '" . (int)$language_id . "', name = '" . $this->db->escape($value['name']) . "', meta_keyword = '" . $this->db->escape($value['meta_keyword']) . "', meta_description = '" . $this->db->escape($value['meta_description']) . "', description = '" . $this->db->escape($value['description']) . "', tag = '" . $this->db->escape($value['tag']) . "', seo_title = '" . $this->db->escape($value['seo_title']) . "', seo_h1 = '" . $this->db->escape($value['seo_h1']) . "'");
		}
		
		if (isset($data['product_store'])) {
			foreach ($data['product_store'] as $store_id) {
				$this->db->query("INSERT INTO " . DB_PREFIX . "product_to_store SET product_id = '" . (int)$product_id . "', store_id = '" . (int)$store_id . "'");
			}
		}

		if (isset($data['product_attribute'])) {
			foreach ($data['product_attribute'] as $product_attribute) {
				if ($product_attribute['attribute_id']) {
					$this->db->query("DELETE FROM " . DB_PREFIX . "product_attribute WHERE product_id = '" . (int)$product_id . "' AND attribute_id = '" . (int)$product_attribute['attribute_id'] . "'");
					
					foreach ($product_attribute['product_attribute_description'] as $language_id => $product_attribute_description) {				
						$this->db->query("INSERT INTO " . DB_PREFIX . "product_attribute SET product_id = '" . (int)$product_id . "', attribute_id = '" . (int)$product_attribute['attribute_id'] . "', language_id = '" . (int)$language_id . "', text = '" .  $this->db->escape($product_attribute_description['text']) . "'");
					}
				}
			}
		}
	
		if (isset($data['product_option'])) {
			foreach ($data['product_option'] as $product_option) {
				if ($product_option['type'] == 'select' || $product_option['type'] == 'radio' || $product_option['type'] == 'checkbox' || $product_option['type'] == 'image') {
					$this->db->query("INSERT INTO " . DB_PREFIX . "product_option SET product_id = '" . (int)$product_id . "', option_id = '" . (int)$product_option['option_id'] . "', required = '" . (int)$product_option['required'] . "', product_sort_option_id = '" . (int)$product_option['product_sort_option_id'] . "'");
				
					$product_option_id = $this->db->getLastId();
				
					if (isset($product_option['product_option_value'])) {
						foreach ($product_option['product_option_value'] as $product_option_value) {
							$this->db->query("INSERT INTO " . DB_PREFIX . "product_option_value SET product_option_id = '" . (int)$product_option_id . "', product_id = '" . (int)$product_id . "', option_id = '" . (int)$product_option['option_id'] . "', option_value_id = '" . (int)$product_option_value['option_value_id'] . "', quantity = '" . (int)$product_option_value['quantity'] . "', subtract = '" . (int)$product_option_value['subtract'] . "', price = '" . (float)$product_option_value['price'] . "', price_prefix = '" . $this->db->escape($product_option_value['price_prefix']) . "', weight_prefix = '" . $this->db->escape($product_option_value['weight_prefix']) . "'");
						} 
					}
				} else { 
					$this->db->query("INSERT INTO " . DB_PREFIX . "product_option SET product_id = '" . (int)$product_id . "', option_id = '" . (int)$product_option['option_id'] . "', option_value = '" . $this->db->escape($product_option['option_value']) . "', required = '" . (int)$product_option['required'] . "', product_sort_option_id = '" . (int)$product_option['product_sort_option_id'] . "'");
				}
			}
		}
		
		if (isset($data['product_discount'])) {
			foreach ($data['product_discount'] as $product_discount) {
				$this->db->query("INSERT INTO " . DB_PREFIX . "product_discount SET product_id = '" . (int)$product_id . "', customer_group_id = '" . (int)$product_discount['customer_group_id'] . "', quantity = '" . (int)$product_discount['quantity'] . "', priority = '" . (int)$product_discount['priority'] . "', price = '" . (float)$product_discount['price'] . "', date_start = '" . $this->db->escape($product_discount['date_start']) . "', date_end = '" . $this->db->escape($product_discount['date_end']) . "'");
			}
		}

		if (isset($data['product_special'])) {
			foreach ($data['product_special'] as $product_special) {
				$this->db->query("INSERT INTO " . DB_PREFIX . "product_special SET product_id = '" . (int)$product_id . "', customer_group_id = '" . (int)$product_special['customer_group_id'] . "', priority = '" . (int)$product_special['priority'] . "', price = '" . (float)$product_special['price'] . "', date_start = '" . $this->db->escape($product_special['date_start']) . "', date_end = '" . $this->db->escape($product_special['date_end']) . "'");
			}
		}
		
		if (isset($data['product_image_interior'])) {
			foreach ($data['product_image_interior'] as $product_image_interior) {
				$this->db->query("INSERT INTO " . DB_PREFIX . "product_image SET product_id = '" . (int)$product_id . "', image = '" . $this->db->escape(html_entity_decode($product_image_interior['image'], ENT_QUOTES, 'UTF-8')) . "', sort_order = '" . (int)$product_image_interior['sort_order'] . "'");
			}
		}
		
		if (isset($data['product_image_exterior'])) {
			foreach ($data['product_image_exterior'] as $product_image_exterior) {
				$this->db->query("INSERT INTO " . DB_PREFIX . "product_image_exterior SET product_id = '" . (int)$product_id . "', image = '" . $this->db->escape(html_entity_decode($product_image_exterior['image'], ENT_QUOTES, 'UTF-8')) . "', sort_order = '" . (int)$product_image_exterior['sort_order'] . "'");
			}
		}
		
		if (isset($data['product_image_more'])) {
			foreach ($data['product_image_more'] as $product_image_more) {
				$this->db->query("INSERT INTO " . DB_PREFIX . "product_image_more SET product_id = '" . (int)$product_id . "', image = '" . $this->db->escape(html_entity_decode($product_image_more['image'], ENT_QUOTES, 'UTF-8')) . "', sort_order = '" . (int)$product_image_more['sort_order'] . "'");
			}
		}

        if (isset($data['product_plan'])) {
            foreach ($data['product_plan'] as $product_plan) {
                $this->db->query("INSERT INTO " . DB_PREFIX . "product_plan SET product_id = '" . (int)$product_id . "', image = '" . $this->db->escape(html_entity_decode($product_plan['image'], ENT_QUOTES, 'UTF-8')) . "', sort_order = '" . (int)$product_plan['sort_order'] . "'");
            }
        }
		
		if (isset($data['product_video'])) {
            foreach ($data['product_video'] as $product_video) {
                $this->db->query("INSERT INTO " . DB_PREFIX . "product_video SET product_id = '" . (int)$product_id . "', video = '" . $this->db->escape(html_entity_decode($product_video['video'], ENT_QUOTES, 'UTF-8')) . "', sort_order = '" . (int)$product_video['sort_order'] . "'");
            }
        }
		
		if (isset($data['product_download'])) {
			foreach ($data['product_download'] as $download_id) {
				$this->db->query("INSERT INTO " . DB_PREFIX . "product_to_download SET product_id = '" . (int)$product_id . "', download_id = '" . (int)$download_id . "'");
			}
		}
		
		if (isset($data['product_category'])) {
			foreach ($data['product_category'] as $category_id) {
				$this->db->query("INSERT INTO " . DB_PREFIX . "product_to_category SET product_id = '" . (int)$product_id . "', category_id = '" . (int)$category_id . "'");
			}
		}
		
		if (isset($data['main_category_id']) && $data['main_category_id'] > 0) {
			$this->db->query("DELETE FROM " . DB_PREFIX . "product_to_category WHERE product_id = '" . (int)$product_id . "' AND category_id = '" . (int)$data['main_category_id'] . "'");
			$this->db->query("INSERT INTO " . DB_PREFIX . "product_to_category SET product_id = '" . (int)$product_id . "', category_id = '" . (int)$data['main_category_id'] . "', main_category = 1");
		} elseif (isset($data['product_category'][0])) {
			$this->db->query("UPDATE " . DB_PREFIX . "product_to_category SET main_category = 1 WHERE product_id = '" . (int)$product_id . "' AND category_id = '" . (int)$data['product_category'][0] . "'");
		}

		if (isset($data['product_related'])) {
			foreach ($data['product_related'] as $related_id) {
				$this->db->query("DELETE FROM " . DB_PREFIX . "product_related WHERE product_id = '" . (int)$product_id . "' AND related_id = '" . (int)$related_id . "'");
				$this->db->query("INSERT INTO " . DB_PREFIX . "product_related SET product_id = '" . (int)$product_id . "', related_id = '" . (int)$related_id . "'");
				$this->db->query("DELETE FROM " . DB_PREFIX . "product_related WHERE product_id = '" . (int)$related_id . "' AND related_id = '" . (int)$product_id . "'");
				$this->db->query("INSERT INTO " . DB_PREFIX . "product_related SET product_id = '" . (int)$related_id . "', related_id = '" . (int)$product_id . "'");
			}
		}

		if (isset($data['product_reward'])) {
			foreach ($data['product_reward'] as $customer_group_id => $product_reward) {
				$this->db->query("INSERT INTO " . DB_PREFIX . "product_reward SET product_id = '" . (int)$product_id . "', customer_group_id = '" . (int)$customer_group_id . "'");
			}
		}

		if (isset($data['product_layout'])) {
			foreach ($data['product_layout'] as $store_id => $layout) {
				if ($layout['layout_id']) {
					$this->db->query("INSERT INTO " . DB_PREFIX . "product_to_layout SET product_id = '" . (int)$product_id . "', store_id = '" . (int)$store_id . "', layout_id = '" . (int)$layout['layout_id'] . "'");
				}
			}
		}
							
		if ($data['keyword']) {
			$this->db->query("INSERT INTO " . DB_PREFIX . "url_alias SET query = 'product_id=" . (int)$product_id . "', keyword = '" . $this->db->escape($data['keyword']) . "'");
		}
						
		$this->cache->delete('product');
		
		/*Кнопка применить*/
		return $product_id;
		/*Кнопка применить*/
	}
	
	public function saveQuantity($product_id,$quantity) {
        $this->db->query("UPDATE " . DB_PREFIX . "product SET quantity = '" . (int)$quantity. "', date_modified = NOW() WHERE product_id = '". $product_id . "'");

        $query = $this->db->query("SELECT quantity FROM " . DB_PREFIX . "product WHERE product_id = '". $product_id . "'");
        $row = $query->row;

        return $row['quantity'];
    }
	
	public function editProduct($product_id, $data) {
        if (!isset($data['video'])) $data['video'] = '';

		$this->db->query("UPDATE " . DB_PREFIX . "product SET model = '" . $this->db->escape($data['model']) . "', /*Выбор основных опций*/ main_option_value = '".(int)$data['main_option_value']."'  /*Выбор основных опций*/, company_value = '".(int)$data['product_company']."', agent = '" . $this->db->escape($data['agent']) . "', this_lots = '" . $this->db->escape($data['lots_value']) . "', sku = '" . $this->db->escape($data['sku']) . "', upc = '" . $this->db->escape($data['upc']) . "', ean = '" . $this->db->escape($data['ean']) . "', lat_lng = '" . $this->db->escape($data['lat_lng']) . "', price_from = '" . (int)$data['price_from'] . "', tax_class_id = '" . (int)$data['tax_class_id'] . "', quantity = '" . (int)$data['quantity'] . "', subtract = '" . (int)$data['subtract'] . "', date_available = '" . $this->db->escape($data['date_available']) . "', manufacturer_id = '" . (int)$data['manufacturer_id'] . "', price = '" . (float)$data['price'] . "', currency_id = '".(int)$data['currency']."', length_class_id = '" . (int)$data['length_class_id'] . "', status = '" . (int)$data['status'] . "', sort_order = '" . (int)$data['sort_order'] . "', /*video = '" . $this->db->escape($data['video']) . "',*/ date_modified = NOW() WHERE product_id = '" . (int)$product_id . "'");

		if (isset($data['image'])) {
			$this->db->query("UPDATE " . DB_PREFIX . "product SET image = '" . $this->db->escape(html_entity_decode($data['image'], ENT_QUOTES, 'UTF-8')) . "' WHERE product_id = '" . (int)$product_id . "'");
		}
		
		$this->db->query("DELETE FROM " . DB_PREFIX . "product_description WHERE product_id = '" . (int)$product_id . "'");
		
		foreach ($data['product_description'] as $language_id => $value) {
			$this->db->query("INSERT INTO " . DB_PREFIX . "product_description SET product_id = '" . (int)$product_id . "', language_id = '" . (int)$language_id . "', name = '" . $this->db->escape($value['name']) . "', meta_keyword = '" . $this->db->escape($value['meta_keyword']) . "', meta_description = '" . $this->db->escape($value['meta_description']) . "', description = '" . $this->db->escape($value['description']) . "', tag = '" . $this->db->escape($value['tag']) . "', seo_title = '" . $this->db->escape($value['seo_title']) . "', seo_h1 = '" . $this->db->escape($value['seo_h1']) . "'");
		}

		$this->db->query("DELETE FROM " . DB_PREFIX . "product_to_store WHERE product_id = '" . (int)$product_id . "'");

		if (isset($data['product_store'])) {
			foreach ($data['product_store'] as $store_id) {
				$this->db->query("INSERT INTO " . DB_PREFIX . "product_to_store SET product_id = '" . (int)$product_id . "', store_id = '" . (int)$store_id . "'");
			}
		}
	
		$this->db->query("DELETE FROM " . DB_PREFIX . "product_attribute WHERE product_id = '" . (int)$product_id . "'");

		if (!empty($data['product_attribute'])) {
			foreach ($data['product_attribute'] as $product_attribute) {
				if ($product_attribute['attribute_id']) {
					$this->db->query("DELETE FROM " . DB_PREFIX . "product_attribute WHERE product_id = '" . (int)$product_id . "' AND attribute_id = '" . (int)$product_attribute['attribute_id'] . "'");
					
					foreach ($product_attribute['product_attribute_description'] as $language_id => $product_attribute_description) {				
						$this->db->query("INSERT INTO " . DB_PREFIX . "product_attribute SET product_id = '" . (int)$product_id . "', attribute_id = '" . (int)$product_attribute['attribute_id'] . "', language_id = '" . (int)$language_id . "', text = '" .  $this->db->escape($product_attribute_description['text']) . "'");
					}
				}
			}
		}

		$this->db->query("DELETE FROM " . DB_PREFIX . "product_option WHERE product_id = '" . (int)$product_id . "'");
		$this->db->query("DELETE FROM " . DB_PREFIX . "product_option_value WHERE product_id = '" . (int)$product_id . "'");
		
		if (isset($data['product_option'])) {
			foreach ($data['product_option'] as $product_option) {
				if ($product_option['type'] == 'select' || $product_option['type'] == 'radio' || $product_option['type'] == 'checkbox' || $product_option['type'] == 'image') {
					$this->db->query("INSERT INTO " . DB_PREFIX . "product_option SET product_option_id = '" . (int)$product_option['product_option_id'] . "', product_id = '" . (int)$product_id . "', option_id = '" . (int)$product_option['option_id'] . "', required = '" . (int)$product_option['required'] . "', product_sort_option_id = '" . (int)$product_option['product_sort_option_id'] . "'");
				
					$product_option_id = $this->db->getLastId();
				
					if (isset($product_option['product_option_value'])) {
						foreach ($product_option['product_option_value'] as $product_option_value) {
							$this->db->query("INSERT INTO " . DB_PREFIX . "product_option_value SET product_option_value_id = '" . (int)$product_option_value['product_option_value_id'] . "', product_option_id = '" . (int)$product_option_id . "', product_id = '" . (int)$product_id . "', option_id = '" . (int)$product_option['option_id'] . "', option_value_id = '" . (int)$product_option_value['option_value_id'] . "', quantity = '" . (int)$product_option_value['quantity'] . "', subtract = '" . (int)$product_option_value['subtract'] . "', price = '" . (float)$product_option_value['price'] . "', price_prefix = '" . $this->db->escape($product_option_value['price_prefix']) . "', weight_prefix = '" . $this->db->escape($product_option_value['weight_prefix']) . "'");
						}
					}
				} else { 
					$this->db->query("INSERT INTO " . DB_PREFIX . "product_option SET product_option_id = '" . (int)$product_option['product_option_id'] . "', product_id = '" . (int)$product_id . "', option_id = '" . (int)$product_option['option_id'] . "', option_value = '" . $this->db->escape($product_option['option_value']) . "', required = '" . (int)$product_option['required'] . "', product_sort_option_id = '" . (int)$product_option['product_sort_option_id'] . "'");
				}					
			}
		}
		
		$this->db->query("DELETE FROM " . DB_PREFIX . "product_discount WHERE product_id = '" . (int)$product_id . "'");
 
		if (isset($data['product_discount'])) {
			foreach ($data['product_discount'] as $product_discount) {
				$this->db->query("INSERT INTO " . DB_PREFIX . "product_discount SET product_id = '" . (int)$product_id . "', customer_group_id = '" . (int)$product_discount['customer_group_id'] . "', quantity = '" . (int)$product_discount['quantity'] . "', priority = '" . (int)$product_discount['priority'] . "', price = '" . (float)$product_discount['price'] . "', date_start = '" . $this->db->escape($product_discount['date_start']) . "', date_end = '" . $this->db->escape($product_discount['date_end']) . "'");
			}
		}
		
		$this->db->query("DELETE FROM " . DB_PREFIX . "product_special WHERE product_id = '" . (int)$product_id . "'");
		
		if (isset($data['product_special'])) {
			foreach ($data['product_special'] as $product_special) {
				$this->db->query("INSERT INTO " . DB_PREFIX . "product_special SET product_id = '" . (int)$product_id . "', customer_group_id = '" . (int)$product_special['customer_group_id'] . "', priority = '" . (int)$product_special['priority'] . "', price = '" . (float)$product_special['price'] . "', date_start = '" . $this->db->escape($product_special['date_start']) . "', date_end = '" . $this->db->escape($product_special['date_end']) . "'");
			}
		}
		
		$this->db->query("DELETE FROM " . DB_PREFIX . "product_image WHERE product_id = '" . (int)$product_id . "'");
		
		if (isset($data['product_image_interior'])) {
			foreach ($data['product_image_interior'] as $product_image_interior) {
				$this->db->query("INSERT INTO " . DB_PREFIX . "product_image SET product_id = '" . (int)$product_id . "', image = '" . $this->db->escape(html_entity_decode($product_image_interior['image'], ENT_QUOTES, 'UTF-8')) . "', sort_order = '" . (int)$product_image_interior['sort_order'] . "'");
			}
		}
		
		$this->db->query("DELETE FROM " . DB_PREFIX . "product_image_exterior WHERE product_id = '" . (int)$product_id . "'");
		
		if (isset($data['product_image_exterior'])) {
			foreach ($data['product_image_exterior'] as $product_image_exterior) {
				$this->db->query("INSERT INTO " . DB_PREFIX . "product_image_exterior SET product_id = '" . (int)$product_id . "', image = '" . $this->db->escape(html_entity_decode($product_image_exterior['image'], ENT_QUOTES, 'UTF-8')) . "', sort_order = '" . (int)$product_image_exterior['sort_order'] . "'");
			}
		}
		
		$this->db->query("DELETE FROM " . DB_PREFIX . "product_image_more WHERE product_id = '" . (int)$product_id . "'");
		
		if (isset($data['product_image_more'])) {
			foreach ($data['product_image_more'] as $product_image_more) {
				$this->db->query("INSERT INTO " . DB_PREFIX . "product_image_more SET product_id = '" . (int)$product_id . "', image = '" . $this->db->escape(html_entity_decode($product_image_more['image'], ENT_QUOTES, 'UTF-8')) . "', sort_order = '" . (int)$product_image_more['sort_order'] . "'");
			}
		}
		
        $this->db->query("DELETE FROM " . DB_PREFIX . "product_plan WHERE product_id = '" . (int)$product_id . "'");

        if (isset($data['product_plan'])) {
            foreach ($data['product_plan'] as $product_plan) {
                $this->db->query("INSERT INTO " . DB_PREFIX . "product_plan SET product_id = '" . (int)$product_id . "', image = '" . $this->db->escape(html_entity_decode($product_plan['image'], ENT_QUOTES, 'UTF-8')) . "', sort_order = '" . (int)$product_plan['sort_order'] . "'");
            }
        }
		
		$this->db->query("DELETE FROM " . DB_PREFIX . "product_video WHERE product_id = '" . (int)$product_id . "'");

        if (isset($data['product_video'])) {
            foreach ($data['product_video'] as $product_video) {
                $this->db->query("INSERT INTO " . DB_PREFIX . "product_video SET product_id = '" . (int)$product_id . "', video = '" . $this->db->escape(html_entity_decode($product_video['video'], ENT_QUOTES, 'UTF-8')) . "', sort_order = '" . (int)$product_video['sort_order'] . "'");
            }
        }
		
		$this->db->query("DELETE FROM " . DB_PREFIX . "product_to_download WHERE product_id = '" . (int)$product_id . "'");
		
		if (isset($data['product_download'])) {
			foreach ($data['product_download'] as $download_id) {
				$this->db->query("INSERT INTO " . DB_PREFIX . "product_to_download SET product_id = '" . (int)$product_id . "', download_id = '" . (int)$download_id . "'");
			}
		}
		
		$this->db->query("DELETE FROM " . DB_PREFIX . "product_to_category WHERE product_id = '" . (int)$product_id . "'");
		
		if (isset($data['product_category'])) {
			foreach ($data['product_category'] as $category_id) {
				$this->db->query("INSERT INTO " . DB_PREFIX . "product_to_category SET product_id = '" . (int)$product_id . "', category_id = '" . (int)$category_id . "'");
			}		
		}

		if (isset($data['main_category_id']) && $data['main_category_id'] > 0) {
			$this->db->query("DELETE FROM " . DB_PREFIX . "product_to_category WHERE product_id = '" . (int)$product_id . "' AND category_id = '" . (int)$data['main_category_id'] . "'");
			$this->db->query("INSERT INTO " . DB_PREFIX . "product_to_category SET product_id = '" . (int)$product_id . "', category_id = '" . (int)$data['main_category_id'] . "', main_category = 1");
		} elseif (isset($data['product_category'])) {
			$this->db->query("UPDATE " . DB_PREFIX . "product_to_category SET main_category = 1 WHERE product_id = '" . (int)$product_id . "' AND category_id = '" . (int)$data['product_category'][0] . "'");
		}

		$this->db->query("DELETE FROM " . DB_PREFIX . "product_related WHERE product_id = '" . (int)$product_id . "'");
		$this->db->query("DELETE FROM " . DB_PREFIX . "product_related WHERE related_id = '" . (int)$product_id . "'");

		if (isset($data['product_related'])) {
			foreach ($data['product_related'] as $related_id) {
				$this->db->query("DELETE FROM " . DB_PREFIX . "product_related WHERE product_id = '" . (int)$product_id . "' AND related_id = '" . (int)$related_id . "'");
				$this->db->query("INSERT INTO " . DB_PREFIX . "product_related SET product_id = '" . (int)$product_id . "', related_id = '" . (int)$related_id . "'");
				$this->db->query("DELETE FROM " . DB_PREFIX . "product_related WHERE product_id = '" . (int)$related_id . "' AND related_id = '" . (int)$product_id . "'");
				$this->db->query("INSERT INTO " . DB_PREFIX . "product_related SET product_id = '" . (int)$related_id . "', related_id = '" . (int)$product_id . "'");
			}
		}
		
		$this->db->query("DELETE FROM " . DB_PREFIX . "product_reward WHERE product_id = '" . (int)$product_id . "'");

		if (isset($data['product_reward'])) {
			foreach ($data['product_reward'] as $customer_group_id => $value) {
				$this->db->query("INSERT INTO " . DB_PREFIX . "product_reward SET product_id = '" . (int)$product_id . "', customer_group_id = '" . (int)$customer_group_id . "', points = '" . (int)$value['points'] . "'");
			}
		}

		$this->db->query("DELETE FROM " . DB_PREFIX . "product_to_layout WHERE product_id = '" . (int)$product_id . "'");

		if (isset($data['product_layout'])) {
			foreach ($data['product_layout'] as $store_id => $layout) {
				if ($layout['layout_id']) {
					$this->db->query("INSERT INTO " . DB_PREFIX . "product_to_layout SET product_id = '" . (int)$product_id . "', store_id = '" . (int)$store_id . "', layout_id = '" . (int)$layout['layout_id'] . "'");
				}
			}
		}
					
		$this->db->query("DELETE FROM " . DB_PREFIX . "url_alias WHERE query = 'product_id=" . (int)$product_id. "'");
		
		if ($data['keyword']) {
			$this->db->query("INSERT INTO " . DB_PREFIX . "url_alias SET query = 'product_id=" . (int)$product_id . "', keyword = '" . $this->db->escape($data['keyword']) . "'");
		}
						
		$this->cache->delete('product');
		
		/*Кнопка применить*/
		return $product_id;
		/*Кнопка применить*/
	}
	
	public function copyProduct($product_id) {
		$query = $this->db->query("SELECT DISTINCT * FROM " . DB_PREFIX . "product p LEFT JOIN " . DB_PREFIX . "product_description pd ON (p.product_id = pd.product_id) WHERE p.product_id = '" . (int)$product_id . "' AND pd.language_id = '" . (int)$this->config->get('config_language_id') . "'");
		
		if ($query->num_rows) {
			$data = array();
			
			$data = $query->row;
			
			$data['sku'] = '';
			$data['upc'] = '';
			$data['viewed'] = '0';
			$data['keyword'] = '';
			$data['status'] = '0';
						
			$data = array_merge($data, array('product_attribute' => $this->getProductAttributes($product_id)));
			$data = array_merge($data, array('product_description' => $this->getProductDescriptions($product_id)));			
			$data = array_merge($data, array('product_discount' => $this->getProductDiscounts($product_id)));
			$data = array_merge($data, array('product_image_interior' => $this->getProductImagesInterior($product_id)));
            $data = array_merge($data, array('product_image_exterior' => $this->getProductImagesExterior($product_id)));
            $data = array_merge($data, array('product_image_more' => $this->getProductImagesMore($product_id)));			
			$data = array_merge($data, array('product_option' => $this->getProductOptions($product_id)));
			$data = array_merge($data, array('product_related' => $this->getProductRelated($product_id)));
			$data = array_merge($data, array('product_reward' => $this->getProductRewards($product_id)));
			$data = array_merge($data, array('product_special' => $this->getProductSpecials($product_id)));
			$data = array_merge($data, array('product_category' => $this->getProductCategories($product_id)));
			$data = array_merge($data, array('product_download' => $this->getProductDownloads($product_id)));
			$data = array_merge($data, array('product_layout' => $this->getProductLayouts($product_id)));
			$data = array_merge($data, array('product_store' => $this->getProductStores($product_id)));
			
			$this->addProduct($data);
		}
	}
	
	public function deleteProduct($product_id) {
		$this->db->query("DELETE FROM " . DB_PREFIX . "product WHERE product_id = '" . (int)$product_id . "'");
		$this->db->query("DELETE FROM " . DB_PREFIX . "product_attribute WHERE product_id = '" . (int)$product_id . "'");
		$this->db->query("DELETE FROM " . DB_PREFIX . "product_description WHERE product_id = '" . (int)$product_id . "'");
		$this->db->query("DELETE FROM " . DB_PREFIX . "product_discount WHERE product_id = '" . (int)$product_id . "'");
		$this->db->query("DELETE FROM " . DB_PREFIX . "product_image WHERE product_id = '" . (int)$product_id . "'");
		$this->db->query("DELETE FROM " . DB_PREFIX . "product_image_exterior WHERE product_id = '" . (int)$product_id . "'");
		$this->db->query("DELETE FROM " . DB_PREFIX . "product_image_more WHERE product_id = '" . (int)$product_id . "'");
		$this->db->query("DELETE FROM " . DB_PREFIX . "product_option WHERE product_id = '" . (int)$product_id . "'");
		$this->db->query("DELETE FROM " . DB_PREFIX . "product_option_value WHERE product_id = '" . (int)$product_id . "'");
		$this->db->query("DELETE FROM " . DB_PREFIX . "product_related WHERE product_id = '" . (int)$product_id . "'");
		$this->db->query("DELETE FROM " . DB_PREFIX . "product_related WHERE related_id = '" . (int)$product_id . "'");
		$this->db->query("DELETE FROM " . DB_PREFIX . "product_reward WHERE product_id = '" . (int)$product_id . "'");
		$this->db->query("DELETE FROM " . DB_PREFIX . "product_special WHERE product_id = '" . (int)$product_id . "'");
		$this->db->query("DELETE FROM " . DB_PREFIX . "product_to_category WHERE product_id = '" . (int)$product_id . "'");
		$this->db->query("DELETE FROM " . DB_PREFIX . "product_to_download WHERE product_id = '" . (int)$product_id . "'");
		$this->db->query("DELETE FROM " . DB_PREFIX . "product_to_layout WHERE product_id = '" . (int)$product_id . "'");
		$this->db->query("DELETE FROM " . DB_PREFIX . "product_to_store WHERE product_id = '" . (int)$product_id . "'");
		$this->db->query("DELETE FROM " . DB_PREFIX . "review WHERE product_id = '" . (int)$product_id . "'");
		
		$this->db->query("DELETE FROM " . DB_PREFIX . "url_alias WHERE query = 'product_id=" . (int)$product_id. "'");
		
		$this->cache->delete('product');
	}
	
	public function setAttributeen($product_id, $column_name, $value){
		$this->db->query("UPDATE " . DB_PREFIX . "product SET " . $column_name . " = '" . (int)$value . "' WHERE product_id = '" . (int)$product_id . "'");
	}
	
	public function getProduct($product_id) {
		$query = $this->db->query("SELECT DISTINCT *, (SELECT keyword FROM " . DB_PREFIX . "url_alias WHERE query = 'product_id=" . (int)$product_id . "') AS keyword FROM " . DB_PREFIX . "product p LEFT JOIN " . DB_PREFIX . "product_description pd ON (p.product_id = pd.product_id) WHERE p.product_id = '" . (int)$product_id . "' AND pd.language_id = '" . (int)$this->config->get('config_language_id') . "'");

		return $query->row;
	}
	
	public function getProducts($data = array()) {
		if ($data) {
			$sql = "SELECT * FROM " . DB_PREFIX . "product p LEFT JOIN " . DB_PREFIX . "product_description pd ON (p.product_id = pd.product_id)";
			
			if (!empty($data['filter_category_id'])) {
				$sql .= " LEFT JOIN " . DB_PREFIX . "product_to_category p2c ON (p.product_id = p2c.product_id)";			
			}
            $data['agent'] = $_SESSION['user_id'];
			if($data['agent']==1){
                $sql .= " WHERE pd.language_id = '" . (int)$this->config->get('config_language_id') . "'";
            }else{
                $sql .= " WHERE pd.language_id = '" . (int)$this->config->get('config_language_id') . "' AND p.agent=".$data['agent'];
            }
			
			if (!empty($data['filter_name'])) {
				$sql .= " AND LCASE(pd.name) LIKE '" . $this->db->escape(utf8_strtolower($data['filter_name'])) . "%'";
			}

			if (!empty($data['filter_model'])) {
				$sql .= " AND LCASE(p.model) LIKE '" . $this->db->escape(utf8_strtolower($data['filter_model'])) . "%'";
			}
			
			if (!empty($data['filter_price'])) {
				$sql .= " AND p.price LIKE '" . $this->db->escape($data['filter_price']) . "%'";
			}
			
			if (isset($data['filter_quantity']) && !is_null($data['filter_quantity'])) {
				$sql .= " AND p.quantity = '" . $this->db->escape($data['filter_quantity']) . "'";
			}
			
			if (isset($data['filter_status']) && !is_null($data['filter_status'])) {
				$sql .= " AND p.status = '" . (int)$data['filter_status'] . "'";
			}
					
			if (!empty($data['filter_category_id'])) {
				if (!empty($data['filter_sub_category'])) {
					$implode_data = array();
					
					$implode_data[] = "category_id = '" . (int)$data['filter_category_id'] . "'";
					
					$this->load->model('catalog/category');
					
					$categories = $this->model_catalog_category->getCategories($data['filter_category_id']);
					
					foreach ($categories as $category) {
						$implode_data[] = "p2c.category_id = '" . (int)$category['category_id'] . "'";
					}
					
					$sql .= " AND (" . implode(' OR ', $implode_data) . ")";			
				} else {
					$sql .= " AND p2c.category_id = '" . (int)$data['filter_category_id'] . "'";
				}
			}
			
			$sql .= " GROUP BY p.product_id";
						
			$sort_data = array(
				'pd.name',
				'p.model',
				'p.price',
				'p.quantity',
				'p.status',
				'p.sort_order'
			);	
			
			if (isset($data['sort']) && in_array($data['sort'], $sort_data)) {
				$sql .= " ORDER BY " . $data['sort'];	
			} else {
				$sql .= " ORDER BY pd.name";	
			}
			
			if (isset($data['order']) && ($data['order'] == 'DESC')) {
				$sql .= " DESC";
			} else {
				$sql .= " ASC";
			}
		
			if (isset($data['start']) || isset($data['limit'])) {
				if ($data['start'] < 0) {
					$data['start'] = 0;
				}				

				if ($data['limit'] < 1) {
					$data['limit'] = 20;
				}	
			
				$sql .= " LIMIT " . (int)$data['start'] . "," . (int)$data['limit'];
			}	

			$query = $this->db->query($sql);
		
			return $query->rows;
		} else {
			$product_data = $this->cache->get('product.' . (int)$this->config->get('config_language_id') . '.' . (int)$this->config->get('config_store_id'));
		
			if (!$product_data) {
				$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "product p LEFT JOIN " . DB_PREFIX . "product_description pd ON (p.product_id = pd.product_id) WHERE pd.language_id = '" . (int)$this->config->get('config_language_id') . "' ORDER BY pd.name ASC");
	
				$product_data = $query->rows;
			
				$this->cache->set('product.' . (int)$this->config->get('config_language_id') . '.' . (int)$this->config->get('config_store_id'), $product_data);
			}	
	
			return $product_data;
		}
	}
	
	public function getProductsByCategoryId($category_id) {
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "product p LEFT JOIN " . DB_PREFIX . "product_description pd ON (p.product_id = pd.product_id) LEFT JOIN " . DB_PREFIX . "product_to_category p2c ON (p.product_id = p2c.product_id) WHERE pd.language_id = '" . (int)$this->config->get('config_language_id') . "' AND p2c.category_id = '" . (int)$category_id . "' ORDER BY pd.name ASC");
								  
		return $query->rows;
	} 
	
	public function getProductDescriptions($product_id) {
		$product_description_data = array();
		
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "product_description WHERE product_id = '" . (int)$product_id . "'");
		
		foreach ($query->rows as $result) {
			$product_description_data[$result['language_id']] = array(
				'seo_title'        => $result['seo_title'],
				'seo_h1'           => $result['seo_h1'],
				'name'             => $result['name'],
				'description'      => $result['description'],
				'meta_keyword'     => $result['meta_keyword'],
				'meta_description' => $result['meta_description'],
				'tag'              => $result['tag']
			);
		}
		
		return $product_description_data;
	}

	public function getProductAttributes($product_id) {
		$product_attribute_data = array();
		
		$product_attribute_query = $this->db->query("SELECT pa.attribute_id, ad.name FROM " . DB_PREFIX . "product_attribute pa LEFT JOIN " . DB_PREFIX . "attribute a ON (pa.attribute_id = a.attribute_id) LEFT JOIN " . DB_PREFIX . "attribute_description ad ON (a.attribute_id = ad.attribute_id) WHERE pa.product_id = '" . (int)$product_id . "' AND ad.language_id = '" . (int)$this->config->get('config_language_id') . "' GROUP BY pa.attribute_id");
		
		foreach ($product_attribute_query->rows as $product_attribute) {
			$product_attribute_description_data = array();
			
			$product_attribute_description_query = $this->db->query("SELECT * FROM " . DB_PREFIX . "product_attribute WHERE product_id = '" . (int)$product_id . "' AND attribute_id = '" . (int)$product_attribute['attribute_id'] . "'");
			
			foreach ($product_attribute_description_query->rows as $product_attribute_description) {
				$product_attribute_description_data[$product_attribute_description['language_id']] = array('text' => $product_attribute_description['text']);
			}
			
			$product_attribute_data[] = array(
				'attribute_id'                  => $product_attribute['attribute_id'],
				'name'                          => $product_attribute['name'],
				'product_attribute_description' => $product_attribute_description_data
			);
		}
		
		return $product_attribute_data;
	}
	
	public function getProductOptions($product_id) {
		$product_option_data = array();
		
		/*Сортировка стандартная из ocStore, удалить комментарии при удалении блока кода ниже*/
		//$product_option_query = $this->db->query("SELECT * FROM " . DB_PREFIX . "product_option po LEFT JOIN `" . DB_PREFIX . "option` o ON (po.option_id = o.option_id) LEFT JOIN " . DB_PREFIX . "option_description od ON (o.option_id = od.option_id) WHERE po.product_id = '" . (int)$product_id . "' AND od.language_id = '" . (int)$this->config->get('config_language_id') . "' ORDER BY o.sort_order");
		/*Сортировка стандартная из ocStore, удалить комментарии при удалении блока кода ниже*/
		/*Изменения, сортировка по возрастанию*/
		$product_option_query = $this->db->query("SELECT * FROM " . DB_PREFIX . "product_option po LEFT JOIN `" . DB_PREFIX . "option` o ON (po.option_id = o.option_id) LEFT JOIN " . DB_PREFIX . "option_description od ON (o.option_id = od.option_id) WHERE po.product_id = '" . (int)$product_id . "' AND od.language_id = '" . (int)$this->config->get('config_language_id') . "' ORDER BY po.product_sort_option_id");
		/*Изменения, сортировка по возрастанию*/
		
		foreach ($product_option_query->rows as $product_option) {
			if ($product_option['type'] == 'select' || $product_option['type'] == 'radio' || $product_option['type'] == 'checkbox' || $product_option['type'] == 'image') {
				$product_option_value_data = array();	
				
				$product_option_value_query = $this->db->query("SELECT * FROM " . DB_PREFIX . "product_option_value pov LEFT JOIN " . DB_PREFIX . "option_value ov ON (pov.option_value_id = ov.option_value_id) LEFT JOIN " . DB_PREFIX . "option_value_description ovd ON (ov.option_value_id = ovd.option_value_id) WHERE pov.product_option_id = '" . (int)$product_option['product_option_id'] . "' AND ovd.language_id = '" . (int)$this->config->get('config_language_id') . "' ORDER BY ov.sort_order");
				
				foreach ($product_option_value_query->rows as $product_option_value) {
					$product_option_value_data[] = array(
						'product_option_value_id' => $product_option_value['product_option_value_id'],
						'option_value_id'         => $product_option_value['option_value_id'],
						'name'                    => $product_option_value['name'],
						'image'                   => $product_option_value['image'],
						'quantity'                => $product_option_value['quantity'],
						'subtract'                => $product_option_value['subtract'],
						'price'                   => $product_option_value['price'],
						'price_prefix'            => $product_option_value['price_prefix'],
						'points'                  => $product_option_value['points'],
						'points_prefix'           => $product_option_value['points_prefix'],						
						'weight'                  => $product_option_value['weight'],
						'weight_prefix'           => $product_option_value['weight_prefix']					
					);
				}
				
				$product_option_data[] = array(
					'product_option_id'    => $product_option['product_option_id'],
					'option_id'            => $product_option['option_id'],
					'name'                 => $product_option['name'],
					'type'                 => $product_option['type'],
					'product_option_value' => $product_option_value_data,
					'required'             => $product_option['required'],
					'product_sort_option_id'  => $product_option['product_sort_option_id']
				);				
			} else {
				$product_option_data[] = array(
					'product_option_id' => $product_option['product_option_id'],
					'option_id'         => $product_option['option_id'],
					'name'              => $product_option['name'],
					'type'              => $product_option['type'],
					'option_value'      => $product_option['option_value'],
					'required'          => $product_option['required'],
					'product_sort_option_id'  => $product_option['product_sort_option_id']
				);				
			}
		}	
		
		return $product_option_data;
	}
	
	public function getProductImagesInterior($product_id) {
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "product_image WHERE product_id = '" . (int)$product_id . "' ORDER BY sort_order ASC");
		
		return $query->rows;
	}
	
	public function getProductImagesExterior($product_id) {
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "product_image_exterior WHERE product_id = '" . (int)$product_id . "' ORDER BY sort_order ASC");
		
		return $query->rows;
	}
	
	public function getProductImagesMore($product_id) {
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "product_image_more WHERE product_id = '" . (int)$product_id . "' ORDER BY sort_order ASC");
		
		return $query->rows;
	}

    public function getProductPlans($product_id) {
        $query = $this->db->query("SELECT * FROM " . DB_PREFIX . "product_plan WHERE product_id = '" . (int)$product_id . "'");

        return $query->rows;
    }
	
	public function getProductVideo($product_id) {
        $query = $this->db->query("SELECT * FROM " . DB_PREFIX . "product_video WHERE product_id = '" . (int)$product_id . "'");

        return $query->rows;
    }
	
	public function getProductDiscounts($product_id) {
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "product_discount WHERE product_id = '" . (int)$product_id . "' ORDER BY quantity, priority, price");
		
		return $query->rows;
	}
	
	public function getProductSpecials($product_id) {
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "product_special WHERE product_id = '" . (int)$product_id . "' ORDER BY priority, price");
		
		return $query->rows;
	}
	
	public function getProductRewards($product_id) {
		$product_reward_data = array();
		
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "product_reward WHERE product_id = '" . (int)$product_id . "'");
		
		foreach ($query->rows as $result) {
			$product_reward_data[$result['customer_group_id']] = array('points' => $result['points']);
		}
		
		return $product_reward_data;
	}
		
	public function getProductDownloads($product_id) {
		$product_download_data = array();
		
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "product_to_download WHERE product_id = '" . (int)$product_id . "'");
		
		foreach ($query->rows as $result) {
			$product_download_data[] = $result['download_id'];
		}
		
		return $product_download_data;
	}

	public function getProductStores($product_id) {
		$product_store_data = array();
		
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "product_to_store WHERE product_id = '" . (int)$product_id . "'");

		foreach ($query->rows as $result) {
			$product_store_data[] = $result['store_id'];
		}
		
		return $product_store_data;
	}

	public function getProductLayouts($product_id) {
		$product_layout_data = array();
		
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "product_to_layout WHERE product_id = '" . (int)$product_id . "'");
		
		foreach ($query->rows as $result) {
			$product_layout_data[$result['store_id']] = $result['layout_id'];
		}
		
		return $product_layout_data;
	}
		
	public function getProductCategories($product_id) {
		$product_category_data = array();
		
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "product_to_category WHERE product_id = '" . (int)$product_id . "'");
		
		foreach ($query->rows as $result) {
			$product_category_data[] = $result['category_id'];
		}

		return $product_category_data;
	}

	public function getProductMainCategoryId($product_id) {
		$query = $this->db->query("SELECT category_id FROM " . DB_PREFIX . "product_to_category WHERE product_id = '" . (int)$product_id . "' AND main_category = '1' LIMIT 1");

		return ($query->num_rows ? (int)$query->row['category_id'] : 0);
	}
	
	public function getProductRelated($product_id) {
		$product_related_data = array();
		
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "product_related WHERE product_id = '" . (int)$product_id . "'");
		
		foreach ($query->rows as $result) {
			$product_related_data[] = $result['related_id'];
		}
		
		return $product_related_data;
	}
	
	public function getProductTags($product_id) {
		$product_tag_data = array();
		
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "product_tag WHERE product_id = '" . (int)$product_id . "'");
		
		$tag_data = array();
		
		foreach ($query->rows as $result) {
			$tag_data[$result['language_id']][] = $result['tag'];
		}
		
		foreach ($tag_data as $language => $tags) {
			$product_tag_data[$language] = implode(',', $tags);
		}
		
		return $product_tag_data;
	}
	
	public function getTotalProducts($data = array()) {
		$sql = "SELECT COUNT(DISTINCT p.product_id) AS total FROM " . DB_PREFIX . "product p LEFT JOIN " . DB_PREFIX . "product_description pd ON (p.product_id = pd.product_id)";

		if (!empty($data['filter_category_id'])) {
			$sql .= " LEFT JOIN " . DB_PREFIX . "product_to_category p2c ON (p.product_id = p2c.product_id)";			
		}
        $data['agent'] = $_SESSION['user_id'];
		if($data['agent']==1){
            $sql .= " WHERE pd.language_id = '" . (int)$this->config->get('config_language_id') . "'";

        } else{
            $sql .= " WHERE pd.language_id = '" . (int)$this->config->get('config_language_id') . "' AND p.agent=".$data['agent'];
        }

		 			
		if (!empty($data['filter_name'])) {
			$sql .= " AND LCASE(pd.name) LIKE '" . $this->db->escape(utf8_strtolower($data['filter_name'])) . "%'";
		}

		if (!empty($data['filter_model'])) {
			$sql .= " AND LCASE(p.model) LIKE '" . $this->db->escape(utf8_strtolower($data['filter_model'])) . "%'";
		}
		
		if (!empty($data['filter_price'])) {
			$sql .= " AND p.price LIKE '" . $this->db->escape($data['filter_price']) . "%'";
		}
		
		if (isset($data['filter_quantity']) && !is_null($data['filter_quantity'])) {
			$sql .= " AND p.quantity = '" . $this->db->escape($data['filter_quantity']) . "'";
		}
		
		if (isset($data['filter_status']) && !is_null($data['filter_status'])) {
			$sql .= " AND p.status = '" . (int)$data['filter_status'] . "'";
		}

		if (!empty($data['filter_category_id'])) {
			if (!empty($data['filter_sub_category'])) {
				$implode_data = array();
				
				$implode_data[] = "p2c.category_id = '" . (int)$data['filter_category_id'] . "'";
				
				$this->load->model('catalog/category');
				
				$categories = $this->model_catalog_category->getCategories($data['filter_category_id']);
				
				foreach ($categories as $category) {
					$implode_data[] = "p2c.category_id = '" . (int)$category['category_id'] . "'";
				}
				
				$sql .= " AND (" . implode(' OR ', $implode_data) . ")";			
			} else {
				$sql .= " AND p2c.category_id = '" . (int)$data['filter_category_id'] . "'";
			}
		}
		
		$query = $this->db->query($sql);
		
		return $query->row['total'];
	}	
	
	public function getTotalProductsByTaxClassId($tax_class_id) {
		$query = $this->db->query("SELECT COUNT(*) AS total FROM " . DB_PREFIX . "product WHERE tax_class_id = '" . (int)$tax_class_id . "'");

		return $query->row['total'];
	}
		
	public function getTotalProductsByStockStatusId($stock_status_id) {
		$query = $this->db->query("SELECT COUNT(*) AS total FROM " . DB_PREFIX . "product WHERE stock_status_id = '" . (int)$stock_status_id . "'");

		return $query->row['total'];
	}
	
	public function getTotalProductsByWeightClassId($weight_class_id) {
		$query = $this->db->query("SELECT COUNT(*) AS total FROM " . DB_PREFIX . "product WHERE weight_class_id = '" . (int)$weight_class_id . "'");

		return $query->row['total'];
	}
	
	public function getTotalProductsByLengthClassId($length_class_id) {
		$query = $this->db->query("SELECT COUNT(*) AS total FROM " . DB_PREFIX . "product WHERE length_class_id = '" . (int)$length_class_id . "'");

		return $query->row['total'];
	}

	public function getTotalProductsByDownloadId($download_id) {
		$query = $this->db->query("SELECT COUNT(*) AS total FROM " . DB_PREFIX . "product_to_download WHERE download_id = '" . (int)$download_id . "'");
		
		return $query->row['total'];
	}
	
	public function getTotalProductsByManufacturerId($manufacturer_id) {
		$query = $this->db->query("SELECT COUNT(*) AS total FROM " . DB_PREFIX . "product WHERE manufacturer_id = '" . (int)$manufacturer_id . "'");

		return $query->row['total'];
	}
	
	public function getTotalProductsByAttributeId($attribute_id) {
		$query = $this->db->query("SELECT COUNT(*) AS total FROM " . DB_PREFIX . "product_attribute WHERE attribute_id = '" . (int)$attribute_id . "'");

		return $query->row['total'];
	}	
	
	public function getTotalProductsByOptionId($option_id) {
		$query = $this->db->query("SELECT COUNT(*) AS total FROM " . DB_PREFIX . "product_option WHERE option_id = '" . (int)$option_id . "'");

		return $query->row['total'];
	}	
	
	public function getTotalProductsByLayoutId($layout_id) {
		$query = $this->db->query("SELECT COUNT(*) AS total FROM " . DB_PREFIX . "product_to_layout WHERE layout_id = '" . (int)$layout_id . "'");

		return $query->row['total'];
	}
	
	public function getPriceFrom($product_id) {
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "product WHERE product_id = '" . (int)$product_id . "'");

		return $query->row['price_from'];
	}
	
	public function getBadge($product_id) {
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "product WHERE product_id = '" . (int)$product_id . "'");

		return $query->row['upc'];
	}
	
	public function getLots($product_id) {
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "product WHERE product_id = '" . (int)$product_id . "'");

		return $query->row['this_lots'];
	}
	
	public function getProductCompanyValue($product_id) {
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "product WHERE product_id = '" . (int)$product_id . "'");

		return $query->row['company_value'];
	}
	
	
	
    /*Основные опции обьекта для вилл*/
	public function addMainOptionVillas($product_id) {
			
		$product_option_array = array(
		'22' => '1', 
		'56' => '2',
		'33' => '3', 
		'58' => '4', 
		'44' => '5', 
		'47' => '6', 
		'59' => '7', 
		'57' => '8', 
		'24' => '9', 
		'30' => '10', 
		'45' => '11',
		'60' => '12' 
		);
		
        $option_value	  = '';
		
		$required	      = '1';
						
		foreach($product_option_array as $option => $sort){
		
	    $this->db->query("INSERT INTO " . DB_PREFIX . "product_option SET product_id = '" . (int)$product_id . "', option_id = '" . (int)$option . "', option_value = '" . $option_value . "', required = '" . (int)$required . "', product_sort_option_id = '" . (int)$sort . "'");
       
		}
	}
	/*Основные опции обьекта для вилл*/
	
	/*Основные опции обьекта для таунхаусов*/
	public function addMainOptionTownhouses($product_id) {
			
		$product_option_array = array(
		'23'  => '1', 
		'56'  => '2',
		'33'  => '3', 
		'58'  => '4', 
		'44'  => '5', 
		'45'  => '6', 
		'60'  => '7', 
		'59'  => '8', 
		'57'  => '9', 
		'24'  => '10', 
		'30'  => '11',
		'46'  => '12', 
		'47'  => '13'		
		);
		
        $option_value	  = '';
		
		$required	      = '1';
						
		foreach($product_option_array as $option => $sort){
		
	    $this->db->query("INSERT INTO " . DB_PREFIX . "product_option SET product_id = '" . (int)$product_id . "', option_id = '" . (int)$option . "', option_value = '" . $option_value . "', required = '" . (int)$required . "', product_sort_option_id = '" . (int)$sort . "'");
       
		}
	}
	/*Основные опции обьекта для таунхаусов*/
	
	/*Основные опции обьекта для апартаментов*/
	public function addMainOptionApartments($product_id) {
			
		$product_option_array = array(
		'29'  => '1', 
		'30'  => '2',
		'44'  => '3', 
		'45'  => '4', 
		'47'  => '5', 
		'23'  => '6', 
		'28'  => '7', 
		'24'  => '8', 
		'76'  => '9', 
		'46'  => '10'
		);
		
        $option_value	  = '';
		
		$required	      = '1';
						
		foreach($product_option_array as $option => $sort){
		
	    $this->db->query("INSERT INTO " . DB_PREFIX . "product_option SET product_id = '" . (int)$product_id . "', option_id = '" . (int)$option . "', option_value = '" . $option_value . "', required = '" . (int)$required . "', product_sort_option_id = '" . (int)$sort . "'");
       
		}
	}
	/*Основные опции обьекта для апартаментов*/
	
	/*Основные опции обьекта для зем. участков*/
	public function addMainOptionForLandPlots($product_id) {
		
		$product_option_array = array(
		'70' => '1', 
		'58' => '2',
		'68' => '3', 
		'67' => '4', 
		'65' => '5', 
		'71' => '6', 
		'63' => '7', 
		'66' => '8', 
		'64' => '9', 
		'47' => '10', 
		'69' => '11'
		);
		
        $option_value	  = '';
		
		$required	      = '1';
						
		foreach($product_option_array as $option => $sort){
			
	    $this->db->query("INSERT INTO " . DB_PREFIX . "product_option SET product_id = '" . (int)$product_id . "', option_id = '" . (int)$option . "', option_value = '" . $option_value . "', required = '" . (int)$required . "', product_sort_option_id = '" . (int)$sort . "'");
			
		}
	}
	/*Основные опции обьекта для зем. участков*/	
	
	/*Основные опции обьекта для коммерч. недвиж.*/
	public function addMainOptionСommercialProperty($product_id) {
		
		$product_option_array = array(
		'28'  => '1', 
		'78'  => '2',
		'47'  => '3', 
		'77'  => '4', 
		'44'  => '5', 
		'75'  => '6'	
		);
		
        $option_value	  = '';
		
		$required	      = '1';
						
		foreach($product_option_array as $option => $sort){
			
	    $this->db->query("INSERT INTO " . DB_PREFIX . "product_option SET product_id = '" . (int)$product_id . "', option_id = '" . (int)$option . "', option_value = '" . $option_value . "', required = '" . (int)$required . "', product_sort_option_id = '" . (int)$sort . "'");
			
		}
	}
	/*Основные опции обьекта для коммерч. недвиж.*/	
	
	/*Основные опции обьекта для дома*/
	public function addMainOptionHomes($product_id) {
		
		$product_option_array = array(
		'63'  => '1', 
		'59'  => '2',
		'43'  => '3', 
		'57'  => '4', 
		'24'  => '5', 
		'74'  => '6', 
		'26'  => '7', 
		'94'  => '8', 
		'44'  => '9', 
		'40'  => '10', 
		'50'  => '11',
		'93'  => '12', 
		'53'  => '13',
	    '102' => '14',
		'68'  => '15',
		'75'  => '16',
		'35'  => '17',
		'85'  => '18',
		'71'  => '19',
		'39'  => '20',
		'23'  => '21',
		'56'  => '22',
		'33'  => '23',
		'58'  => '24',
		'30'  => '25',
		'27'  => '26',
		'38'  => '27',
		'45'  => '28',
		'49'  => '29',
		'51'  => '30',
		'52'  => '31',
		'54'  => '32',
		'55'  => '33',
		'67'  => '34',
		'60'  => '35',
		'34'  => '36',
		'47'  => '37'
		);
		
        $option_value	  = '';
		
		$required	      = '1';
						
		foreach($product_option_array as $option => $sort){
			
	    $this->db->query("INSERT INTO " . DB_PREFIX . "product_option SET product_id = '" . (int)$product_id . "', option_id = '" . (int)$option . "', option_value = '" . $option_value . "', required = '" . (int)$required . "', product_sort_option_id = '" . (int)$sort . "'");
			
		}
	}
	/*Основные опции обьекта для дома*/	
	
	/*Основные опции обьекта для квартиры*/
	public function addMainOptionQuarters($product_id) {
		
		$product_option_array = array(
		'62'  => '1', 
		'59'  => '2',
		'43'  => '3', 
		'29'  => '4', 
		'26'  => '5', 
		'44'  => '6', 
		'49'  => '7', 
		'91'  => '8', 
		'89'  => '9', 
		'86'  => '10', 
		'71'  => '11',
		'39'  => '12', 
		'84'  => '13',
	    '28' => '14',
		'33'  => '15',
		'38'  => '16',
		'45'  => '17',
		'66'  => '18',
		'90'  => '19',
		'31'  => '20',
		'85'  => '21'
		);
		
        $option_value	  = '';
		
		$required	      = '1';
						
		foreach($product_option_array as $option => $sort){
			
	    $this->db->query("INSERT INTO " . DB_PREFIX . "product_option SET product_id = '" . (int)$product_id . "', option_id = '" . (int)$option . "', option_value = '" . $option_value . "', required = '" . (int)$required . "', product_sort_option_id = '" . (int)$sort . "'");
			
		}
	}
	/*Основные опции обьекта для квартиры*/	
	
	public function updateImageInterior($product_id, $image) {
		
		        //$this->db->query("DELETE FROM " . DB_PREFIX . "product_image WHERE product_id = '" . (int)$product_id . "'");
		
			foreach ($image as $product_image) {
				$this->db->query("INSERT INTO " . DB_PREFIX . "product_image SET product_id = '" . (int)$product_id . "', image = '" . $this->db->escape(html_entity_decode($product_image['image'], ENT_QUOTES, 'UTF-8')) . "', sort_order = '" . (int)$product_image['sort_order'] . "'");
			}
	}
	
	public function updateImageExterior($product_id, $image) {
		
		        //$this->db->query("DELETE FROM " . DB_PREFIX . "product_image_exterior WHERE product_id = '" . (int)$product_id . "'");
		
			foreach ($image as $product_image) {
				$this->db->query("INSERT INTO " . DB_PREFIX . "product_image_exterior SET product_id = '" . (int)$product_id . "', image = '" . $this->db->escape(html_entity_decode($product_image['image'], ENT_QUOTES, 'UTF-8')) . "', sort_order = '" . (int)$product_image['sort_order'] . "'");
			}
	}
	
	public function updateImageMore($product_id, $image) {
		
		        //$this->db->query("DELETE FROM " . DB_PREFIX . "product_image_more WHERE product_id = '" . (int)$product_id . "'");
		
			foreach ($image as $product_image) {
				$this->db->query("INSERT INTO " . DB_PREFIX . "product_image_more SET product_id = '" . (int)$product_id . "', image = '" . $this->db->escape(html_entity_decode($product_image['image'], ENT_QUOTES, 'UTF-8')) . "', sort_order = '" . (int)$product_image['sort_order'] . "'");
			}
	}
	
	/*Сортировка по цене*/
	public function getProductCurency() {
		
		$query = $this->db->query("SELECT product_id, price, currency_id FROM " . DB_PREFIX . "product WHERE status = '1'");
		
		return $query->rows;
		
	}
		
	public function insertPrice($array) {

		foreach($array as $value){
			
			$this->db->query("UPDATE " . DB_PREFIX . "product SET real_price = '" . (float)$value['price'] ."' WHERE product_id = '" . (int)$value['product_id'] . "'");

		}
	}
	/*Сортировка по цене*/
}
?>
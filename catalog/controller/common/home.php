<?php  
class ControllerCommonHome extends Controller {
	public function index() {
		$this->document->setTitle($this->config->get('config_title'));
		$this->document->setDescription($this->config->get('config_meta_description'));
		$this->document->setKeywords($this->config->get('config_meta_keyword'));



        // Новостройки

       /* $this->load->model('catalog/product');

        $category_id = 79;
        $sort = 'p.sort_order';
        $order = 'ASC';
        $limit = 4;

        $this->data['category_href'] = $this->url->link('product/category', 'path=' . '20_'.$category_id);

        $this->data['products'] = array();



        $data = array(

            'filter_category_id' => $category_id,

            'sort'               => $sort,

            'order'              => $order,

            'start'              => 0,

            'limit'              => $limit

        );



        //$product_total = $this->model_catalog_product->getTotalProducts($data);



        $results = $this->model_catalog_product->getProducts($data);

        $this->load->model('localisation/currency');
		$this->load->model('tool/object');

        foreach ($results as $result) {

            if($result['upc']){

                $badge = $result['upc'];

            }

            else{

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

            } else {

                $special = false;

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

                'model'      => $result['model'],

                'description' => $descr_plaintext,

                'price'       => $price,

                'rub'         => $rub,

                'special'     => $special,

                'saving' 	  => $this->currency->format(($this->tax->calculate($result['price'], $result['tax_class_id'], $this->config->get('config_tax')))-($this->tax->calculate($result['special'], $result['tax_class_id'], $this->config->get('config_tax')))),

                'tax'         => $tax,

                'rating'      => $result['rating'],

                'reviews'     => sprintf($this->language->get('text_reviews'), (int)$result['reviews']),

                'video'     => html_entity_decode($result['video'], ENT_QUOTES, "UTF-8"),

                'gallery_href'        => $this->url->link('product/product/gallery', 'path=' . $this->request->get['path'] . '&product_id=' . $result['product_id']),

                'video_href'        => $this->url->link('product/product/video', 'path=' . $this->request->get['path'] . '&product_id=' . $result['product_id']),

                'href'        => $this->url->link('product/product', 'path=' . $this->request->get['path'] . '&product_id=' . $result['product_id'])


            );

        }*/


        $this->load->model('catalog/information');
        $this->data['articles'] = $this->model_catalog_information->getBlogInformationsByType(0, 3, 1);

		$this->data['heading_title'] = $this->config->get('config_title');
		
		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/common/home.tpl')) {
			$this->template = $this->config->get('config_template') . '/template/common/home.tpl';
		} else {
			$this->template = 'default/template/common/home.tpl';
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
?>
<?php
class ControllerModuleFavorites extends Controller {
    public function index() {
        if ($_SERVER['REQUEST_METHOD']=='POST') {
            $this->load->model('catalog/product');

            $sess_id = isset($_POST['sess_id']) ? intval($_POST['sess_id']) : 0;
            $product_id = isset($_POST['product_id']) ? intval($_POST['product_id']) : 0;

            if (!empty($sess_id) && !empty($product_id) && $sess_id==$this->model_catalog_product->getSessId()) {
                $user_id = intval($this->customer->getId());

                $this->model_catalog_product->addFavorite($user_id, $sess_id, $product_id);

                $response = array(
                    'status' => 1
                );
            } else {
                $response = array(
                    'status' => 0
                );
            }

            echo json_encode($response);
        }
    }

    public function remove() {
        if ($_SERVER['REQUEST_METHOD']=='POST') {
            $this->load->model('catalog/product');

            $sess_id = isset($_POST['sess_id']) ? intval($_POST['sess_id']) : 0;
            $product_id = isset($_POST['product_id']) ? intval($_POST['product_id']) : 0;

            if (!empty($sess_id) && !empty($product_id) && $sess_id==$this->model_catalog_product->getSessId()) {
                $user_id = intval($this->customer->getId());

                $this->model_catalog_product->removeFavorite($user_id, $sess_id, $product_id);

                $response = array(
                    'status' => 1
                );
            } else {
                $response = array(
                    'status' => 0
                );
            }

            echo json_encode($response);
        }
    }

    public function favorites() {

        $this->data['breadcrumbs'] = array();



        $this->data['breadcrumbs'][] = array(

            'text'      => $this->language->get('text_home'),

            'href'      => $this->url->link('common/home'),

            'separator' => false

        );


        $this->data['breadcrumbs'][] = array(

            'text'      => 'Избранное',

            'href'      => $this->url->link('module/favorites/favorites'),

            'separator' => $this->language->get('text_separator')

        );

        if (isset($this->request->get['page'])) {

            $page = $this->request->get['page'];

        } else {

            $page = 1;

        }



        /*if (isset($this->request->get['limit'])) {

            $limit = $this->request->get['limit'];

        } else {

            $limit = $this->config->get('config_catalog_limit');

        }*/
		
		if (isset($this->request->get['limit'])) {

            $limit = 100;

        } else {

            $limit = 100;

        }


        $this->load->model('catalog/product');
        $user_id = intval($this->customer->getId());
        $sess_id=intval($this->model_catalog_product->getSessId());

        $total = $this->model_catalog_product->getFavoritesTotal($user_id, $sess_id);
        $favorites = $this->model_catalog_product->getFavorites($user_id, $sess_id, $limit, $page);

        $this->data['products'] = array();

        $this->load->model('localisation/currency');

        foreach ($favorites as $favorite) {
            $result = $this->model_catalog_product->getProduct($favorite['product_id']);
            if (!$result) continue;

            if($result['upc']){

                $badge = $result['upc'];

            }

            else{

                $badge = '';

            }

            if ($result['image']) {

                //$image = $this->model_tool_image->resize($result['image'], $this->config->get('config_image_product_width'), $this->config->get('config_image_product_height'));
                $image = file_exists($_SERVER['DOCUMENT_ROOT'].'/image/'.$result['image']) ? '/image/'.$result['image'] : '';

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

        }

        /*$pagination = new Pagination();

        $pagination->total = $total;

        $pagination->page = $page;

        $pagination->limit = $limit;

        $pagination->text = $this->language->get('text_pagination');

        $pagination->url = $this->url->link('module/favorites/favorites', 'page={page}');



        $this->data['pagination'] = $pagination->render();*/


        $this->template = $this->config->get('config_template') . '/template/product/favorites.tpl';

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
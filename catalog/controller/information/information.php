<?php 
class ControllerInformationInformation extends Controller {
	public function index() {  
    	$this->language->load('information/information');

		$this->load->model('catalog/information');
		
		$this->data['breadcrumbs'] = array();
		
      	$this->data['breadcrumbs'][] = array(
        	'text'      => $this->language->get('text_home'),
			'href'      => $this->url->link('common/home'),
        	'separator' => false
      	);
		
		/*Загррузка файлов в товарах */
		/////////////////////////////////////
        $this->data['downloads'] = array();
 
        $results = $this->model_catalog_information->getDownloads($this->request->get['information_id']);
 
        foreach ($results as $result) {
            if (file_exists(DIR_DOWNLOAD . $result['filename'])) {
            $size = filesize(DIR_DOWNLOAD . $result['filename']);
 
            $i = 0;
 
            $suffix = array(
				'B',
				'KB',
				'MB',
				'GB',
				'TB',
				'PB',
				'EB',
				'ZB',
				'YB'
            );
 
            while (($size / 1024) > 1) {
				$size = $size / 1024;
            $i++;
            }
 
            $this->data['downloads'][] = array(
				'date_added'    => date($this->language->get('date_format_short'), strtotime($result['date_added'])),
				'name'          => $result['name'],
				'description'	=> html_entity_decode($result['description'], ENT_QUOTES, 'UTF-8'),
				'size'          => round(substr($size, 0, strpos($size, '.') + 4), 2) . $suffix[$i],
				'href'        => $this->url->link('information/information/download', 'information_id='. $this->request->get['information_id']. '&download_id=' . $result['download_id'])
            );
            }
        }
        /////////////////////////////////////	
		
		if (isset($this->request->get['information_id'])) {
			$information_id = (int)$this->request->get['information_id'];
		} else {
			$information_id = 0;
		}
		
		$information_info = $this->model_catalog_information->getInformation($information_id);
   		
		if ($information_info) {
			if ($information_info['seo_title']) {
				$this->document->setTitle($information_info['seo_title']);
			} else {
				$this->document->setTitle($information_info['title']);
			}
			$this->document->setDescription($information_info['meta_description']);
			$this->document->setKeywords($information_info['meta_keyword']);

            if (!empty($information_info['show_in_blog'])) {
                $this->data['breadcrumbs'][] = array(
                    'text'      => 'Блог',
                    'href'      => $this->url->link('information/information/blog'),
                    'separator' => $this->language->get('text_separator'),
                );
            }

      		$this->data['breadcrumbs'][] = array(
        		'text'      => $information_info['title'],
				'href'      => $this->url->link('information/information', 'information_id=' .  $information_id),      		
        		'separator' => $this->language->get('text_separator'),
                'current' => true
      		);	

			if ($information_info['seo_h1']) {
				$this->data['heading_title'] = $information_info['seo_h1'];
			} else {
				$this->data['heading_title'] = $information_info['title'];
			}
						
      		$this->data['button_continue'] = $this->language->get('button_continue');
			
			$this->data['description'] = html_entity_decode($information_info['description'], ENT_QUOTES, 'UTF-8');
      		
			$this->data['continue'] = $this->url->link('common/home');

            if (!empty($information_info['image']) && $information_info['image']!='no_image.jpg') {
                $this->data['image'] = HTTP_IMAGE . $information_info['image'];
            }

            if (trim($_SERVER['REQUEST_URI'],'/')=='crimea-gallery') {
                $this->document->addStyle('catalog/view/theme/default/css/galleriffic-2.css');
                $this->document->addScript('catalog/view/theme/default/js/jquery.opacityrollover.js');
                $this->document->addScript('catalog/view/theme/default/js/jquery.galleriffic.js');

                $this->load->model('catalog/gallimage');

                $this->data['gallimages'] = array();

                $results = $this->model_catalog_gallimage->getGallimage(3);

                foreach ($results as $result) {
                    if (file_exists(DIR_IMAGE . $result['image'])) {
                        $this->data['gallimages'][] = array(
                            'title' => $result['title'],
                            'link'  => $result['link'],
                            'image' => '/image/'.$result['image']
                        );
                    }
                }

                if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/information/gallery.tpl')) {
                    $this->template = $this->config->get('config_template') . '/template/information/gallery.tpl';
                } else {
                    $this->template = 'default/template/information/gallery.tpl';
                }

                $this->children = array(
                    'common/column_left',
                    'common/column_right',
                    'common/content_top',
                    'common/content_bottom',
                    'common/footer',
                    'common/header'
                );
            } else if (!empty($information_info['show_in_blog'])) {
                $this->data['blog_categories'] = $this->model_catalog_information->getBlogCategories();
                $this->template = 'default/template/information/blog_head.tpl';
                $this->data['blog_head'] = $this->render();

                if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/information/blog.tpl')) {
                    $this->template = $this->config->get('config_template') . '/template/information/blog.tpl';
                } else {
                    $this->template = 'default/template/information/blog.tpl';
                }

                $this->children = array(
                    'common/column_left',
                    'common/column_right',
                    'common/content_top',
                    'common/content_bottom',
                    'common/footer',
                    'common/header'
                );

            } else if (empty($information_info['clean'])) {
                if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/information/information.tpl')) {
                    $this->template = $this->config->get('config_template') . '/template/information/information.tpl';
                } else {
                    $this->template = 'default/template/information/information.tpl';
                }

                $this->children = array(
                    'common/column_left',
                    'common/column_right',
                    'common/content_top',
                    'common/content_bottom',
                    'common/footer',
                    'common/header'
                );

            } else {
                // Отзывы
                $this->load->model('catalog/testimonial');

                $this->data['testimonials'] = array();

                $results = $this->model_catalog_testimonial->getTestimonials(0, 2);

                foreach ($results as $result) {

                    $this->data['testimonials'][] = array(
                        'name'		=> $result['name'],
                        'title'    		=> $result['title'],
                        'rating'		=> $result['rating'],
                        'city'		=> $result['city'],
                        'date_added'	=> date("H:i:s m-d-Y", strtotime($result['date_added'])) //$result['date_added']



                    );
                }

                // FAQ
                $this->load->model('fido/faq');
                $topic_data = $this->model_fido_faq->getTopicsLimited(0, 3);

                if ($topic_data) {
                    $this->data['topics'] = array();

                    foreach ($topic_data as $result) {
                        $result['description'] = html_entity_decode($result['description'],ENT_QUOTES,'UTF-8');
                        $m = array(0 => '', 1 => '', 2 => '');
                        if ($co=preg_match_all('/<details.*?>.*?<summary.*?>(.+?)<\/summary>(.+?)<\/details>/siu', $result['description'], $m)) {

                            foreach($m[1] as $k=>$_m) {
                                $desc = isset($m[2][$k]) ? $m[2][$k] : '';
                                $this->data['topics'][] = array(
                                    'title' => strip_tags($_m),
                                    'href'  => '/index.php?route=information/faq',
                                    'description' => strip_tags($desc)
                                );
                            }
                        } else {
                            $this->data['topics'][] = array(
                                'title' => $result['title'],
                                'href'  => $this->url->link('information/faq', 'topic=' . $result['faq_id']),
                                'description' => $result['description']
                            );
                        }
                    }
                }
                // Блог
                $this->load->model('catalog/information');
                $this->data['articles'] = $this->model_catalog_information->getBlogInformationsByType(0, 1, 1);

                // Галерея
                $this->load->model('catalog/gallimage');

                $this->data['gallimages'] = array();

                $results = $this->model_catalog_gallimage->getGallimageLimited(3,4);

                foreach ($results as $result) {
                    if (file_exists(DIR_IMAGE . $result['image'])) {
                        $this->data['gallimages'][] = array(
                            'title' => $result['title'],
                            'link'  => $result['link'],
                            'image' => '/image/'.$result['image']
                        );
                    }
                }

                //

                $this->template = $this->config->get('config_template') . '/template/information/right.tpl';
                $this->data['right'] = $this->render();
                $this->template = $this->config->get('config_template') . '/template/information/form.tpl';
                $this->data['form'] = $this->render();

                if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/information/page.tpl')) {
                    $this->template = $this->config->get('config_template') . '/template/information/page.tpl';
                } else {
                    $this->template = 'default/template/information/page.tpl';
                }

                $this->children = array(
                    'common/content_top',
                    'common/content_bottom',
                    'common/footer',
                    'common/header'
                );
            }
			

						
	  		$this->response->setOutput($this->render());
    	} else {
      		$this->data['breadcrumbs'][] = array(
        		'text'      => $this->language->get('text_error'),
				'href'      => $this->url->link('information/information', 'information_id=' . $information_id),
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

    public function blog() {
        $this->language->load('information/information');

        $this->load->model('catalog/information');

        $this->data['breadcrumbs'] = array();

        $this->data['breadcrumbs'][] = array(
            'text'      => $this->language->get('text_home'),
            'href'      => $this->url->link('common/home'),
            'separator' => false,
            'current'    => false
        );

        $this->data['breadcrumbs'][] = array(
            'text'      => 'Блог',
            'href'      => '/blog',
            'separator' => $this->language->get('text_separator'),
            'current' => true
        );

        $limit = 20;

        if (isset($this->request->get['page']) && is_numeric($this->request->get['page']) && intval($this->request->get['page'])>0) {
            $page = intval($this->request->get['page']);
        } else {
            $page = 1;
        }

        $type = isset($this->request->get['type']) ? $this->request->get['type'] : 'all';

        if (is_numeric($type)) {
            $articles = $this->model_catalog_information->getBlogInformationsByCategory($type, $limit, $page);
            $total = $this->model_catalog_information->getBlogInformationsByCategoryCount($type);
            $this->data['articles'] = $articles;
        } else {
            switch($type) {
                case 'news':
                    $this->data['title'] = 'Новости';
                    $data = array(
                        'start'           => ($page - 1) * $limit,
                        'limit'           => $limit
                    );
                    $this->load->model('catalog/news');
                    $results = $this->model_catalog_news->getNewsLimited($data);
                    $articles=$this->model_catalog_information->getBlogNews($results);
                    $total = $this->model_catalog_news->getTotalNews($data);

                    $this->data['articles'] = $articles;
                    break;
                case 'articles':
                    $this->data['title'] = 'Статьи';
                    $articles = $this->model_catalog_information->getBlogInformationsByType(0, $limit, $page);
                    $total = $this->model_catalog_information->getBlogInformationsByTypeCount(0);

                    $this->data['articles'] = $articles;
                    break;
                case 'video':
                    $this->data['title'] = 'Видео';
                    $articles = $this->model_catalog_information->getBlogInformationsByType(1, $limit, $page);
                    $total = $this->model_catalog_information->getBlogInformationsByTypeCount(1);

                    $this->data['articles'] = $articles;
                    break;
                default:
//                    $this->data['title'] = 'Блог';
//                    $articles = $this->model_catalog_information->getBlogInformations($limit, $page);
//                    $total = $this->model_catalog_information->getBlogInformationsCount();

                    $page = 1;
                    $limit = 5;
                    $data = array(
                        'start'           => ($page - 1) * $limit,
                        'limit'           => $limit
                    );
                    $this->load->model('catalog/news');
                    $results = $this->model_catalog_news->getNewsLimited($data);
                    $news=$this->model_catalog_information->getBlogNews($results);

                    $articles = $this->model_catalog_information->getBlogInformationsByType(0, $limit, $page);
                    $videos = $this->model_catalog_information->getBlogInformationsByType(1, $limit, $page);

                    $this->data['news'] = $news;
                    $this->data['articles'] = $articles;
                    $this->data['videos'] = $videos;
                    break;
            }
        }



        $this->data['blog_categories'] = $this->model_catalog_information->getBlogCategories();
        $this->data['type'] = $type;

        $this->template = 'default/template/information/blog_head.tpl';
        $this->data['blog_head'] = $this->render();

        if ($type == 'all') {
            $this->template = 'default/template/information/blog_index.tpl';
        } else {
            $pagination = new Pagination();
            $pagination->total = $total;
            $pagination->page = $page;
            $pagination->limit = $limit;
            $pagination->text = $this->language->get('text_pagination');
            if (empty($type) || $type=='all') {
                $pagination->url = '/blog?page={page}';
            } else {
                $pagination->url = '/blog/'.$type.'?page={page}';
            }

            $this->data['pagination'] = $pagination->render();

            $this->template = 'default/template/information/blog.tpl';
        }

        $this->children = array(
            'common/content_top',
            'common/content_bottom',
            'common/footer',
            'common/header'
        );

        $this->response->setOutput($this->render());
    }
	
	public function info() {
		$this->load->model('catalog/information');
		
		if (isset($this->request->get['information_id'])) {
			$information_id = (int)$this->request->get['information_id'];
		} else {
			$information_id = 0;
		}      
		
		$information_info = $this->model_catalog_information->getInformation($information_id);

		if ($information_info) {
			$output  = '<html dir="ltr" lang="en">' . "\n";
			$output .= '<head>' . "\n";
			$output .= '  <title>' . $information_info['title'] . '</title>' . "\n";
			$output .= '  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">' . "\n";
			$output .= '  <meta name="robots" content="noindex">' . "\n";
			$output .= '</head>' . "\n";
			$output .= '<body>' . "\n";
			$output .= '  <h1>' . $information_info['title'] . '</h1>' . "\n";
			$output .= html_entity_decode($information_info['description'], ENT_QUOTES, 'UTF-8') . "\n";
			$output .= '  </body>' . "\n";
			$output .= '</html>' . "\n";			

			$this->response->setOutput($output);
		}
	}
	
    /*Загрузка Файлов в товарах*/
	
	public function download() {
 
        $this->load->model('catalog/information');
 
        if (isset($this->request->get['download_id'])) {
        $download_id = $this->request->get['download_id'];
        } else {
        $download_id = 0;
    }
 
        if (isset($this->request->get['information_id'])) {
        $information_id = $this->request->get['information_id'];
        } else {
        $information_id = 0;
    }
 
        $download_info = $this->model_catalog_information->getDownload($information_id, $download_id);
 
        if ($download_info) {
        $file = DIR_DOWNLOAD . $download_info['filename'];
        $mask = basename($download_info['mask']);
 
        if (!headers_sent()) {
        if (file_exists($file)) {
        header('Content-Description: File Transfer');
        header('Content-Type: application/octet-stream');
        header('Content-Disposition: attachment; filename="' . ($mask ? $mask : basename($file)) . '"');
        header('Content-Transfer-Encoding: binary');
        header('Expires: 0');
        header('Cache-Control: must-revalidate, post-check=0, pre-check=0');
        header('Pragma: public');
        header('Content-Length: ' . filesize($file));
 
        readfile($file, 'rb');
		exit;
        } else {
        exit('Error: Could not find file ' . $file . '!');
    }
        } else {
        exit('Error: Headers already sent out!');
    }
        } else {
        $this->redirect(HTTP_SERVER . 'index.php?route=account/download');
    }
}

    //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
}
?>
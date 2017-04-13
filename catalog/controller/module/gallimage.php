<?php  
class ControllerModuleGallimage extends Controller {
	protected function index($setting) {
		static $module = 0;	
		
		$this->language->load('module/gallimage'); 

		$this->data['heading_title'] = $this->language->get('heading_title');
		
		$this->load->model('catalog/gallimage');
		$this->load->model('tool/image');
		
		$this->document->addScript('catalog/view/javascript/jquery/colorbox/jquery.colorbox-min.js');
		$this->document->addStyle('catalog/view/javascript/jquery/colorbox/colorbox.css');
				
		$this->data['gallimages'] = array();
		
		$results = $this->model_catalog_gallimage->getGallimage($setting['gallimage_id']);	

		foreach ($results as $result) {
			if (file_exists(DIR_IMAGE . $result['image'])) {
				$this->data['gallimages'][] = array(
					'title' => $result['title'],
					'link'  => $result['link'],
					'image' => $this->model_tool_image->resize($result['image'], $setting['width'], $setting['height']),
					'popup' => $this->model_tool_image->resize($result['image'], 500, 500)
				);
			}
		}
		
		$this->data['widthdiv'] = $setting['width'];
		
		$this->data['module'] = $module++;
				
		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/module/gallimage.tpl')) {
			$this->template = $this->config->get('config_template') . '/template/module/gallimage.tpl';
		} else {
			$this->template = 'default/template/module/gallimage.tpl';
		}
		
		$this->render();
	}
}
?>
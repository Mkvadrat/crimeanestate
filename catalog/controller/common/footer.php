<?php  
class ControllerCommonFooter extends Controller {
	protected function index() {
		$this->language->load('common/footer');

		$this->data['text_information'] = $this->language->get('text_information');
		$this->data['text_service'] = $this->language->get('text_service');
		$this->data['text_extra'] = $this->language->get('text_extra');
		$this->data['text_contact'] = $this->language->get('text_contact');
		$this->data['text_return'] = $this->language->get('text_return');
		$this->data['text_sitemap'] = $this->language->get('text_sitemap');
		$this->data['text_manufacturer'] = $this->language->get('text_manufacturer');
		$this->data['text_voucher'] = $this->language->get('text_voucher');
		$this->data['text_affiliate'] = $this->language->get('text_affiliate');
		$this->data['text_special'] = $this->language->get('text_special');
		$this->data['text_account'] = $this->language->get('text_account');
		$this->data['text_order'] = $this->language->get('text_order');
		$this->data['text_wishlist'] = $this->language->get('text_wishlist');
		$this->data['text_newsletter'] = $this->language->get('text_newsletter');
		$this->data['text_contact'] = $this->language->get('text_contact');

		$this->load->model('catalog/information');

		$this->data['informations'] = array();

		foreach ($this->model_catalog_information->getInformations() as $result) {
			if ($result['bottom']) {
				$this->data['informations'][] = array(
					'title' => $result['title'],
					'href'  => $this->url->link('information/information', 'information_id=' . $result['information_id'])
				);
			}
		}

		$this->data['contact'] = $this->url->link('information/contact');
		$this->data['return'] = $this->url->link('account/return/insert', '', 'SSL');
		$this->data['sitemap'] = $this->url->link('information/sitemap');
		$this->data['manufacturer'] = $this->url->link('product/manufacturer');
		$this->data['voucher'] = $this->url->link('account/voucher', '', 'SSL');
		$this->data['affiliate'] = $this->url->link('affiliate/account', '', 'SSL');
		$this->data['special'] = $this->url->link('product/special');
		$this->data['account'] = $this->url->link('account/account', '', 'SSL');
		$this->data['order'] = $this->url->link('account/order', '', 'SSL');
		$this->data['wishlist'] = $this->url->link('account/wishlist', '', 'SSL');
		$this->data['newsletter'] = $this->url->link('account/newsletter', '', 'SSL');		

		$this->data['powered'] = sprintf($this->language->get('text_powered'), $this->config->get('config_name'), date('Y', time()));

		// Whos Online
		if ($this->config->get('config_customer_online')) {
			$this->load->model('tool/online');

			if (isset($this->request->server['REMOTE_ADDR'])) {
				$ip = $this->request->server['REMOTE_ADDR'];	
			} else {
				$ip = ''; 
			}

			if (isset($this->request->server['HTTP_HOST']) && isset($this->request->server['REQUEST_URI'])) {
				$url = 'http://' . $this->request->server['HTTP_HOST'] . $this->request->server['REQUEST_URI'];	
			} else {
				$url = '';
			}

			if (isset($this->request->server['HTTP_REFERER'])) {
				$referer = $this->request->server['HTTP_REFERER'];	
			} else {
				$referer = '';
			}

			$this->model_tool_online->whosonline($ip, $this->customer->getId(), $url, $referer);
		}

        // feedback form
        $setting = array(
            'id' => 0,
            'name' => 'on',
            'email' => 'on',
            'phone' => 'on',
            'text' => 'on',
            'r' => array('name' => 'on'),
            'module_title' => array(1 => 'Обратная связь'),
            'module_style' => 'classic'
        );

        $this->data['feedback_form'] = $this->getChild('module/feedback', $setting);

        $this->data['logged'] = $this->customer->isLogged();

		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/common/footer.tpl')) {
			$this->template = $this->config->get('config_template') . '/template/common/footer.tpl';
		} else {
			$this->template = 'default/template/common/footer.tpl';
		}

		$this->render();
	}
	
 public function page() {
        if (($this->request->server['REQUEST_METHOD'] == 'POST')) {

            $response = array(
                'status' => 0,
                'message' => ''
            );

            try {
                if (empty($_POST['phone']) && empty($_POST['email'])) {
                    throw new Exception('Укажите ваш Email или телефон');
                }
                if (empty($_POST['name'])) {
                    $name = '-';
                } else {
                    $name = strip_tags($_POST['name']);
                }

                if (empty($_POST['phone'])) {
                    $phone = '-';
                } else {
                    $phone = strip_tags($_POST['phone']);
                }

                if (empty($_POST['email'])) {
                    $email = '-';
                } else if (!preg_match('/^[^\@]+@.*\.[a-z]{2,6}$/i', $_POST['email'])) {
                    throw new Exception('Некорректный email');
                } else {
                    $email = strip_tags($_POST['email']);
                }

                if (empty($_POST['text'])) {
                    throw new Exception('Напишите ваше сообщение');
                }
                $text = strip_tags($_POST['text']);

                $to = $this->config->get('config_email') . ', crimean.estate@ya.ru';
                $from = 'noreply@'.$_SERVER['HTTP_HOST'];
                $from_name = $_SERVER['HTTP_HOST'];

                $body = '';
                $body .= 'Имя: '.$name."\r\n";
                $body .= 'Телефон: '.$phone."\r\n";
                $body .= 'Email: '.$email."\r\n";
                $body .= 'Сообщение: '."\r\n";
                $body .= $text."\r\n";
                $body .= "\r\n";

                $mail = new Mail();
                $mail->protocol = $this->config->get('config_mail_protocol');
                $mail->parameter = $this->config->get('config_mail_parameter');
                $mail->hostname = $this->config->get('config_smtp_host');
                $mail->username = $this->config->get('config_smtp_username');
                $mail->password = $this->config->get('config_smtp_password');
                $mail->port = $this->config->get('config_smtp_port');
                $mail->timeout = $this->config->get('config_smtp_timeout');

                $mail->setTo($to);
                $mail->setFrom($from);
                $mail->setSender($from_name);
                $mail->setSubject('Обратная связь');
                $mail->setText($body);
                $mail->send();

                $response = array(
                    'status' => 1,
                    'message' => 'Ваше сообщение отправлено'
                );
            } catch(Exception $e) {
                $response = array(
                    'status' => 0,
                    'message' => $e->getMessage()
                );
            }

            $this->response->setOutput(json_encode($response));
        }
    }
}
?>
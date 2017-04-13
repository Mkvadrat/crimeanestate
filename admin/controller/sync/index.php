<?php
class ControllerSyncIndex extends Controller {
    const REMOTE_DB_USER = 'yaltapar_root';
    const REMOTE_DB_PASSWORD = 'partner123partner';
    const REMOTE_DB_NAME = 'yaltapar_partner2';
    //const REMOTE_DB_NAME = 'yaltapar_test';
    const REMOTE_DB_HOST = '176.9.135.163';

    const REMOTE_FTP_HOST = 'ftp.yaltapartner.ru';
    const REMOTE_FTP_USER = 'sync@yaltapartner.ru';
    const REMOTE_FTP_PASSWORD = 'wuCp!,?ELRbe';

    const IMAGES_DIR = 'image';
    const REMOTE_IMAGES_DIR = 'image';
    const REMOTE_CACHE_DIR = 'system/cache';
    const DUMPS_DIR = 'dumps';

    private $subdir = 'default';

    public function index() {
        $this->load->model('sync/sync');
        if (!$this->model_sync_sync->sync_allowed()) exit();

        if (!empty($_GET['dumps_only'])) {
            $this->response->setOutput($this->list_dumps());
            return;
        }

        if (!empty($_GET['rollback']) && !empty($_POST['dir'])) {
            $result = $this->rollback($_POST['dir']);
            if (!$result) {
                $this->response->setOutput('<div class="warning">Невозможно сделать откат</div>');
            } else {
                $this->response->setOutput('<div class="success">Откат сделан успешно</div>');
            }
            return;
        }

        if (!empty($_POST['cmd'])) {
            $response = $this->cmd($_POST['cmd']);
            if ($response['status']=='error') {
                $this->log('Error:');
                $this->log(str_replace('<br />',"\r\n",$response['message']));
            }
            echo json_encode($response);
            exit;
        }

        $this->data['heading_title'] = 'Дампы:';
        $this->data['button_start'] = 'Начать синхронизацию';

        $this->data['breadcrumbs'] = array();

        $this->data['breadcrumbs'][] = array(
            'text'      => $this->language->get('text_home'),
            'href'      => $this->url->link('common/home', 'token=' . $this->session->data['token'], 'SSL'),
            'separator' => false
        );

        $this->data['breadcrumbs'][] = array(
            'text'      => $this->data['heading_title'] ,
            'href'      => $this->url->link('sync/index', 'token=' . $this->session->data['token'] , 'SSL'),
            'separator' => ' :: '
        );

        $this->data['dumps']=$this->list_dumps();

        $this->template = 'sync/index.tpl';
        $this->children = array(
            'common/header',
            'common/footer'
        );

        $this->response->setOutput($this->render());
    }

    private function list_dumps() {
        $this->data['dumps'] = array();

        $dir = $_SERVER['DOCUMENT_ROOT'] . '/' . self::DUMPS_DIR;
        if (file_exists($dir)) {
            $d = opendir($dir);
            while(($file = readdir($d))!==false) {
                if ($file == '.' || $file=='..') continue;
                if (!is_dir($dir.'/'.$file)) continue;
                $date = 'unknown';
                $index = count($this->data['dumps']);
                if (preg_match('/^[\d]{4}[-][\d]{2}[-][\d]{2}$/',$file)) {
                    $date = date('d.m.Y',strtotime($file));
                    $index = strtotime($file);
                }
                $dump = array(
                    'date' => $date,
                    'files' => array(),
                    'dir' => $file
                );
                $dd = opendir($dir.'/'.$file);
                while(($_file = readdir($dd))!==false) {
                    if ($_file == '.' || $_file=='..') continue;
                    $dump['files']['/' . self::DUMPS_DIR . '/' . $file . '/' . $_file] = $_file;
                }
                closedir($dd);
                $this->data['dumps'][$index] = $dump;
            }
            closedir($d);
        }

        ksort($this->data['dumps']);

        $this->template = 'sync/list.tpl';

        return $this->render();
    }

    private function rollback($folder) {
        if (strpos($folder,'..')!==false) return false;
        $filename = $_SERVER['DOCUMENT_ROOT'].'/'.self::DUMPS_DIR.'/'.$folder.'/'.self::REMOTE_DB_NAME.'.sql.gz';
        if (!file_exists($filename)) return false;

        ob_start();
        readgzfile($filename);
        $sql = ob_get_clean();

        if (empty($sql)) return false;

        $mysqli = new mysqli(self::REMOTE_DB_HOST, self::REMOTE_DB_USER, self::REMOTE_DB_PASSWORD, self::REMOTE_DB_NAME);

        if ($mysqli->connect_errno) return false;

        if (!$mysqli->multi_query($sql)) {
            die('<div class="warning">'.$mysqli->error.'</div>');
        } else {
            do {
                $mysqli->use_result();
                if($mysqli->errno) die('<div class="warning">'.$mysqli->error.'</div>');
            } while($mysqli->next_result());
        }

        $mysqli->close();

        return true;
    }

    private function get_sync_tables($type) {
        switch($type) {
            case 'products':
                return array(
                    'product',
                    'product_attribute',
                    'product_description',
                    'product_discount',
                    'product_image',
                    'product_option',
                    'product_option_value',
                    'product_related',
                    'product_reward',
                    'product_special',
                    'product_to_category',
                    'product_to_download',
                    'product_to_layout',
                    'product_to_store'
                );
                break;
            case 'urlaliases':
                return 'url_alias';
                break;
            case 'banners':
                return array(
                    'banner',
                    'banner_image',
                    'banner_image_description'
                );
                break;
            case 'attribute_groups':
                return array(
                    'attribute_group',
                    'attribute_group_description'
                );
                break;
            case 'attributes':
                return array(
                    'attribute',
                    'attribute_description'
                );
                break;
            case 'options':
                return array(
                    'option',
                    'option_description',
                    'option_value',
                    'option_value_description'
                );
                break;
            case 'categories':
                return array(
                    'category',
                    'category_description',
                    'category_to_layout',
                    'category_to_store'
                );
                break;
            case 'informations':
                return array(
                    'information',
                    'information_description',
                    'information_to_layout',
                    'information_to_store'
                );
                break;
            case 'news':
                return array(
                    'news',
                    'news_description',
                    'news_related',
                    'news_to_layout',
                    'news_to_store'
                );
                break;
        }
    }

    private function get_sync_primary_table($type) {
        switch($type) {
            case 'products':
                return 'product';
                break;
            case 'urlaliases':
                return 'url_alias';
                break;
            case 'banners':
                return 'banner';
                break;
            case 'attribute_groups':
                return 'attribute_group';
                break;
            case 'attributes':
                return 'attribute';
                break;
            case 'options':
                return 'option';
                break;
            case 'categories':
                return 'category';
                break;
            case 'informations':
                return 'information';
                break;
            case 'news':
                return 'news';
                break;
        }
    }

    private function get_sync_primary_key($type) {
        switch($type) {
            case 'products':
                return 'product_id';
                break;
            case 'urlaliases':
                return 'url_alias_id';
                break;
            case 'banners':
                return 'banner_id';
                break;
            case 'attribute_groups':
                return 'attribute_group_id';
                break;
            case 'attributes':
                return 'attribute_id';
                break;
            case 'options':
                return 'option_id';
                break;
            case 'categories':
                return 'category_id';
                break;
            case 'informations':
                return 'information_id';
                break;
            case 'news':
                return 'news_id';
                break;
        }
    }

    private function get_sync_modified_keys($type) {
        switch($type) {
            case 'products':
                return 'date_modified';
                break;
            case 'urlaliases':
                return array('query','keyword');
                break;
            case 'banners':
                return array('name','status','link','image','title');
                break;
            case 'attribute_groups':
                return array('sort_order','name');
                break;
            case 'attributes':
                return array('attribute_group_id','sort_order','name');
                break;
            case 'options':
                return array('type','sort_order','name','image');
                break;
            case 'categories':
                return 'date_modified';
                break;
            case 'informations':
                return array('bottom','sort_order','status','title','description','meta_description','meta_keyword','seo_title','seo_h1','store_id','layout_id');
                break;
            case 'news':
                return array('status','image','acom','sort_order','title','description','meta_desc','meta_key','seo_title','seo_h1','product_id','store_id','layout_id');
                break;
        }
    }

    private function get_sync_modified_tables($type) {
        switch($type) {
            case 'products':
                return 'product';
                break;
            case 'urlaliases':
                return 'url_alias';
                break;
            case 'banners':
                return array('banner','banner_image','banner_image_description');
                break;
            case 'attribute_groups':
                return array(
                    'attribute_group',
                    'attribute_group_description'
                );
                break;
            case 'attributes':
                return array(
                    'attribute',
                    'attribute_description'
                );
                break;
            case 'options':
                return array(
                    'option',
                    'option_description',
                    'option_value',
                    'option_value_description'
                );
                break;
            case 'categories':
                return 'category';
                break;
            case 'informations':
                return array(
                    'information',
                    'information_description',
                    'information_to_layout',
                    'information_to_store'
                );
                break;
            case 'news':
                return array(
                    'news',
                    'news_description',
                    'news_related',
                    'news_to_layout',
                    'news_to_store'
                );
                break;
        }
    }

    private function get_sync_image_tables($type) {
        switch($type) {
            case 'products':
                return array('product','product_image');
                break;
            case 'banners':
                return array('banner_image');
                break;
            case 'options':
                return array('option_value');
                break;
            case 'categories':
                return array('category');
                break;
            case 'news':
                return array('news');
                break;
        }
    }

    private function get_sync_image_key($type) {
        switch($type) {
            case 'products':
                return 'image';
                break;
            case 'banners':
                return 'image';
                break;
            case 'options':
                return 'image';
                break;
            case 'categories':
                return 'image';
                break;
            case 'news':
                return 'image';
                break;
        }
    }

    private function cmd($cmd) {
        $this->subdir = date('Y-m-d');

        $response = array(
            'status' => 'error',
            'message' => ''
            );

        switch(urldecode($cmd)) {
            case 'dump local':
                $response = $this->dump_local();
                break;
            case 'dump remote':
                $response = $this->dump_remote();
                break;
            case 'sync new products':
                $response = $this->sync_products_step_1();
                break;
            case 'upload new products':
                $offset = isset($_POST['data']) ? intval($_POST['data']) : null;
                $response = $this->sync_products_step_2($offset);
                break;
            case 'update new products':
                $response = $this->sync_products_step_3();
                break;
            case 'sync existing products':
                $response = $this->sync_products_step_4();
                break;
            case 'upload existing products':
                $offset = isset($_POST['data']) ? intval($_POST['data']) : null;
                $response = $this->sync_products_step_5($offset);
                break;
            case 'update existing products':
                $response = $this->sync_products_step_6();
                break;
            case 'delete not found products':
                $response = $this->sync_products_step_7();
                break;
            case 'update seo urls':
                $response = $this->sync_seo_urls();
                break;
            case 'update banners':
                $response = $this->sync_banners();
                break;
            case 'update attributes':
                $response = $this->sync_attributes();
                break;
            case 'update options':
                $response = $this->sync_options();
                break;
            case 'update categories':
                $response = $this->sync_categories();
                break;
            case 'update informations':
                $response = $this->sync_informations();
                break;
            case 'update news':
                $response = $this->sync_news();
                break;
            case 'clear cache':
                $response = $this->clear_remote_cache();
                break;
            default:
                $output = $this->exec($cmd);
                $response['status'] = 'ok';
                $response['message'] = $output;
                break;
        }

        return $response;
    }

    private function prepare_dirs() {
        $dumps_dir = $_SERVER['DOCUMENT_ROOT'] . '/' . self::DUMPS_DIR;

        if (!file_exists($dumps_dir) || !is_writable($dumps_dir)) {
            return false;
        }

        if (!file_exists($dumps_dir . '/' .$this->subdir)) {
            @mkdir($dumps_dir . '/' .$this->subdir, 0777);
        }
        if (!file_exists($dumps_dir . '/' .$this->subdir) || !is_writable($dumps_dir . '/' .$this->subdir)) {
            return false;
        }

        return true;
    }

    private function dump_local() {
        if (!$this->prepare_dirs()) {
            return array(
                'status' => 'error',
                'message' => 'Директория '.self::DUMPS_DIR.' не доступна для записи'
            );
        }

        $this->log('#');
        $this->log('#       '.date('d.m.Y H:i:s'));
        $this->log('###########################################################');
        $this->log('#');
        $this->log('#');
        $this->log('-- Local dump --');

        $filename = $_SERVER['DOCUMENT_ROOT'] . '/' . self::DUMPS_DIR . '/' . $this->subdir .'/'. DB_DATABASE.'.sql';
        //if (file_exists($filename)) @unlink($filename);
        //if (file_exists($filename.'.gz')) @unlink($filename.'.gz');
        if (file_exists($filename) || file_exists($filename.'.gz')) {
            return array(
                'status' => 'ok',
                'message' => 'Дамп уже снят'
            );
        }
        $output = $this->dump(DB_DATABASE, DB_USERNAME, DB_PASSWORD, $filename);

        if (file_exists($filename) && filesize($filename)>0) {
            $exec = 'gzip '.$filename;
            $output .= $this->exec($exec);
            return array(
                'status' => 'ok',
                'message' => $output
            );
        } else {
            return array(
                'status' => 'error',
                'message' => $output
            );
        }
    }

    private function dump_remote() {
        if (!$this->prepare_dirs()) {
            return array(
                'status' => 'error',
                'message' => 'Директория '.self::DUMPS_DIR.' не доступна для записи'
            );
        }

        $this->log('-- Remote dump --');

        $filename = $_SERVER['DOCUMENT_ROOT'] . '/' . self::DUMPS_DIR . '/' . $this->subdir .'/'. self::REMOTE_DB_NAME.'.sql';
        //if (file_exists($filename)) @unlink($filename);
        //if (file_exists($filename.'.gz')) @unlink($filename.'.gz');
        if (file_exists($filename) || file_exists($filename.'.gz')) {
            return array(
                'status' => 'ok',
                'message' => 'Дамп уже снят'
            );
        }
        $output = $this->dump(self::REMOTE_DB_NAME, self::REMOTE_DB_USER, self::REMOTE_DB_PASSWORD, $filename, self::REMOTE_DB_HOST);

        if (file_exists($filename) && filesize($filename)>0) {
            $exec = 'gzip '.$filename;
            $output .= $this->exec($exec);
            return array(
                'status' => 'ok',
                'message' => $output
            );
        } else {
            return array(
                'status' => 'error',
                'message' => $output
            );
        }
    }

    private function sync_products_step_1() {
        return $this->sync_tables_step_1('products');
    }

    private function sync_tables_step_1($type) {
        $this->finalize($type);

        if (!$this->prepare_dirs()) {
            return array(
                'status' => 'error',
                'message' => 'Директория '.self::DUMPS_DIR.' не доступна для записи'
            );
        }

        $this->log('-- Sync '.$type.' --');

        $primary_table = $this->get_sync_primary_table($type);
        $primary_key = $this->get_sync_primary_key($type);
        $image_tables = $this->get_sync_image_tables($type);
        $image_key = $this->get_sync_image_key($type);

        if (empty($primary_key) || empty($primary_table)) {
            return array(
                'status' => 'error',
                'message' => 'Неверный тип синхронизации'
            );
        }

        $output = '';
        $query=$this->db->query('SELECT MAX('.$primary_key.') as '.$primary_key.' FROM `'.DB_PREFIX.$primary_table.'`');
        if (empty($query->row[$primary_key])) {
            return array(
                'status' => 'error',
                'message' => 'Невозможно определить строки для синхронизации'
            );
        }
        $local_max_id = $query->row[$primary_key];
        $this->log('Local MAX('.$primary_key.') = '.$local_max_id);

        $_SESSION[$type.'_local_max_id'] = $local_max_id;

        try {
            $mysqli = new mysqli(self::REMOTE_DB_HOST, self::REMOTE_DB_USER, self::REMOTE_DB_PASSWORD, self::REMOTE_DB_NAME);

            if ($mysqli->connect_errno) {
                throw new Exception($mysqli->connect_error);
            }

            $res=$mysqli->query('SELECT MAX('.$primary_key.') as '.$primary_key.' FROM `'.DB_PREFIX.$primary_table.'`');
            $row = $res->fetch_assoc();

            if (empty($row[$primary_key])) {
                throw new Exception('Невозможно определить строки для синхронизации');
            }

            $remote_max_id = $row[$primary_key];
            $this->log('Remote MAX('.$primary_key.') = '.$remote_max_id);

            if ($local_max_id<=$remote_max_id) {
                return array(
                    'status' => 'ok',
                    'message' => 'Строки для синхронизации не найдены'
                );
            }

            $_SESSION[$type.'_remote_max_id'] = $remote_max_id;

            $mysqli->close();

            $images = array();

            if (!empty($image_key) && !empty($image_tables)) {
                if (!is_array($image_tables)) $image_tables = array($image_tables);

                foreach($image_tables as $image_table) {
                    $query = $this->db->query("SELECT ".$image_key.", ".$primary_key." FROM `".DB_PREFIX.$image_table."` WHERE ".$primary_key.">".intval($remote_max_id));

                    foreach($query->rows as $row) {
                        if (empty($row[$image_key])) continue;
                        if (!file_exists($_SERVER['DOCUMENT_ROOT'].'/'.self::IMAGES_DIR.'/'.$row[$image_key])) {
                            $this->log('File not found: '.$row[$image_key].' (id='.$row[$primary_key].')');
                            throw new Exception('Файл не найден: '.$row[$image_key].' (id='.$row[$primary_key].')');
                        }
                        if (in_array($row[$image_key], $images)) continue;
                        $images[]= $row[$image_key];
                    }
                }

                $_SESSION[$type.'_local_images'] = $images;

                $this->log('Found images: '.count($images));
                $output = 'Найдено файлов: '.count($images);
            }
        } catch(Exception $e) {
            return array(
                'status' => 'error',
                'message' => $e->getMessage()
            );
        }

        return array(
            'status' => 'ok',
            'message' => $output
        );
    }

    private function sync_products_step_2($offset) {
        return $this->sync_tables_step_2('products',$offset);
    }

    private function sync_tables_step_2($type,$offset = null) {
        if (!$this->prepare_dirs()) {
            return array(
                'status' => 'error',
                'message' => 'Директория '.self::DUMPS_DIR.' не доступна для записи'
            );
        }

        $output = '';

        if (empty($_SESSION[$type.'_remote_max_id'])) {
            return array(
                'status' => 'ok',
                'message' => ''
            );
        }

        $remote_max_id = $_SESSION[$type.'_remote_max_id'];

        if (!empty($_SESSION[$type.'_local_images']) && is_array($_SESSION[$type.'_local_images'])) {
            $images = $_SESSION[$type.'_local_images'];
        }

        if (empty($images)) {
            return array(
                'status' => 'ok',
                'message' => 'Нет файлов для загрузки'
            );
        }

        if ($offset===null) {
            return array(
                'status' => 'ok',
                'message' => $output,
                'data' => 0,
                'content' => $images[0]
            );
        } else if (count($images)>$offset) {
            $output = '';
            if (!$this->ftp_upload($images[$offset], $output)) {
                return array(
                    'status' => 'error',
                    'message' => $output,
                    'data' => $offset,
                    'content' => $images[$offset]
                );
            }

            $offset++;
            if (count($images)>$offset) {
                return array(
                    'status' => 'ok',
                    'message' => $output,
                    'data' => $offset,
                    'content' => $images[$offset]
                );
            }
        }

        return array(
            'status' => 'ok',
            'message' => $output
        );
    }

    private function sync_products_step_3() {
        return $this->sync_tables_step_3('products');
    }

    private function sync_tables_step_3($type) {
        if (!$this->prepare_dirs()) {
            return array(
                'status' => 'error',
                'message' => 'Директория '.self::DUMPS_DIR.' не доступна для записи'
            );
        }

        if (empty($_SESSION[$type.'_local_max_id'])) {
            return array(
                'status' => 'error',
                'message' => 'Ошибка сессии'
            );
        }

        if (empty($_SESSION[$type.'_remote_max_id'])) {
            return array(
                'status' => 'ok',
                'message' => ''
            );
        }

        $this->log('-- Sync new rows --');

        $remote_max_id = $_SESSION[$type.'_remote_max_id'];
        $local_max_id = $_SESSION[$type.'_local_max_id'];

        $output = '';

        $sync_tables = $this->get_sync_tables($type);
        $primary_key = $this->get_sync_primary_key($type);
        $primary_table = $this->get_sync_primary_table($type);

        $inserts = $this->generate_inserts($sync_tables,$primary_key.'>'.$remote_max_id,$primary_key);

        if (empty($inserts)) {
            return array(
                'status' => 'error',
                'message' => 'Ошибка при генерации запросов'
            );
        }

        $mysqli = new mysqli(self::REMOTE_DB_HOST, self::REMOTE_DB_USER, self::REMOTE_DB_PASSWORD, self::REMOTE_DB_NAME);

        if ($mysqli->connect_errno) {
            return array(
                'status' => 'error',
                'message' => 'Ошибка б.д. '.$mysqli->connect_error
            );
        }

        $this->log('Executing generated SQL:');
        $this->log(implode("\r\n",$inserts));

        foreach($inserts as $insert) {
            if (!$mysqli->query($insert)) {
                return array(
                    'status' => 'error',
                    'message' => 'Ошибка б.д: '.mysqli_error($mysqli).' - Запрос: '.$insert
                );
            }
        }

        $res=$mysqli->query('SELECT MAX('.$primary_key.') as '.$primary_key.' FROM `'.DB_PREFIX.$primary_table.'`');
        $row = $res->fetch_assoc();

        if (empty($row[$primary_key])) {
            return array(
                'status' => 'error',
                'message' => 'Невозможно проверить обновление строк'
            );
        }

        $new_remote_max_id = $row[$primary_key];
        $this->log('Remote new MAX('.$primary_key.') = '.$new_remote_max_id);

        if ($new_remote_max_id != $local_max_id) {
            return array(
                'status' => 'error',
                'message' => 'Ошибка обновления строк'
            );
        }

        $mysqli->close();

        if (!empty($output)) $output .= '<br />';
        $output .= 'Строки обновлены до id='.$new_remote_max_id;

//        $this->finalize($type);
//        $_SESSION[$type.'_local_max_id'] = $local_max_id;

        return array(
            'status' => 'ok',
            'message' => $output
        );
    }

    private function sync_products_step_4() {
        return $this->sync_tables_step_4('products');
    }

    private function sync_tables_step_4($type) {
        if (!$this->prepare_dirs()) {
            return array(
                'status' => 'error',
                'message' => 'Директория '.self::DUMPS_DIR.' не доступна для записи'
            );
        }

        if (empty($_SESSION[$type.'_local_max_id'])) {
            return array(
                'status' => 'error',
                'message' => 'Ошибка сессии'
            );
        }

        $this->log('-- Sync existing --');

        $local_max_id = $_SESSION[$type.'_local_max_id'];

        if (!empty($_SESSION[$type.'_remote_max_id'])) {
            $remote_max_id = $_SESSION[$type.'_remote_max_id'];
        } else {
            $remote_max_id = $local_max_id;
        }

        $mysqli = new mysqli(self::REMOTE_DB_HOST, self::REMOTE_DB_USER, self::REMOTE_DB_PASSWORD, self::REMOTE_DB_NAME);

        if ($mysqli->connect_errno) {
            return array(
                'status' => 'error',
                'message' => 'Ошибка б.д. '.$mysqli->connect_error
            );
        }

        $mysqli->query("SET NAMES utf8");

        $output = '';

        $modified_tables = $this->get_sync_modified_tables($type);
        $primary_table = $this->get_sync_primary_table($type);
        $primary_key = $this->get_sync_primary_key($type);
        $modified_keys = $this->get_sync_modified_keys($type);
        $sync_tables = $this->get_sync_tables($type);
        $image_tables = $this->get_sync_image_tables($type);
        $image_key = $this->get_sync_image_key($type);

        if (empty($modified_tables) || empty($primary_key) || empty($primary_table) || empty($modified_keys) || empty($sync_tables)) {
            return array(
                'status' => 'error',
                'message' => 'Неверный тип синхронизации'
            );
        }

        if (!is_array($modified_tables)) $modified_tables = array($modified_tables);
        if (!is_array($modified_keys)) $modified_keys = array($modified_keys);

        $modified_ids = array();
        $limit = 100;
        $this->log('Checking modified rows:');

        foreach($modified_tables as $modified_table) {
            $offset = 0;
            $columns = array();
            $query=$this->db->query("SHOW COLUMNS FROM `".$modified_table.'`');
            foreach($query->rows as $row) {
                if (in_array($row['Field'], $modified_keys)) {
                    $columns[] = $row['Field'];
                }
            }
            $query = $this->db->query("SHOW INDEX FROM `".DB_PREFIX.$modified_table."` WHERE Key_name = 'PRIMARY'");
            $primary_keys = array();
            foreach ($query->rows as $row) {
                $primary_keys[]=$row['Column_name'];
            }
            if (!in_array($primary_key,$primary_keys)) $primary_keys[]=$primary_key;
            do {
                $query_str = 'SELECT `'.implode('`, `',$columns).'`, `'.implode('`, `',$primary_keys).'` FROM `'.DB_PREFIX.$modified_table.'` WHERE '.$primary_key.'<='.$remote_max_id.' ORDER BY '.$primary_key.' ASC LIMIT '.$limit.' OFFSET '.$offset;
                $this->log($query_str);
                $query=$this->db->query($query_str);

                $checking_ids = array();
                $checking_rows = array();
                $checking_primaries = array();
                foreach ($query->rows as $row) {
                    $index = '';
                    foreach($primary_keys as $key) {
                        if (!empty($index)) $index.='-';
                        $index.=$row[$key];
                    }
                    if (!in_array($row[$primary_key],$checking_ids)) $checking_ids[]=$row[$primary_key];
                    $checking_rows[$index] = $row;
                    $checking_primaries[$index] = $row[$primary_key];
                }

                if (empty($checking_ids)) break;

                $query_str = 'SELECT `'.implode('`, `',$columns).'`, `'.implode('`, `',$primary_keys).'` FROM `'.DB_PREFIX.$modified_table."` WHERE ".$primary_key." IN ('".implode("', '",$checking_ids)."') ORDER BY ".$primary_key.' ASC ';
                $this->log($query_str);

                $remote_ids = array();
                $remote_rows = array();
                $remote_primaries = array();
                $res=$mysqli->query($query_str);
                while ($row = $res->fetch_assoc()) {
                    $index = '';
                    foreach($primary_keys as $key) {
                        if (!empty($index)) $index.='-';
                        $index.=$row[$key];
                    }
                    if (!in_array($row[$primary_key],$remote_ids)) $remote_ids[] = $row[$primary_key];
                    $remote_rows[$index] = $row;
                    $remote_primaries[$index] = $row[$primary_key];
                }

                foreach ($checking_rows as $index=>$row) {
                    $primary = $checking_primaries[$index];
                    $local = $row;
                    if (!array_key_exists($index, $remote_rows)) {
                        if ($modified_table == $primary_table) {
                            // recreate row ?
                            continue;
                        }
                        if (in_array($primary,$modified_ids)) continue;
                        $modified_ids[]=$primary;
                        $this->log('Found modified row: id='.$primary);
                        continue;
                    }

                    $remote = $remote_rows[$index];
                    foreach($columns as $key) {
                        if ($local[$key]!=$remote[$key]) {
                            if (in_array($primary,$modified_ids)) break;
                            $modified_ids[]=$primary;
                            $this->log('Found modified row: id='.$primary.', column='.$key);
                            break;
                        }
                    }
                }

                $offset += $limit;
            } while (count($query->rows)>0);
        }

        if (empty($modified_ids)) {
            return array(
                'status' => 'ok',
                'message' => ''
            );
        }

        $_SESSION[$type.'_local_modified_ids'] = $modified_ids;

        $images = array();

        if (!empty($image_key) && !empty($image_tables)) {
            if (!is_array($image_tables)) $image_tables = array($image_tables);

            $local_images=array();
            foreach ($modified_ids as $id) {
                foreach($image_tables as $image_table) {
                    $query = $this->db->query("SELECT ".$image_key.", ".$primary_key." FROM `".DB_PREFIX.$image_table."` WHERE ".$primary_key."=".intval($id));

                    foreach($query->rows as $row) {
                        if (empty($row[$image_key])) continue;
                        if (!file_exists($_SERVER['DOCUMENT_ROOT'].'/'.self::IMAGES_DIR.'/'.$row[$image_key])) {
                            $this->log('File not found: '.$row[$image_key].' (id='.$row[$primary_key].')');
                            throw new Exception('Файл не найден: '.$row[$image_key].' (id='.$row[$primary_key].')');
                        }
                        if (in_array($row[$image_key], $local_images)) continue;
                        $local_images[]= $row[$image_key];
                    }
                }
            }

            $remote_images=array();
            foreach ($modified_ids as $id) {
                foreach($image_tables as $image_table) {
                    $res = $mysqli->query("SELECT ".$image_key.", ".$primary_key." FROM `".DB_PREFIX.$image_table."` WHERE ".$primary_key."=".intval($id));

                    while($row=$res->fetch_assoc()) {
                        if (empty($row[$image_key])) continue;
                        if (!file_exists($_SERVER['DOCUMENT_ROOT'].'/'.self::IMAGES_DIR.'/'.$row[$image_key])) {
                            $this->log('File not found: '.$row[$image_key].' (id='.$row[$primary_key].')');
                            throw new Exception('Файл не найден: '.$row[$image_key].' (id='.$row[$primary_key].')');
                        }
                        if (in_array($row[$image_key], $remote_images)) continue;
                        $remote_images[]= $row[$image_key];
                    }
                }
            }

            foreach($local_images as $image) {
                if (!in_array($image, $remote_images)) {
                    $images[] = $image;
                }
            }

            $_SESSION[$type.'_existing_local_images'] = $images;

            $this->log('Found images: '.count($images));
            $output = 'Найдено файлов: '.count($images);
        }

        $mysqli->close();

        return array(
            'status' => 'ok',
            'message' => $output
        );
    }

    private function sync_products_step_5($offset) {
        return $this->sync_tables_step_5('products',$offset);
    }

    private function sync_tables_step_5($type,$offset=null) {
        if (!$this->prepare_dirs()) {
            return array(
                'status' => 'error',
                'message' => 'Директория '.self::DUMPS_DIR.' не доступна для записи'
            );
        }

        $output = '';

        if (empty($_SESSION[$type.'_local_modified_ids'])) {
            return array(
                'status' => 'ok',
                'message' => ''
            );
        }

        $modified_ids = $_SESSION[$type.'_local_modified_ids'];

        if (!empty($_SESSION[$type.'_existing_local_images']) && is_array($_SESSION[$type.'_existing_local_images'])) {
            $images = $_SESSION[$type.'_existing_local_images'];
        }

        if (empty($images)) {
            return array(
                'status' => 'ok',
                'message' => 'Нет файлов для загрузки'
            );
        }

        if ($offset===null) {
            return array(
                'status' => 'ok',
                'message' => $output,
                'data' => 0,
                'content' => $images[0]
            );
        } else if (count($images)>$offset) {
            $output = '';
            if (!$this->ftp_upload($images[$offset], $output)) {
                return array(
                    'status' => 'error',
                    'message' => $output,
                    'data' => $offset,
                    'content' => $images[$offset]
                );
            }

            $offset++;
            if (count($images)>$offset) {
                return array(
                    'status' => 'ok',
                    'message' => $output,
                    'data' => $offset,
                    'content' => $images[$offset]
                );
            }
        }

        return array(
            'status' => 'ok',
            'message' => $output
        );
    }

    private function sync_products_step_6() {
        return $this->sync_tables_step_6('products');
    }

    private function sync_tables_step_6($type) {
        $output = '';

        if (empty($_SESSION[$type.'_local_modified_ids'])) {
            return array(
                'status' => 'ok',
                'message' => ''
            );
        }

        $this->log('-- Sync existing rows --');

        $modified_ids = $_SESSION[$type.'_local_modified_ids'];

        $primary_key = $this->get_sync_primary_key($type);
        $primary_table = $this->get_sync_primary_table($type);
        $sync_tables = $this->get_sync_tables($type);

        if (empty($primary_key) || empty($primary_table) || empty($sync_tables)) {
            return array(
                'status' => 'error',
                'message' => 'Неверный тип синхронизации'
            );
        }

        $mysqli = new mysqli(self::REMOTE_DB_HOST, self::REMOTE_DB_USER, self::REMOTE_DB_PASSWORD, self::REMOTE_DB_NAME);

        if ($mysqli->connect_errno) {
            return array(
                'status' => 'error',
                'message' => 'Ошибка б.д. '.$mysqli->connect_error
            );
        }

        if (!is_array($sync_tables)) $sync_tables = array($sync_tables);

        $_sync_tables = array();
        foreach($sync_tables as $table) {
            if ($table == $primary_table) continue;
            $_sync_tables[] = $table;
        }

        $updates = array();
        foreach ($modified_ids as $id) {
            $_updates = $this->generate_updates($primary_table,$primary_key.'='.$id);
            $updates = array_merge($updates, $_updates);
            $_updates = $this->generate_deletes($_sync_tables,$primary_key.'='.$id);
            $updates = array_merge($updates, $_updates);
            $_updates = $this->generate_inserts($_sync_tables,$primary_key.'='.$id,$primary_key);
            $updates = array_merge($updates, $_updates);
        }

        if (empty($updates)) {
            return array(
                'status' => 'error',
                'message' => 'Ошибка при генерации запросов'
            );
        }

        $this->log('Executing generated SQL:');
        $this->log(implode("\r\n",$updates));

        foreach($updates as $update) {
            if (!$mysqli->query($update)) {
                return array(
                    'status' => 'error',
                    'message' => 'Ошибка б.д: '.mysqli_error($mysqli).' - Запрос: '.$update
                );
            }
        }


        if (!empty($output)) $output .= '<br />';
        $output .= 'Объекты обновлены';

        return array(
            'status' => 'ok',
            'message' => $output
        );
    }

    private function sync_products_step_7() {
        return $this->sync_tables_step_7('products');
    }

    private function sync_tables_step_7($type) {
        $output = '';

        if (empty($_SESSION[$type.'_local_max_id'])) {
            return array(
                'status' => 'error',
                'message' => 'Ошибка сессии'
            );
        }

        $this->log('-- Sync deleted rows --');

        $local_max_id = $_SESSION[$type.'_local_max_id'];

        if (!empty($_SESSION[$type.'_remote_max_id'])) {
            $remote_max_id = $_SESSION[$type.'_remote_max_id'];
        } else {
            $remote_max_id = 0;
        }

        $deleted_ids = array();

        $primary_key = $this->get_sync_primary_key($type);
        $primary_table = $this->get_sync_primary_table($type);
        $sync_tables = $this->get_sync_tables($type);

        if (empty($primary_key) || empty($primary_table) || empty($sync_tables)) {
            return array(
                'status' => 'error',
                'message' => 'Неверный тип синхронизации'
            );
        }

        $mysqli = new mysqli(self::REMOTE_DB_HOST, self::REMOTE_DB_USER, self::REMOTE_DB_PASSWORD, self::REMOTE_DB_NAME);

        if ($mysqli->connect_errno) {
            return array(
                'status' => 'error',
                'message' => 'Ошибка б.д. '.$mysqli->connect_error
            );
        }

        if (!is_array($sync_tables)) $sync_tables = array($sync_tables);

        $this->log('Checking deleted rows:');
        $deleted_ids = array();
        $limit = 100;
        $offset = 0;
        do {
            $query_str = 'SELECT `'.$primary_key.'` FROM `'.DB_PREFIX.$primary_table.'`';
            if (!empty($remote_max_id)) {
                $query_str .= ' WHERE '.$primary_key.'<='.$remote_max_id;
            }
            $query_str .= ' ORDER BY '.$primary_key.' ASC LIMIT '.$limit.' OFFSET '.$offset;

            $this->log($query_str);

            $remote_ids = array();
            $remote_rows = array();

            $res=$mysqli->query($query_str);
            while ($row = $res->fetch_assoc()) {
                $remote_ids[] = $row[$primary_key];
                $remote_rows[$row[$primary_key]] = $row;
            }

            if (empty($remote_ids)) break;

            $query_str = 'SELECT  `'.$primary_key.'` FROM `'.DB_PREFIX.$primary_table."` WHERE ".$primary_key." IN ('".implode("', '",$remote_ids)."') ORDER BY ".$primary_key.' ASC ';
            $this->log($query_str);

            $query=$this->db->query($query_str);

            $checking_ids = array();
            $checking_rows = array();
            foreach ($query->rows as $row) {
                $checking_ids[]=$row[$primary_key];
                $checking_rows[$row[$primary_key]] = $row;
            }

            foreach($remote_ids as $id) {
                if (!in_array($id, $checking_ids)) {
                    $deleted_ids[]=$id;
                }
            }

            $offset += $limit;
        } while (!empty($remote_ids));

        if (empty($deleted_ids)) {
            $this->finalize($type);

            return array(
                'status' => 'ok',
                'message' => ''
            );
        }

        $deletes = array();
        foreach ($deleted_ids as $id) {
            $_deletes = $this->generate_deletes($sync_tables,$primary_key.'='.$id);
            $deletes = array_merge($deletes, $_deletes);
        }

        if (empty($deletes)) {
            return array(
                'status' => 'error',
                'message' => 'Ошибка при генерации запросов'
            );
        }

        $this->log('Executing generated SQL:');
        $this->log(implode("\r\n",$deletes));

        foreach($deletes as $delete) {
            if (!$mysqli->query($delete)) {
                return array(
                    'status' => 'error',
                    'message' => 'Ошибка б.д: '.mysqli_error($mysqli).' - Запрос: '.$delete
                );
            }
        }


        if (!empty($output)) $output .= '<br />';
        $output .= 'Строки удалены';

        $this->finalize($type);

        return array(
            'status' => 'ok',
            'message' => $output
        );
    }

    private function sync_seo_urls() {
        $output = $this->sync_type('urlaliases');
        if ($output['status']=='error') return $output;
        $output['message'] = 'Адреса обновлены';
        return $output;
    }

    private function sync_banners() {
        $output = $this->sync_type('banners');
        if ($output['status']=='error') return $output;

        $banner_settings = '';
        $query = $this->db->query("SELECT * FROM `".DB_PREFIX."setting` WHERE `key`='banner_module'");
        if (!empty($query->row)) {
            $banner_settings = $query->row['value'];
        }

        $mysqli = new mysqli(self::REMOTE_DB_HOST, self::REMOTE_DB_USER, self::REMOTE_DB_PASSWORD, self::REMOTE_DB_NAME);

        if ($mysqli->connect_errno) {
            return array(
                'status' => 'error',
                'message' => 'Ошибка б.д. '.$mysqli->connect_error
            );
        }

        if (!empty($banner_settings)) {
            $query_str="UPDATE ".DB_PREFIX."setting SET `value`='".$this->db->escape($banner_settings)."' WHERE `key` = 'banner_module'";
        } else {
            $query_str="DELETE FROM `".DB_PREFIX."setting` WHERE `key` = 'banner_module'";
        }

        $this->log('Updating banner settings:');
        $this->log($query_str);

        $mysqli->query($query_str);

        $mysqli->close();

        $output['message'] = 'Баннеры обновлены';
        return $output;
    }

    private function sync_attributes() {
        $output = $this->sync_type('attribute_groups');
        if ($output['status']=='error') return $output;
        $output = $this->sync_type('attributes');
        if ($output['status']=='error') return $output;
        $output['message'] = 'Атрибуты обновлены';
        return $output;
    }

    private function sync_options() {
        $output = $this->sync_type('options');
        if ($output['status']=='error') return $output;
        $output['message'] = 'Опции обновлены';
        return $output;
    }

    private function sync_categories() {
        $output = $this->sync_type('categories');
        if ($output['status']=='error') return $output;
        $output['message'] = 'Категории обновлены';
        return $output;
    }

    private function sync_informations() {
        $output = $this->sync_type('informations');
        if ($output['status']=='error') return $output;
        $output['message'] = 'Страницы обновлены';
        return $output;
    }

    private function sync_news() {
        $output = $this->sync_type('news');
        if ($output['status']=='error') return $output;
        $output['message'] = 'Новости обновлены';
        return $output;
    }

    private function sync_type($type) {
        $output = $this->sync_tables_step_1($type);
        if ($output['status']=='error') {
            return $output;
        }
        $message = $output['message'];

        $output = $this->sync_tables_step_2($type);
        $output['message'] = !empty($message) && !empty($output['message']) ? $message.'<br />'.$output['message'] : $message.$output['message'];

        if ($output['status']=='error') {
            return $output;
        }
        $message = $output['message'];

        if (isset($output['data'])) {
            $offset = 0;
            $iteration = 0;
            do {
                $_output = $this->sync_tables_step_2($type,$offset);
                $_output['message'] = !empty($message) && !empty($_output['message']) ? $message.'<br />'.$_output['message'] : $message.$_output['message'];

                if ($_output['status']=='error') {
                    return $_output;
                }
                $message = $_output['message'];

                if (!empty($_output['data'])) $offset = $_output['data'];
                else break;

                $iteration++;
                if ($iteration>99999) break;
            } while(true);
        }

        $output = $this->sync_tables_step_3($type);
        $output['message'] = !empty($message) && !empty($output['message']) ? $message.'<br />'.$output['message'] : $message.$output['message'];

        if ($output['status']=='error') {
            return $output;
        }
        $message = $output['message'];

        $output = $this->sync_tables_step_4($type);
        $output['message'] = !empty($message) && !empty($output['message']) ? $message.'<br />'.$output['message'] : $message.$output['message'];

        if ($output['status']=='error') {
            return $output;
        }
        $message = $output['message'];

        $output = $this->sync_tables_step_5($type);
        $output['message'] = !empty($message) && !empty($output['message']) ? $message.'<br />'.$output['message'] : $message.$output['message'];

        if ($output['status']=='error') {
            return $output;
        }
        $message = $output['message'];

        if (isset($output['data'])) {
            $offset = 0;
            $iteration = 0;
            do {
                $_output = $this->sync_tables_step_5($type,$offset);
                $_output['message'] = !empty($message) && !empty($_output['message']) ? $message.'<br />'.$_output['message'] : $message.$_output['message'];

                if ($_output['status']=='error') {
                    return $_output;
                }
                $message = $_output['message'];

                if (!empty($_output['data'])) $offset = $_output['data'];
                else break;

                $iteration++;
                if ($iteration>99999) break;
            } while(true);
        }

        $output = $this->sync_tables_step_6($type);
        $output['message'] = !empty($message) && !empty($output['message']) ? $message.'<br />'.$output['message'] : $message.$output['message'];

        if ($output['status']=='error') {
            return $output;
        }
        $message = $output['message'];

        $output = $this->sync_tables_step_7($type);
        $output['message'] = !empty($message) && !empty($output['message']) ? $message.'<br />'.$output['message'] : $message.$output['message'];

        return $output;
    }

    private function clear_remote_cache() {
        $output = '';

        if (!$this->ftp_clear_cache($output)) {
            return array(
                'status' => 'error',
                'message' => $output
            );
        }

        $output = 'Кэш очищен';

        return array(
            'status' => 'ok',
            'message' => $output
        );
    }

    private function ftp_upload($file, &$output) {
        $ftp = @ftp_connect(self::REMOTE_FTP_HOST);
        if (!$ftp) {
            $output = 'Нет соединения';
            return false;
        }

        if (!@ftp_login($ftp, self::REMOTE_FTP_USER, self::REMOTE_FTP_PASSWORD)) {
            $output = 'Неверный логин или пароль';
            return false;
        }

        $this->log('FTP connected');

        $this->ftp_chdir($ftp, '/', false);
        if (!$this->ftp_chdir($ftp, explode('/',self::REMOTE_IMAGES_DIR), false)) {
            $output = 'Ошибка при смене директории';
            return false;
        }
        if (!$this->ftp_chdir($ftp, explode('/',dirname($file)))) {
            $output = 'Ошибка при смене директории';
            return false;
        }

        $this->log('FTP upload: '.$file);
        if (!@ftp_put($ftp, basename($file), $_SERVER['DOCUMENT_ROOT'].'/'.self::IMAGES_DIR.'/'.$file, FTP_BINARY)) {
            $output = 'Ошибка при загрузке';
            return false;
        }

        $remote_size = @ftp_size($ftp, basename($file));
        if ($remote_size != filesize($_SERVER['DOCUMENT_ROOT'].'/'.self::IMAGES_DIR.'/'.$file)) {
            $output = 'Размеры не совпадают';
            return false;
        }

        $this->log('* uploaded file size: '.$remote_size);
        $output = 'Размер загруженного файла: '.round($remote_size/1024).' кБ';

        @ftp_close($ftp);

        $this->log('FTP disconnected');

        return true;
    }

    private function ftp_chdir($ftp, $dirs, $createIfNotExists = true) {
        if (!is_array($dirs)) $dirs = array($dirs);
        foreach ($dirs as $dir) {
            $this->log('FTP chdir: '.$dir);
            if (!@ftp_chdir($ftp, $dir)) {
                if ($createIfNotExists) {
                    $this->log('FTP mkdir: '.$dir);
                    @ftp_mkdir($ftp, $dir);
                    if (!ftp_chdir($ftp, $dir)) return false;
                } else {
                    return false;
                }
            }
        }

        return true;
    }

    private function ftp_clear_cache(&$output) {
        $ftp = @ftp_connect(self::REMOTE_FTP_HOST);
        if (!$ftp) {
            $output = 'Нет соединения';
            return false;
        }

        if (!@ftp_login($ftp, self::REMOTE_FTP_USER, self::REMOTE_FTP_PASSWORD)) {
            $output = 'Неверный логин или пароль';
            return false;
        }

        $this->log('FTP connected');

        $this->ftp_chdir($ftp, '/', false);
        if (!$this->ftp_chdir($ftp, explode('/',self::REMOTE_CACHE_DIR), false)) {
            $output = 'Ошибка при смене директории';
            return false;
        }

        $files = @ftp_nlist($ftp, '.');

        if (!empty($files) && is_array($files)) {
            foreach($files as $file) {
                if ($file == '.' || $file == '..') continue;
                if (strpos($file,'cache.')===false) continue;
                if (!@ftp_delete($ftp, $file)) {
                    $output = 'Ошибка при удалении файла '.$file;
                    return false;
                }
                $this->log('FTP delete: '.$file);
            }
        }

        @ftp_close($ftp);

        $this->log('FTP disconnected');

        return true;
    }

    private function dump($db_name, $db_user, $db_password, $filename=null, $host = null, $tables = array(),$where = null,$nocreate=false,$quick=false) {
        $host_str = '';
        if (!empty($host)) $host_str = ' -h '.$host;
        $tables_str = '';
        if (!empty($tables)) $tables_str = ' '.implode(' ',$tables);
        $where_str = '';
        if (!empty($where)) $where_str = " --where='".$where."'";
        $filename_str = '';
        $nocreate_str = '';
        if ($nocreate) $nocreate_str = ' --no-create-db --no-create-info';
        if (!empty($filename)) $filename_str = ' -r '.$filename;
        $quick_str = '';
        if (!empty($quick)) $quick_str = ' -q';
        $exec_str = 'mysqldump'.$host_str.' -u '.$db_user.' -p'.$db_password.' -f'.$quick_str.$nocreate_str.' --default-character-set=utf8 --skip-comments'.$filename_str.' '.$db_name.$tables_str.$where_str;

        return $this->exec($exec_str);
    }

    private function generate_inserts($tables,$where,$primary_key) {
        if (!is_array($tables)) $tables = array($tables);
        $output = array();
        $output []= 'SET NAMES utf8;';
        foreach ($tables as $table) {
            $columns = array();
            $query = $this->db->query("SHOW COLUMNS FROM `".DB_PREFIX.$table.'`');
            foreach ($query->rows as $row) {
                $columns[]=$row['Field'];
            }
            if (empty($columns)) continue;
            $query = $this->db->query("SELECT * FROM `".DB_PREFIX.$table."` WHERE ".$where." ORDER BY ".$primary_key." ASC");
            if (empty($query->rows)) continue;
            $output []= "LOCK TABLES `".DB_PREFIX.$table."` WRITE;";
            $_output = "INSERT INTO `".DB_PREFIX.$table."` (`".implode('`,`',$columns)."`) VALUES ";
            $first_val = true;
            foreach ($query->rows as $row) {
                if (!$first_val) $_output .= ", ";
                foreach($row as $k=>$v) {
                    $row[$k] = $this->db->escape($v);
                }
                $_output .= "('".implode("','",$row)."')";
                $first_val = false;
            }
            $_output .= ";";
            $output []= $_output;
            $output []= "UNLOCK TABLES;";
        }
        return $output;
    }

    private function generate_updates($tables,$where) {
        if (!is_array($tables)) $tables = array($tables);
        $output = array();
        $output []= 'SET NAMES utf8;';
        foreach ($tables as $table) {
            $query = $this->db->query("SHOW INDEX FROM `".DB_PREFIX.$table."` WHERE Key_name = 'PRIMARY'");
            $primary_keys = array();
            foreach ($query->rows as $row) {
                $primary_keys[]=$row['Column_name'];
            }
            $columns = array();
            $query = $this->db->query("SHOW COLUMNS FROM `".DB_PREFIX.$table.'`');
            foreach ($query->rows as $row) {
                $columns[]=$row['Field'];
            }
            if (empty($columns)) continue;
            $query = $this->db->query("SELECT * FROM `".DB_PREFIX.$table."` WHERE ".$where);
            if (empty($query->rows)) continue;
            $output []= "LOCK TABLES `".DB_PREFIX.$table."` WRITE;";

            foreach ($query->rows as $row) {
                $_output = "UPDATE `".DB_PREFIX.$table."` SET ";
                $first_column=true;
                foreach ($columns as $column) {
                    if (in_array($column,$primary_keys)) continue;
                    if (!$first_column) $_output .= ", ";
                    $_output .= "`".$column."`='".$this->db->escape($row[$column])."'";
                    $first_column = false;
                }
                $_output .= " WHERE ".$where.";";
            }

            $output []= $_output;
            $output []= "UNLOCK TABLES;";
        }
        return $output;
    }

    private function generate_deletes($tables,$where) {
        if (!is_array($tables)) $tables = array($tables);
        $output = array();
        foreach ($tables as $table) {
            $output []= "LOCK TABLES `".DB_PREFIX.$table."` WRITE;";
            $output []= "DELETE FROM `".DB_PREFIX.$table."` WHERE ".$where.";";
            $output []= "UNLOCK TABLES;";
        }
        return $output;
    }

    private function exec($cmd) {
        $this->log($cmd);
        exec(trim($cmd)." 2>&1", $output);
        $this->log(implode("\r\n",$output));
        return implode('<br />',$output);
    }

    private function log($txt) {
        if (!$this->prepare_dirs()) return;

        $dumps_dir = $_SERVER['DOCUMENT_ROOT'] . '/' . self::DUMPS_DIR;
        $filename = 'log.txt';

        $f = fopen($dumps_dir . '/' . $this->subdir . '/' . $filename, 'a+');
        fwrite($f, $txt."\r\n");
        fclose($f);
    }

    private function finalize($type) {
        if (isset($_SESSION[$type.'_remote_max_id'])) unset($_SESSION[$type.'_remote_max_id']);
        if (isset($_SESSION[$type.'_local_max_id'])) unset($_SESSION[$type.'_local_max_id']);
        if (isset($_SESSION[$type.'_local_images'])) unset($_SESSION[$type.'_local_images']);
        if (isset($_SESSION[$type.'_local_modified_ids'])) unset($_SESSION[$type.'_local_modified_ids']);
        if (isset($_SESSION[$type.'_existing_local_images'])) unset($_SESSION[$type.'_existing_local_images']);
    }
}
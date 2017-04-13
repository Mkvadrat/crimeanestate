<?php
class ModelCatalogInformation extends Model {
	public function getInformation($information_id) {
		$query = $this->db->query("SELECT DISTINCT * FROM " . DB_PREFIX . "information i LEFT JOIN " . DB_PREFIX . "information_description id ON (i.information_id = id.information_id) LEFT JOIN " . DB_PREFIX . "information_to_store i2s ON (i.information_id = i2s.information_id) WHERE i.information_id = '" . (int)$information_id . "' AND id.language_id = '" . (int)$this->config->get('config_language_id') . "' AND i2s.store_id = '" . (int)$this->config->get('config_store_id') . "' AND i.status = '1'");
	
		return $query->row;
	}
	
	public function getInformations() {
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "information i LEFT JOIN " . DB_PREFIX . "information_description id ON (i.information_id = id.information_id) LEFT JOIN " . DB_PREFIX . "information_to_store i2s ON (i.information_id = i2s.information_id) WHERE id.language_id = '" . (int)$this->config->get('config_language_id') . "' AND i2s.store_id = '" . (int)$this->config->get('config_store_id') . "' AND i.status = '1' ORDER BY i.sort_order, LCASE(id.title) ASC");
		
		return $query->rows;
	}
	
	public function getInformationLayoutId($information_id) {
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "information_to_layout WHERE information_id = '" . (int)$information_id . "' AND store_id = '" . (int)$this->config->get('config_store_id') . "'");
		 
		if ($query->num_rows) {
			return $query->row['layout_id'];
		} else {
			return $this->config->get('config_layout_information');
		}
	}

    public function getBlogInformations($limit, $page) {
        $query = $this->db->query("SELECT * FROM " . DB_PREFIX . "information i LEFT JOIN " . DB_PREFIX . "information_description id ON (i.information_id = id.information_id) LEFT JOIN " . DB_PREFIX . "information_to_store i2s ON (i.information_id = i2s.information_id) WHERE id.language_id = '" . (int)$this->config->get('config_language_id') . "' AND i2s.store_id = '" . (int)$this->config->get('config_store_id') . "' AND i.status = '1' AND i.sort_order <> '-1' AND show_in_blog = '1' ORDER BY i.sort_order, date_added DESC LIMIT ".intval($limit)." OFFSET ".(intval($page)-1)*$limit);

        return $query->rows;
    }

    public function getBlogInformationsByType($type, $limit, $page) {
        $query = $this->db->query("SELECT * FROM " . DB_PREFIX . "information i LEFT JOIN " . DB_PREFIX . "information_description id ON (i.information_id = id.information_id) LEFT JOIN " . DB_PREFIX . "information_to_store i2s ON (i.information_id = i2s.information_id) WHERE id.language_id = '" . (int)$this->config->get('config_language_id') . "' AND i2s.store_id = '" . (int)$this->config->get('config_store_id') . "' AND i.status = '1' AND i.sort_order <> '-1' AND show_in_blog = '1' AND blog_type = '".intval($type)."' ORDER BY i.sort_order, date_added DESC LIMIT ".intval($limit)." OFFSET ".(intval($page)-1)*$limit);

        return $query->rows;
    }

    public function getBlogInformationsByCategory($cat, $limit, $page) {
        $query = $this->db->query("SELECT * FROM " . DB_PREFIX . "information i LEFT JOIN " . DB_PREFIX . "information_description id ON (i.information_id = id.information_id) LEFT JOIN " . DB_PREFIX . "information_to_store i2s ON (i.information_id = i2s.information_id) WHERE id.language_id = '" . (int)$this->config->get('config_language_id') . "' AND i2s.store_id = '" . (int)$this->config->get('config_store_id') . "' AND i.status = '1' AND i.sort_order <> '-1' AND show_in_blog = '1' AND blog_category = '".intval($cat)."' ORDER BY i.sort_order, date_added DESC LIMIT ".intval($limit)." OFFSET ".(intval($page)-1)*$limit);

        return $query->rows;
    }

    public function getBlogNews($results) {
        $articles = array();
        foreach ($results as $result) {
            $articles[] = array(
                'article_id'  => $result['news_id'],
                'title'        => $result['title'],
                'image'       => $result['image'],
                'description' => $result['description'],
                'date_added' => $result['date_added'],
                'href'        => $this->url->link('news/article' . '&news_id=' . $result['news_id'])
            );
        }
        return $articles;
    }

    public function getBlogInformationsCount() {
        $query = $this->db->query("SELECT count(*) as co FROM " . DB_PREFIX . "information i LEFT JOIN " . DB_PREFIX . "information_description id ON (i.information_id = id.information_id) LEFT JOIN " . DB_PREFIX . "information_to_store i2s ON (i.information_id = i2s.information_id) WHERE id.language_id = '" . (int)$this->config->get('config_language_id') . "' AND i2s.store_id = '" . (int)$this->config->get('config_store_id') . "' AND i.status = '1' AND i.sort_order <> '-1' AND show_in_blog = '1' ORDER BY i.sort_order, date_added DESC");

        $count = 0;
        if ($query->num_rows) {
            $count = $query->row['co'];
        }
        return $count;
    }

    public function getBlogInformationsByTypeCount($type) {
        $query = $this->db->query("SELECT count(*) as co FROM " . DB_PREFIX . "information i LEFT JOIN " . DB_PREFIX . "information_description id ON (i.information_id = id.information_id) LEFT JOIN " . DB_PREFIX . "information_to_store i2s ON (i.information_id = i2s.information_id) WHERE id.language_id = '" . (int)$this->config->get('config_language_id') . "' AND i2s.store_id = '" . (int)$this->config->get('config_store_id') . "' AND i.status = '1' AND i.sort_order <> '-1' AND show_in_blog = '1' AND blog_type = '".intval($type)."'");

        $count = 0;
        if ($query->num_rows) {
            $count = $query->row['co'];
        }
        return $count;
    }

    public function getBlogInformationsByCategoryCount($cat) {
        $query = $this->db->query("SELECT count(*) as co FROM " . DB_PREFIX . "information i LEFT JOIN " . DB_PREFIX . "information_description id ON (i.information_id = id.information_id) LEFT JOIN " . DB_PREFIX . "information_to_store i2s ON (i.information_id = i2s.information_id) WHERE id.language_id = '" . (int)$this->config->get('config_language_id') . "' AND i2s.store_id = '" . (int)$this->config->get('config_store_id') . "' AND i.status = '1' AND i.sort_order <> '-1' AND show_in_blog = '1' AND blog_category = '".intval($cat)."'");

        $count = 0;
        if ($query->num_rows) {
            $count = $query->row['co'];
        }
        return $count;
    }

    public function getBlogCategories() {
        // править в 2-х местах: admin/model/catalog, model/catalog
        return array(
            '1' => 'По умолчанию'
        );
    }
	
	/*Загрузка файлов*/
    public function getDownloads($information_id) {
 
        $query = $this->db->query("SELECT * FROM " . DB_PREFIX . "information_to_download pd LEFT JOIN " . DB_PREFIX . "download d ON(pd.download_id=d.download_id) LEFT JOIN " . DB_PREFIX . "download_description dd ON(pd.download_id=dd.download_id) WHERE information_id = '" . (int)$information_id . "' AND dd.language_id = '" . (int)$this->config->get('config_language_id')."'");
 
        return $query->rows;
    }
 
    public function getDownload($information_id, $download_id) {
        $download="";
        if($download_id!=0)$download=" AND d.download_id=".(int)$download_id;
        $query = $this->db->query("SELECT * FROM " . DB_PREFIX . "information_to_download pd LEFT JOIN " . DB_PREFIX . "download d ON(pd.download_id=d.download_id) LEFT JOIN " . DB_PREFIX . "download_description dd ON(pd.download_id=dd.download_id) WHERE information_id = '" . (int)$information_id . "' ".$download." AND dd.language_id = '" . (int)$this->config->get('config_language_id')."'");
 
        return $query->row;
    }
    /*-----------------------------------------------------------------------------------------------------------*/
}
?>
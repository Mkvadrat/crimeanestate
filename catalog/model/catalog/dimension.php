<?php
	class ModelCatalogDimension extends Model
	{
		public function getDimension($length_class_id)
		{
			return $this->db->query("SELECT * FROM `".DB_PREFIX."length_class_description` WHERE `length_class_id`='".(int)$length_class_id."' AND language_id = '" . (int)$this->config->get('config_language_id') . "'")->row;
		}
	}
?>
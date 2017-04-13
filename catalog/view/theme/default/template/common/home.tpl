<?php echo $header; ?>
<?php include(DIR_TEMPLATE.$this->config->get('config_template') . '/template/common/slider.tpl'); ?>
<?php //include(DIR_TEMPLATE.$this->config->get('config_template') . '/template/common/search.tpl'); ?>
<?php echo $content_top; ?>
<?php //include(DIR_TEMPLATE.$this->config->get('config_template') . '/template/common/home_content.tpl'); ?>

<?php include(DIR_TEMPLATE.$this->config->get('config_template') . '/template/common/new_objects.tpl'); ?>
<?php echo $content_bottom; ?>

<?php include(DIR_TEMPLATE.$this->config->get('config_template') . '/template/common/clients.tpl'); ?>
<?php //include(DIR_TEMPLATE.$this->config->get('config_template') . '/template/common/jj.tpl'); ?>
<?php echo $column_left; ?>
<?php include(DIR_TEMPLATE.$this->config->get('config_template') . '/template/common/partners.tpl'); ?>
<?php include(DIR_TEMPLATE.$this->config->get('config_template') . '/template/common/blog.tpl'); ?>
<?php //include(DIR_TEMPLATE.$this->config->get('config_template') . '/template/common/vk.tpl'); ?>

<?php echo $footer; ?>
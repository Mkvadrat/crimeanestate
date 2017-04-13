<?php echo $header; ?>
<?php echo $content_top; ?>
    <div class="content">
        <div class="conteiner article-container">
        <?php $description = str_replace('[[contact_form]]',$form,$description); ?>
        <?php echo str_replace('[[right_column]]',$right,$description); ?>
        </div>
    </div>
<?php echo $content_bottom; ?>
<?php echo $footer; ?>

<script type="text/javascript">
    jQuery(document).ready(function(){
        jQuery('details p').hide();
        jQuery('details details').hide();
        jQuery('details summary').click(function(){
            if (jQuery(this).parent('details').children('p').css('display')=='none') {
                jQuery(this).parent('details').children('p').show();
            } else {
                jQuery(this).parent('details').children('p').hide();
            }
            if (jQuery(this).parent('details').children('details').css('display')=='none') {
                jQuery(this).parent('details').children('details').show();
            } else {
                jQuery(this).parent('details').children('details').hide();
            }
        });
    });
</script>
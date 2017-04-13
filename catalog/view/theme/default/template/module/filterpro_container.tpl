<div class="product-filter">
    <div class="sort"><?php echo $text_sort; ?>
        <select onchange="location = this.value;">
            <?php foreach ($sorts as $sorts) { ?>
            <?php if ($sorts['value'] == $sort . '-' . $order) { ?>
            <option value="<?php echo $sorts['href']; ?>" selected="selected"><?php echo $sorts['text']; ?></option>
            <?php } else { ?>
            <option value="<?php echo $sorts['href']; ?>"><?php echo $sorts['text']; ?></option>
            <?php } ?>
            <?php } ?>
        </select>
    </div>
    <div class="limit"><?php echo $text_limit; ?>
        <select onchange="location = this.value;">
            <?php foreach ($limits as $limits) { ?>
            <?php if ($limits['value'] == $limit) { ?>
            <option value="<?php echo $limits['href']; ?>" selected="selected"><?php echo $limits['text']; ?></option>
            <?php } else { ?>
            <option value="<?php echo $limits['href']; ?>"><?php echo $limits['text']; ?></option>
            <?php } ?>
            <?php } ?>
        </select>
    </div>

</div>
<div class="product-list">

</div>
<div class="pagination"></div>
<script type="text/javascript"><!--
var jQuery = jQuery.noConflict();
    function display('list') {
        if (view == 'list') {
            jQuery('.product-grid').attr('class', 'product-list');

            /*jQuery('.product-list > div').each(function(index, element) {
                html  = '';

                var image = jQuery(element).find('.image').html();

                if (image != null) {
                    html += '<div class="image">' + image + '</div>';
                }

                html += '  <div class="pr_center">' + jQuery(element).find('.pr_center').html() + '</div>';



                var price = jQuery(element).find('.price').html();

                if (price != null) {
                    html += '<div class="pr_right"><div class="price">' + price  + '</div><div class="cart-box">' + jQuery(element).find('.cart-box').html() + '</div>'+'</div>';
                }
                else{
                    html += '<div class="pr_right"><div class="cart-box">' + jQuery(element).find('.cart-box').html() + '</div></div>';
                }
                jQuery(element).html(html);
            });*/

            jQuery('.poshytips').poshytip({
                className: 'tip-twitter',
                showTimeout: 1,
                alignTo: 'target',
                alignX: 'center',
                offsetY: 5,
                allowTipHover: false
            });

            jQuery('.colorbox').colorbox({
                overlayClose: true,
                opacity: 0.5,
                width:"1050px",
                height:"750px",
                fixed:true,
                rel: "colorbox"
            });

            jQuery('.display').html('<?php echo $text_display; ?>&nbsp;<img align="absmiddle" src="catalog/view/theme/default/image/icon/list-icon-active.png">&nbsp;<a onclick="display(\'grid\');"><img align="absmiddle" src="catalog/view/theme/default/image/icon/grid-icon.png" title="<?php echo $text_grid; ?>"></a>');

            jQuery.totalStorage('display', 'list');
        } else {
            jQuery('.product-list').attr('class', 'product-grid');

            /*jQuery('.product-grid > div').each(function(index, element) {
                html = '';

                var image = jQuery(element).find('.image').html();

                if (image != null) {
                    html += '<div class="image">' + image + '</div>';
                }

                html += '  <div class="description-list">' + jQuery(element).find('.description-list').html() + '</div>';
                html += '<div class="description-grid">' + jQuery(element).find('.description-grid').html() + '</div>';

                var rating = jQuery(element).find('.rating').html();

                if (rating != null) {
                    html += '<div class="rating">' + rating + '</div>';
                }

                html += '<div class="pr_center">' + jQuery(element).find('.pr_center').html() + '</div>';

                var price = jQuery(element).find('.price').html();

                if (price != null) {
                    html += '<div class="price">' + price  + '</div>';
                }


                html += '<div class="cart-box">' + jQuery(element).find('.cart-box').html() + '</div>';

                jQuery(element).html(html);
            });*/

            jQuery('.poshytips').poshytip({
                className: 'tip-twitter',
                showTimeout: 1,
                alignTo: 'target',
                alignX: 'center',
                offsetY: 5,
                allowTipHover: false
            });

            jQuery('.colorbox').colorbox({
                overlayClose: true,
                opacity: 0.5,
                width:"1050px",
                height:"750px",
                fixed:true,
                rel: "colorbox"
            });

            jQuery('.display').html('<?php echo $text_display; ?>&nbsp;<a onclick="display(\'list\');"><img align="absmiddle" src="catalog/view/theme/default/image/icon/list-icon.png" title="<?php echo $text_list; ?>"></a>&nbsp;<img align="absmiddle" src="catalog/view/theme/default/image/icon/grid-icon-active.png">');

            jQuery.totalStorage('display', 'grid');
        }
    }

    view = jQuery.totalStorage('display');

    if (view) {
        display(view);
    } else {
        display('list');
    }
    //--></script>

<?php if ($position == 'content_top'  or $position == 'content_bottom') { ?>

<?php } else { ?>
<div class="box">
    <div class="box-content">
        <div class="box-category">
            <ul>
                <?php foreach ($categories as $category) { ?>
                <li>
                    <?php if ($category['category_id'] == $category_id) { ?>
                    <a href="<?php echo $category['href']; ?>" class="active"><?php echo $category['name']; ?></a>
                    <?php } else { ?>
                    <a href="<?php echo $category['href']; ?>" class="no-active"><?php echo $category['name']; ?></a>
                    <?php } ?>
                    <?php if ($category['children']) { ?>
                    <ul>
                        <?php foreach ($category['children'] as $child) { ?>
                        <li>
                            <?php if ($child['category_id'] == $child_id) { ?>
                            <a href="<?php echo $child['href']; ?>" class="child-active">
                                - <?php echo $child['name']; ?></a>
                            <?php } else { ?>
                            <a href="<?php echo $child['href']; ?>"> - <?php echo $child['name']; ?></a>
                            <?php } ?>
                        </li>
                        <?php } ?>
                    </ul>
                    <?php } ?>
                </li>
                <?php } ?>
            </ul>
        </div>
    </div>
</div>
<?php } ?>






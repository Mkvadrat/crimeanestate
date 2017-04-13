<?php if (!isset($type)) $type=''; ?>

<div class="blog-menu-wrapper">
    <ul id="blog-menu">
        <li><a href="/blog/news"<?php if ($type=='news') echo ' class="active"' ?>>Новости</a></li>
        <li><a href="/blog/articles"<?php if ($type=='articles') echo ' class="active"' ?>>Статьи</a></li>
        <li><a href="/blog/video"<?php if ($type=='video') echo ' class="active"' ?>>Видео</a></li>
    </ul>
</div>

<div id="blog-category-wrapper">
    <?php if (!empty($blog_categories)): ?>
        <ul>
            <li class="bold">Рубрики:</li>
            <?php foreach($blog_categories as $cat_id=>$cat_name): ?>
                <li><a href="/blog/<?php echo intval($cat_id) ?>"<?php if ($type==$cat_id) echo ' class="active"' ?>><?php echo htmlspecialchars($cat_name) ?></a></li>
            <?php endforeach; ?>
        </ul>
    <?php endif; ?>
</div>
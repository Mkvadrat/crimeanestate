<div class="box">
 <div class="box-heading"><?php echo $heading_title; ?></div>
 <div class="box-content">
  <div class="box-news-side">
    <?php foreach ($news as $news_story) { ?>
      <div>

<span class="news-dates"><?php echo $news_story['date']; ?></span>
	   <div class="news-story-title"><a href="<?php echo $news_story['href']; ?>"><?php echo $news_story['title']; ?></a></div>
     

	  
	  </div>
    <?php } ?>
	
  </div>
 </div>
</div>


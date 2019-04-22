<?php echo $header; ?>
<?php echo $search; ?>

<section>
  <div class="container">
    <div class="row">
      <div class="col-lg-12">
        <div class="breadcrumb">
          <ul>

            <?php foreach ($breadcrumbs as $breadcrumb) { ?>
              <li>
                <a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?> /</a>
              </li>
            <?php } ?>
            <li>Производители</li>
          </ul>
        </div>
      </div>
    </div>
  </div>
</section>

<section class="top-title">
  <div class="container">
    <div class="row">
      <div class="col-lg-12">
        <a href="<?php echo $back; ?>" class="back_link">
          <i class="icon icon-back"></i>
          <span>Назад</span>
        </a>
        <h1>Производители</h1>
      </div>
    </div>
  </div>
</section>

<section class="brand_list">
  <div class="container">
    <div class="row">
      <div class="col-lg-12">
        <div class="mobile-txt title">Производители</div>
        <div class="lang">A-Z</div>
      </div>
    </div>
    <?php foreach ($categories as $category) { ?>
      <div class="row">
        <div class="col-lg-12 clearfix">
          <div class="character"><?php echo $category['name']; ?></div>
            <?php if ($category['manufacturer']) { ?>
			 <div class="brand_list-item">
              <ul>
			  <!-- <?php foreach (array_chunk($category['manufacturer'], 4) as $manufacturers) { ?> -->

                 
                    
                      <?php foreach ($manufacturers as $manufacturer) { ?>
                      <li>
                        <a href="<?php echo $manufacturer['href']; ?>"><?php echo $manufacturer['name']; ?></a>
                      </li>
                      <?php } ?>
                  
                  
               <!-- <?php } ?> -->
			     </ul>
			   </div>
              <?php } ?>

        </div>
      </div>
    <?php } ?>
  </div>

  <div class="container">
    <div class="row">
      <div class="col-lg-12">
        <div class="lang">А-Я</div>
      </div>
    </div>
    <?php foreach ($categories_ru as $category) { ?>
      <div class="row">
        <div class="col-lg-12 clearfix">
          <div class="character"><?php echo $category['name']; ?></div>
            <?php if ($category['manufacturer']) { ?>
<div class="brand_list-item">
                    <ul>
              <?php foreach (array_chunk($category['manufacturer'], 4) as $key => $manufacturers) { ?>
                  <?php if (($key == 3) || ($key == 6)){ ?>
      
                  <?php  } ?>
                  
                      <?php foreach ($manufacturers as $manufacturer) { ?>
                        <li>
                          <a href="<?php echo $manufacturer['href']; ?>"><?php echo $manufacturer['name']; ?></a>
                        </li>
                      <?php } ?>
                   

              <?php } ?>
			   </ul>
                  </div>

            <?php } ?>
        </div>
      </div>
    <?php } ?>
  </div>
</section>
<div id="overlay" style="display: none;"></div>
<?php echo $footer; ?>
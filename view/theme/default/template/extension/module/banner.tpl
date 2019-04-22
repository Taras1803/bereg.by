<?php foreach($banners as $banner){ ?>
<section class="banner">
  <div class="container">
    <h1><?php echo $banner['title']?></h1>
    <div class="search_wrap">
      <div class="clearfix top-banner-form">

        <div class="srch">
          <input type="text" autocomplete="off" class="srch__field" name="search" placeholder="Что будем искать?" />
          <div class="dropdown_search" style="display: none">
            <a  class="close js_close">
              <i class="icon icon-close"></i>
            </a>
            <ul class="srch__result">

            </ul>
            <a  class="all_result js_show_all">Найдено <span class="js_elastic_total_product"></span> продуктов и <span class="js_elastic_total_category"></span> категорий <span class="go_to_search">показать все</span></a>

          </div>
        </div>

        <button>
          <i class="icon icon-search"></i>
        </button>
      </div>

    </div>
    <p>30 000 товаров на складе</p>
  </div>
</section>
<?php } ?>
<div id="overlay" style="display: none;"></div>

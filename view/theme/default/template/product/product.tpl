<?php

$timestamp = strtotime($date_modified);

$LastModified_unix = $timestamp; // время последнего изменения страницы
$LastModified = gmdate("D, d M Y H:i:s \G\M\T", $LastModified_unix);


$IfModifiedSince = false;
if (isset($_ENV['HTTP_IF_MODIFIED_SINCE']))
    $IfModifiedSince = strtotime(substr($_ENV['HTTP_IF_MODIFIED_SINCE'], 5));
if (isset($_SERVER['HTTP_IF_MODIFIED_SINCE']))
    $IfModifiedSince = strtotime(substr($_SERVER['HTTP_IF_MODIFIED_SINCE'], 5));
if ($IfModifiedSince && $IfModifiedSince >= $LastModified_unix) {
header($_SERVER['SERVER_PROTOCOL'] . ' 304 Not Modified');
exit;
}
header('Last-Modified: '. $LastModified);
?>


<?php echo $header; ?>
<?php echo $search; ?>


<section>
  <div class="container">
    <div class="row">
      <div class="col-lg-12">
        <div class="breadcrumb">
          <ul>
            <?php foreach ($breadcrumbs as $breadcrumb) { ?>
            <?php if($breadcrumb != end($breadcrumbs)) { ?>
            <li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?> /</a></li>
            <?php } else { ?>
            <li><?php echo $breadcrumb['text']; ?></li>
            <?php  } ?>
            <?php  } ?>
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
        <a href="<?php echo $back ?>" class="back_link">
          <i class="icon icon-back"></i>
          <span>Назад</span>
        </a>
        <h1 id="xml_search_product_name"><?php echo $heading_title; ?></h1>
        <div id="xml_search_product_id" hidden="true" ><?php echo $product_id; ?></div>
      </div>
    </div>
  </div>
</section>

<section class="product">
  <div class="container">
    <div class="row">
      <div class="mobile-txt title"><?php echo $heading_title; ?></div>
      <div class="col-lg-5 col-md-5 col-sm-6">
        <div class="product_img">
          <img src="<?php echo $thumb; ?>" alt="<?php echo $heading_title; ?>" />
        </div>
      </div>
      <div class="col-lg-7 col-md-7 col-sm-6">
        <div class="product_descr" id="product">
          <div class="product_descr-top clearfix">
            <div class="price">
              <strong><?php echo $price; ?></strong>
              <em>Цена с НДС за 1  <?php if(isset($unit)){ echo $unit; } ?></em>
            </div>
            
            <div class="wrap-btn">
              <span class="mobile-txt">Количество</span>
              <input id="productLimit" name="quantity" type="number" value="<?php echo $minimum; ?>" />
            <input type="hidden" name="product_id" value="<?php echo $product_id; ?>" />
              <button id="button-cart" <?php if((int)$price <= 0 ){ ?>  disabled="disabled" <?php } ?> class="btn-accent">
                <i class="icon icon-cart_white"></i>
            <?php if((int)$price > 0 ){ ?>
                    <?php if($count_product != 0 ){ ?>
                        <span id="add_button">Добалено <?= $count_product ?> шт</span>
                    <?php } else { ?>
                        <span id="add_button">Добавить в корзину</span>
                    <?php }  ?>
            <?php } else { ?>
            <span>Нельзя добавить</span>
            <?php }  ?>
              </button>
              <em class="existence">В наличии
                <span id="productAvailability"><?php echo $quantity; ?></span>
                <?php if(isset($unit)){ echo $unit; } ?>
              </em>
            </div>

          </div>
          <?php if (isset($technical_attributes)){ ?>
            <table>
              <tbody>
              <?php foreach($technical_attributes['attribute'] as $attribute){ ?>
                <tr>
                  <td><?php echo $attribute['name'] ?></td>
                  <td><?php echo $attribute['text'] ?></td>
                </tr>
              <?php } ?>
              </tbody>
            </table>
          <?php } ?>
        </div>
      </div>
    </div>
    <div class="row">
      <div class="col-lg-12">
        <div class="tabs">
          <ul class="tabs_control clearfix">

            <li class="tabs_control_item active">
              <a class="tabs_control_link">Характеристики</a>
            </li>
            <li class="tabs_control_item">
              <a class="tabs_control_link">Спецификация</a>
            </li>
          </ul>
          <ul class="tabs_list">

            <li class="tabs_item active">
              <table>
                <tbody>
                <?php if (isset($technical_attributes)){ ?>
                  <?php foreach($technical_attributes['attribute'] as $attribute){ ?>
                    <tr>
                      <td><?php echo $attribute['name'] ?></td>
                      <td><?php echo $attribute['text'] ?></td>
                    </tr>
                  <?php } ?>
                <?php } ?>
                  <?php if ($properties != ''){ ?>
                    <?php foreach($properties as $property){ ?>
                      <tr>
                        <td><?php echo $property['name'] ?></td>
                        <td><?php echo $property['text'] ?></td>
                      </tr>
                    <?php } ?>
                  <?php } ?>
                </tbody>
              </table>

            </li>
            <li class="tabs_item">
              <span>Скачать PDF спецификацию</span>
                <i class="icon icon-download"></i>
            </li>
          </ul>
        </div>
      </div>
    </div>
  </div>
</section>

<section class="product-recomended">
  <?php if ($products_recomend) { ?>
      <div class="container">
        <div class="row">
          <div class="col-lg-12">
            <div class="recomended-wrap">
              <h3>Рекомендуемые комплектующие</h3>
            </div>
          </div>

          <div class="slider-mobile">
          <?php foreach ($products_recomend as $product) { ?>
            <div class="col-lg-3 col-md-3 col-sm-3">
              <div class="recomended-wrap_item">
                <div class="listing-item clearfix">
                  <div class="listing-item_img">
                    <a href="<?php echo $product['href']; ?>"><img src="<?php echo $product['thumb']; ?>" alt="<?php echo $product['name']; ?>" /></a>
                  </div>
                  <div class="listing-item_descr">
                    <a href="<?php echo $product['href']; ?>"><h3><?php echo $product['name']; ?></h3></a>
                    <?php if ($product['price']) { ?>
                    <div class="price">
                      <em>Цена с НДС</em><strong><?php echo $product['price']; ?></strong>
                    </div>
                    <?php } ?>
                    <?php if($product['manufacturer'] != ''){ ?>
                    <div class="producer">
                      <em>Производитель</em><span><?php echo $product['manufacturer']; ?></span>
                    </div>
                    <?php } ?>
                    <?php if($product['weight'] != ''){ ?>
                    <div class="weight">
                      <em>Масса</em><span><?php echo $product['weight']; ?></span>
                    </div>
                    <?php } ?>

                     <!-- <?php if (isset($recomend_technical_attributes)){ ?>
                         <?php foreach($recomend_technical_attributes['attribute'] as $attribute){ ?>
                             <div class="press">
                                 <em><?php echo $attribute['name'] ?></em><span><?php echo $attribute['text'] ?></span>
                             </div>
                         <?php } ?>
                     <?php } ?> -->

                  </div>
                  <i onclick="cart.add('<?php echo $product['product_id']; ?>', '<?php echo $product['minimum']; ?>');" class="icon icon-add_to_cart"></i>
                </div>
              </div>
            </div>
          <?php } ?>
          </div>

        </div>
      </div>
  <?php } ?>

  <?php if ($products) { ?>
    <div class="container">
      <div class="row">
        <div class="col-lg-12">
          <div class="recomended-wrap">
            <h3>Похожие товары / Аналоги</h3>
          </div>
        </div>

        <div class="slider-mobile">
        <?php foreach ($products as $product) { ?>
          <div class="col-lg-3 col-md-3 col-sm-3">
          <div class="recomended-wrap_item">
            <div class="listing-item clearfix">
              <div class="listing-item_img">
                  <a href="<?php echo $product['href']; ?>"><img src="<?php echo $product['thumb']; ?>" alt="<?php echo $product['name']; ?>" /></a>
              </div>
              <div class="listing-item_descr">
                  <a href="<?php echo $product['href']; ?>"><h3><?php echo $product['name']; ?></h3></a>
                <?php if ($product['price']) { ?>
                <div class="price">
                  <em>Цена с НДС</em><strong><?php echo $product['price']; ?></strong>
                </div>
                <?php } ?>
                <?php if($product['manufacturer'] != ''){ ?>
                  <div class="producer">
                    <em>Производитель</em><span><?php echo $product['manufacturer']; ?></span>
                  </div>
                <?php } ?>
                <?php if($product['weight'] != ''){ ?>
                  <div class="weight">
                    <em>Масса</em><span><?php echo $product['weight']; ?></span>
                  </div>
                <?php } ?>

                <!-- <?php if (isset($related_technical_attributes)){ ?>
                         <?php foreach($related_technical_attributes['attribute'] as $attribute){ ?>
                             <div class="press">
                                 <em><?php echo $attribute['name'] ?></em><span><?php echo $attribute['text'] ?></span>
                             </div>
                         <?php } ?>
                     <?php } ?> -->

              </div>
              <i onclick="cart.add('<?php echo $product['product_id']; ?>', '<?php echo $product['minimum']; ?>');" class="icon icon-add_to_cart"></i>
            </div>
          </div>
        </div>
        <?php } ?>
        </div>
        
      </div>
    </div>
  <?php } ?>
</section>
<script type="text/javascript"><!--

  $('.jq-number__spin minus').on('click',function () {
    alert(111)
    $('#productLimit').val()
  })

  $('.jq-number__spin plus').on('click',function () {
    $('#productLimit').val()
  })

  $('#button-cart').on('click', function() {

    $.ajax({
      url: 'index.php?route=checkout/cart/add',
      type: 'post',
      data: $('#product input[type=\'text\'], #product input[type=\'number\'], #product input[type=\'hidden\'], #product input[type=\'radio\']:checked, #product input[type=\'checkbox\']:checked, #product select, #product textarea'),
      dataType: 'json',
      beforeSend: function() {
        $('#button-cart').button('loading');
      },
      complete: function() {
        $('#button-cart').button('reset');
      },
      success: function(json) {
        console.log(json)
        $('.alert, .text-danger').remove();
        $('.form-group').removeClass('has-error');

        if (json['error']) {
          if (json['error']['option']) {
            for (i in json['error']['option']) {
              var element = $('#input-option' + i.replace('_', '-'));

              if (element.parent().hasClass('input-group')) {
                element.parent().after('<div class="text-danger">' + json['error']['option'][i] + '</div>');
              } else {
                element.after('<div class="text-danger">' + json['error']['option'][i] + '</div>');
              }
            }
          }

          if (json['error']['recurring']) {
            $('select[name=\'recurring_id\']').after('<div class="text-danger">' + json['error']['recurring'] + '</div>');
          }
          if (json['error']['quantity']) {
            $('#button-cart').after('<p class="text-danger">' + json['error']['quantity'] + '</p>');
            setTimeout(function () {
              $('.text-danger').remove();
            },2000)

          }
          // Highlight any found errors
          $('.text-danger').parent().addClass('has-error');
        }

        if (json['success']) {


          setTimeout (function f() {
            $('#add_button').html('Добалено ' + json['count_product'] + ' шт');
          },50)

          $('.cart-count').html(json['total']);
          $('.cart-count').show();

        

          $('#cart > ul').load('index.php?route=common/cart/info ul li');

          $('#modal-cart').load('index.php?route=common/cart/info .test', function () {

            $(".custom_layer_cart").mCustomScrollbar({
              theme: "minimal-dark"
            });

            $('#modal-cart .bt').on('click', function(e){
              e.preventDefault();

              $('#modal-cart').slideToggle(200);
            });
          });
        }
      },
      error: function(xhr, ajaxOptions, thrownError) {
        alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
      }
    });
  });
  //--></script>
<div id="overlay" style="display: none;"></div>
<?php echo $footer; ?>

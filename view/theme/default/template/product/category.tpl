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
                <h1 id="xml_search_category_name"><?php echo $heading_title; ?></h1>
               
            </div>
        </div>
    </div>
</section>

<section class="listing">
    <div class="container">
        <div class="row">

            <div class="col-lg-4 col-md-4 col-sm-5">
                <div class="all_category">
                    <a href="<?php echo $catalog; ?>">Все категории</a>
                    <i class="icon icon-sandwich"></i>
                </div>
                <div id="allCat" class="menu-wrapper">
                    <div class="first">
                        <input id="match-search" type="text" placeholder="Поиск по категориям"/>
                        <i class="icon icon-search-2"></i>
                    </div>
                    <div class="category_menu">
                        <ul class="custom_layer_cart">
                            <li id="not">
                                <a href="#">Совпадений не найдено!</a>
                            </li>
                            <?php foreach($parent_categories as $category){ ?>
                            <li class="li_custom">
                                <a href="<?php echo $category['href'] ?>"><?php echo $category['name'] ?></a>
                                <?php if(isset($category['sub_categories'])){ ?>
                                <i class="icon icon-arrow"></i>
                                <?php  echo recursive($category['sub_categories']) ?>
                                <?php } ?>
                            </li>
                            <?php } ?>
                        </ul>
                    </div>
                    <div class="last">
                        <a href="<?php echo $catalog ?>">Смотреть весь каталог</a>
                    </div>
                </div>


                <?php
                function recursive ($categories){
                     $tree = '<ul class="category_menu-sub_menu">';
                foreach($categories as $category){
                $tree .= '
                <li>';
                    $tree .= '<a href="'.$category['href'] .'">'. $category['name'] .'</a>';
                    if(isset($category['sub_categories'])){
                    $tree .= '<i class="icon icon-arrow"></i>';
                    $tree .= recursive($category['sub_categories']);
                    }
                    $tree .= '
                </li>
                ';
                }
                $tree .= '</ul>';
                return $tree;
                }
                ?>


                <?php if(isset($categories)){ ?>
                <ul class="category_menu">
                    <?php foreach($categories as $category){ ?>
                    <li>
                        <a href="<?php echo $category['href'] ?>"><?php echo $category['name'] ?></a>
                        <?php if(isset($category['sub_categories'])){ ?>
                        <i class="icon icon-arrow"></i>
                        <?php  echo recursive($category['sub_categories']) ?>
                        <?php } ?>
                    </li>
                    <?php } ?>
                </ul>
                <?php } ?>
            </div>


            <div class="col-lg-8 col-md-8 col-sm-7">
                <div class="sorting">
                    <span>Сортировать по:</span>
                    <form action="#">
                        <select id="input-sort" class="form-control" onchange="location = this.value;">
                            <?php foreach ($sorts as $sorts) { ?>
                            <?php if ($sorts['value'] == $sort . '-' . $order) { ?>
                            <option value="<?php echo $sorts['href']; ?>"
                                    selected="selected"><?php echo $sorts['text']; ?></option>
                            <?php } else { ?>
                            <option value="<?php echo $sorts['href']; ?>"><?php echo $sorts['text']; ?></option>
                            <?php } ?>
                            <?php } ?>
                        </select>
                        <?php if(count($manufacturers) > 1) { ?>
                        <select class="form-control" onchange="location = this.value;">
                            <?php foreach ($manufacturers as $sorts) { ?>
                            <?php if ($sorts['value'] == $sort . '-' . $order) { ?>
                            <option value="<?php echo $sorts['href']; ?>"
                                    selected="selected"><?php echo $sorts['text']; ?></option>
                            <?php } else { ?>
                            <option value="<?php echo $sorts['href']; ?>"><?php echo $sorts['text']; ?></option>
                            <?php } ?>
                            <?php } ?>
                        </select>
                        <?php } ?>
                    </form>
                    <div class="listing-icon_wrap">
                        <i id="listing_string" class="icon icon-listing_string active"></i>
                        <i id="listing_card" class="icon icon-listing_card"></i>
                    </div>
                </div>
                <div class="mobile-txt title"><?php echo $heading_title; ?></div>
                <div class="listing-wrap clearfix catcards">
                    <?php if ($products) { ?>
                    <?php foreach ($products as $product) { ?>
                    <div class="listing-item listing-item--string clearfix product-list">
                        <div class="listing-item_img">
                            <a href="<?php echo $product['href']; ?>"><img src="<?php echo $product['thumb']; ?>"
                                                                           alt="product img"></a>
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
                            <!--<?php if($product['weight'] > 0){ ?>
                            <div class="weight">
                                <em>Масса</em><span><?php echo $product['weight']; ?></span>
                            </div>
                            <?php } ?>
                            <?php if($product['length'] > 0){ ?>
                            <div class="weight">
                                <em>Длинна</em><span><?php echo $product['length']; ?></span>
                            </div>
                            <?php } ?>
                            <?php if($product['width'] > 0){ ?>
                            <div class="weight">
                                <em>Ширина</em><span><?php echo $product['width']; ?></span>
                            </div>
                            <?php } ?>
                            <?php if($product['height'] > 0){ ?>
                            <div class="weight">
                                <em>Высота</em><span><?php echo $product['height']; ?></span>
                            </div>
                            <?php } ?>-->
                            <?php if (isset($product['attribute'])){ ?>
                            <?php foreach($product['attribute'] as $attribute){ ?>
                            <div class="press">
                                <em><?php echo $attribute['name'] ?></em><span><?php echo $attribute['value'] ?></span>
                            </div>
                            <?php } ?>
                            <?php } ?>

                        </div>
                        <?php if((int)$product['price'] > 0){ ?>
                        <div data-toggle="modal" onclick="showCart(<?php echo $product['product_id']; ?>)" class="add_to_cart-wrap">
                            <div class="icon-wrap">
                                <i class="icon icon-add_to_cart"></i>
                            </div>
                        </div>

                        <?php } ?>

                    </div>
                    <?php } ?>
                    <?php } ?>
                </div>
                <div class="row">
                    <div class="col-lg-12 text-left pagination_custom"><?php echo $pagination; ?></div>
                </div>
            </div>
        </div>
    </div>

    <!-- this is pagination for scrolling -->

    <!--<?php if ($loadmore_arrow_status) { ?>
    <a id="arrow_top" style="display:none;" onclick="scroll_to_top();"></a>
    <?php } ?>
    <div id="load_more" style="display:none;">
        <div class="row text-center" style="display:none;">
            <a href="#" class="load_more">Подгрузить ещё</a>
        </div>
    </div>-->

    <script type="text/javascript"><!--


        $('.last-item').click(function () {
            $('.category_menu li').removeAttr('hidden');
            $(this).remove();
        })

        $('.category_menu li').hover(function () {
            $('.category_menu-sub_menu li').show();
        });
        --></script>
</section>
<style>
    a.load_more {
        display: inline-block;
        margin: 0 auto 20px auto;
        padding: 0.5em 2em;
        border: 1px solid #069;
        border-radius: 5px;
        text-decoration: none;
        text-transform: uppercase;
    }
</style>
<style>
    #ajax_loader {
        width: 100%;
        height: 30px;
        margin-top: 15px;
        text-align: center;
        border: none !important;
    }

    #arrow_top {
        background: url("image/catalog/chevron_up.png") no-repeat transparent;
        background-size: cover;
        position: fixed;
        bottom: 50px;
        right: 15px;
        cursor: pointer;
        height: 50px;
        width: 50px;
    }
</style>
<div id="overlay" style="display: none;"></div>

<!-- Modal -->
<div class="modal fade" id="cartModal" tabindex="-1" role="dialog" aria-labelledby="cartModalTitle" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="modalTitle"></h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body" id="cart-body">

            </div>
            <div class="modal-footer">

            </div>
        </div>
    </div>
</div>

<div class="modal fade" id="successModal" tabindex="-1" role="dialog" aria-labelledby="successModalTitle" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body" id="success-body">
                <div id="add_to_cart-done">
                    <section class="cart-done">
                        <div class="cart-done-wrap">
                            <div class="popup_top">
                                <i class="icon icon-done-cart"></i>
                            </div>
                            <div class="popup_middle clearfix">
                                <h3>Товар добавлен в корзину</h3>
                            </div>
                            <div class="popup_bottom clearfix">
                                <a onclick="continueShopping()" class="bt">Продолжить покупки</a>
                                <a href="/checkout" id="checkout_btn" class="bt-2">Оформить заказ</a>
                            </div>
                        </div>
                    </section>
                </div>
            </div>
        </div>
    </div>
</div>

<script>

    function showCart(product_id) {
        $.post('index.php?route=product/product/getproductInfo',{product_id:product_id}, function (data) {
            $('#cartModal').show();
            $('#cart-body').html(data);
            $('#cartModal').modal('show');
            $('input, select').styler();

        });


    }
    function cartAdd(product_id)
    {
        $('#cartModal').modal('hide');
        cart.add(product_id,$('#productLimit').val());
        $('#successModal').show();
        //$('#overlay').hide();
        $('#successModal').modal('show');
    }
    function continueShopping()
    {
        $('#successModal').hide();
        $('#overlay').hide();
    }
</script>

<?php echo $footer; ?>
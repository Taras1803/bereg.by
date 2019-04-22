<!DOCTYPE html>
<!--[if IE]><![endif]-->
<!--[if IE 8 ]><html dir="<?php echo $direction; ?>" lang="<?php echo $lang; ?>" class="ie8"><![endif]-->
<!--[if IE 9 ]><html dir="<?php echo $direction; ?>" lang="<?php echo $lang; ?>" class="ie9"><![endif]-->
<!--[if (gt IE 9)|!(IE)]><!-->
<html dir="<?php echo $direction; ?>" lang="<?php echo $lang; ?>">
<!--<![endif]-->
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title><?php echo $title; ?></title>
<base href="<?php echo $base; ?>" />
<?php if ($description) { ?>
<meta name="description" content="<?php echo $description; ?>" />
<?php } ?>
<?php if ($keywords) { ?>
<meta name="keywords" content= "<?php echo $keywords; ?>" />
<?php } ?>

    <link rel="shortcut icon" href="catalog/view/theme/default/img/favicon.png" />




    <?php if(isset($page)){ ?>
    <link rel="canonical" href="<?php echo $base; ?>"/>
        <?php if($page > 2 ){ ?>
            <link rel="prev" href="<?php echo $base; ?><?php echo $type_of_pagination; ?>/page-<?php echo $page-1; ?>"/>
        <?php } elseif($page == 2){ ?>
            <link rel="prev" href="<?php echo $base; ?><?php echo $type_of_pagination; ?>/"/>
        <?php } ?>
            <link rel="next" href="<?php echo $base; ?><?php echo $type_of_pagination; ?>/page-<?php echo $page+1; ?>"/>
    <?php } ?>







    <link rel="stylesheet" href="catalog/view/theme/default/libs/bootstrap/bootstrap-grid-3.3.1.min.css" />
    <link rel="stylesheet" href="catalog/view/theme/default/assets/css/reset.css" />
    <link rel="stylesheet" href="catalog/view/theme/default/libs/jq_form_styler/jquery_formstyler.css" />
    <link rel="stylesheet" href="catalog/view/theme/default/libs/slick-1.8.0/slick.css" />
    <link rel="stylesheet" href="catalog/view/theme/default/libs/custom_scrollbar/custom_scrollbar.css" />


    <link rel="stylesheet" href="catalog/view/theme/default/assets/css/fonts.css" />
    <link rel="stylesheet" href="catalog/view/theme/default/assets/css/main_style.css" />
    <link rel="stylesheet" href="catalog/view/theme/default/assets/css/media_style.css" />

    <script src="catalog/view/javascript/jquery-3.2.1.min.js"></script>

    <script src="catalog/view/javascript/jquery_formstyler.min.js"></script>
    <script src="catalog/view/javascript/slick.min.js"></script>
    <script src="catalog/view/javascript/custom_scrollbar.min.js"></script>
    <script src="catalog/view/javascript/main_script.js"></script>
    <script src="catalog/view/javascript/cart.js"></script>




<script src="catalog/view/javascript/bootstrap/js/bootstrap.min.js" type="text/javascript"></script>
<link href="catalog/view/javascript/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css" />
<link href="//fonts.googleapis.com/css?family=Open+Sans:400,400i,300,700" rel="stylesheet" type="text/css" />
<!-- <link href="catalog/view/theme/default/stylesheet/stylesheet.css" rel="stylesheet">-->
<?php foreach ($styles as $style) { ?>
<link href="<?php echo $style['href']; ?>" type="text/css" rel="<?php echo $style['rel']; ?>" media="<?php echo $style['media']; ?>" />
<?php } ?>
<script src="catalog/view/javascript/common.js" type="text/javascript"></script>
    <?php foreach ($links as $link) { ?>
         <link href="<?php echo $link['href']; ?>" rel="<?php echo $link['rel']; ?>" />
    <?php } ?>
    <?php foreach ($scripts as $script) { ?>
    <script src="<?php echo $script; ?>" type="text/javascript"></script>
    <?php } ?>
    <?php foreach ($analytics as $analytic) { ?>
    <?php echo $analytic; ?>
    <?php } ?>
    </head>
    <body class="<?php echo $class; ?>">
    <div class="container-global">
        <div class="mobile-header">
            <a href="/" class="mobile-logo">
                <img src="/image/logo_mobile.png" alt="logo">
            </a>
            <div class="tel">
                <i class="icon icon-phone"></i>
                <a href="tel:+375 (17) 279-43-79">
                    <span>+375 (17) 279-43-79</span>
                </a>
                <i class="icon icon-tel_drop"></i>
            </div>
            <div class="cart" id="cart-mobile">
                <a onclick="">
                    <i class="icon icon-cart"></i>
                    <?php if($count != 0) { ?>
                        <span class="cart-count"><?php echo $count ?></span>
                    <?php } ?>
                </a>
            </div>


            <a href="#" class="mobile-menu__open">
                <i class="icon icon-sandwich"></i>
            </a>
        </div>
        <div class="mobile-menu">
            <a href="#" class="mobile-menu__close">
                <i class="icon icon-close_mob_menu-2"></i>
            </a>
            <div class="top">
                <div class="account-wrap">
                    <img src="<?php echo $avatar; ?>" alt="avatar" />
                    <span>Аккаунт</span>
                </div>
                <div class="search-wrap srch">
                    <i class="icon icon-search-2"></i>
                    <input type="text" autocomplete="off" class="srch__field" name="search" value="" placeholder="Поиск по каталогу" />
                    <div class="dropdown_search" style="display: none">
                        <a  class="close js_close">
                            <i class="icon icon-close"></i>
                        </a>
                        <ul class="srch__result">

                        </ul>
                        <a  class="all_result js_show_all">Найдено <span class="js_elastic_total_product"></span> продуктов и <span class="js_elastic_total_category"></span> категорий<span class="go_to_search"> показать всё</span></a>

                    </div>
                </div>
                <ul>
                    <li>
                        <a href="<?php echo $catalog; ?>">Каталог</a>
                    </li>
                    <li>
                        <a href="<?php echo $manufacturer; ?>">Производители</a>
                    </li>
                </ul>
            </div>
            <div class="middle">
                <ul>
                    <li>
                        <a href="<?php echo $contact; ?>">Контакты</a>
                    </li>
                    <li>
                        <a href="<?php echo $jobs; ?>">Вакансии</a>
                    </li>
                    <li>
                        <a href="<?php echo $about_us; ?>">О компании</a>
                    </li>
                </ul>
            </div>
            <div class="bottom">
                <ul>
                    <li>
                        <a href="<?php echo $delivery; ?>">Доставка</a>
                    </li>
                    <li>
                        <a href="<?php echo $return; ?>">Возврат</a>
                    </li>
                    <li>
                        <a href="<?php echo $warranty; ?>">Гарантия</a>
                    </li>

                    <li>
                        <a href="<?php echo $payments; ?>">Оплата</a>
                    </li>
                </ul>
            </div>
        </div>
        <div class="mobile-tel">
            <div class="close">
                <i class="icon icon-close_mob_menu"></i>
            </div>
            <h4>Позвонить</h4>
            <div class="item">
                <i class="icon icon-phone"></i>
                <a href="tel:+375 (17) 279-43-79">
                    <span>+375 (17) 279-43-79</span>
                </a>
                <p>Опт</p>
            </div>
            <div class="item">
                <i class="icon icon-phone"></i>
                <a href="tel:+375 (29) 679-43-54">
                    <span>+375 (29) 679-43-54</span>
                </a>
                <p>Розница</p>
            </div>


        </div>
    <?php if ($status!='false') { ?>
        <header>
            <div class="top">
                <div class="container">
                    <div class="row">
                        <div class="col-lg-2 col-md-2 hidden-sm">
                            <small>Центр обслуживания</small>
                        </div>
                        <div class="col-lg-6 col-md-6 col-sm-7">
                            <div class="tel">
                                <i class="icon icon-phone"></i>
                                <small>Опт</small>
                                <a href="tel:+375 (17) 279-43-79">
                                    <span>+375 (17) 279-43-79</span>
                                </a>
                                <span class="line"></span>
                                <small>Розница</small>
                                <a href="tel:+375 (29) 679-43-54">
                                    <span>+375 (29) 679-43-54</span>
                                </a>
                            </div>
                        </div>
                        <div class="col-lg-3 col-md-3 col-sm-4">
                            <div class="time">
                                <i class="icon icon-clock"></i>
                                <span>Пн - Пт 9:00 - 18:00</span>
                            </div>
                        </div>
                        <div class="col-lg-1 col-sm-1">
                            <?php echo $cart ?>
                        </div>
                    </div>
                </div>
            </div>
            <div class="bottom">
                <div class="container">
                    <div class="row">
                        <div class="col-lg-2 col-md-2 col-sm-2">
                            <a href="/" class="logo">
                                <img src="/image/logo.png" alt="logo">
                            </a>
                            <a href="/" class="mobile-logo">
                                <img src="/image/logo_mobile.png" alt="logo">
                            </a>
                        </div>
                        <div class="col-lg-7 col-md-7 col-sm-6">
                            <nav>
                                <li>
                                    <a>Клиентам</a>
                                    <i class="icon icon-tel_drop"></i>
                                    <div class="dropdown-mnu">
                                        <ul>
                                            <li>
                                                <a href="<?php echo $warranty; ?>">Гарантия</a>
                                            </li>
                                            <li>
                                                <a href="<?php echo $return; ?>">Возврат</a>
                                            </li>
                                            <li>
                                                <a href="<?php echo $delivery; ?>">Доставка</a>
                                            </li>
                                            <li>
                                                <a href="<?php echo $payments; ?>">Оплата</a>
                                            </li>
                                        </ul>
                                    </div>
                                </li>
                                <li>
                                    <a href="<?php echo $about_us; ?>">О компании</a>
                                </li>
                                <li>
                                    <a href="<?php echo $contact; ?>">Контакты</a>
                                </li>
                                <li>
                                    <a href="<?php echo $jobs; ?>">Вакансии</a>
                                </li>
                            </nav>
                        </div>
                        <div class="col-lg-3 col-md-3 col-sm-4">
                            <div class="login">
                                <?php if ($logged) { ?>
                                    <a href="<?php echo $logout; ?>" class="enter">Выйти</a>
                                <?php } else { ?>
                                    <a href="<?php echo $register; ?>" class="registr">Зарегистрироваться</a>
                                    <a href="<?php echo $login; ?>" class="enter">Войти</a>
                                <?php } ?>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </header>
    <?php } ?>

        <script type="text/javascript"><!--
            $('#cart-mobile').click(function () {
                if(parseInt($('#cart-mobile').find('.cart-count').text()) > 0 ){
                    location.href = "<?php echo $go_to_cart ?>";
                }else{
                    alert("Корзина пуста");
                }
            })
            //--></script>




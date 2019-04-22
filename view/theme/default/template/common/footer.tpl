<div id="mobile-fixed-menu">
    <div class="tabs">
        <ul class="tabs_control clearfix">
            <li class="tabs_control_item active">
                <a class="tabs_control_link" href="/">
                    <div class="icon-wrap">
                        <i class="icon icon-home_mob"></i>
                    </div>
                    <span>Главная</span>
                </a>
            </li>
            <li class="tabs_control_item">
                <a class="tabs_control_link" href="#">
                    <div class="icon-wrap">
                        <i class="icon icon-account_mob"></i>
                    </div>
                    <span>Аккаунт</span>
                </a>
            </li>
            <li class="tabs_control_item">
                <a class="tabs_control_link" href="#">
                    <div class="icon-wrap">
                        <i class="icon icon-search_mob"></i>
                    </div>
                    <span>Поиск</span>
                </a>
            </li>
            <li class="tabs_control_item">
                <a class="tabs_control_link" href="#">
                    <div class="icon-wrap">
                        <i class="icon icon-menu_mob"></i>
                    </div>
                    <span>Меню</span>
                </a>
            </li>
            <li class="tabs_control_item">
                <a class="tabs_control_link" href="#">
                    <div class="icon-wrap">
                        <i class="icon icon-cat_mob"></i>
                    </div>
                    <span>Каталог</span>
                </a>
            </li>
        </ul>
        <ul class="tabs_list">
            <div class="close">
                <i class="icon icon-close_mob_menu"></i>
            </div>
            <li class="tabs_item active">
                <div class="title">Главная</div>
            </li>
            <li class="tabs_item tabs_item--account">
                <!-- <section class="login">
                    <div class="title">Аккаунт</div>
                    <div class="login-link">
                        <span>У вас нет аккаунта?</span>
                        <a href="#" class="registr">Зарегистрироваться</a>
                        <a href="#" class="enter">Войти</a>
                    </div>
                </section> -->

                <!-- <section class="login">
                    <div class="top top--info">
                        <a href="#" class="back_link">
                            <i class="icon icon-back"></i>
                            <span>Назад</span>
                        </a>
                        <h2>Вход</h2>
                    </div>
                    <div class="form-wrap">
                        <p class="info success">Мы отправили пароль на exemple@gmail.com</p>
                        <form action="#">
                            <label>
                                <span>E-mail</span>
                                <input type="text" value="Введите ваш E-mail" />
                            </label>
                            <label>
                                <span>Пароль</span>
                                <a href="#">Забыли пароль?</a>
                                <input type="password" placeholder="Введите ваш пароль" />
                                <i class="icon icon-visible"></i>
                            </label>
                            <div class="button-wrap">
                                <button class="btn btn-accent" type="submit">Войти</button>
                            </div>
                        </form>
                    </div>
                    <div class="login_social-wrap">
                        <div class="login_social">
                            <span>Или войти с помощью</span>
                            <a href="#">
                                <i class="icon icon-fb-2"></i>
                            </a>
                            <a href="#">
                                <i class="icon icon-vk-2"></i>
                            </a>
                            <a href="#">
                                <i class="icon icon-tw-2"></i>
                            </a>
                        </div>
                    </div>
                </section> -->

                <!-- <section class="login">
                    <div class="top top--info">
                        <a href="#" class="back_link">
                            <i class="icon icon-back"></i>
                            <span>Назад</span>
                        </a>
                        <h2>Забыли пароль?</h2>
                    </div>
                    <div class="form-wrap">
                        <p class="info">Для восстановления пароля укажите E-mail, на который будет отправлен Ваш пароль</p>
                        <p class="info error">Указанный E-mail, не зарегистрирован в системе</p>
                        <form action="#">
                            <label>
                                <span>E-mail</span>
                                <input type="text" value="Введите ваш E-mail" />
                            </label>
                            <div class="button-wrap">
                                <button class="btn btn-accent" type="submit">Отправить</button>
                            </div>
                        </form>
                    </div>
                </section> -->

                <!-- <section class="login">
                    <div class="top">
                        <a href="#" class="back_link">
                            <i class="icon icon-back"></i>
                            <span>Назад</span>
                        </a>
                        <h2>Выход</h2>
                    </div>
                    <div class="user-info">
                        <div class="img-wrap">
                            <img src="img/user_ico.png" alt="user">
                        </div>
                        <p class="email">exemple@gmail.com</p>
                    </div>
                    <div class="form-wrap">
                        <form action="#">
                            <div class="button-wrap">
                                <button class="btn btn-exit" type="submit">Выйти</button>
                            </div>
                        </form>
                    </div>
                </section> -->

                <section class="login">
                    <div class="top">
                        <a href="<?php echo $back; ?>" class="back_link">
                            <i class="icon icon-back"></i>
                            <span>Назад</span>
                        </a>
                        <h2>Регистрация</h2>
                    </div>
                    <div class="form-wrap">

                        <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" >
                            <label>
                                <span>E-mail</span>
                                <input type="email" name="email" value="" placeholder="E-Mail" id="input-email" class="form-control" />
                            </label>
                            <label>
                                <span>Пароль</span>
                                <input type="password" name="password" value="" placeholder="не менее 5 символов" id="input-password" class="form-control" />
                                <i class="icon icon-visible"></i>
                            </label>
                            <div class="button-wrap">
                                <button class="btn btn-accent" type="submit">Зарегистрироваться</button>
                            </div>
                        </form>


                    </div>
                    <div class="login_social-wrap">
                        <div class="login_social">
                            <span>Или зарегистрироваться с помощью</span>
                            <a href="<?php echo $fb ?>">
                                <i class="icon icon-fb-2"></i>
                            </a>
                            <a href="<?php echo $vk ?>">
                                <i class="icon icon-vk-2"></i>
                            </a>
                            <a href="<?php echo $tw ?>">
                                <i class="icon icon-tw-2"></i>
                            </a>
                        </div>
                    </div>
                </section>

            </li>
            <li class="tabs_item tabs_item--search">
                <div class="title">Поиск</div>

                <div class="search-wrap">
                    <i class="icon icon-search-2"></i>
                    <input id="teste" type="text" class="srch__field_2" name="search" placeholder="Что будем искать?" />
                    <i class="icon icon-delete"></i>
                </div>
                <div class="result-wrap">
                    <ul class="srch__result_2">

                    </ul>
                </div>
            </li>
            <li class="tabs_item tabs_item--menu">
                <div class="title">Меню</div>
                <div class="top">
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
                            <a href="#">Гарантия</a>
                        </li>
                        <li>
                            <a href="<?php echo $return; ?>">Возврат</a>
                        </li>
                        <li>
                            <a href="#">Оплата</a>
                        </li>
                    </ul>
                </div>
            </li>
            <li class="tabs_item tabs_item--catalog">
                <div class="title">Каталог</div>
                <div id="mobileAllCat" class="menu-wrapper">
                    <div class="first">
                        <input id="match-search" type="text" placeholder="Поиск по каталогу" />
                        <i class="icon icon-search-2"></i>
                    </div>
                    <div class="category_menu">
                        <ul id="mainPgCat-mobile" class="custom_layer_cart">
                            <li id="not">
                                <a href="#">Совпадений не найдено!</a>
                            </li>
                            <?php foreach ($categories as $key => $category) { ?>
                                <li class="li_custom">
                                    <a href="<?php echo $category['href']; ?>"><?php echo $category['name']; ?></a>
                                    <?php if ($category['children']) { ?>
                                        <i class="icon icon-arrow"></i>
                                        <ul class="category_menu-sub_menu">
                                            <?php foreach ($category['children'] as $child) { ?>
                                                <li>
                                                    <a href="<?php echo $child['href']; ?>"><?php echo $child['name']; ?></a>
                                                </li>
                                            <?php } ?>
                                        </ul>
                                    <?php } ?>
                                </li>
                            <?php } ?>
                        </ul>
                    </div>
                    <div class="last li_custom">
                        <a href="<?php echo $catalog ?>">Смотреть весь каталог</a>
                    </div>
                </div>
                <!-- <div class="title">Сортировка</div>
                <p class="descr">
                    Выбранный производитель будет отображаться первым
                </p>
                <div class="sort">
                    <div class="item">
                        <a href="#">Grundfos</a>
                    </div>
                    <div class="item">
                        <a href="#">UNIPUMP</a>
                    </div>
                </div> -->
            </li>
        </ul>
        <div class="tab-line"></div>
    </div>
</div>
<footer>
  <div class="container">
    <div class="row">
      <div class="col-lg-1 col-md-1 hidden-sm"></div>
      <div class="col-lg-2 col-md-2 col-sm-3">
        <h3>Компания</h3>
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
      <div class="col-lg-2 col-md-2 col-sm-3">
        <h3>Покупателям</h3>
        <ul>
          <li>
            <a href="<?php echo $delivery; ?>">Доставка</a>
          </li>
          <li>
            <a href="#">Гаранития</a>
          </li>
          <li>
            <a href="<?php echo $return; ?>">Возврат</a>
          </li>
          <li>
            <a href="<?php echo $catalog; ?>">Каталог</a>
          </li>
          <li>
            <a href="<?php echo $manufacturer; ?>">Произвидители</a>
          </li>
        </ul>
      </div>
      <div class="col-lg-2 col-md-2 col-sm-2">
        <h3>Медиа</h3>
        <ul>
          <li>
            <a href="<?php echo $news ?>">Новости</a>
          </li>
          <li>
            <a href="<?php echo $blog ?>">Статьи</a>
          </li>
        </ul>
      </div>
      <div class="col-lg-1 col-md-1 hidden-sm"></div>
      <div class="col-lg-4 col-md-4 col-sm-4">
        <a href="/" class="logo">
          <img src="/image/logo_footer.png" alt="logo">
        </a>
        <p>ЗАО "Чистый берег" УНП 101489077 <br/>
          Дата регистрации торговом реестре <br/>
          с 07.08.2014 г. №101489077, <br/>
          выдан 11.12.2009 г., Мингорисполком.</p>
        <div class="social-wrap">
          <a href="https://www.facebook.com/bereg.by/">
            <i class="icon icon-fb"></i>
          </a>
          <a href="https://www.instagram.com/bereg.by/">
            <i class="icon icon-inst"></i>
          </a>
          <a href="https://www.youtube.com/channel/UCjEwepZ7cFoX45Q7SFjqCpQ">
            <i class="icon icon-ytube"></i>
          </a>
        </div>
      </div>
    </div>
  </div>
  <div class="bottom-footer">
    <div class="container">
      <div class="row">
        <div class="col-lg-1 col-md-1 hidden-sm"></div>
        <div class="col-lg-2 col-md-2 col-sm-3">
          <h3>Безналичные продажи</h3>
          <ul>
            <li>
              <a href="tel:+375 (17) 279-43-79">+375 (17) 279-43-79</a>
            </li>
            <li>
              <a href="mailto:zakaz@bereg.by">zakaz@bereg.by</a>
            </li>
          </ul>
        </div>
        <div class="col-lg-2 col-md-2 col-sm-3">
          <h3>Наличные продажи</h3>
          <ul>
            <li>
              <a href="tel:+375 (29) 679-43-54">+375 (29) 679-43-54</a>
            </li>
            <li>
              <a href="mailto:shop@bereg.by">shop@bereg.by</a>
            </li>
          </ul>
        </div>
        <div class="col-lg-2 col-md-2 col-sm-2">
          <h3>Время работы</h3>
          <ul>
            <li>Пн - Пт 9:00 - 18:00</li>
          </ul>
        </div>
        <div class="col-lg-1 col-md-1 hidden-sm"></div>
        <div class="col-lg-4 col-md-4 col-sm-4">
          <h3>Адрес склада</h3>
          <ul>
            <li>п/у Колядичи, напротив <br/> ул.Бабушкина, 78</li>
          </ul>
          <div class="card-wrap">
            <i class="icon icon-visa"></i>
            <i class="icon icon-mc"></i>
          </div>
        </div>
      </div>
    </div>
  </div>
    <!-- Yandex.Metrika counter -->
    <script type="text/javascript" >
        (function(m,e,t,r,i,k,a){m[i]=m[i]||function(){(m[i].a=m[i].a||[]).push(arguments)};
                m[i].l=1*new Date();k=e.createElement(t),a=e.getElementsByTagName(t)[0],k.async=1,k.src=r,a.parentNode.insertBefore(k,a)})
        (window, document, "script", "https://mc.yandex.ru/metrika/tag.js", "ym");

        ym(1655633, "init", {
            clickmap:true,
            trackLinks:true,
            accurateTrackBounce:true,
            webvisor:true,
            ecommerce:"dataLayer"
        });
    </script>
    <noscript><div><img src="https://mc.yandex.ru/watch/1655633" style="position:absolute; left:-9999px;" alt="" /></div></noscript>
    <!-- /Yandex.Metrika counter -->
</footer>
</div>
<div id="overlay"></div>
<div id="overlay-cart"></div>
</body>
</html>

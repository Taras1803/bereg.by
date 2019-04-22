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
        <h1><?php echo $heading_title; ?></h1>
        <p class="descr descr--contact">
          Контактная информация ЗАО «Чистый берег» : <br />
          Для просмотра кликните по заголовку интересуего вас раздела
        </p>
      </div>
    </div>
  </div>
</section>

<section class="contact">
  <div class="container">
    <div class="row">
      <div class="col-lg-12">
        <div class="mobile-txt title"><?php echo $heading_title; ?></div>
      </div>
      <div class="col-lg-1"></div>
      <div class="col-lg-10">
        <div class="contact-wrap">


<?php foreach($locations_groups as $group){ ?>
          <div class="contact-item">
            <h3>
              <i class="icon icon-plus"></i>
              <span><?php echo $group['name'] ?></span>
            </h3>
                <div class="contact-item_inner clearfix">
                  <?php foreach($group['locations'] as $key => $store){ ?>

                    <?php if(count($group['locations']) > 1){ ?>
                    <div class="heading-wrap">
                      <h4><span>0<?php echo $key+1 ?></span><?php echo $store['name'] ?></h4>
                      <?php } ?>


                      <div class="send-wrap">
                        <a href="#popup_email" class="popup_open" data-type="loc" data-id="<?php echo $store['location_id'] ?>">
                          <i class="icon icon-contact-send"></i>
                        </a>
                        <a href="#popup_phone" class="popup_open" data-type="loc" data-id="<?php echo $store['location_id'] ?>">
                          <i class="icon icon-contact-sms"></i>
                        </a>
                      </div>


                      <?php if(count($group['locations']) > 1){ ?>
                      </div>
                        <?php } ?>

                    <div class="clearfix">
                        <ul>
                          <?php if($store['open']){ ?>
                            <li>
                              <i class="icon icon-contact-time"></i>
                              <span><?php echo $store['open'] ?></span>
                            </li>
                          <?php } ?>
                          <?php if($store['telephone']) { ?>
                            <li>
                              <i class="icon icon-contact-phone"></i>
                                <?php foreach($store['telephone'] as $telephone) { ?>
                                    <span><?php echo $telephone ?></span>
                              <?php } ?>
                            </li>
                          <?php } ?>
                          <?php if($store['fax']) { ?>
                            <li>
                              <i class="icon icon-contact-fax"></i>
                              <span><?php echo $store['fax'] ?></span>
                            </li>
                          <?php } ?>
                          <?php if($store['address']) { ?>
                            <li>
                              <i class="icon icon-contact-marker"></i>
                              <span><?php echo $store['address'] ?></span>
                            </li>
                          <?php } ?>
                          <?php if($store['email']) { ?>
                            <li>
                              <i class="icon icon-contact-mail"></i>
                              <span><?php echo $store['email'] ?></span>
                            </li>
                          <?php } ?>
                          <?php if($store['geocode']) { ?>
                            <li>
                              <i class="icon icon-contact-pos"></i>
                              <span><?php echo $store['geocode'] ?></span>
                            </li>
                          <?php } ?>
                        </ul>
                      <div class="contact_map">
                          <iframe src="http://maps.google.com/maps?q=<?php echo $store['geocode_w'] ?>, <?php echo $store['geocode_h'] ?>&z=15&output=embed" width="360" height="270" frameborder="0" style="border:0"></iframe>
                      </div>
                    </div>

                  <?php } ?>
              </div>

           </div>

<?php } ?>

          <?php echo $content_bottom; ?>

          <div class="contact-item">
            <h3>
              <i class="icon icon-plus"></i>
              <span><?php echo $regions['name'] ?></span>
            </h3>
            <div class="contact-item_inner clearfix">
              <?php foreach($regions['locations'] as $key => $location) { ?>
                  <div class="contact-item_inner--region clearfix">
                <div class="heading-wrap">
                  <h4><span><?php echo $key+1 ?></span><?php echo $location['name'] ?></h4>
                  <div class="send-wrap">
                    <a href="#popup_email" class="popup_open" data-type="loc" data-id="<?php echo $location['location_id'] ?>">
                      <i class="icon icon-contact-send"></i>
                    </a>
                    <a href="#popup_phone" class="popup_open" data-type="loc" data-id="<?php echo $location['location_id'] ?>">
                      <i class="icon icon-contact-sms"></i>
                    </a>
                  </div>
                </div>
                <div class="clearfix">
                  <ul>
                    <li>
                      <i class="icon icon-contact-marker"></i>
                      <span><?php echo $location['address'] ?></span>
                    </li>
                    <li>
                      <i class="icon icon-contact-phone"></i>
                      <?php foreach($location['telephone'] as  $telephone) { ?>
                        <span><?php echo $telephone ?></span>
                      <?php } ?>
                    </li>
                    <li>
                      <i class="icon icon-contact-pos"></i>
                      <span><?php echo $location['geocode'] ?></span>
                    </li>
                  </ul>
                  <?php if(count($location['settings']) > 0){ ?>
                    <?php foreach($location['settings'] as $key => $location_append) { ?>
                      <ul>
                        <li>
                          <i class="icon icon-contact-marker"></i>
                          <span><?php echo $location_append['address_append'] ?></span>
                        </li>
                        <li>
                          <i class="icon icon-contact-phone"></i>
                          <?php foreach(explode(',', $location_append['telephone_append']) as $telephone) { ?>
                            <span><?php echo $telephone ?></span>
                          <?php } ?>
                        </li>
                        <li>
                          <i class="icon icon-contact-pos"></i>
                          <span><?php echo $location_append['geocode_append'] ?></span>
                        </li>
                      </ul>
                    <?php } ?>
                  <?php } ?>
                </div>
              </div>
              <?php } ?>
            </div>
          </div>
        </div>
      </div>
      <div class="col-lg-1"></div>
    </div>
    <div class="row">
      <div class="col-lg-1"></div>
      <div class="col-lg-10">
        <div class="contact-form_wrap">
          <h4>Напишите нам</h4>
          <span class="e-mail"><?php echo $main_email ?></span>
          <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data">
            <div class="form-item">
              <label>
                <span>E-mail</span>
                <input id="input-email" type="text" name="email" value="<?php echo $email; ?>" placeholder="Введите ваш E-mail" class="form-control" />
                  <?php if ($error_email) { ?>
                      <div class="text-danger"><?php echo $error_email; ?></div>
                  <?php } ?>
              </label>
            </div>
            <div class="form-item">
              <label>
                <span>Имя</span>
                <input type="text" name="name" value="<?php echo $name; ?>" id="input-name" class="form-control" placeholder="Введите ваше имя" />
                <?php if ($error_name) { ?>
                <div class="text-danger"><?php echo $error_name; ?></div>
                <?php } ?>
              </label>
            </div>
            <div class="form-item">
              <label>
                <span>Сообщение</span>
                <textarea name="enquiry" id="input-enquiry" class="form-control" placeholder="Пишите, не стесняйтесь ;)"></textarea>
                <?php if ($error_enquiry) { ?>
                <div class="text-danger"><?php echo $error_enquiry; ?></div>
                <?php } ?>
              </label>
            </div>
            <div class="form-item">
              <button class="btn-accent" type="submit">Отправить</button>
            </div>
            <div class="form-item">
              <label>
                <input type="checkbox" name="copy" value="1"/>
                <span>Отправить мне копию</span>
              </label>
            </div>
          </form>
        </div>
      </div>
      <div class="col-lg-1"></div>
    </div>
  </div>
</section>

<div class="popup" id="popup_phone">
  <div class="close_popup">
    <i class="icon icon-close"></i>
  </div>
  <div class="popup_header">
    <h3>Отправить СМС</h3>
    <p class="sms_store_group">Центральный офис</p>
  </div>
  <div class="popup_body">
    <form id="form_phone">
      <label>
        <span>Телефон</span>
        <input type="text" name="phone" class="send_sms"/>
        <input type="hidden" name="location_id" value="" class="hidden_id"/>
        <input type="hidden" name="type" value="" class="hidden_type"/>
        <input type="hidden" name="action" value="send_sms"/>
      </label>
    </form>
  </div>
  <div class="popup_footer clearfix">
    <button class="btn cancel_btn">Отмена</button>
    <button class="btn btn-accent" id="send_sms_btn">Отправить</button>
  </div>
</div>

<div class="popup" id="popup_email">
  <div class="close_popup">
    <i class="icon icon-close"></i>
  </div>
  <div class="popup_header">
    <h3>Отправить на Email</h3>
    <p class="email_store_group">Центральный офис</p>
  </div>
  <div class="popup_body">
    <form id="form_email">
      <label>
        <span>Email</span>
        <input type="text" name="email" class="send_email"/>
        <div style="display: none; color: red" class="danger">Не корректный email</div>
        <input type="hidden" name="location_id" value="" class="hidden_id"/>
        <input type="hidden" name="type" value="" class="hidden_type"/>
        <input type="hidden" name="action" value="send_email"/>
      </label>
    </form>
  </div>
  <div class="popup_footer clearfix">
    <button class="btn cancel_btn">Отмена</button>
    <button class="btn btn-accent" id="send_email_btn">Отправить</button>
  </div>
</div>
<div id="overlay"></div>
<?php echo $footer; ?>

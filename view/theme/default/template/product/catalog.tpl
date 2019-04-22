<?php echo $header; ?>
<?php echo $search; ?>

<section>
    <div class="container">
        <div class="row">
            <div class="col-lg-12">
                <div class="breadcrumb">
                    <ul>
                      <li>
                          <a href="<?php echo $home ?>">Главная /</a>
                      </li>
                      <li>Каталог</li>
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
                <h1>Каталог</h1>
            </div>
        </div>
    </div>
</section>

<section class="catalog">
    <div class="mobile-txt title">Каталог</div>
    <div class="container">
        <div class="row">
            <?php foreach (array_chunk($categories, round(count($categories) / 3)) as $chunk_categories) { ?>
            <div class="col-lg-4 col-md-4">
                <?php foreach ($chunk_categories as $key => $category) { ?>
                                <div class="cat-item">
                                    <a href="<?php echo $category['href']; ?>"><h3 class="main-cat"><?php echo $category['name']; ?></h3></a>
                                        <?php if($category['children']) { ?>
                                            <ul class="sub-cat">
                                                <?php foreach ($category['children'] as $sub_category) { ?>
                                                    <li>
                                                        <a href="<?php echo $sub_category['href']; ?>"><?php echo $sub_category['name']; ?></a>
                                                    </li>
                                                <?php } ?>
                                            </ul>
                                        <?php } ?>
                                </div>
                <?php } ?>
            </div>
            <?php } ?>
        </div>
    </div>
</section>
<div id="overlay" style="display: none;"></div>
<?php echo $footer; ?>
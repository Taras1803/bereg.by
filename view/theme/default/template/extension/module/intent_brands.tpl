<section class="section-brand">
    <div class="container">
        <div class="row">
            <div class="col-lg-12">
                <h2>Бренды</h2>
                <p>В портфеле компании более 60 торговых марок   40 производителей</p>
                <a href="<?php echo $brands ?>" class="link_all">Смотреть все бренды</a>
            </div>
        </div>
        <div class="row">
            <div class="col-lg-12">
                <div class="brand-item clearfix">
                    <?php  foreach ($products as $product) { ?>
                        <div class="brand-item_img">
                            <a href="<?php echo $product['href']?>">
                                <img class="img" src="<?php echo $product['thumb']?>" alt="IMI">
                                <img class="hover-img" src="<?php echo $product['thumb2']?>" alt="IMI">
                            </a>
                        </div>
                    <?php }?>
                </div>
            </div>
        </div>
    </div>
</section>
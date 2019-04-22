<?php echo $header; ?>
<div class="container">
    <ul class="breadcrumb">
        <?php foreach ($breadcrumbs as $breadcrumb) { ?>
        <?php if($breadcrumb != end($breadcrumbs)) { ?>
        <li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?> /</a></li>
        <?php } else { ?>
        <li><?php echo $breadcrumb['text']; ?></li>
        <?php } ?>
        <?php  } ?>
    </ul>

    <section class="top-title">
        <div class="container">
            <div class="row">
                <div class="col-lg-12">
                    <a href="<?php echo $back; ?>" class="back_link">
                        <i class="icon icon-back"></i>
                        <span>Назад</span>
                    </a>
                    <h1><?php echo $heading_title; ?></h1>
                </div>
            </div>
        </div>
    </section>
    <div class="row"><?php echo $column_left; ?>
        <?php if ($column_left && $column_right) { ?>
        <?php $class = 'col-sm-6'; ?>
        <?php } elseif ($column_left || $column_right) { ?>
        <?php $class = 'col-sm-9'; ?>
        <?php } else { ?>
        <?php $class = 'col-sm-12'; ?>
        <?php } ?>
        <div id="content" class="<?php echo $class; ?>"><?php echo $content_top; ?>
            <section class="clients-details">
                <div class="container">
                    <div class="row">
                        <div class="col-lg-12">
                            <div class="details-wrap">


                                <h1><?php echo $heading_title; ?></h1>
                                <?php echo $description; ?><?php echo $content_bottom; ?></div>
                            <?php echo $column_right; ?></div>

                    </div>
                </div>
            </section>
        </div>
    </div>

</div>
<?php echo $footer; ?>
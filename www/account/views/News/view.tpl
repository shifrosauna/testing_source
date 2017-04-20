<div class="row">
    <div class="col-lg-12">
        <div class="panel panel-default">
            <div class="panel-heading">
                <?php echo $view->item->getTitle(); ?>
                <span class="pull-right"><?php echo $this->toDate($view->item->getDate_c()); ?></span>
            </div>
            <div class="panel-body">
                <?php echo $view->item->getDescription(); ?>
            </div>
            
            <?php if (!empty($view->item->links)): ?>
            <div class="panel-footer">
                &nbsp;
                <?php foreach ($view->item->links as $title => $link): ?>
                    <a href="<?php echo $link; ?>" class="pull-right"><?php echo $title; ?></a>
                <?php endforeach; ?>
            </div>
            <?php endif; ?>
        </div>
    </div>
</div>

<a href="/news">Назад</a>
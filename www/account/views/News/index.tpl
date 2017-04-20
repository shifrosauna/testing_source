<?php if (!empty($view->items)): ?>
<?php foreach ($view->items as $item): ?>
    
    <div class="row">
        <div class="col-lg-12">
            <div class="panel panel-default">
                <div class="panel-heading">
                    <a href="/news/view/<?php echo $item->getId(); ?>"><?php echo $item->getTitle(); ?></a>
                    <span class="pull-right"><?php echo $this->toDate($item->getDate_c()); ?></span>
                </div>
                <div class="panel-body">
                    <p><?php echo $item->getDescription(); ?></p>
                </div>
                
                <?php if (!empty($item->links)): ?>
                <div class="panel-footer">
                    &nbsp;
                    <?php foreach ($item->links as $title => $link): ?>
                        <a href="<?php echo $link; ?>" class="pull-right"><?php echo $title; ?></a>
                        <span class="pull-right">&nbsp;&nbsp;</span>
                    <?php endforeach; ?>
                </div>
                <?php endif; ?>
            </div>
        </div>
    </div>
    
<?php endforeach; ?>
<?php endif; ?>
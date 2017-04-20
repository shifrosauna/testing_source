
<?php echo ($view->_admin) ? $view->tabs : ''; ?>

<div class="row">
    
    <div id="multiple-apks-block" class="col-lg-6">
        <div class="panel panel-info">
            <div class="panel-heading">
                Приложения
            </div>
            <div class="panel-body">
                <div class="table-responsive">
                    <table class="table table-hover" id="arc-apks-table">
                        <thead>
                            <tr>
                                <th>Путь</th>
                                <th></th>
                            </tr>
                        </thead>
                        <tbody><?php if (!empty($view->apks)): ?>
                            <?php foreach($view->apks as $status => $apks): ?>
                            <?php foreach($apks as $apk): ?>
                            
                            <tr class="<?php echo $apk->status; ?>" id="apk-<?php echo $apk->id; ?>">
                                <td class="apk-filename"><b><?php echo $apk->filename; ?></b></td>
                                <td class="apk-percent text-right"><?php echo $apk->percent; ?>%</td>
                            </tr>
                            
                            <?php endforeach; ?>
                            <?php endforeach; ?>
                            <?php endif; ?></tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>
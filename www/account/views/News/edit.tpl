<script type="text/javascript">

    $(document).ready(function(){
        
        $('.datepicker').datepicker({
            autoclose: true,
            format: "yyyy-mm-dd",
            language: "ru",
            todayHighlight: true
        });
        
        //$('.datepicker').datetimepicker();
        
        var form = new Form(
            '#news-update-form',
            {
                'date': ['required'],
                'title': ['required'],
                'description': ['required']
            }
        );
        
        form.init();
    });
</script>

<div class="row">
    <div class="col-lg-12">
        <div class="panel panel-default">
            <div class="panel-heading">
                <?php echo $view->item->getTitle(); ?> <img src="/img/loader.gif" id="news-create-form-loader" class="form-loader" />
            </div>
            <div class="panel-body">
                <div class="row">
                    <div class="col-lg-6">
                        <form action="/news/update" id="news-update-form" role="form" method="POST">
                            
                            <input type="hidden" name="id" value="<?php echo $view->item->getId(); ?>" />
                            
                            <div class="form-group">
                                <label>Дата</label>
                                <input type="text" name="date" id="date" value="<?php echo $this->toDate($view->item->getDate_c()); ?>" class="form-control datepicker" />
                                <p class="form-control-static caption-error" id="caption-date"></p>
                            </div>
                            
                            <div class="form-group">
                                <label>Заголовок</label>
                                <input type="text" name="title" id="title" class="form-control" value="<?php echo $view->item->getTitle(); ?>" />
                                <p class="form-control-static caption-error" id="caption-title"></p>
                                
                            </div>
                            
                            <div class="form-group">
                                <label>Текст</label>
                                <textarea name="description" id="description" class="form-control" rows="8"><?php echo $view->item->getDescription(); ?></textarea>
                                <p class="form-control-static caption-error" id="caption-description"></p>
                            </div>
                            
                            <button type="submit" class="btn btn-default">Сохранить</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
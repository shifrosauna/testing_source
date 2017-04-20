<script type="text/javascript">
    
    $(document).ready(function(){
        
        $('.datepicker').datepicker({
            autoclose: true,
            format: "yyyy-mm-dd",
            language: "ru",
            todayHighlight: true
        });
        
        var form = new Form(
            '#news-create-form',
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
                Добавить новость <img src="/img/loader.gif" id="news-create-form-loader" class="form-loader" />
            </div>
            <div class="panel-body">
                <div class="row">
                    <div class="col-lg-6">
                        
                        <div id="news-create-form-info-bar" class="alert form-info-bar"></div>
                        
                        <form action="/news/create" id="news-create-form" role="form" method="POST">
                            <div class="form-group">
                                <label>Дата</label>
                                <input type="text" name="date" id="date" value="<?php echo date("Y-m-d"); ?>" class="form-control datepicker" />
                                <p class="form-control-static caption-error" id="caption-date"></p>
                            </div>
                            
                            <div class="form-group">
                                <label>Заголовок</label>
                                <input type="text" name="title" id="title" class="form-control" autofocus />
                                <p class="form-control-static caption-error" id="caption-title"></p>
                                
                            </div>
                            
                            <div class="form-group">
                                <label>Текст</label>
                                <textarea name="description" id="description" class="form-control" rows="8"></textarea>
                                <p class="form-control-static caption-error" id="caption-description"></p>
                            </div>
                            
                            <button type="submit" class="btn btn-default">Добавить</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
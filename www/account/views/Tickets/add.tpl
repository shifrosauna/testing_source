<script type="text/javascript">
    
    $(document).ready(function(){
        
        var form = new Form(
            '#tickets-create-form',
            {
                'theme': ['required'],
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
                Создать тикет <img src="/img/loader.gif" id="tickets-create-form-loader" class="form-loader" />
            </div>
            <div class="panel-body">
                
                <div id="tickets-create-form-info-bar" class="alert form-info-bar"></div>
                
                <div class="row">
                    <div class="col-lg-6">
                        <form action="/tickets/create" id="tickets-create-form" role="form" method="POST">
                            
                            <input type="hidden" name="priority_id" value="3" />
                            
                            <div class="form-group">
                                <label>Вкратце опишите суть Вашего вопроса</label>
                                <input type="text" name="theme" id="theme" class="form-control" autofocus />
                                <p class="form-control-static caption-error" id="caption-theme"></p>
                            </div>
                            
                            <div class="form-group">
                                <label>Выберите категорию</label>
                                <select name="category_id" id="category_id" class="form-control">
                                    <?php foreach($view->categories as $category): ?>
                                    <option value="<?php echo $category->id; ?>"<?php echo ($category->by_default) ? ' selected' : ''; ?>><?php echo $category->name; ?></option>
                                    <?php endforeach; ?>
                                </select>
                            </div>
                            
                            <div class="form-group">
                                <label>Подробно опишите Вашу проблему</label>
                                <textarea name="description" id="description" class="form-control" rows="5"></textarea>
                                <p class="form-control-static caption-error" id="caption-description"></p>
                            </div>
                            
                            <button type="submit" class="btn btn-default">Создать</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<style type="text/css">
    .contacts-links:hover {
        text-decoration:none;
    }
    
    /*button[disabled="disabled"]:after {
        content: url(/img/loader.gif);
        width: 18px;
    }*/
    
    .btn-loader {
        width:24px;
        margin: -4px 15px -4px 15px;
    }
    
    .row-loader {
        display: none;
    }
</style>

<script type="text/javascript">
    
    var tables = {};
    
    function tableInit(id) {
        
        return $('#dataTables-partners-'+ id).DataTable({
            order: [[ 0, "desc" ]],
            pageLength: 50,
            language:  {
                search:         "Поиск &nbsp;",
                processing:     "Загружаю...",
                lengthMenu:     "Показывать по _MENU_ партнеров",
                info:           "Показано с _START_ по _END_ из _TOTAL_ строк",
                infoEmpty:      "", // "Показано с 0 по 0 из 0 строк",
                infoFiltered:   "(отфильтровано из _MAX_ строк)",
                infoPostFix:    "",
                loadingRecords: "Загружаю...",
                zeroRecords:    "Нет данных",
                emptyTable:     "Нет данных",
                paginate: {
                    first:      "Первая",
                    previous:   "Предыдущая",
                    next:       "Следующая",
                    last:       "Последняя"
                },
                aria: {
                    sortAscending:  ": сортировать в порядке возрастания",
                    sortDescending: ": сортировать в порядке убывания"
                }
            },
        });
    }
    
    function setAccess(button, offer_id, partner_id, status) {
        
        var row = $('#partner-'+ partner_id);
        var loader = row.find('.row-loader');
        
        loader.show();
        row.find('button').attr('disabled', 'disabled').addClass('hide').removeClass('pull-right');
        
        $.ajax({
            type:     'post',
            dataType: 'json',
            url:      '/offers/accesssave',
            data:     'offer_id='+ offer_id +'&partner_id='+ partner_id +'&status='+ status,
            success:  function (data, textStatus, jqXHR) {
                
                if (data && data.status && data.status == 'success') {
                    
                    tables.approved.destroy();
                    tables.nonapproved.destroy();
                    tables.blocked.destroy();
                    
                    loader.hide();
                    
                    switch (status) {
                        case 'approve':
                            
                            var tableId = 'approved';
                            
                            row.find('button.btn-info').removeAttr('disabled').removeClass('hide');
                            row.find('button.btn-danger').removeAttr('disabled').removeClass('hide').addClass('pull-right');
                            
                            break;
                        
                        case 'nonapprove':
                            
                            var tableId = 'nonapproved';
                            
                            row.find('button.btn-success').removeAttr('disabled').removeClass('hide');
                            row.find('button.btn-danger').removeAttr('disabled').removeClass('hide').addClass('pull-right');
                            
                            break;
                        
                        case 'block':
                            
                            var tableId = 'blocked';
                            
                            row.find('button.btn-success').removeAttr('disabled').removeClass('hide');
                            row.find('button.btn-info').removeAttr('disabled').removeClass('hide').addClass('pull-right');
                            
                            break;
                    }
                    
                    var parentRow = $('#dataTables-partners-'+ tableId).parent().parent().parent().parent().parent();
                    if (parentRow.hasClass('hide')) {
                        $(parentRow).removeClass('hide');
                        $('#dataTables-partners-'+ tableId +' tbody').html('');
                    }
                    
                    $('#dataTables-partners-'+ tableId +' tbody').append(row);
                    row.hide().fadeIn();
                    
                    tables.approved = tableInit('approved');
                    tables.nonapproved = tableInit('nonapproved');
                    tables.blocked = tableInit('blocked');
                    
                } else {
                    $(button).html('Error');
                }
            },
            error: function (jqXHR, textStatus, errorThrown) {
                // select.val('Loading error.');
            }
        });
    }
    
    $(document).ready(function() {
        
        $('h1').prepend('<img src="<?php echo $view->offer->icon; ?>" class="offer-icon-title" />&nbsp;');
        $('h1').append(' <span style="font-size:14px" class="pull-right">id оффера: <?php echo $view->offer->id; ?></span>');
        
        tables.approved = tableInit('approved');
        tables.nonapproved = tableInit('nonapproved');
        tables.blocked = tableInit('blocked');
    });
</script>

<?php echo $view->tabs; ?>

<?php if ($view->offer->is_private == 1): ?>
    <div class="alert alert-danger">
        Оффер является приватным. Доступ к нему имеют только утвержденные пользователи. <br/>
        Изменить настройки приватности можно <a href="/offers/edit/<?php echo $view->offer->id; ?>" class="alert-link">на странице редактирования оффера</a>.
    </div>
<?php else: ?>
    <div class="alert alert-success">
        Оффер находится в публичном доступе. <br/>
        Изменить настройки приватности можно <a href="/offers/edit/<?php echo $view->offer->id; ?>" class="alert-link">на странице редактирования оффера</a>.
    </div>
<?php endif; ?>

<div id="row-approved" class="row <?php echo (empty($view->partners_approved)) ? ' hide' : ''; ?>">
    <div class="col-lg-12">
        <div class="panel panel-success">
            <div class="panel-heading">
                Утвержденные пользователи 
            </div>
            <div class="panel-body">
                <div class="dataTable_wrapper">
                    <table class="table table-striped table-bordered table-hover" id="dataTables-partners-approved">
                        <thead>
                            <tr>
                                <th class="col-lg-1">ID</th>
                                <th class="col-lg-3">Логин</th>
                                <th class="col-lg-3">Контакты</th>
                                <th class="col-lg-2"></th>
                            </tr>
                        </thead>
                        <tbody>
                            <?php foreach ($view->partners_approved as $partner): ?>
                            
                            <tr class="gradeA" id="partner-<?php echo $partner->id ?>">
                                <td class="col-lg-1"><?php echo $partner->id; ?></td>
                                <td class="col-lg-3"><?php echo $partner->login; ?></td>
                                <td class="col-lg-3">
                                    <?php if (!empty($partner->info->skype)): ?>
                                    <a href="skype:[<?php echo $partner->info->skype; ?>]" class="contacts-links"><i class="fa fa-skype fa-fw"></i> <?php echo $partner->info->skype; ?></a><br/>
                                    <?php endif; ?>
                                    
                                    <a href="mailto:<?php echo $partner->email; ?>" class="contacts-links"><i class="fa fa-envelope-o fa-fw"></i> <?php echo $partner->email; ?></a>
                                </td>
                                
                                <td class="col-lg-2">
                                    <button type="button" class="btn btn-sm btn-success hide" onclick="setAccess(this, <?php echo $view->offer->id ?>, <?php echo $partner->id ?>, 'approve')">Утвердить</button>
                                    <button type="button" class="btn btn-sm btn-info" onclick="setAccess(this, <?php echo $view->offer->id ?>, <?php echo $partner->id ?>, 'nonapprove')">Сбросить</button>
                                    <button type="button" class="btn btn-sm btn-danger pull-right" onclick="setAccess(this, <?php echo $view->offer->id ?>, <?php echo $partner->id ?>, 'block')">Заблокировать</button>
                                    
                                    <img src="/img/loader.gif" class="row-loader" />
                                </td>
                            </tr>
                            
                            <?php endforeach; ?>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>

<div id="row-nonapproved" class="row <?php echo (empty($view->partners_nonapproved)) ? ' hide' : ''; ?>">
    <div class="col-lg-12">
        <div class="panel panel-info">
            <div class="panel-heading">
                Неутвержденные пользователи
            </div>
            <div class="panel-body">
                <div class="dataTable_wrapper">
                    <table class="table table-striped table-bordered table-hover" id="dataTables-partners-nonapproved">
                        <thead>
                            <tr>
                                <th class="col-lg-1">ID</th>
                                <th class="col-lg-3">Логин</th>
                                <th class="col-lg-3">Контакты</th>
                                <th class="col-lg-2"></th>
                            </tr>
                        </thead>
                        <tbody>
                            <?php foreach ($view->partners_nonapproved as $partner): ?>
                            
                            <tr class="gradeA" id="partner-<?php echo $partner->id ?>">
                                <td class="col-lg-1"><?php echo $partner->id; ?></td>
                                <td class="col-lg-3"><?php echo $partner->login; ?></td>
                                <td class="col-lg-3">
                                    <?php if (!empty($partner->info->skype)): ?>
                                    <a href="skype:[<?php echo $partner->info->skype; ?>]" class="contacts-links"><i class="fa fa-skype fa-fw"></i> <?php echo $partner->info->skype; ?></a><br/>
                                    <?php endif; ?>
                                    
                                    <a href="mailto:<?php echo $partner->email; ?>" class="contacts-links"><i class="fa fa-envelope-o fa-fw"></i> <?php echo $partner->email; ?></a>
                                </td>
                                
                                <td class="col-lg-2">
                                    <button type="button" class="btn btn-sm btn-success" onclick="setAccess(this, <?php echo $view->offer->id ?>, <?php echo $partner->id ?>, 'approve')">Утвердить</button>
                                    <button type="button" class="btn btn-sm btn-info hide" onclick="setAccess(this, <?php echo $view->offer->id ?>, <?php echo $partner->id ?>, 'nonapprove')">Сбросить</button>
                                    <button type="button" class="btn btn-sm btn-danger pull-right" onclick="setAccess(this, <?php echo $view->offer->id ?>, <?php echo $partner->id ?>, 'block')">Заблокировать</button>
                                    
                                    <img src="/img/loader.gif" class="row-loader" />
                                </td>
                            </tr>
                            
                            <?php endforeach; ?>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>

<div id="row-blocked" class="row <?php echo (empty($view->partners_blocked)) ? ' hide' : ''; ?>">
    <div class="col-lg-12">
        <div class="panel panel-danger">
            <div class="panel-heading">
                Заблокированные пользователи
            </div>
            <div class="panel-body">
                <div class="dataTable_wrapper">
                    <table class="table table-striped table-bordered table-hover" id="dataTables-partners-blocked">
                        <thead>
                            <tr>
                                <th class="col-lg-1">ID</th>
                                <th class="col-lg-3">Логин</th>
                                <th class="col-lg-3">Контакты</th>
                                <th class="col-lg-2"></th>
                            </tr>
                        </thead>
                        <tbody>
                            <?php foreach ($view->partners_blocked as $partner): ?>
                            
                            <tr class="gradeA" id="partner-<?php echo $partner->id ?>">
                                <td class="col-lg-1"><?php echo $partner->id; ?></td>
                                <td class="col-lg-3"><?php echo $partner->login; ?></td>
                                <td class="col-lg-3">
                                    <?php if (!empty($partner->info->skype)): ?>
                                    <a href="skype:[<?php echo $partner->info->skype; ?>]" class="contacts-links"><i class="fa fa-skype fa-fw"></i> <?php echo $partner->info->skype; ?></a><br/>
                                    <?php endif; ?>
                                    
                                    <a href="mailto:<?php echo $partner->email; ?>" class="contacts-links"><i class="fa fa-envelope-o fa-fw"></i> <?php echo $partner->email; ?></a>
                                </td>
                                
                                <td class="col-lg-2">
                                    <button type="button" class="btn btn-sm btn-success" onclick="setAccess(this, <?php echo $view->offer->id ?>, <?php echo $partner->id ?>, 'approve')">Утвердить</button>
                                    <button type="button" class="btn btn-sm btn-info pull-right" onclick="setAccess(this, <?php echo $view->offer->id ?>, <?php echo $partner->id ?>, 'nonapprove')">Сбросить</button>
                                    <button type="button" class="btn btn-sm btn-danger hide" onclick="setAccess(this, <?php echo $view->offer->id ?>, <?php echo $partner->id ?>, 'block')">Заблокировать</button>
                                    
                                    <img src="/img/loader.gif" class="row-loader" />
                                </td>
                            </tr>
                            
                            <?php endforeach; ?>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>
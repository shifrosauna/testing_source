<style type="text/css">
    .contacts-links:hover {
        text-decoration:none;
    }
</style>
    
<script>
    $(document).ready(function() {
        $('#dataTables-partners').DataTable({
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
    });
</script>

<div class="row">
    <div class="col-lg-12">
        <div class="panel panel-default">
            <div class="panel-body">
                <div class="dataTable_wrapper">
                    <table class="table table-striped table-bordered table-hover" id="dataTables-partners">
                        <thead>
                            <tr>
                                <th style="width:1px"></th>
                                <th>Логин</th>
                                <th>Контакты</th>
                                <th>WMZ</th>
                                <th>Трафик</th>
                                <th>Привел</th>
                            </tr>
                        </thead>
                        <tbody>
                            <?php if (!empty($view->partners)): ?>
                            <?php foreach ($view->partners as $partner): ?>
                            
                            <tr class="gradeA">
                                <td><?php echo $partner->id; ?></td>
                                <td><?php echo $partner->login; ?></td>
                                <td>
                                    <?php if (!empty($partner->info->skype)): ?>
                                    <a href="skype:[<?php echo $partner->info->skype; ?>]" class="contacts-links"><i class="fa fa-skype fa-fw"></i> <?php echo $partner->info->skype; ?></a><br/>
                                    <?php endif; ?>
                                    
                                    <a href="mailto:<?php echo $partner->email; ?>" class="contacts-links"><i class="fa fa-envelope-o fa-fw"></i> <?php echo $partner->email; ?></a>
                                </td>
                                
                                <td><?php echo (!empty($partner->info->wmz)) ? $partner->info->wmz : ''; ?></td>
                                
                                <td>
                                    <?php echo (!empty($partner->info->traffic_types)) ? '<b>Источники:</b> '. $partner->info->traffic_types .'<br/><br/>' : ''; ?>
                                    <?php echo (!empty($partner->info->traffic_subjects)) ? '<b>Тематика:</b> '. $partner->info->traffic_subjects .'<br/><br/>' : ''; ?>
                                    <?php echo (!empty($partner->info->traffic_volumes)) ? '<b>Объемы:</b> '. $partner->info->traffic_volumes : ''; ?>
                                </td>
                                
                                <td><?php echo (!empty($partner->ref_partner)) ? $partner->ref_partner : ''; ?></td>
                            </tr>
                            
                            <?php endforeach; ?>
                            <?php endif; ?>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>
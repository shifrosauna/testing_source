<script>
    $(document).ready(function() {
        
        var userLang = getCookie('lang');
        var langTable = (userLang && userLang == 'en')
            ?  {
                    search: "Search &nbsp;",
                    processing:     "Loading...",
                    lengthMenu:     "Show _MENU_ offers",
                    info:           "Showes from _START_ to _END_ of _TOTAL_ offers",
                    infoEmpty:      "", // "Показано с 0 по 0 из 0 строк",
                    infoFiltered:   "(filtered from _MAX_ offers)",
                    infoPostFix:    "",
                    loadingRecords: "Loading...",
                    zeroRecords:    "Empty data",
                    emptyTable:     "Empty data",
                    paginate: {
                        first:      "First",
                        previous:   "Prev",
                        next:       "Next",
                        last:       "Last"
                    },
                    aria: {
                        sortAscending:  ": сортировать в порядке возрастания",
                        sortDescending: ": сортировать в порядке убывания"
                    }
                }
            : {
                    search:         "Поиск &nbsp;",
                processing:     "Загружаю...",
                lengthMenu:     "Показывать по _MENU_ офферов",
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
            }
        ;
        
        $('#dataTables-offers').DataTable({
            //responsive: true,
            order: [[ 0, "desc" ]],
            pageLength: 25,
            language:  langTable,
        });
    });
</script>

<div class="row">
    <div class="col-lg-12">
        <div class="panel panel-default">
            
            <!--div class="panel-heading">
                Header
            </div-->
            
            <div class="panel-body">
                
                <!--div class="well">
                    <h4>Filters</h4>
                    <p>DataTables is a very flexible, advanced tables plugin for jQuery. In SB Admin, we are using a specialized version of DataTables built for Bootstrap 3. We have also customized the table headings to use Font Awesome icons in place of images. For complete documentation on DataTables, visit their website at <a target="_blank" href="https://datatables.net/">https://datatables.net/</a>.</p>
                    <a class="btn btn-default btn-lg btn-block" target="_blank" href="https://datatables.net/">Reload</a>
                </div-->
                
                <div class="dataTable_wrapper">
                    <table class="table table-striped table-bordered table-hover" id="dataTables-offers">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th></th>
                                <th>Название</th>
                                <th>Ставка</th>
                                <th>Предпросмотр</th>
                                <th>Тип отдачи</th>
                                <th style="max-width:300px">География</th>
                                
                                <?php if (!empty($view->_admin)): ?>
                                <th></th>
                                <?php endif; ?>
                            </tr>
                        </thead>
                        <tbody>
                            <?php if (!empty($view->offers)): ?>
                            <?php foreach ($view->offers as $offer): ?>
                            
                            <tr class="gradeA">
                                <td class="col-id_"><?php echo $offer->id; ?></td>
                                <td class="col-icon">
                                    <?php if (!empty($offer->icon)): ?>
                                    <img src="<?php echo $offer->icon; ?>" class="offer-icon" />
                                    <?php endif; ?>
                                </td>
                                <td style="max-width:350px">
                                    <a href="<?php echo $offer->view_link; ?>"><?php echo $offer->name; ?></a>
                                </td>
                                
                                <?php if (!empty($offer->countries_payouts)): ?>
                                <td data-order="<?php echo $offer->max_countries_payouts; ?>">
                                    <div class="table-responsive">
                                        <table>
                                            <tbody>
                                                <?php foreach ($offer->countries_payouts as $country): ?>
                                                <tr>
                                                    <td style="padding-right:10px"><?php echo $country->name; ?></td>
                                                    <td><b><?php echo $country->cpa; ?></b> $</td>
                                                </tr>
                                                <?php endforeach; ?>
                                                <tr>
                                                    <td colspan="2"><a href="<?php echo $offer->view_link; ?>">Остальные страны</a></td>
                                                </tr>
                                            </tbody>
                                        </table>
                                    </div>
                                </td>
                                <?php else: ?>
                                <td data-order="<?php echo $offer->goals_cpa; ?>">
                                    <?php echo (!empty($offer->goals_cpa)) ? $offer->goals_cpa : 0; ?> $
                                </td>
                                <?php endif; ?>
                                
                                <td class="col-preview_"><a href="<?php echo $offer->preview_url; ?>" target="_blank"><i class="fa fa-external-link-square fa-fw"></i></a></td>
                                
                                <td><?php echo $offer->return_type; ?></td>
                                <td style="max-width:350px">
                                
                                    <?php if (!empty($offer->countries_title)): ?>
                                    <a class="tooltip-link" data-toggle="tooltip" data-placement="bottom" data-original-title="<?php echo $offer->countries_title; ?>">
                                    <i class="fa fa-search-plus fa-fw"></i>
                                    <?php endif; ?>
                                    
                                    <?php echo $offer->countries; ?>
                                    
                                    <?php if (!empty($offer->countries_title)): ?>
                                    </a>
                                    <?php endif; ?>
                                </td>
                                
                                <?php if (!empty($view->_admin)): ?>
                                <td class="col-id <?php echo (empty($offer->options->appmetrika_app_id)) ? ' danger' : ''; ?>" style="cursor: pointer" onclick="location.href='<?php echo $offer->edit_link; ?>'">
                                    <a href="/offers/<?php echo (empty($offer->arc)) ? 'edit' : 'arc_edit'; ?>/<?php echo $offer->id; ?>"><i class="fa fa-pencil fa-fw"></i></a>
                                </td>
                                <?php endif; ?>
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
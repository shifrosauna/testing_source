<script>
    $(document).ready(function() {
        $('#dataTables-example').DataTable({
            responsive: true
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
                    <table class="table table-striped table-bordered table-hover" id="dataTables-example">
                        <thead>
                            <tr>
                                <th>Дата</th>
                                
                                <?php if ($view->_admin): ?>
                                <th>Партнер</th>
                                <?php endif; ?>
                                
                                <th>Тема</th>
                                
                                <?php if ($view->_admin): ?><th></th><?php endif; ?>
                            </tr>
                        </thead>
                        <tbody>
                            <?php if (!empty($view->tickets)): ?>
                            <?php foreach ($view->tickets as $ticket): ?>
                            
                            <tr class="gradeA">
                                <td><?php echo $ticket->toDate('date_c'); ?></td>
                                
                                <?php if ($view->_admin): ?>
                                <td><?php echo $ticket->owner_name; ?></td>
                                <?php endif; ?>
                                
                                
                                <td><a href="/tickets/view/<?php echo $ticket->id; ?>"><?php echo $ticket->theme; ?></a></td>
                                
                                <?php if ($view->_admin && !empty($ticket->links)): ?>
                                <td class="col-id">
                                    <a href="/tickets/edit/<?php echo $ticket->id; ?>"><i class="fa fa-pencil fa-fw"></i></a>
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
    <?php if (!empty($view->weeks) && $view->_admin): ?>
    
    <div class="row">
        <div class="col-lg-12">
            <div class="panel panel-info">
                <div class="panel-heading">
                    Выплаты
                </div>
                <div class="panel-body">
                    <div class="table-responsive">
                        <table class="table table-hover">
                            <thead>
                                <tr>
                                    <th>Неделя</th>
                                    <th>Сумма</th>
                                    <th>CSV</th>
                                    <th>XML</th>
                                </tr>
                            </thead>
                            <tbody>
                                <?php foreach ($view->weeks as $week): ?>
                                
                                <tr>
                                    <td><?php echo $week['date_from'] .' - '. $week['date_to']; ?></td>
                                    <td><?php echo $week['sum']; ?> $</td>
                                    <td><a href="/payments/csv?date_from=<?php echo $week['date_from']; ?>&date_to=<?php echo $week['date_to']; ?>">csv</a></td>
                                    <td><a href="/payments/xml?date_from=<?php echo $week['date_from']; ?>&date_to=<?php echo $week['date_to']; ?>">xml</a></td>
                                </tr>
                                
                                <?php endforeach; ?>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <?php else: ?>
    
    <div class="row">
        <div class="col-lg-12">
            <div class="panel panel-default">
                <div class="panel-body">
                    
                    <p>
                    <?php if (!empty($view->wmz)): ?>
                    Ваш кошелек: <?php echo $view->wmz; ?><br/><br/>
                    <?php endif; ?>
                    </p>
                    
                    <p>На данный момент по Вашему аккаунту выплат не осуществлялось.</p>
                </div>
            </div>
        </div>
    </div>
    
    <?php endif; ?>
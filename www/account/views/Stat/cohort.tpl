
<link rel="stylesheet" type="text/css" href="/bower_components/bootstrap-daterangepicker/daterangepicker.css" />

<script type="text/javascript" src="/bower_components/moment/min/moment.min.js"></script>
<script type="text/javascript" src="/bower_components/bootstrap-daterangepicker/daterangepicker.js"></script>
<script type="text/javascript" src="/bower_components/datatables-fixedheader/js/dataTables.fixedHeader.js"></script>

<script type="text/javascript" src="/dist/js/stat_cohort.js"></script>

<div class="row">
    <div class="col-lg-12">
        <div class="panel panel-default">
            <div class="panel-body">
                <form id="stat-filters-form" action="/stat/cohortload" method="POST">
                    <div class="row">
						
						<div class="col-lg-2">
                            <div class="panel panel-info">
                                <div class="panel-heading">
                                    Детализация
                                </div>
                                <div class="panel-body" style="padding:5px 15px">
									
                                    <div class="form-group">
										<div class="checkbox">
                                            <label>
                                                <input type="checkbox" name="agregate[]" value="date" class="data-params" checked="checked" />Дата
                                            </label>
                                        </div>
                                        <!--div class="checkbox">
                                            <label>
                                                <input type="checkbox" name="agregate[]" value="month" class="data-params" />Месяц
                                            </label>
                                        </div-->
                                    </div>
                                </div>
								<div class="panel-footer" style="display:inline-block; padding: 0 15px; width: 100%">
									<div class="form-group">
										<div class="checkbox">
                                            <label>
                                                <input type="checkbox" name="fields[]" value="offer" class="data-params" />Оффер
                                            </label>
                                        </div>
										
										<div class="checkbox">
                                            <label>
                                                <input type="checkbox" name="fields[]" value="partner" class="data-params" />Партнер
                                            </label>
                                        </div>
										<div class="checkbox">
                                            <label>
                                                <input type="checkbox" name="fields[]" value="country" class="data-params" />Страна
                                            </label>
                                        </div>
										<div class="checkbox">
                                            <label>
                                                <input type="checkbox" name="fields[]" value="mediator" class="data-params" />Медиатор
                                            </label>
                                        </div>
                                    </div>
								</div>
                            </div>
                        </div>
						
                        <div class="col-lg-2">
                            <div class="panel panel-info">
                                <div class="panel-heading">
                                    Данные
                                </div>
                                <div class="panel-body" style="padding:5px 15px">
                                    <div class="form-group">
                                        <div class="checkbox">
                                            <label>
                                                <input type="checkbox" name="fields[]" value="activations" class="data-params" checked="checked" /> Активации
                                            </label>
                                        </div>
										<div class="checkbox">
                                            <label>
                                                <input type="checkbox" name="fields[]" value="impressions" class="data-params" checked="checked" /> Показы
                                            </label>
                                        </div>
                                        <div class="checkbox">
                                            <label>
                                                <input type="checkbox" name="fields[]" value="payout" class="data-params" checked="checked" /> Выплата
                                            </label>
                                        </div>
										<div class="checkbox">
                                            <label>
                                                <input type="checkbox" name="fields[]" value="revenue" class="data-params" checked="checked" /> Доход
                                            </label>
                                        </div>
                                    </div>
                                </div>
                                <div class="panel-footer" style="display:inline-block; padding: 0 15px; width: 100%">
                                    <div class="form-group">
										<div class="checkbox">
                                            <label>
                                                <input type="checkbox" name="fields[]" value="profit" class="data-params" checked="checked" /> Прибыль
                                            </label>
                                        </div>
										<div class="checkbox">
                                            <label>
                                                <input type="checkbox" name="fields[]" value="ltv" class="data-params" /> LTV
                                            </label>
                                        </div>
										<div class="checkbox">
                                            <label>
                                                <input type="checkbox" name="fields[]" value="roi" class="data-params" /> ROI
                                            </label>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
						
						
						
                        <div class="col-lg-8">
                            <div class="panel panel-info">
                                <div class="panel-heading">
                                    Фильтры
                                </div>
                                <div class="panel-body">
                                    <div class="row">
                                        <div class="col-lg-6">
                                            <label for="period">Период:</label>
                                            <div class="form-group input-group">
                                                <span class="input-group-addon" style="cursor: pointer"><label for="period" style="cursor:pointer; margin-bottom:0;"><i class="glyphicon glyphicon-calendar fa fa-calendar"></i></label></span>
                                                <input class="form-control" type="text" name="filters[period]" id="period" value="<?php echo date("Y-m-d", strtotime("-1week")) .' - '. date("Y-m-d");?>" />
                                            </div>
                                        </div>
                                        
										
                                        <div class="col-lg-6">
                                            <label for="filters-country_select">GEO:</label>
                                            <div class="form-group input-group">
                                                
                                                <span class="input-group-addon" style="cursor: pointer"><label for="filters-country_select" style="cursor: pointer; margin-bottom:0;"><i class="fa fa-globe fa-fw"></i></label></span>
                                                
                                                <input type="hidden" id="filters-country" />
                                                <input  type="text" id="filters-country_select" disabled="disabled" class="autocomplete-select form-control"
                                                        placeholder="Введите название страны"
                                                        value="Загружаю..." />
                                            </div>
                                        </div>
										
										<div class="col-lg-6">
                                            <label for="filters-offer_select">Офферы:</label>
                                            <div class="form-group input-group">
                                                <span class="input-group-addon" style="cursor: pointer"><label for="filters-offer_select" style="cursor: pointer; margin-bottom:0;"><i class="fa fa-tags fa-fw"></i></label></span>
                                                <input type="hidden" id="filters-offer" />
                                                <input  type="text" id="filters-offer_select" disabled="disabled" class="autocomplete-select form-control"
                                                        placeholder="Введите название оффера"
                                                        value="Загружаю..." />
                                            </div>
                                        </div>
										
										<div class="col-lg-6">
                                            <label for="filters-partner_select">Партнеры:</label>
                                            <div class="form-group input-group">
                                                <span class="input-group-addon" style="cursor: pointer"><label for="filters-partner_select" style="cursor: pointer; margin-bottom:0;"><i class="fa fa-user fa-fw"></i></label></span>
                                                <input type="hidden" id="filters-partner" />
                                                <input  type="text" id="filters-partner_select" disabled="disabled" class="autocomplete-select form-control"
                                                        placeholder="Введите логин партнера"
                                                        value="Загружаю..." />
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="panel-footer" style="display:inline-block; padding-top:0; width: 100%">&nbsp;
                                    <div id="filters-offer_box" class="multiselect-box" style="margin-bottom:0; margin-top:-13px;"></div>
									<div id="filters-partner_box" class="multiselect-box" style="margin-bottom:0"></div>
                                    <div id="filters-country_box" class="multiselect-box" style="margin-bottom:0"></div>
                                </div>
                            </div>
                        </div>
                        
                        <!--<div class="col-lg-3">-->
                        <!--    <div class="panel panel-info">-->
                        <!--        <div class="panel-heading">-->
                        <!--            Период-->
                        <!--        </div>-->
                        <!--        <div class="panel-body">-->
                        <!--            -->
                        <!--            -->
                        <!--            <div class="form-group input-group">-->
                        <!--                <span class="input-group-addon" style="cursor: pointer"><label for="period" style="cursor: pointer"><i class="fa fa-calendar fa-fw"></i></label></span>-->
                        <!--                <input class="form-control" type="text" name="filters[period]" id="period" value="" />-->
                        <!--            </div>-->
                        <!--            <!---->
                        <!--            <!--<div class="form-group">-->
                        <!--            <!--    <input class="datepicker" type="text" name="filters[date_from]" id="date_from" value="<?php echo date("Y-m-d", strtotime("-1week")); ?>" />-->
                        <!--            <!--</div>-->
                        <!--            <!--<div class="form-group">-->
                        <!--            <!--    <input class="datepicker" type="text" name="filters[date_to]" id="date_to" value="<?php echo date("Y-m-d"); ?>" />-->
                        <!--            <!--</div>-->
                        <!--        </div>-->
                        <!--    </div>-->
                        <!--</div>-->
                    </div>
                    
                    <div class="row">
                        <div class="col-lg-12">
                            <button type="submit" name="submit" class="btn btn-info">Обновить</button>
							<img src="/img/loader.gif" id="loader" class="form-loader" />
							<span id="info-bar"></span><br/><br/>
                        </div>
                    </div>
                </form>
                
                <div class="dataTable_wrapper">
                    <table class="table table-striped table-bordered table-hover" id="dataTables-stat">
                        <thead>
                            <tr>
                                <th>Дата</th>
                                <th>Активации</th>
								<th>Показы</th>
                                <th>Выплата</th>
                                <th>Доход</th>
                            </tr>
                        </thead>
                        <tbody>
                            
                        </tbody>
						<tfoot>
							
						</tfoot>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>
{extends file="index.tpl"}

{block name="body"}

<style>
table.stats { }
.stats th, .stats td { vertical-align: top; padding-left:1em; padding-right:1em }
.stats th { text-align: center }
.stats td { height: 10em; border:1px solid #eee; color:#444; padding-top:1em }
.c { padding-left: 2px }
.c1 { background-color: burlywood }
.c2 { background-color: chocolate }
.c3 { background-color: orange }
.fac { color: #ccc }
.sparkline { margin-top:1px }
</style>

    <div class="jumbotron">
		<div class="container">
			<div class="row">

				<div class="col-xs-6 col-md-3">
					<h1><span class="jumbo-label text-muted"><i class="fa fa-bar-chart"></i> Reports</span>
					<span class="jumbo-value">{$table_count.reports|number_format}</span></h1>
				</div>

				<div class="col-xs-6 col-md-3">
					<h1><span class="jumbo-label text-muted"><i class="fa fa-search"></i> Searches</span>
					<span class="jumbo-value">{$table_count.searches|number_format}</span></h1>
				</div>

				<div class="col-xs-6 col-md-3">
					<h1><span class="jumbo-label text-muted"><i class="fa fa-rss"></i> Trapped URLs</span>
					<span class="jumbo-value">{$table_count.urltrap|number_format}</span></h1>
				</div>

			</div>
		</div>
	</div>

{*<!--
    <div class="container">
        <div class="row">
            <div class="col-xs-12 col-md-12">

{function sparklines}
{if $value > 0}
<div class="sparkline" title={$title|json_encode}>
    <div style="background-color:#ddd">
        <div class="c {$color}" style="width:{($value/$max)*100}%;">
            {$label}{$value|number_format}
        </div>
    </div>
</div>
{/if}
{/function}

<table class="stats" border="0" width="100%">
    <thead>
        <tr>
            <th>Sun</th>
            <th>Mon</th>
            <th>Tue</th>
            <th>Wed</th>
            <th>Thu</th>
            <th>Fri</th>
            <th>Sat</th>
        </tr>
    </thead>
    <tbody>
{foreach $cal as $k => $week}
        <tr>
{foreach $week as $k2=>$day}
            <td>
{if !empty($day)}
                <p class="fac"><i class="fa fa-calendar-o"></i> {$day.date}</p>
{sparklines label="R:" title="Reports" color="c1" value=$day.tables.reports max=$range.reports.max}
{sparklines label="S:" title="Searches" color="c2" value=$day.tables.searches max=$range.searches.max}
{sparklines label="U:" title="Trapped URLs" color="c3" value=$day.tables.urltrap max=$range.urltrap.max}
{/if}
            </td>
{/foreach}
        </tr>
{/foreach}
    </tbody>
</table>

<div id="chart_1"></div>


            </div>
        </div>
    </div>
-->*}
<div class="container">
    <div class="row">
        <div class="col-xs-12 col-md-12">
            <div id="chart_1"></div>
        </div>
    </div>
</div>

{/block}

{block name="footer" append}

<script src="https://code.highcharts.com/highcharts.js"></script>

<script>
var chart1_labels_x = {$chart1_labels_x|json_encode};

$("#chart_1").highcharts({
    chart: {
        type: "scatter",
    },
    title: {
        text: "return"
    },
    xAxis: {
        title: {
            text: 'Day'
        },
        startOnTick: true,
        endOnTick: true,
        tickLength: 1,
        labels: {
            formatter: function() {
                return( chart1_labels_x[this.value] );
            }
        }
    },
    yAxis: {
        max: 23,
        title: {
            text: 'Hour'
        },
        startOnTick: true,
        endOnTick: true
    },
    plotOptions: {
        series: {
            pointStart: 0,
            pointInterval: 1
        }
    },
    tooltip: {
        formatter: function() {
            return( chart1_labels_x[this.x] + " at " + this.y + ":00" )
        }
    },
    series:[
        {
            name: "Metrics",
            color: "rgba(223, 83, 83, .5)",
            data: {$chart1|json_encode}
        }
    ]

})
</script>
{/block}

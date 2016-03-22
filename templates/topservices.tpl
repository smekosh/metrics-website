
<!-- <h2 class="col-xs-12 col-md-12 blockhead" >Top VOA Services<span class="pull-right"><i class="fa fa-bar-chart"></i> Pageviews</span></h2>
<div class="col-xs-12 col-md-12"> -->
<table class="table table-striped col-xs-12 col-md-12">
    <thead class="blockhead" style="background-color: #1330bf;">
        <tr>
            <!-- <th class="col-xs-1 col-md-1"><span class="sr-only">Rank</span></th> -->
            <th colspan="2" class="col-xs-6 col-md-6 text-left">Top VOA Services</th>
            <th class="col-xs-6 col-md-6 text-right"><i class="fa fa-bar-chart"></i> Pageviews</th>
        </tr>
    </thead>
    <tbody>
{foreach $top_services as $service}
        <tr>
            <td class="text-left">{*<!--{$service@index+1}-->*}- -</td>
            <td class="text-left">{*<!--{$service}-->*}- -</td>
            <td class="text-right">{*<!--{$top_services_pageviews[{$service@index}]|number_format:0:".":","}-->*}- -</td>
        </tr>
{/foreach}
    </tbody>
</table>
<!-- </div> -->

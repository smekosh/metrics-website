<table class="table table-striped col-xs-12 col-md-12">

    <thead class="blockhead" style="background-color: #bbb;">
        <tr>
            <th><span class="sr-only">Metric</span></th>

{foreach $last_7_days.dates as $date}
            <th class="text-right{if $date@index < 4} hidden-xs{/if}">{if $date@index == 6}Yesterday{else}{$date|date_format:"l"}{/if}</th>
{/foreach}
        </tr>
    </thead>

    <tbody>
        <tr>
            <td><i class="fa fa-bar-chart"></i> Pageviews</td>

{foreach $last_7_days.pageviews as $metric}
            <td class="text-right{if $metric@index < 4} hidden-xs{/if}">{*<!--{$metric|number_format:0:".":","}-->*}</td>
{/foreach}
        </tr>

        <tr>
            <td><i class="fa fa-share"></i> Social</td>

{foreach $last_7_days.social as $metric}
            <td class="text-right{if $metric@index < 4} hidden-xs{/if}">{*<!--{$metric|number_format:0:".":","}-->*}</td>
{/foreach}
        </tr>

        <tr>
            <td><i class="fa fa-comment"></i> Comments</td>

{foreach $last_7_days.comments as $metric}
            <td class="text-right{if $metric@index < 4} hidden-xs{/if}">{*<!--{$metric|number_format:0:".":","}-->*}</td>
{/foreach}
        </tr>

        <tr>
            <td><i class="fa fa-paper-plane"></i> Email</td>

{foreach $last_7_days.email as $metric}
            <td class="text-right{if $metric@index < 4} hidden-xs{/if}">{*<!--{$metric|number_format:0:".":","}-->*}</td>
{/foreach}
        </tr>
    </tbody>

</table>

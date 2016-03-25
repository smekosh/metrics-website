<table class="table table-striped col-xs-12 col-md-12">

    <thead class="blockhead" style="background-color: #bbb;">
        <tr>
            <th><span class="sr-only">Metric</span></th>

{foreach $last_7_days.dates as $date}
            <th class="text-right{if $date@index < 4} hidden-xs{/if}">{if $date@index == 6}Today{else}{$date|date_format:"l"}{/if}</th>
{/foreach}
        </tr>
    </thead>

    <tbody>

{function name=row}
    <tr class="{cycle values='even,odd'}">
        <td><i class="fa {$icon}"></i> {$title}</td>

{foreach $data as $point}
        <td class="text-right{if $point@index < 4} hidden-xs{/if}">{$point|number_format:0:".":","}</td>
{/foreach}
    </tr>
{/function}

{row title="Pageviews"          icon="fa-bar-chart"   data=$last_7_days.pageviews}
{row title="Social Shares"      icon="fa-share"       data=$last_7_days.social}
{row title="Comments"           icon="fa-comment"     data=$last_7_days.comments}
{row title="Published Articles" icon="fa-paper-plane" data=$last_7_days.articles}

    </tbody>

</table>

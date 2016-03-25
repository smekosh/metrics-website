
{function name=chart}

<svg class="chart" id="{$id}" style="width:100%; height:240px; background-color:ghostwhite; display: none" width="1000" height="240" viewBox="0 0 1000 240" pxreserveAspectRatio="none">
    <g class="horizontal">
{for $i = 0; $i < 7; $i++}
{$y = ((240 / 7) * $i)|intval}
        <path d="M20,{$y} L1000,{$y}" />
{/for}
    </g>
    <g class="lines">
{foreach from=$data item=point}
{$x = 270 + ((900 / $data|count) * $point@index)|intval}
{$y = 200 - ((180 * $point) / $data|max)|intval}
{if $point@index > 0}
        <path d="M{$x},{$y} L{$ox},{$oy}" />
{/if}
{$ox = $x}{$oy = $y}
{/foreach}
    </g>
    <g class="points">
{foreach from=$data item=point}
{capture}
{$x = 270 + ((900 / $data|count) * $point@index)|intval}
{$y = 200 - ((180 * $point) / $data|max)|intval}
{/capture}
        <circle cx="{$x}" cy="{$y}" r="6" />
{/foreach}
    </g>
    <g class="labels">
{foreach from=$data item=point}
{capture}
{$x = 270 + ((900 / $data|count) * $point@index)|intval}
{$y = 200 - ((180 * $point) / $data|max)|intval}
{/capture}
        <text x="{$x}" y="{$y + 25}">{$point|number_format}</text>
{/foreach}
    </g>
</svg>

{/function}

<div class="chart-container">
{chart id="chart_1" data=$last_7_days.pageviews}
{chart id="chart_2" data=$last_7_days.social}
{chart id="chart_3" data=$last_7_days.comments}
{chart id="chart_4" data=$last_7_days.articles}
</div>

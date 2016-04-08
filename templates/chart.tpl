{$hard_width = 1150}
{$hard_height = 300}
{$padding_left = 300}
{$padding_right = 0}
{$padding_top = 30}
{$padding_bottom = 10}
{$effective_width = $hard_width - $padding_left - $padding_right}
{$effective_height = $hard_height - $padding_top - $padding_bottom}

{function name=linechart}

<svg class="chart" id="{$id}" style="width:100%; height:{$hard_height}px; background-color:ghostwhite; display: none" width="{$hard_width}" height="{$hard_height}" viewBox="0 0 {$hard_width} {$hard_height}" pxreserveAspectRatio="none">
{* debug boundaries
    <rect style="stroke:black;fill:white;stroke-width:2px" x="1" y="1" width="{$hard_width-2}" height="{$hard_height-2}" />
    <rect style="stroke:black;fill:white;stroke-width:2px" x="{$padding_left}" y="{$padding_top}" width="{$effective_width}" height="{$effective_height}" />
*}
    <g class="horizontal">
{$steps = 10}
{for $i = 0; $i < $steps; $i++}
{$x = $padding_left}
{$y = ($padding_top + ((($effective_height) / $steps) * $i)|intval)}
{$w = $effective_width}
        <path d="M{$x},{$y} l{$w},0" />
{/for}
    </g>
    <g class="points">
{foreach from=$data item=point}
{capture}
{$step_size = $effective_width/($data|count)}
{$mid = $step_size / 2}
{$x = $mid + $padding_left + ($step_size * ($point@index))|intval}
{$y = $padding_top + ($effective_height - (($effective_height * $point) / $data|max)|intval)}
{$height = $effective_height + $padding_top - $y}
{if $height == 0}{$height = 1}{$y--}{/if}
{/capture}
        <rect x="{$x - $mid*.333}" y="{$y}" width="{$mid*.666}" height="{$height}" />
{/foreach}
    </g>
    <g class="labels">
{foreach from=$data item=point}
{capture}
{$step_size = $effective_width/($data|count)}
{$mid = $step_size / 2}
{$x = $mid + $padding_left + ($step_size * ($point@index))|intval}
{$y = $padding_top + ($effective_height - (($effective_height * $point) / $data|max)|intval)}
{/capture}
        <text x="{$x}" y="{$y - 10}">{$point|number_format}</text>
{/foreach}
    </g>
</svg>

{/function}

<div class="chart-container">
{linechart id="chart_1" data=$last_7_days.pageviews}
{linechart id="chart_2" data=$last_7_days.social}
{linechart id="chart_3" data=$last_7_days.comments}
{linechart id="chart_4" data=$last_7_days.articles}
</div>

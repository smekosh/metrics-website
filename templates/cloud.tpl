<style>
.cloud-count { font-size:10px; color:#888; }
.cloud-active, .cloud-active.cloud-count { color: crimson !important; }
</style>

{function name=fontsize}{strip}
{* scale font from 12 to 24 *}
{12 + ((48 * $value) / $max)}
{/strip}{/function}

{foreach from=$data key=word item=count}

<span
    title="{$count} searches"
    onmouseover="this.className='cloud-active';"
    onmouseout="this.className='';"
    style="color: {cycle values='#444,silver,gray'}; font-size:{fontsize count=$data|count value=$count max=$data|max}px"
>{$word} <span class="cloud-count">({$count})</span></span>

{/foreach}

<style>
.cloud-active { color: crimson !important }
</style>

{function name=fontsize}{strip}
{* scale font from 12 to 24 *}
{12 + ((48 * $value) / $max)}
{/strip}{/function}

{foreach from=$data key=word item=count}

<span
    onmouseover="this.className='cloud-active';"
    onmouseout="this.className='';"
    style="color: {cycle values='#444,silver,gray'}; font-size:{fontsize count=$data|count value=$count max=$data|max}px"
>{$word}</span>

{/foreach}

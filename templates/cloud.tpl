
{foreach from=$data key=word item=count}

<span onmouseover="this.style.color='red'" onmouseout="this.style.color='inherit';" style="font-size:{12 + ($count*2)}px">{$word}</span>

{/foreach}

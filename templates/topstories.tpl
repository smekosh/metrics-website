<table class="table table-striped col-xs-12 col-md-12">

    <thead class="blockhead">
        <tr>
            <th class="col-xs-6 col-md-5 text-left">Top Stories</th>
            <th colspan="2" class="col-xs-1 col-md-2 text-left"><i class="fa fa-calendar"></i><span class="hidden-xs"> Pub Date</span></th>
            <th class="text-right"><i class="fa fa-bar-chart"></i><span class="hidden-xs"> Pageviews</span></th>
            <th class="text-right"><i class="fa fa-share"></i><span class="hidden-xs"> Social</span></th>
            <th class="hidden-xs text-right"><i class="fa fa-comment"></i><span class="hidden-xs"> Comments</span></th>
            {*<!--<th class="hidden-xs text-right"><i class="fa fa-paper-plane"></i><span class="hidden-xs"> Email</span></th>-->*}
        </tr>
    </thead>

    <tbody>
{foreach $top_stories as $story}
{if $story@index < 10}
        <tr>
            <td class="text-left"><a href="{$story.url}" target="_blank">{$story.title|default:'(Untitled or Title Missing)'}</a></td>
{if $story.pubdate}
            <td class="text-left text-muted hint" title="Published {$story.pubdate|date_format:"%A, %B %e, %Y"} at {$story.pubdate|date_format:"%l:%M %p, %Z"}"><span class="visible-xs-inline">{$story.pubdate|date_format:"%a"}</span><span class="hidden-xs">{$story.pubdate|date_format:"l"}</span></td>
            <td class="text-left text-muted hint" title="Published {$story.pubdate|date_format:"%A, %B %e, %Y"} at {$story.pubdate|date_format:"%l:%M %p, %Z"}"><span class="visible-xs-inline">{$story.pubdate|date_format:"%a"}</span><span style='color:silver; padding-left:2em'>{$story.pubdate|ago} ago</span></span></td>
{else}
            <td class="text-left text-muted hint" title="Unknown Published Date"><span class="visible-xs-inline">Unknown</span><span class="hidden-xs">Unknown</span></td>
            <td class="text-left text-muted hint" title="Unknown Published Date"></td>
{/if}
            <td class="text-right">{$story.pageviews|number_format:0:".":","|replace:"-1":"&mdash;"}</td>
            <td class="text-right">{$story.social|number_format:0:".":","|replace:"-1":"&mdash;"}</td>
            <td class="hidden-xs text-right">{$story.comments|number_format:0:".":","|replace:"-1":"&mdash;"}</td>
            {*<!--<td class="hidden-xs text-right">{$story.email|number_format:0:".":","|replace:"-1":"&mdash;"}</td>-->*}
        </tr>
{/if}
{/foreach}
    </tbody>

</table>

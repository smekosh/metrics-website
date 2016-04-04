<div class="jumbotron">
    <div class="container">
        <div class="row">

            <div class="col-xs-6 col-md-3">
                <h1><span class="jumbo-label text-muted"><i class="fa fa-bar-chart"></i> Pageviews</span>
                <span class="jumbo-value">{$jumbotron_data.pageviews|number_format:0:".":","}</span></h1>
            </div>

            <div class="col-xs-6 col-md-3">
                <h1><span class="jumbo-label text-muted"><i class="fa fa-paper-plane"></i> Published Articles</span>
                <span class="jumbo-value">{$jumbotron_data.articles|number_format:0:".":","}</span></h1>
            </div>

            <div class="col-xs-6 col-md-3">
                <h1><span class="jumbo-label text-muted"><i class="fa fa-share"></i> Social Shares</span>
                <span class="jumbo-value">{$jumbotron_data.social|number_format:0:".":","}</span></h1>
            </div>

            <div class="col-xs-6 col-md-3">
                <h1><span class="jumbo-label text-muted"><i class="fa fa-comment"></i> Comments</span>
                <span class="jumbo-value">{$jumbotron_data.comments|number_format:0:".":","}</span></h1>
            </div>

{*<!--
            <div class="col-xs-6 col-md-3">
                <h1><span class="jumbo-label text-muted"><i class="fa fa-paper-plane"></i> Email Shares</span>
                <span class="jumbo-value">{$jumbotron_data.email|number_format:0:".":","}</span></h1>
            </div>
-->*}
        </div>
    </div>
</div>

<!DOCTYPE html>
<html lang="en">

<head>
	<meta charset="utf-8" />
	<meta http-equiv="X-UA-Compatible" content="IE=edge" />
	<meta name="viewport" content="width=device-width, initial-scale=1" />
	<link type="image/x-icon" rel="icon" href="{$homepage}/favicon.ico" />

	<title>VOA Metrics Dashboard</title>

	<!-- Bootstrap core CSS -->
	<link href="{$bootstrap}/css/bootstrap.min.css" rel="stylesheet" />

	<!-- Font Awesome icon font CSS -->
	<link href="{$homepage}/vendor/components/font-awesome/css/font-awesome.min.css" rel="stylesheet" />

	<!-- Custom styles for this template -->
	<link href="{$homepage}/dashboard.css" rel="stylesheet" />

	<!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
	<script src="{$bootstrap}/js/ie10-viewport-bug-workaround.js"></script>

	<!--[if lt IE 9]>
	<script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
	<script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
	<![endif]-->
</head>

<body>

	<!-- Fixed navbar -->
    <nav class="navbar navbar-inverse navbar-fixed-top">
      <div class="container">
        <div class="navbar-header">
          <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
            <span class="sr-only">Toggle navigation</span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
          </button>
          <a class="navbar-brand" href="{$homepage}/">VOA Dash</a>
        </div>
        <div id="navbar" class="navbar-collapse collapse">
          <ul class="nav navbar-nav">
            <!--
            <li class="active"><a href="#">Home</a></li>
            <li><a href="#about">About</a></li>
            <li><a href="#contact">Contact</a></li>
            <li class="dropdown">
              <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">Dropdown <span class="caret"></span></a>
              <ul class="dropdown-menu">
                <li><a href="#">Action</a></li>
                <li><a href="#">Another action</a></li>
                <li><a href="#">Something else here</a></li>
                <li role="separator" class="divider"></li>
                <li class="dropdown-header">Nav header</li>
                <li><a href="#">Separated link</a></li>
                <li><a href="#">One more separated link</a></li>
              </ul>
            </li>
            -->
          </ul>
          <ul class="nav navbar-nav navbar-right">
            <li><a href="#">Last updated {$latest_entry.stamp|ago} ago</a></li>
            <!--
            <li><a href="../navbar/">Default</a></li>
            <li><a href="../navbar-static-top/">Static top</a></li>
            <li class="active"><a href="./">Fixed top <span class="sr-only">(current)</span></a></li>
            -->
          </ul>
        </div><!--/.nav-collapse -->
      </div>
    </nav>

	<div class="jumbotron">
		<div class="container">
			<div class="row">

				<div class="col-xs-6 col-md-3">
					<h1><span class="jumbo-label text-muted"><i class="fa fa-bar-chart"></i> Pageviews</span>
					<span class="jumbo-value">{$jumbotron_data.pageviews|number_format:0:".":","}</span></h1>
				</div>

				<div class="col-xs-6 col-md-3">
					<h1><span class="jumbo-label text-muted"><i class="fa fa-share"></i> Social Shares</span>
					<span class="jumbo-value">{$jumbotron_data.social|number_format:0:".":","}</span></h1>
				</div>

				<div class="col-xs-6 col-md-3">
					<h1><span class="jumbo-label text-muted"><i class="fa fa-comment"></i> Comments</span>
					<span class="jumbo-value">{$jumbotron_data.comments|number_format:0:".":","}</span></h1>
				</div>

				<div class="col-xs-6 col-md-3">
					<h1><span class="jumbo-label text-muted"><i class="fa fa-paper-plane"></i> Email Shares</span>
					<span class="jumbo-value">{$jumbotron_data.email|number_format:0:".":","}</span></h1>
				</div>

			</div>
		</div>
	</div>

	<div class="container">
		<div class="row">
			<table class="table table-striped col-xs-12 col-md-12">

				<thead class="blockhead">
					<tr>
						<th class="col-xs-6 col-md-5 text-left">Top Stories</th>
						<th class="col-xs-1 col-md-1 text-right"><i class="fa fa-calendar"></i><span class="hidden-xs"> Pub Date</span></th>
						<th class="text-right"><i class="fa fa-bar-chart"></i><span class="hidden-xs"> Pageviews</span></th>
						<th class="text-right"><i class="fa fa-share"></i><span class="hidden-xs"> Social</span></th>
						<th class="hidden-xs text-right"><i class="fa fa-comment"></i><span class="hidden-xs"> Comments</span></th>
						<th class="hidden-xs text-right"><i class="fa fa-paper-plane"></i><span class="hidden-xs"> Email</span></th>
					</tr>
				</thead>

				<tbody>
					{foreach $top_stories as $story}
					<tr>
						<td class="text-left"><a href="{$story.url}" target="_blank">{$story.title|default:'(Untitled or Title Missing)'}</a></td>
{if $story.pubdate}
						<td class="text-right text-muted hint" title="Published {$story.pubdate|date_format:"%A, %B %e, %Y"} at {$story.pubdate|date_format:"%l:%M %p, %Z"}"><span class="visible-xs-inline">{$story.pubdate|date_format:"%a"}</span><span class="hidden-xs">{$story.pubdate|date_format:"l"}</span></td>
{else}
						<td class="text-right text-muted hint" title="Unknown Published Date"><span class="visible-xs-inline">Unknown</span><span class="hidden-xs">Unknown</span></td>
{/if}
						<td class="text-right">{$story.pageviews|number_format:0:".":","|replace:"-1":"&mdash;"}</td>
						<td class="text-right">{$story.social|number_format:0:".":","|replace:"-1":"&mdash;"}</td>
						<td class="hidden-xs text-right">{$story.comments|number_format:0:".":","|replace:"-1":"&mdash;"}</td>
						<td class="hidden-xs text-right">{$story.email|number_format:0:".":","|replace:"-1":"&mdash;"}</td>
					</tr>
					{/foreach}
				</tbody>

			</table>
		</div>
	</div>



	<div class="container">
		<div class="row">
			<h2 class="col-xs-12 col-md-12 blockhead">Popular Searches</h2>
		</div>

		<div class="row">
			<div class="col-xs-12 col-md-12">
{include file="cloud.tpl" data=$search_terms}
			</div>
		</div>
	</div>



	<div class="container">

		<div class="row">

			<div id="voa-top-services" class="col-xs-12 col-md-4">
				<div class="row">

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
								<td class="text-left">{$service@index+1}</td>
								<td class="text-left">{$service}</td>
								<td class="text-right">{$top_services_pageviews[{$service@index}]|number_format:0:".":","}</td>
							</tr>
							{/foreach}
						</tbody>
					</table>
					<!-- </div> -->
				</div>
			</div>


			<div class="col-xs-12 col-md-4">
				<div class="row">

					<h2 class="col-xs-12 col-md-12 blockhead" style="background-color: #469AE9;">Recent Tweets</h2>
					<div class="col-xs-12 col-md-12">
						{literal}
						<a class="twitter-timeline"
						   width="100%"
						   height="360"
						   data-dnt="true"
						   href="https://twitter.com/search?q=%40voanews"
						   data-chrome="noheader nofooter noborders transparent"
						   data-widget-id="634847380127526912">Tweets about @voanews</a>
						<script>!function(d,s,id){var js,fjs=d.getElementsByTagName(s)[0],p=/^http:/.test(d.location)?'http':'https';if(!d.getElementById(id)){js=d.createElement(s);js.id=id;js.src=p+"://platform.twitter.com/widgets.js";fjs.parentNode.insertBefore(js,fjs);}}(document,"script","twitter-wjs");</script>
						{/literal}
          			</div>

				</div>
			</div>


			<div class="col-xs-12 col-md-4">
				<div class="row">

					<h2 class="col-xs-12 col-md-12 blockhead" style="background-color: #3B5998;">Top Facebook Post</h2>
					<div class="col-xs-12 col-md-12" id="top-facebook-post-widget">

						{literal}

						<div class="fb-post" data-href="https://www.facebook.com/voiceofamerica/posts/10153193367123074"></div>
						<div id="fb-root"></div>
						<script>(function(d, s, id) {
							var js, fjs = d.getElementsByTagName(s)[0];
							if (d.getElementById(id)) return;
							js = d.createElement(s); js.id = id;
							js.src = "//connect.facebook.net/en_US/sdk.js#xfbml=1&version=v2.2";
							fjs.parentNode.insertBefore(js, fjs);
						}(document, 'script', 'facebook-jssdk'));</script>

						{/literal}

					</div>

				</div>
			</div>

		</div>

	</div>



	<div class="container">
		<div class="row">
			<h2 class="col-xs-12 col-md-12 blockhead">Last <span class="visible-xs-inline">3</span><span class="hidden-xs">7</span> Days</h2>
		</div>

		<div class="row">
			<div class="col-xs-12 col-md-12">
				<p>Interactive chart goes here.</p>
			</div>
		</div>

		<div class="row">

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
						<td class="text-right{if $metric@index < 4} hidden-xs{/if}">{$metric|number_format:0:".":","}</td>
						{/foreach}
					</tr>

					<tr>
						<td><i class="fa fa-share"></i> Social</td>

						{foreach $last_7_days.social as $metric}
						<td class="text-right{if $metric@index < 4} hidden-xs{/if}">{$metric|number_format:0:".":","}</td>
						{/foreach}
					</tr>

					<tr>
						<td><i class="fa fa-comment"></i> Comments</td>

						{foreach $last_7_days.comments as $metric}
						<td class="text-right{if $metric@index < 4} hidden-xs{/if}">{$metric|number_format:0:".":","}</td>
						{/foreach}
					</tr>

					<tr>
						<td><i class="fa fa-paper-plane"></i> Email</td>

						{foreach $last_7_days.email as $metric}
						<td class="text-right{if $metric@index < 4} hidden-xs{/if}">{$metric|number_format:0:".":","}</td>
						{/foreach}
					</tr>
				</tbody>

			</table>

		</div>
	</div>





	<!-- Bootstrap core JavaScript
	================================================== -->
	<!-- Placed at the end of the document so the pages load faster -->
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
	<script src="{$bootstrap}/js/bootstrap.min.js"></script>
	<script src="../../assets/js/docs.min.js"></script>
	<!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
	<script src="../../assets/js/ie10-viewport-bug-workaround.js"></script>

</body>
</html>

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
            <li><a href="#">Last updated 3.5 hours ago</a></li>
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
					<h1><span class="jumbo-label"><i class="fa fa-bar-chart"></i> Pageviews</span>
					<span class="jumbo-value">{$jumbotron_data.pageviews|number_format:0:".":","}</span></h1>
				</div>

				<div class="col-xs-6 col-md-3">
					<h1><span class="jumbo-label"><i class="fa fa-share"></i> Social Shares</span> 
					<span class="jumbo-value">{$jumbotron_data.social|number_format:0:".":","}</span></h1>
				</div>

				<div class="col-xs-6 col-md-3">
					<h1><span class="jumbo-label"><i class="fa fa-comment"></i> Comments</span> 
					<span class="jumbo-value">{$jumbotron_data.comments|number_format:0:".":","}</span></h1>
				</div>

				<div class="col-xs-6 col-md-3">
					<h1><span class="jumbo-label"><i class="fa fa-paper-plane"></i> Email Shares</span> 
					<span class="jumbo-value">{$jumbotron_data.email|number_format:0:".":","}</span></h1>
				</div>

			</div>
		</div>
	</div>

	<div class="container">
		<div class="row">
			<table class="table col-xs-12 col-md-12">
				
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
						<td class="text-left"><a href="{$story.url}" target="_blank">{$story.title}</a></td>
						<td class="text-right text-muted small hint" title="Published {$story.pubdate|date_format:"%A, %B %e, %Y"} at {$story.pubdate|date_format:"%l:%M %p, %Z"}"><span class="visible-xs-inline">{$story.pubdate|date_format:"%a"}</span><span class="hidden-xs">{$story.pubdate|date_format:"l"}</span></td>
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
				<p>Tag cloud goes here</p>
			</div>
		</div>

		<div class="row">
			
			<div class="col-xs-12 col-md-4">
				<div class="row">

					<h2 class="col-xs-12 col-md-12 blockhead" style="background-color: #1330bf;">Top VOA Services</h2>
					<div class="col-xs-12 col-md-12">
						<p>services</p>
					</div>

				</div>
			</div>


			<div class="col-xs-12 col-md-4">
				<div class="row">

					<h2 class="col-xs-12 col-md-12 blockhead" style="background-color: #469AE9;">Recent Tweets</h2>
					<div class="col-xs-12 col-md-12">
						<p>twitter widget goes here</p>
					</div>

				</div>
			</div>


			<div class="col-xs-12 col-md-4">
				<div class="row">

					<h2 class="col-xs-12 col-md-12 blockhead" style="background-color: #3B5998;">Top Facebook Post</h2>
					<div class="col-xs-12 col-md-12">
						<p>facebook widget goes here</p>
					</div>

				</div>
			</div>

		</div>

	</div>



	<div class="container">
		<div class="row">
			<h2 class="col-xs-12 col-md-12 blockhead">Last 7 Days</h2>
		</div>

		<div class="row">	
			<div class="col-xs-12 col-md-12">
				<p>Interactive chart goes here.</p>
			</div>
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
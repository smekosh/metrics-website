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

	!-- Custom styles for this template -->
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
					<h1><span class="jumbo-label">Pageviews</span> 
					<span class="jumbo-value">345830</span></h1>
				</div>

				<div class="col-xs-6 col-md-3">
					<h1><span class="jumbo-label">Social Shares</span> 
					<span class="jumbo-value">345830</span></h1>
				</div>

				<div class="col-xs-6 col-md-3">
					<h1><span class="jumbo-label">Comments</span> 
					<span class="jumbo-value">345830</span></h1>
				</div>

				<div class="col-xs-6 col-md-3">
					<h1><span class="jumbo-label">Email Shares</span> 
					<span class="jumbo-value">345830</span></h1>
				</div>

			</div>
		</div>
	</div>

	<div class="container">
		<div class="row">
			
			<div class="col-md-12">
				
				<div class="table-responsive">
					<table class="table">
						
						<thead>
							<tr>
								<th>Top Stories for English</th>
								<th>Pageviews</th>
								<th>Social</th>
								<th>Comments</th>
								<th>Email</th>
							</tr>
						</thead>

						<tbody>
							<tr>
								<td>Kerry in Saudi Arabia to Discuss Yemen Crisis</td>
							</tr>
							<tr>
								<td>Counselors Work to Undo Boko Haram's Damage at Nigeria Camp</td>
							</tr>
							<tr>
								<td>Social Media Mock Bizarre Islamic State Reports</td>
							</tr>
							<tr>
								<td>US Facing Dilemmas in Supporting Fragmented Syrian Opposition</td>
							</tr>
							<tr>
								<td>US Tightens Security at Military Bases</td>
							</tr>
						</tbody>

					</table>
				</div>

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
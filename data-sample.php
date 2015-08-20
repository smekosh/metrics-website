<?php

// dummy data for mockup



$jumbotron_data = array(
	'pageviews' => rand(25000,500000),
	'social'    => rand(5000,50000),
	'comments'  => rand(100,2500),
	'email'     => rand(50,500)
);



$top_stories = array(
	array( 
		'title'     => 'Kerry in Saudi Arabia to Discuss Yemen Crisis',
		'pubdate'   => date('U'),
		'url'       => 'nada',
		'pageviews' => rand(5000,35000),
		'social'    => rand(25,10000),
		'comments'  => rand(-1,150),
		'email'     => rand(0,75)
	),
	array( 
		'title'     => 'Counselors Work to Undo Boko Haram\'s Damage at Nigeria Camp',
		'pubdate'   => date('U') - 3000 * 2,
		'url'       => 'nada',
		'pageviews' => rand(5000,25000),
		'social'    => rand(25,10000),
		'comments'  => rand(-1,150),
		'email'     => rand(0,75)
	),
	array( 
		'title'     => 'Social Media Mock Bizarre Islamic State Reports',
		'pubdate'   => date('U') - 3000 * 7,
		'url'       => 'nada',
		'pageviews' => rand(3000,10000),
		'social'    => rand(25,10000),
		'comments'  => rand(-1,150),
		'email'     => rand(0,75)
	),
	array( 
		'title'     => 'US Facing Dilemmas in Supporting Fragmented Syrian Opposition',
		'pubdate'   => date('U') - 3000 * 30,
		'url'       => 'nada',
		'pageviews' => rand(500,5000),
		'social'    => rand(25,10000),
		'comments'  => rand(-1,150),
		'email'     => rand(0,75)
	),
	array( 
		'title'     => 'US Tightens Security at Military Bases',
		'pubdate'   => date('U') - 3000 * 55,
		'url'       => 'nada',
		'pageviews' => rand(500,5000),
		'social'    => rand(25,10000),
		'comments'  => rand(-1,150),
		'email'     => rand(0,75)
	)
);
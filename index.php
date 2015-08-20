<?php

require_once( 'config.php' );
require_once( 'vendor/autoload.php' );

// load sample data for the mockup
include( 'data-sample.php' );

// initialize smarty
$smarty = new Smarty();

// assign constants
$smarty->assign( "homepage", HOMEPAGE );
$smarty->assign( "bootstrap", BOOTSTRAP );

// populated by data-sample.php
$smarty->assign( 'jumbotron_data', $jumbotron_data );
$smarty->assign( 'top_stories', $top_stories );

// render the page
$smarty->display('index.tpl');

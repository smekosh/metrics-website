<?php

require_once( 'config.php' );
require_once( 'vendor/autoload.php' );
require_once( 'class.data.php' );

// load sample data for the mockup
#include( 'data-sample.php' );
date_default_timezone_set( 'America/New_York' );
include( 'data.php' ) ;

// initialize smarty
$smarty = new Smarty();

// assign constants
$smarty->assign( "homepage", HOMEPAGE );
$smarty->assign( "bootstrap", BOOTSTRAP );

// for debugging
if( isset( $_GET['stats']) ) {
    include( 'stats.php' );
    $smarty->display('stats.tpl');
    die;
}

// populated by data-sample.php
$smarty->assign( 'jumbotron_data', $jumbotron_data );
$smarty->assign( 'top_stories', $top_stories );
$smarty->assign( 'top_services', $top_services );
$smarty->assign( 'top_services_pageviews', $top_services_pageviews );
$smarty->assign( 'last_7_days', $last_7_days );
$smarty->assign( 'latest_entry', $latest_entry );

$smarty->assign( 'search_terms', $search_terms );

// render the page
$smarty->display('index.tpl');

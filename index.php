<?php

require_once( 'config.php' );
require_once( 'vendor/autoload.php' );

function smarty_modifier_ago($tm, $cur_tm = null) {
	if( is_null($cur_tm) ) $cur_tm = time();
	$dif = $cur_tm-strtotime($tm);

	$pds = array('second','minute','hour','day','week','month','year','decade');
	$lngh = array(1,60,3600,86400,604800,2630880,31570560,315705600);
	for($v = sizeof($lngh)-1; ($v >= 0)&&(($no = $dif/$lngh[$v])<=1); $v--);
	if($v < 0) $v = 0;
	$_tm = $cur_tm-($dif%$lngh[$v]);
	$no = floor($no); if($no <> 1) $pds[$v] .='s'; $x=sprintf("%d %s ",$no,$pds[$v]);

	return $x;
}

// load sample data for the mockup
#include( 'data-sample.php' );
date_default_timezone_set( 'America/New_York' );
include( 'data.php' ) ;

// initialize smarty
$smarty = new Smarty();

// assign constants
$smarty->assign( "homepage", HOMEPAGE );
$smarty->assign( "bootstrap", BOOTSTRAP );

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

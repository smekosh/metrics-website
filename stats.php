<?php

$stats = new metricsStats();

$smarty->assign( 'latest_entry', $stats->query_max() );
$smarty->assign( 'table_count', $stats->countTables() );

// for computing max, min
$range = array(
    "reports" => array("min" => 0, "max" => 0, "values" => array() ),
    "searches" => array("min" => 0, "max" => 0, "values" => array()),
    "urltrap" => array("min" => 0, "max" => 0, "values" => array())
);

// reports graph
$chart1 = array();
$chart1_labels_x = array();

$day_count = 0;

$cal = $stats->getCalendar();
foreach( $cal as $k => $week ) {
    foreach( $week as $k2 => $day ) {
        if( empty($day) ) continue;

        $day_count++;

        $t = $stats->countTables($day["date"]);

        $chart1_labels_x[] = $day["date"];
        $cal[$k][$k2]["tables"] = $t;

        $x = $stats->getHistogramReports($day["date"]);

        foreach( $x as $count ) {
            // day, hour
            $chart1[] = array(intval($day_count), intval($count["hour"]) );
        }

        $range["reports"]["values"][] = $t["reports"];
        $range["searches"]["values"][] = $t["searches"];
        $range["urltrap"]["values"][] = $t["urltrap"];
    }
}

// compute range, needed for sparklines
foreach( $range as $k => $v ) {
    $range[$k]["min"] = min($v["values"]);
    $range[$k]["max"] = max($v["values"]);
}

#echo "<PRE>"; print_r( $cal ); die;
#echo "<PRE>"; print_r( $chart1 ); die;
#$chart1 = $stats->getHistogramReports("2016-03-28");
#echo "<PRE>"; print_r( $chart1 ); die;

$smarty->assign( 'cal', $cal );
$smarty->assign( 'range', $range );
$smarty->assign( 'chart1', $chart1 );
$smarty->assign( 'chart1_labels_x', $chart1_labels_x );

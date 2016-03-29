<?php
if( !defined("HOMEPAGE") ) die( "Error 1.");

include( "data-sample.php" );

$metrics = new metricsData();
//$st = $metrics->db->prepare("SET GLOBAL general_log = 'ON';");
//$st = $metrics->db->prepare("SET GLOBAL general_log = 'OFF';");
//$st->execute();
$top_stories = $metrics->query_top_stories();

$jumbotron_data["pageviews"] = $metrics->query_total_pageviews(
    $metrics->max["day"],
    $metrics->max["hour"]
);

$jumbotron_data["comments"] = $metrics->query_total_comments(
    $metrics->max["day"],
    $metrics->max["hour"]
);

$jumbotron_data["social"] = $metrics->query_total_shares(
    $metrics->max["day"],
    $metrics->max["hour"]
);

$jumbotron_data["articles"] = $metrics->query_article_count(
    $metrics->max["day"]
);

$jumbotron_data["email"] = 0;

$latest_entry = $metrics->max;

$search_terms = $metrics->query_search_terms($metrics->max["day"]);

$last_7_days = $metrics->query_last_7_days($metrics->max["day"]);

<?php
if( !defined("HOMEPAGE") ) die( "Error 1.");

include( "data-sample.php" );

try {
    $db = new PDO(PDO_CONN, PDO_USER, PDO_PASS);
} catch( PDOException $e ) {
    var_dump( $e );
    die;
}

try {
    $st = $db->prepare("select `day`, `hour` from reports order by `id` desc limit 1");
    $st->execute();
    $max = $st->fetch(PDO::FETCH_ASSOC);
} catch( PDOException $e ) {
    var_dump( $e );
    die;
}

try {
    $st = $db->prepare(
        "select * from `reports` where `day`=:day and `hour`=:hour order by `pageviews` desc limit 5"
    );
    $st->execute(array(
        "day" => $max["day"],
        "hour" => $max["hour"]
    ));
    $top_stories = $st->fetchAll(PDO::FETCH_ASSOC);
} catch( PDOException $e ) {
    var_dump( $e );
    die;
}

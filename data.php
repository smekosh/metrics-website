<?php
if( !defined("HOMEPAGE") ) die( "Error 1.");

include( "data-sample.php" );

class metricsData {
    public $db;
    public $max;

    function __construct() {
        $this->connect();
    }

    function connect() {
        $this->db = new PDO(PDO_CONN, PDO_USER, PDO_PASS);
    }

    function query_max() {
        $st = $this->db->prepare(
            "select `day`, `hour` from reports order by `id` desc limit 1"
        );
        $st->execute();
        $this->max = $st->fetch(PDO::FETCH_ASSOC);
        return( $this->max );
    }

    function query_total_pageviews($day, $hour) {
        $st = $this->db->prepare(
            "select
                count(*) as `rows`,
                `urltype`,
                `total_pageviews` as `total`
            from `reports`
            where
                `day`=:day and
                `hour`=:hour
            group by `urltype`
            order by `urltype`"
        );
        $st->execute(array(
            "day" => $day,
            "hour" => $hour
        ));
        $t = $st->fetchAll(PDO::FETCH_ASSOC);
        if( count($t) != 2 ) {
            throw new Exception("Expected 2 results (for D and M sites).");
            die;
        }
        return( intval($t[0]["total"]) + intval($t[1]["total"]) );
    }

    function get_title_by_article_id($article_id, $day, $hour) {
        $st = $this->db->prepare(
            "select
                `title`
            from
                `reports`
            where
                `article_id`=:article_id and
                `day`=:day and
                `hour`=:hour
            order by `urltype` asc, `id` desc
            limit 2"
        );
        $st->execute(array(
            "article_id" => $article_id,
            "day" => $day,
            "hour" => $hour
        ));
        $articles = $st->fetchAll(PDO::FETCH_ASSOC);
        return($articles[0]["title"]);
    }

    function get_url_by_article_id($article_id, $day, $hour) {
        $st = $this->db->prepare(
            "select
                `url`
            from
                `reports`
            where
                `article_id`=:article_id and
                `day`=:day and
                `hour`=:hour
            order by `urltype` asc, `id` desc
            limit 2"
        );
        $st->execute(array(
            "article_id" => $article_id,
            "day" => $day,
            "hour" => $hour
        ));
        $articles = $st->fetchAll(PDO::FETCH_ASSOC);
        return($articles[0]["url"]);
    }

    function get_shares_by_article_id($article_id, $day, $hour) {
        $st = $this->db->prepare(
            "select
                `fb.shares`
            from
                `reports`
            where
                `article_id`=:article_id and
                `day`=:day and
                `hour`=:hour
            order by `urltype` asc, `id` desc
            limit 2"
        );
        $st->execute(array(
            "article_id" => $article_id,
            "day" => $day,
            "hour" => $hour
        ));
        $articles = $st->fetchAll(PDO::FETCH_ASSOC);
        return($articles[0]["fb.shares"]);
    }

    function get_comments_by_article_id($article_id, $day, $hour) {
        $st = $this->db->prepare(
            "select
                `comments`
            from
                `reports`
            where
                `article_id`=:article_id and
                `day`=:day and
                `hour`=:hour
            order by `id` desc
            limit 2"
        );
        $st->execute(array(
            "article_id" => $article_id,
            "day" => $day,
            "hour" => $hour
        ));
        $articles = $st->fetchAll(PDO::FETCH_ASSOC);
        $comments = 0;
        foreach( $articles as $article ) {
            if( $article["comments"] > 0 ) $comments += $article["comments"];
        }
        return( $comments );
    }

    function query_total_comments($day, $hour) {
        $st = $this->db->prepare(
            "select
                sum(`comments`) as `comments_total`
            from reports
                where `comments`>0 and
                `day`=:day"
        );
        $st->execute(array(
            "day" => $day
        ));

        $comment_count = $st->fetch(PDO::FETCH_ASSOC);
        return( $comment_count["comments_total"] );
    }

    function query_total_shares($day, $hour) {
        $st = $this->db->prepare(
            "select
                sum(`fb.shares`) as `shares_total`
            from reports
                where `fb.shares`>0 and
                `day`=:day"
        );
        $st->execute(array(
            "day" => $day
        ));

        $comment_count = $st->fetch(PDO::FETCH_ASSOC);
        return( $comment_count["shares_total"] );
    }

    /*
    given limited array of rows, article_id, fill in title and urls
    */
    function details_for_query($q, $day = null, $hour = null) {
        $retarr = array();
        foreach( $q as $k => $v ) {
            $v["title"] = $this->get_title_by_article_id($v["article_id"], $day, $hour);
            $v["url"] = $this->get_url_by_article_id($v["article_id"], $day, $hour);
            $v["comments"] = $this->get_comments_by_article_id($v["article_id"], $day, $hour);
            $v["shares"] = $this->get_shares_by_article_id($v["article_id"], $day, $hour);
            $v["pageviews"] = $v["combined_pageviews"];
            $v["social"] = $v["shares"];
            $v["email"] = 0;
            $v["pubdate"] = 0;
            $retarr[] = $v;
        }
        return( $retarr );
    }

    /*
    returns array of rows, article_id, combined_pageviews: needs details
    */
    function query_top_stories($day = null, $hour = null) {
        if( is_null($day) && is_null($hour) ) {
            $this->query_max();
            $day = $this->max["day"];
            $hour = $this->max["hour"];
        }

        $st = $this->db->prepare(
            "select
                count(*) as `rows`,
                `article_id`,
                sum(`pageviews`) as `combined_pageviews`
            from `reports`
            where
                `day`=:day and
                `hour`=:hour
            group by article_id
            order by combined_pageviews desc
            limit 5"
        );
        $st->execute(array(
            "day" => $day,
            "hour" => $hour,
        ));
        $top_stories = $st->fetchAll(PDO::FETCH_ASSOC);
        $top_stories = $this->details_for_query($top_stories, $day, $hour);
        return( $top_stories );
    }
}

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

$jumbotron_data["email"] = 0;

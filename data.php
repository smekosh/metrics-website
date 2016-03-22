<?php
if( !defined("HOMEPAGE") ) die( "Error 1.");

include( "data-sample.php" );

/**
 * sadasd as
 */
class metricsData {
    public $db;
    public $max;

    function __construct() {
        $this->connect();
    }

    function connect() {
        $this->db = new PDO(PDO_CONN, PDO_USER, PDO_PASS);
    }

    /**
     * gets most recent report's day and hour
     * stores to $this->max and returns as array
     */
    function query_max() {
        $st = $this->db->prepare(
            "select `day`, `hour`, `stamp` from `reports` order by `id` desc limit 1"
        );
        $st->execute();
        $this->max = $st->fetch(PDO::FETCH_ASSOC);
        return( $this->max );
    }

    /**
     * The omniture API call returns a "total pageviews" associated with it
     * This query finds a combination of desktop and mobile from a particular
     * day and hour query
     *
     * @param string $day Day in YYYY-MM-DD format
     * @param string $hour Hour as string (0 - 23)
     */
    function query_total_pageviews($day, $hour) {
        $st = $this->db->prepare("
            select
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

    /**
     * Given an ID, find title of article. Each article might have duplicates
     * as mobile, desktop. Prioritize for the desktop title
     *
     * @param string $article_Id VOA article (pangea) ID number
     * @param string $day Day in YYYY-MM-DD format
     * @param string $hour Hour as string (0 - 23)
     */
    function get_title_by_article_id($article_id, $day, $hour) {
        $st = $this->db->prepare("
            select
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

    /**
     * Given an ID, find the URL of article. Each article might have two
     * URLs for mobile, desktop versions. Prioritize for the desktop URL
     *
     * @param string $article_Id VOA article (pangea) ID number
     * @param string $day Day in YYYY-MM-DD format
     * @param string $hour Hour as string (0 - 23)
     */
    function get_url_by_article_id($article_id, $day, $hour) {
        $st = $this->db->prepare("
            select
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

    /**
     * Given an ID, find number of times article's been shared on facebook
     * While there might be two separate URLs for the ID (mobile, desktop)
     * facebook assigns same share count to canonical URLs
     *
     * @param string $article_Id VOA article (pangea) ID number
     * @param string $day Day in YYYY-MM-DD format
     * @param string $hour Hour as string (0 - 23)
     */
    function get_shares_by_article_id($article_id, $day, $hour) {
        $st = $this->db->prepare("
            select
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

    /**
     * Given an ID, find number of comments on article
     * Comments are separate on mobile and desktop, so combine them
     *
     * @param string $article_Id VOA article (pangea) ID number
     * @param string $day Day in YYYY-MM-DD format
     * @param string $hour Hour as string (0 - 23)
     */
    function get_comments_by_article_id($article_id, $day, $hour) {
        $st = $this->db->prepare("
            select
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

    /**
     * Given an ID, find date it was published on
     *
     * @param string $article_Id VOA article (pangea) ID number
     * @todo make this work
     */
    function get_pubdate_by_article_id($article_id) {
        $st = $this->db->prepare("
            select * from `urltrap` where `article_id`=:article_id"
        );
        $st->execute(array(
            "article_id" => $article_id
        ));

        $r = $st->fetch(PDO::FETCH_ASSOC);
        if( !$r ) return("0");

        $ts = strtotime($r["pubdate"]);
        return( date("r", $ts) );
    }

    /**
     * Given a day, hour find total number of comments on articles
     * Comments are separate on mobile and desktop, so they're combined
     * Comment counts can be errors stating -1 or -2 so ignore anything <= 0
     *
     * @param string $day Day in YYYY-MM-DD format
     * @param string $hour Hour as string (0 - 23)
     */
    function query_total_comments($day, $hour) {
        $st = $this->db->prepare("
            select
                sum(`comments`) as `comments_total`
            from reports
                where `comments`>0 and
                `day`=:day and
                `hour`=:hour"
        );
        $st->execute(array(
            "day" => $day,
            "hour" => $hour
        ));

        $comment_count = $st->fetch(PDO::FETCH_ASSOC);
        return( $comment_count["comments_total"] );
    }

    /**
     * Given a day, hour find total number of times articles have been shared
     * Because facebook is aware of mobile/desktop versions, only target
     * desktop counts for summation.  Share counts can be errors as -1 or -2
     * so ignore anything <= 0
     *
     * @param string $day Day in YYYY-MM-DD format
     * @param string $hour Hour as string (0 - 23)
     */
    function query_total_shares($day, $hour) {
        $st = $this->db->prepare("
            select
                count(*) as `rows`,
                `article_id`,
                max(`fb.shares`) as `shares`,
                `urltype`
            from `reports`
            where `fb.shares`>0 and
            `day`=:day
            group by `article_id`"
        );
        $st->execute(array(
            "day" => $day
        ));

        $articles = $st->fetchAll(PDO::FETCH_ASSOC);
        $count = 0;
        foreach( $articles as $article ) {
            $count += $article["shares"];
        }
        return( $count );
    }

    /**
    * given limited array fill in title and urls, used by query_top_stories
    *
    * @param array $q List of article_ids
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
            $v["pubdate"] = $this->get_pubdate_by_article_id($v["article_id"]);
            $retarr[] = $v;
        }
        return( $retarr );
    }

    /**
     * returns array of rows, article_id, combined_pageviews: needs details
     *
     * @param string $day Day in YYYY-MM-DD format
     * @param string $hour Hour as string (0 - 23)
     */
    function query_top_stories($day = null, $hour = null) {
        if( is_null($day) && is_null($hour) ) {
            $this->query_max();
            $day = $this->max["day"];
            $hour = $this->max["hour"];
        }

        $st = $this->db->prepare("
            select
                count(*) as `rows`,
                `article_id`,
                sum(`pageviews`) as `combined_pageviews`
            from `reports`
            where
                `day`=:day and
                `hour`=:hour
            group by article_id
            order by combined_pageviews desc"
        );
        $st->execute(array(
            "day" => $day,
            "hour" => $hour,
        ));
        $top_stories = $st->fetchAll(PDO::FETCH_ASSOC);
        $top_stories = $this->details_for_query($top_stories, $day, $hour);
        return( $top_stories );
    }

    /**
     * given query return of search terms, combines them (desktop + mobile)
     *
     * @param array $terms Queried search terms from omniture
     */
    function combine_search_terms($terms, $limit = 20) {
        $ret = array();
        foreach( $terms as $term ) {
            $key = $term["term"];

            if( !isset($ret[$key]) ) {
                $ret[$key] = 0;
            }

            $ret[$key] += $term["visits"];
        }

        return( array_slice($ret, 0, $limit) );
    }

    /**
     * returns list of search terms for a day
     *
     * @param string $day Day in YYYY-MM-DD format
     */
    function query_article_count($day) {
        $st = $this->db->prepare(
            "select count(*) as `count` from `urltrap` where `day`=:day"
        );
        $st->execute(array(
            "day" => $day
        ));
        $res = $st->fetch(PDO::FETCH_ASSOC);
        return( $res["count"] );
    }

    /**
     * returns list of search terms for a day
     *
     * @param string $day Day in YYYY-MM-DD format
     */
    function query_search_terms($day) {
        $st = $this->db->prepare("
            select * from `searches` where
            `day`=:day and
            `term`!='::unspecified::'
            order by `visits` desc"
        );
        $st->execute(array(
            "day" => $day
        ));
        $terms = $st->fetchAll(PDO::FETCH_ASSOC);
#echo "<PRE>"; print_r( $terms); die;
        $terms = $this->combine_search_terms($terms);
#echo "<PRE>"; print_r( $terms); die;
        return( $terms );
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

$jumbotron_data["articles"] = $metrics->query_article_count(
    $metrics->max["day"]
);

$jumbotron_data["email"] = 0;

$latest_entry = $metrics->max;

$search_terms = $metrics->query_search_terms($metrics->max["day"]);

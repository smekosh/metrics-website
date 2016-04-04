<?php
/**
 * reusable
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
     * stores to $this->max
     * and always returns query as array
     */
    function query_max() {
        $st = $this->db->prepare(
            "select
                `day`, `hour`, `stamp`
            from `reports`
            order by `id` desc
            limit 1"
        );
        $st->execute();
        $ret = $st->fetch(PDO::FETCH_ASSOC);
        $this->max = $ret;
        return( $ret );
    }

    /**
     * gets a particular day's most recent report's hour
     * returns as array
     */
    function query_max_day($day) {
        $temp = $this->max;
        $st = $this->db->prepare(
            "select
                `day`, `hour`, `stamp`
            from `reports`
            where `day`=:day
            order by `id` desc
            limit 1"
        );
        $st->execute(array("day" => $day));
        $ret = $st->fetch(PDO::FETCH_ASSOC);
        return( $ret );
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
            select *
            from `reports`
            where
                `day`=:day and
                `hour`=:hour
            limit 1"
        );
        $st->execute(array(
            "day" => $day,
            "hour" => $hour
        ));
        $t = $st->fetch(PDO::FETCH_ASSOC);
        if( empty($t) ) {
            return( 0 );
        }
        return( $t["total_pageviews"] );
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
            order by `id` desc
            limit 1"
        );
        $st->execute(array(
            "article_id" => $article_id,
            "day" => $day,
            "hour" => $hour
        ));
        $article = $st->fetch(PDO::FETCH_ASSOC);
        return($article["title"]);
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
            order by `id` desc
            limit 1"
        );
        $st->execute(array(
            "article_id" => $article_id,
            "day" => $day,
            "hour" => $hour
        ));
        $article = $st->fetch(PDO::FETCH_ASSOC);
        return($article["url"]);
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
            order by `id` desc
            limit 1"
        );
        $st->execute(array(
            "article_id" => $article_id,
            "day" => $day,
            "hour" => $hour
        ));
        $article = $st->fetch(PDO::FETCH_ASSOC);
        return($article["fb.shares"]);
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
            limit 1"
        );
        $st->execute(array(
            "article_id" => $article_id,
            "day" => $day,
            "hour" => $hour
        ));
        $article = $st->fetch(PDO::FETCH_ASSOC);
        if( $article["comments"] > 0 ) return( $article["comments"] );

        //TODO: pass a -1 through for comments closed?
        return( 0 );
    }

    /**
     * Given an ID, find date it was published on
     *
     * @param string $article_Id VOA article (pangea) ID number
     * @todo make this work
     */
    function get_pubdate_by_article_id($article_id) {
        $st = $this->db->prepare("
            select * from `urltrap` where `article_id`=:article_id limit 1"
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
            where
                `comments`>0 and
                `day`=:day and
                `hour`=:hour"
        );
        $st->execute(array(
            "day" => $day,
            "hour" => $hour
        ));

        $comment_count = $st->fetch(PDO::FETCH_ASSOC);
        if( is_null($comment_count["comments_total"]) ) return( 0 );

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
                sum(`fb.shares`) as `shares`
            from `reports`
            where
                `fb.shares`>0 and
                `day`=:day and
                `hour`=:hour"
        );
        $st->execute(array(
            "day" => $day,
            "hour" => $hour
        ));

        $shares = $st->fetch(PDO::FETCH_ASSOC);
        return( $shares["shares"] );
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
        #echo "<PRE>"; print_r( $top_stories ); die;
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

    /**
    * returns complex array of metrics info for the past week starting from day
     *
     * @param string $day Day in YYYY-MM-DD format
     */
    function query_last_7_days($day) {
        $ret = array(
            "dates" => array(),
            "pageviews" => array(),
            "social" => array(),
            "comments" => array(),
            "email" => array(),
            "articles" => array()
        );
        for( $i = 6; $i >= 0; $i-- ) {
            $computed_day = date("Y-m-d", strtotime("-{$i} day") );
            $day_max = $this->query_max_day($computed_day);

            $ret["dates"][] = $computed_day;
            $ret["articles"][] = $this->query_article_count($computed_day);
            $ret["comments"][] = $this->query_total_comments($computed_day, $day_max["hour"]);
            $ret["pageviews"][] = $this->query_total_pageviews($computed_day, $day_max["hour"]);
            $ret["social"][] = $this->query_total_shares($computed_day, $day_max["hour"]);
            $ret["email"][] = 0;
        }
        return( $ret );
    }
}

class metricsStats extends metricsData {
    function countGeneric($table, $day = null) {
        if( is_null($day) ) {
            $st = $this->db->prepare(
                "select count(*) as `count` from `{$table}`"
            );
            $st->execute();
        } else {
            $st = $this->db->prepare(
                "select count(*) as `count` from `{$table}` where `day`=:day"
            );
            $st->execute(array("day" => $day));
        }
        $r = $st->fetch(PDO::FETCH_ASSOC);
        return( $r["count"] );
    }

    function countReports($day = null) {
        return( $this->countGeneric("reports", $day) );
    }

    function countSearches($day = null) {
        return( $this->countGeneric("searches", $day) );
    }

    function countURLtrap($day = null) {
        return( $this->countGeneric("urltrap", $day) );
    }

    function countTables($day = null) {
        return( array(
            "reports" => $this->countReports($day),
            "searches" => $this->countSearches($day),
            "urltrap" => $this->countURLtrap($day)
        ));
    }

    function getCalendar($year = null, $month = null) {
        $cal = array();
        $ts = time();

        if( !is_null($year) && !is_null($month) ) {
            $ts = strtotime("{$year}-{$month}-01");
        }

        $days = date("t", $ts);
        $starting_day = strtotime(date("Y-m", $ts) . "-01");
        $starting_day_of_the_week = date("w", $starting_day);

        // pad beginning days
        for( $i = 0; $i < $starting_day_of_the_week; $i++ ) {
            $cal[] = array();
        }

        for( $i = 0; $i < $days; $i++ ) {
            $ts = strtotime("+{$i} day", $starting_day);
            $cal[] = array(
                "date" => date("Y-m-d", $ts),
                "day" => date("l", $ts)
            );
        }

        $cal = array_chunk($cal, 7);
        return( $cal );
    }

    // for charts
    function getHistogramReports($day) {
        #$ret = array();
        $st = $this->db->prepare(
            "select `hour`, count(*) as `count` from `reports` where `day`=:day and urltype='m' group by `hour` order by `hour`"
        );
        $st->execute(array("day" => $day));
        $r = $st->fetchAll(PDO::FETCH_ASSOC);

        #foreach( $r as $k => $v ) {
        #    $ret[] = array($v["count"], $v["count"]);
        #}
        return( $r );
        # return( $ret );
    }

    function publishDrift() {
        $ret = array();
        $st = $this->db->prepare(
            "select * from urltrap order by id desc limit 1000"
        );
        $st->execute();
        $r = $st->fetchAll(PDO::FETCH_ASSOC);
        foreach( $r as $k => $v ) {
            $a = strtotime($v["stamp"]);
            $b = strtotime($v["pubdate"]);
            $diff = intval(($a - $b) / 60);
            $v["diff"] = $diff;
            $ret[] = $v;
        }
        return( $ret );
    }

}

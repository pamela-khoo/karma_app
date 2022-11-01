<?php 
 include 'connection.php';
 include 'baseurl.php';
 include 'time.php';

if (isset($_GET['events_all'])) {

    $array = array();

    $query = "SELECT e.id AS event_id,e.name,e.start_date,e.end_date,e.start_time,e.end_time,e.description,e.status,e.venue,
            e.category,c.id,c.name AS cat_name,e.organization,o.id,o.org_name,e.points,e.image_url,e.limit_registration
            FROM events e JOIN category c ON e.category = c.id JOIN organization o ON e.organization = o.id 
            WHERE e.status = '1'";

    $sql = mysqli_query($conn, $query);

    while ($data = mysqli_fetch_assoc($sql)) {

        $row['id'] = $data['event_id'];
        $row['name'] = $data['name'];
        $row['start_date'] = $data['start_date'];
        $row['end_date'] = $data['end_date'];
        $row['start_time'] = $data['start_time'];
        $row['end_time'] = $data['end_time'];
        $row['description'] = $data['description'];
        $row['status'] = $data['status'];
        $row['venue'] = $data['venue'];
        $row['cat_name'] = $data['cat_name'];
        $row['org_name'] = $data['org_name'];
        $row['points'] = $data['points'];
        $row['image_url'] = $image_path.$data['image_url'];
        $row['limit_registration'] = $data['limit_registration'];

        array_push($array, $row);
    }

    header( 'Content-Type: application/json; charset=utf-8' );
    echo $val= str_replace('\\/', '/', json_encode($array,JSON_UNESCAPED_UNICODE | JSON_PRETTY_PRINT | JSON_NUMERIC_CHECK));
    die();

} elseif (isset($_GET['event_by_id'])) {
		
    $array = array();

    $eventID = $_GET['event_by_id'];

    $query = "SELECT e.id AS event_id,e.name,e.start_date,e.end_date,e.start_time,e.end_time,e.description,e.status,e.venue,
                e.category,c.id,c.name AS cat_name,e.organization,o.id,o.org_name,e.points,e.image_url,e.limit_registration
                FROM events e JOIN category c ON e.category = c.id JOIN organization o ON e.organization = o.id 
                WHERE e.id = '".$eventID."' ";

    $sql = mysqli_query($conn, $query);

    while ($data = mysqli_fetch_assoc($sql)) {
        
        $row['id'] = $data['event_id'];
        $row['name'] = $data['name'];
        $row['start_date'] = $data['start_date'];
        $row['end_date'] = $data['end_date'];
        $row['start_time'] = $data['start_time'];
        $row['end_time'] = $data['end_time'];
        $row['description'] = $data['description'];
        $row['status'] = $data['status'];
        $row['venue'] = $data['venue'];
        $row['cat_name'] = $data['cat_name'];
        $row['org_name'] = $data['org_name'];
        $row['points'] = $data['points'];
        $row['image_url'] = $image_path.$data['image_url'];
        $row['limit_registration'] = $data['limit_registration'];

        array_push($array, $row);
    }

    header( 'Content-Type: application/json; charset=utf-8' );
    echo $val= str_replace('\\/', '/', json_encode($array,JSON_UNESCAPED_UNICODE | JSON_PRETTY_PRINT | JSON_NUMERIC_CHECK));
    die();

} elseif (isset($_GET['mission'])) {

    $userID = $_GET['mission'];
    
    $array = array();

    $query = "SELECT e.id AS event_id,e.name,e.start_date,e.end_date,e.start_time,e.end_time,e.description,e.status,e.venue,
                e.category,c.id,c.name AS cat_name,e.organization,o.id,o.org_name,e.points,e.image_url,e.limit_registration
                FROM events e JOIN category c ON e.category = c.id JOIN organization o ON e.organization = o.id
                JOIN mission m ON e.id = m.event_id JOIN user u ON m.user_id = u.id
                WHERE m.user_id = '".$userID."' ORDER BY m.id DESC";

    $sql = mysqli_query($conn, $query);

    while ($data = mysqli_fetch_assoc($sql)) {
        
        $row['id'] = $data['event_id'];
        $row['name'] = $data['name'];
        $row['start_date'] = $data['start_date'];
        $row['end_date'] = $data['end_date'];
        $row['start_time'] = $data['start_time'];
        $row['end_time'] = $data['end_time'];
        $row['description'] = $data['description'];
        $row['status'] = $data['status'];
        $row['venue'] = $data['venue'];
        $row['cat_name'] = $data['cat_name'];
        $row['org_name'] = $data['org_name'];
        $row['points'] = $data['points'];
        $row['image_url'] = $image_path.$data['image_url'];
        $row['limit_registration'] = $data['limit_registration'];

        array_push($array, $row);
    }

    header( 'Content-Type: application/json; charset=utf-8' );
    echo $val= str_replace('\\/', '/', json_encode($array,JSON_UNESCAPED_UNICODE | JSON_PRETTY_PRINT | JSON_NUMERIC_CHECK));
    die();

} elseif (isset($_GET['upcoming_mission'])) {

    $userID = $_GET['upcoming_mission'];
    
    $array = array();

    $query = "SELECT e.id AS event_id,e.name,e.start_date,e.end_date,e.start_time,e.end_time,e.description,e.status,e.venue,
                e.category,c.id,c.name AS cat_name,e.organization,o.id,o.org_name,e.points,e.image_url,e.limit_registration
                FROM events e JOIN category c ON e.category = c.id JOIN organization o ON e.organization = o.id
                JOIN mission m ON e.id = m.event_id JOIN user u ON m.user_id = u.id
                WHERE m.user_id = '".$userID."' AND m.status = '0' ORDER BY m.id DESC";

    $sql = mysqli_query($conn, $query);

    while ($data = mysqli_fetch_assoc($sql)) {
        
        $row['id'] = $data['event_id'];
        $row['name'] = $data['name'];
        $row['start_date'] = $data['start_date'];
        $row['end_date'] = $data['end_date'];
        $row['start_time'] = $data['start_time'];
        $row['end_time'] = $data['end_time'];
        $row['description'] = $data['description'];
        $row['status'] = $data['status'];
        $row['venue'] = $data['venue'];
        $row['cat_name'] = $data['cat_name'];
        $row['org_name'] = $data['org_name'];
        $row['points'] = $data['points'];
        $row['image_url'] = $image_path.$data['image_url'];
        $row['limit_registration'] = $data['limit_registration'];

        array_push($array, $row);
    }

    header( 'Content-Type: application/json; charset=utf-8' );
    echo $val= str_replace('\\/', '/', json_encode($array,JSON_UNESCAPED_UNICODE | JSON_PRETTY_PRINT | JSON_NUMERIC_CHECK));
    die();

} elseif (isset($_GET['completed_mission'])) {

        $userID = $_GET['completed_mission'];
        
        $array = array();
    
        $query = "SELECT e.id AS event_id,e.name,e.start_date,e.end_date,e.start_time,e.end_time,e.description,e.status,e.venue,
                    e.category,c.id,c.name AS cat_name,e.organization,o.id,o.org_name,e.points,e.image_url,e.limit_registration
                    FROM events e JOIN category c ON e.category = c.id JOIN organization o ON e.organization = o.id
                    JOIN mission m ON e.id = m.event_id JOIN user u ON m.user_id = u.id
                    WHERE m.user_id = '".$userID."' AND m.status = '1' ORDER BY m.id DESC";
    
        $sql = mysqli_query($conn, $query);
    
        while ($data = mysqli_fetch_assoc($sql)) {
            
            $row['id'] = $data['event_id'];
            $row['name'] = $data['name'];
            $row['start_date'] = $data['start_date'];
            $row['end_date'] = $data['end_date'];
            $row['start_time'] = $data['start_time'];
            $row['end_time'] = $data['end_time'];
            $row['description'] = $data['description'];
            $row['status'] = $data['status'];
            $row['venue'] = $data['venue'];
            $row['cat_name'] = $data['cat_name'];
            $row['org_name'] = $data['org_name'];
            $row['points'] = $data['points'];
            $row['image_url'] = $image_path.$data['image_url'];
            $row['limit_registration'] = $data['limit_registration'];
    
            array_push($array, $row);
        }
    
        header( 'Content-Type: application/json; charset=utf-8' );
        echo $val= str_replace('\\/', '/', json_encode($array,JSON_UNESCAPED_UNICODE | JSON_PRETTY_PRINT | JSON_NUMERIC_CHECK));
        die();

} elseif (isset($_GET['user_stats'])) {

        $userID = $_GET['user_stats'];
        
        $array = array();
    
        $query = "SELECT u.id AS id, COUNT(m.id) AS mission_total, u.points AS points
                    FROM events e 
                    JOIN mission m ON e.id = m.event_id JOIN user u ON m.user_id = u.id 
                    WHERE m.user_id = '".$userID."' AND m.status = '1' ORDER BY m.id DESC";
    
        $sql = mysqli_query($conn, $query);
    
        while ($data = mysqli_fetch_assoc($sql)) { 
            $query ="SELECT * FROM earned_badges JOIN badges ON earned_badges.badge_key = badges.badge_key WHERE earned_badges.user_id = '" .$data['id']. "' "; 
        
            $badgeFetch = mysqli_query($conn, $query); 
            $getBadge = []; 
            foreach ($badgeFetch as $key => $value) { 
                $getBadge[$key]['badge_name'] = $value['badge_name']; 
                $getBadge[$key]['badge_img'] = $image_badge.$value['badge_img']; 
            }
            
            $row['id'] = $data['id'];
            $row['mission_total'] = $data['mission_total'];
            $row['points'] = $data['points'];
            $row['badge'] = $getBadge;
    
            array_push($array, $row);
        }
    
        header( 'Content-Type: application/json; charset=utf-8' );
        echo $val= str_replace('\\/', '/', json_encode($array,JSON_UNESCAPED_UNICODE | JSON_PRETTY_PRINT | JSON_NUMERIC_CHECK));
        die();

} elseif (isset($_GET['badge'])) { 
    $array = array(); 
    $query = "SELECT * FROM badges "; //TODO: WHERE badge_status = '1'
    $sql = mysqli_query($conn, $query); 
    while ($data = mysqli_fetch_assoc($sql)) { 
        $row['id'] = $data['id']; 
        $row['badge_name'] = $data['badge_name']; 
        $row['badge_description'] = $data['badge_description']; 
        $row['badge_status'] = $data['badge_status']; 
        $row['badge_img'] = $image_badge.$data['badge_img']; 
        $row['badge_key'] = $data['badge_key']; 

        array_push($array, $row); 
    } 

    header( 'Content-Type: application/json; charset=utf-8' );
    echo $val= str_replace('\\/', '/', json_encode($array,JSON_UNESCAPED_UNICODE | JSON_PRETTY_PRINT | JSON_NUMERIC_CHECK)); 

} elseif (isset($_GET['leaderboard'])) { 
    $array = array(); 
    $query = "SELECT id AS user_id, CONCAT(CONCAT(first_name,' '),last_name) AS name, points FROM user ORDER BY points DESC LIMIT 5"; 
    $sql = mysqli_query($conn, $query); 

    while ($data = mysqli_fetch_assoc($sql)) { 
        $query ="SELECT * FROM earned_badges JOIN badges ON earned_badges.badge_key = badges.badge_key WHERE earned_badges.user_id = '" .$data['user_id']. "' ORDER BY user_id ASC"; 
    
        $badgeFetch = mysqli_query($conn, $query); 
        $getBadge = []; 
        foreach ($badgeFetch as $key => $value) { 
            $getBadge[$key]['badge_name'] = $value['badge_name']; 
            $getBadge[$key]['badge_img'] = $image_badge.$value['badge_img']; 
        }

        $row['user_id'] = $data['user_id'];
        $row['name'] = $data['name'];
        $row['points'] = $data['points'];
        $row['badge'] = $getBadge;

        array_push($array, $row);
    }

    header( 'Content-Type: application/json; charset=utf-8' );
    echo $val= str_replace('\\/', '/', json_encode($array,JSON_UNESCAPED_UNICODE | JSON_PRETTY_PRINT | JSON_NUMERIC_CHECK));

} elseif (isset($_GET['point'])) { 
    $array = array(); 
    $query = "SELECT u.id as user_id, SUM(e.points) as total
    FROM mission m 
    JOIN events e ON m.event_id = e.id 
    JOIN user u ON m.user_id = u.id
    WHERE m.status = '1' 
    GROUP BY m.user_id 
    "; 
    $sql = mysqli_query($conn, $query); 

    while ($data = mysqli_fetch_assoc($sql)) { 
       $query = "UPDATE user SET points = '".$data['total']."' WHERE id = '".$data['user_id']."' "; 
       print_r($query);
       $pointsUpdate = mysqli_query($conn, $query); 

        $row['id'] = $data['user_id'];
        $row['points'] = $data['total'];

        array_push($array, $row);
    }

    header( 'Content-Type: application/json; charset=utf-8' );
    echo $val= str_replace('\\/', '/', json_encode($array,JSON_UNESCAPED_UNICODE | JSON_PRETTY_PRINT | JSON_NUMERIC_CHECK));
} 

    

?>
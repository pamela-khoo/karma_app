<?php 
 include 'connection.php';
 include 'baseurl.php';
 include 'time.php';

// if (isset($_GET['mission'])) { 
//     $array = array(); 
//     $query = "SELECT * FROM user ORDER BY id DESC";
//     $sql = mysqli_query($conn, $query); 
    
//     while ($data = mysqli_fetch_assoc($sql)) { 

//         $query = "SELECT * FROM mission JOIN events ON mission.event_id = events.id
//                 WHERE mission.user_id = '".$data['id']."' ";

//         $missionFetch = mysqli_query($conn, $query);

//         $getMission = [];
//          foreach ($missionFetch as $key => $value) {
//              $getMission[$key]['id'] = $value['id'];
//              $getMission[$key]['image_url'] = $value['image_url'];
//          }

//         $row['id'] = $data['id']; 
//         $row['first_name'] = $data['first_name']; 
//         $row['mission'] = $getMission;

//         array_push($array, $row); 
//     }
//     header('Content-Type: application/json; charset=utf-8');
//     echo str_replace('\\/', '/', json_encode($array, JSON_UNESCAPED_UNICODE | JSON_PRETTY_PRINT));

// } elseif (isset($_GET['events'])) { 
//     $array = array(); 
//     $query = "SELECT * FROM events ORDER BY id DESC";
//     $sql = mysqli_query($conn, $query); 
    
//     while ($data = mysqli_fetch_assoc($sql)) { 

//         $row['id'] = $data['id']; 
//         $row['name'] = $data['name']; 

//         array_push($array, $row); 
//     }
//     header('Content-Type: application/json; charset=utf-8');
//     echo str_replace('\\/', '/', json_encode($array, JSON_UNESCAPED_UNICODE | JSON_PRETTY_PRINT));

//     //NEW CODE!!!!!!!!!!
// } else
    
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

} else if (isset($_GET['event_by_id'])) {
		
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

} else if (isset($_GET['mission'])) {

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

}
    

?>
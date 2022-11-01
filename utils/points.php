<?php 
include '../include/connection.php';


$data = file_get_contents('php://input');
$dataDecode = json_decode($data, true);

$user_id = $dataDecode['id']; 

//sum total score and store in user table 
$query = "SELECT u.id as user_id, SUM(e.points) as total
            FROM mission m 
            JOIN events e ON m.event_id = e.id 
            JOIN user u ON m.user_id = u.id
            WHERE m.status = '1' 
            GROUP BY m.user_id "; 
$sql = mysqli_query($conn, $query); 

while ($total = mysqli_fetch_assoc($sql)) { 
   $query = "UPDATE user SET points = '".$total['total']."' WHERE id = '".$total['user_id']."' "; 
   $pointsUpdate = mysqli_query($conn, $query); 
}

//get current score 
$query = mysqli_query($conn, "SELECT * FROM user WHERE id = '".$user_id. "' ");
$fetch = mysqli_fetch_assoc($query);

$currentPoints = $fetch['points']; 

//add earned badges 
if ($currentPoints >= 10 && $currentPoints <= 99) { 
    echo "Silver"; 
    $result = mysqli_fetch_assoc(mysqli_query($conn, "SELECT * FROM earned_badges WHERE badge_key = 10 AND user_id = '".$user_id. "'")); 
    if ($result['badge_key'] != 10) { 
        mysqli_query($conn, "INSERT INTO earned_badges (user_id, badge_key) VALUES ('" .$user_id. "', 10)"); 
    }
} elseif ($currentPoints >= 100 && $currentPoints <= 199) { 
    echo "Gold"; 
    $result = mysqli_fetch_assoc(mysqli_query($conn, "SELECT * FROM earned_badges WHERE badge_key = 100 AND user_id = '".$user_id. "'")); 
    if ($result['badge_key'] != 100) { 
        mysqli_query($conn, "INSERT INTO earned_badges (user_id, badge_key) VALUES ('" .$user_id. "', 100)"); 
    }
} elseif ($currentPoints >= 200 && $currentPoints <= 299) { 
    echo "Diamond"; 
    $result = mysqli_fetch_assoc(mysqli_query($conn, "SELECT * FROM earned_badges WHERE badge_key = 200 AND user_id = '".$user_id. "'")); 
    if ($result['badge_key'] != 200) { 
        mysqli_query($conn, "INSERT INTO earned_badges (user_id, badge_key) VALUES ('" .$user_id. "', 200)"); 
    }
}

?>
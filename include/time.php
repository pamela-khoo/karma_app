<?php

//return current date time

function getCurrentDateTime(){

    /** You can configure timezones
        more detail about timezones
        you can visit below link
        https://www.php.net/manual/en/timezones.php*/

    date_default_timezone_set('Asia/Jakarta');
    return date("Y-m-d H:i:s");
}
function getDateString($date){
    $dateArray = date_parse_from_format('Y/m/d', $date);
    $monthName = DateTime::createFromFormat('!m', $dateArray['month'])->format('M');
    return $dateArray['day'] . " " . $monthName  . " " . $dateArray['year'];
}

function getDateTimeDifferenceString($datetime){
    $currentDateTime = new DateTime(getCurrentDateTime());
    $passedDateTime = new DateTime($datetime);
    $interval = $currentDateTime->diff($passedDateTime);
    //$elapsed = $interval->format('%y years %m months %a days %h hours %i minutes %s seconds');
    $day = $interval->format('%a');
    $hour = $interval->format('%h');
    $min = $interval->format('%i');
    $seconds = $interval->format('%s');

    if($day > 7)
        return getDateString($datetime);
    else if($day >= 1 && $day <= 7 ){
        if($day == 1) return $day . " day ago";
        return $day . " days ago";
    }else if($hour >= 1 && $hour <= 24){
        if($hour == 1) return $hour . " hour ago";
        return $hour . " hours ago";
    }else if($min >= 1 && $min <= 60){
        if($min == 1) return $min . " minute ago";
        return $min . " minutes ago";
    }else if($seconds >= 1 && $seconds <= 60){
        if($seconds == 1) return $seconds . " second ago";
        return $seconds . " seconds ago";
    }
}

?>
<?php
include '../connect.php';
$sql = mysqli_query($con, "SELECT * FROM onlineclass_tb");
$list = array();

if(mysqli_num_rows($sql) > 0) {
    while($row = mysqli_fetch_assoc($sql)) {
        $myarray = array();
        $myarray['result'] = 'success';
        $myarray['Link'] = $row['link'];
        $myarray['Caption'] = $row['caption'];
        $myarray['Date'] = $row['date'];

        array_push($list, $myarray);
    }
} 
else {
    $myarray = array();
    $myarray['result'] = 'failed';
    array_push($list, $myarray);
}

echo json_encode($list);
?>

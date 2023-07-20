<?php
include '../connect.php';
$sql = mysqli_query($con, "SELECT * FROM add_post_user INNER JOIN user_register_table ON add_post_user.login_id = user_register_table.login_id WHERE (image IS NOT NULL OR text IS NOT NULL)");
$list = array();

if(mysqli_num_rows($sql) > 0) {
    while($row = mysqli_fetch_assoc($sql)) {
        $myarray = array();
        $myarray['result'] = 'success';
        $myarray['Name'] = $row['name'];

        $myarray['Date'] = $row['date'];
        $myarray['Time'] = $row['time'];
        $myarray['Image'] = $row['image'];
        $myarray['Text'] = $row['text'];

        array_push($list, $myarray);
    }
} else {
    $myarray = array();
    $myarray['result'] = 'failed';
    array_push($list, $myarray);
}

echo json_encode($list);
?>

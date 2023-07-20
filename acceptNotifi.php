<?php
include "connect.php";
$login_id = $_POST['login_id'];
$sql = mysqli_query($con,"SELECT * FROM request_table
INNER JOIN user_register_table ON request_table.login_id = user_register_table.login_id WHERE req_status='Accepted' AND request_table.login_id='$login_id'
ORDER BY req_id DESC;");
$list = array();

if ($sql === false) {
    $myarray = array();
    $myarray['result'] = 'failed';
    $myarray['error'] = mysqli_error($con);
    array_push($list, $myarray);
} else {
    if (mysqli_num_rows($sql) > 0) {
        while ($row = mysqli_fetch_assoc($sql)) {
            $myarray = array();
            $myarray['result'] = 'success';
            $myarray['req_id']  = $row['req_id']; 
            $myarray['login_id']  = $row['login_id']; 

            $myarray['Name'] = $row['name'] ?? '';
            $myarray['UDID'] = $row['UDID'] ?? '';
            $myarray['Amount'] = $row['amount'] ?? '';
            $myarray['Contact_name'] = $row['contact_name'] ?? '';
            $myarray['Contact_number'] = $row['contact_number'] ?? '';
            $myarray['Contact_address'] = $row['contact_address'] ?? '';
            $myarray['Foodtype'] = $row['foodtype'] ?? '';
            $myarray['Image'] = $row['image'] ?? '';
            $myarray['Req_status'] = $row['req_status'] ?? '';
            $myarray['Description'] = $row['description'] ?? '';
            $myarray['Date'] = $row['date'];
            $myarray['Username'] = $row['username'] ?? '';

            array_push($list, $myarray);
        }
    } else {
        $myarray = array();
        $myarray['result'] = 'failed';
        array_push($list, $myarray);
    }
}

echo json_encode($list);
?>

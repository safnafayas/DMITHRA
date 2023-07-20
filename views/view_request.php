<?php


include "../connect.php";
$type = $_POST['type'];
$sql = mysqli_query($con, "SELECT request_table.*,user_register_table.*,user_login.*, request_table.contact_number as phone FROM request_table INNER JOIN user_register_table ON request_table.login_id = user_register_table.login_id INNER JOIN user_login on request_table.login_id=user_login.login_id WHERE request_table.type='$type' && req_status='Requested';");

$list = array();

if (mysqli_num_rows($sql) > 0) {
    while ($row = mysqli_fetch_assoc($sql)) {
        $myarray = array();
        $myarray['result'] = 'success';
        $myarray['req_id'] = $row['req_id'];
        $myarray['type'] = $row['type'] ?? '';
        $myarray['Name'] = $row['name'] ?? '';
        $myarray['UDID'] = $row['UDID'] ?? '';
        $myarray['Amount'] = $row['amount'] ?? '';
        $myarray['Contact_name'] = $row['contact_name'] ?? '';
        $myarray['Contact_number'] = $row['phone'] ?? '';
        $myarray['Contact_address'] = $row['contact_address'] ?? '';
        $myarray['Foodtype'] = $row['foodtype'] ?? '';
        $myarray['Image'] = $row['image'] ?? '';
        $myarray['Req_status'] = $row['req_status'] ?? '';
        $myarray['Description'] = $row['description'] ?? '';
        $myarray['Date'] = $row['date'];
        array_push($list, $myarray);
    }
} else {
    $myarray = array();
    $myarray['result'] = 'failed';
    array_push($list, $myarray);
}

echo json_encode($list);
?>
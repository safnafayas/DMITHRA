<?php
include "connect.php";
$login_id = $_POST['login_id'];
$sql = mysqli_query($con,"SELECT * FROM product_orders
INNER JOIN user_register_table ON product_orders.user_id = user_register_table.login_id INNER JOIN sponsor_reg ON product_orders.user_id = sponsor_reg.login_id WHERE status='accepted' AND product_orders.user_id='$login_id'
ORDER BY date DESC;");
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
            $myarray['login_id']  = $row['login_id']; 

            $myarray['Name'] = $row['name'] ?? '';
            $myarray['rate'] = $row['rate'] ?? '';
            $myarray['pickupdate'] = $row['pickupdate'] ?? '';
            $myarray['date'] = $row['date'] ?? '';
            $myarray['product_id'] = $row['product_id'] ?? '';
            $myarray['order_id'] = $row['order_id'] ?? '';
            $myarray['Image'] = $row['image'] ?? '';
            $myarray['status'] = $row['status'] ?? '';
        

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

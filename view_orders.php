<?php
include 'connect.php';

$sql = $con->query("SELECT * FROM product_orders INNER JOIN product_tb ON product_tb.product_id = product_orders.product_id where status='Requested'");

if ($sql) {
    $list = array();
    if ($sql->num_rows > 0) {
        while ($rowdata = $sql->fetch_assoc()) {
            $myarray['result'] = "success";
            $myarray['order_id'] = $rowdata['order_id'];
            $myarray['product_id'] = $rowdata['product_id'];
            $myarray['product_name'] = $rowdata['product_name'];
            $myarray['description'] = $rowdata['description'];
            $myarray['rate'] = $rowdata['rate'];
            $myarray['pickupdate'] = $rowdata['pickupdate'];
            $myarray['image'] = $rowdata['image'];
            array_push($list, $myarray);
        }
    } else {
        $myarray['result'] = "failed";
        array_push($list, $myarray);
    }

    echo json_encode($list);
} else {
    $myarray['result'] = "failed";
    echo json_encode($myarray);
}
?>

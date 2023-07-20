<?php
include "../connect.php";
$sql = mysqli_query($con, "SELECT * FROM spo_org_login
                          INNER JOIN org_register ON spo_org_login.sp_og_id = org_register.login_id");

$list = array();

if ($sql->num_rows > 0) {
  while ($row = mysqli_fetch_assoc($sql)) {
    $myarray['result'] = 'success';
    $myarray['Org_name'] = $row['username'];
    $myarray['Email'] = $row['email'];
    $myarray['Org_category'] = $row['org_category'];
    $myarray['Address'] = $row['address'];
    $myarray['Location'] = $row['location'];    
    $myarray['Contact_number'] = $row['contact_number'];
    array_push($list, $myarray);
  }
} else {
  $myarray['result'] = 'failed';
  array_push($list, $myarray);
}

echo json_encode($list);
?>

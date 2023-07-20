<?php
include "connect.php";

// Retrieve the POST parameters
$type = $_POST['type'] ?? '';
$login_id = $_POST['login_id'] ?? '';
$date = $_POST['date'] ?? '';
$description = $_POST['description'] ?? '';
$image = $_FILES['image']['name'] ?? '';
$imagePath = 'prescribtionUpload/'.$image;
$tmp_name = $_FILES['image']['tmp_name'] ?? '';
move_uploaded_file($tmp_name, $imagePath);
$amount = $_POST['amount'] ?? '';
$foodtype = $_POST['foodtype'] ?? '';
$contact_name = $_POST['contact_name'] ?? '';
$contact_number = $_POST['contact_number'] ?? '';
$contact_address = $_POST['contact_address'] ?? '';
$recipient_id = $_POST['accepted_id'] ?? '';

// Perform the SQL query
$sql = mysqli_query($con, "INSERT INTO `request_table` (`type`, `login_id`, `date`, `description`, `image`, `amount`, `foodtype`, `contact_name`, `contact_number`, `contact_address`)
                            VALUES ('$type', '$login_id', '$date', '$description', '$image', '$amount', '$foodtype', '$contact_name', '$contact_number', '$contact_address')");

// Prepare the response
$response = array();

if ($sql) {
    // Query executed successfully
    $response['result'] = 'success';
    $response['req_id'] = mysqli_insert_id($con);
} else {
    // Query execution failed
    $response['result'] = 'failed';
}

// Convert the response array to JSON format
echo json_encode($response);

?>




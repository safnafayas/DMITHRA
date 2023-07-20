<?php
include "connect.php";

// Check if the required POST parameters are set
$req_id = $_POST['req_id'] ?? '';
$login_id = $_POST['login_id'] ?? '';

if (!empty($req_id) && !empty($login_id)) {
    // Execute the SQL query
    $sql = mysqli_query($con, "UPDATE `request_table` SET req_status='Accepted', login_id='$login_id',accepted_id='$login_id' WHERE req_id='$req_id'");

    if ($sql) {
        // Query executed successfully
        $response = array("result" => "success", "req_id" => $req_id);
    } else {
        // Query execution failed
        $response = array("result" => "error", "message" => "Update failed");
    }
} else {
    // Missing or empty parameters
    $response = array("result" => "error", "message" => "Invalid parameters");
}

// Convert the response array to JSON format
echo json_encode($response);
?>

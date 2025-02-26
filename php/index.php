<?php
// index.php - A simple Hello World PHP application

// Set the content type header
header('Content-Type: text/html; charset=UTF-8');

// Get current server time
$serverTime = date('Y-m-d H:i:s');

// Get client IP address
$clientIP = $_SERVER['REMOTE_ADDR'];

// Get server information
$serverInfo = $_SERVER['SERVER_SOFTWARE'];
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>PHP Hello World</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            max-width: 800px;
            margin: 0 auto;
            padding: 20px;
            line-height: 1.6;
        }
        .container {
            background-color: #f5f5f5;
            border-radius: 8px;
            padding: 20px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }
        h1 {
            color: #4a5568;
        }
        .info {
            background-color: #e6f7ff;
            border-left: 4px solid #1890ff;
            padding: 10px 15px;
            margin: 20px 0;
        }
        footer {
            margin-top: 30px;
            font-size: 0.9em;
            color: #718096;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Hello, World!</h1>
        <p>Welcome to your first PHP application running on Apache.</p>
        
        <div class="info">
            <h2>Server Information</h2>
            <ul>
                <li><strong>Current Server Time:</strong> <?php echo $serverTime; ?></li>
                <li><strong>Your IP Address:</strong> <?php echo $clientIP; ?></li>
                <li><strong>Server Software:</strong> <?php echo $serverInfo; ?></li>
                <li><strong>PHP Version:</strong> <?php echo phpversion(); ?></li>
            </ul>
        </div>
        
        <h2>PHP Environment Variables</h2>
        <p>Here are some environment variables from your PHP server:</p>
        <pre><?php print_r($_SERVER); ?></pre>
    </div>
    
    <footer>
        <p>This is a simple PHP Hello World example running on Apache.</p>
    </footer>
</body>
</html>

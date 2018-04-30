<?php
session_start();
$params = session_get_cookie_params();
setcookie(session_name(), '', 0, $params['path'], $params['domain'], $params['secure'], isset($params['httponly']));
session_destroy();
session_write_close();
?>

<html>
<body>
<h1>Logged out</h1>
<p><a href="index.php">Login</a></p>
</body>
</html>

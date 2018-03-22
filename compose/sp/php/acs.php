<html>
<body>

<?php

  ini_set('display_errors', 1);
  ini_set('display_startup_errors', 1);
  error_reporting(E_ALL);


  session_start();

  require_once('/var/www/html/php-saml/_toolkit_loader.php');
 
  $auth = new OneLogin_Saml2_Auth();
  if (isset($_SESSION) && isset($_SESSION['AuthNRequestID'])) {
      $requestID = $_SESSION['AuthNRequestID'];
  } else {
      $requestID = null;
  }

  $auth->processResponse($requestID);
  unset($_SESSION['AuthNRequestID']);

  $errors = $auth->getErrors();

  if (!empty($errors)) {
      echo '<p>', implode(', ', $errors), '</p>';
      exit();
  }

  if (!$auth->isAuthenticated()) {
      echo "<p>Not authenticated</p>";
      exit();
  }

  $_SESSION['samlUserdata'] = $auth->getAttributes();
  $_SESSION['samlNameId'] = $auth->getNameId();
  $_SESSION['samlNameIdFormat'] = $auth->getNameIdFormat();
  $_SESSION['samlSessionIndex'] = $auth->getSessionIndex();

  if (isset($_POST['RelayState']) && OneLogin_Saml2_Utils::getSelfURL() != $_POST['RelayState']) {
      $auth->redirectTo($_POST['RelayState']);
  }

  $attributes = $_SESSION['samlUserdata'];
  $nameId = $_SESSION['samlNameId'];

  echo '<h1>Identified user: '. htmlentities($nameId) .'</h1>';

  if (!empty($attributes)) {
      echo '<h2>'._('User attributes:').'</h2>';
      echo '<table><thead><th>'._('Name').'</th><th>'._('Values').'</th></thead><tbody>';
      foreach ($attributes as $attributeName => $attributeValues) {
          echo '<tr><td>' . htmlentities($attributeName) . '</td><td><ul>';
          foreach ($attributeValues as $attributeValue) {
              echo '<li>' . htmlentities($attributeValue) . '</li>';
          }
          echo '</ul></td></tr>';
      }
      echo '</tbody></table>';
  } else {
      echo _('No attributes found.');
  }
?>

</body>
</html>

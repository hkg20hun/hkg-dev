function generateInviteCode($length = 8) {
  $characters = '0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHJKLMNOPQRSTUVWXYZ';
  $CODE = ' ';
  for ($i = 0; < $length; $i++) {
    $code .= $characters[rand(0, strlen($characters) -1)];
  }
  return $code;
}

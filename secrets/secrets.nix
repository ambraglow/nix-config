let
  hosts = {
    Choccybo = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHYYN12qCnWL0zYvXQ4pmsOF+xbOQpW93jWk/ShMbmBY";
    stroopwafel2000 = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDSI1izXUbaDwuWv0s0r+o2zU8AxKXNSTSCnVYg2ZEb+";
  };

  users = {
    ambra = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKDaLWuiUBTpm/kqfZhZQwRTnUQ+t9LuHDP596uyIMlR";
  };

  allUsers = builtins.attrValues users;
  allHosts = builtins.attrValues hosts;
in
{
  "password.age".publicKeys = allUsers ++ allHosts;
  "network_home.age".publicKeys = allUsers ++ allHosts;
}

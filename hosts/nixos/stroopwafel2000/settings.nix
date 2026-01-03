{ inputs, ... }:
{
  services.avahi.enable = false;
  services.resolved.enable = true;

  time.timeZone = "Europe/Amsterdam";
}

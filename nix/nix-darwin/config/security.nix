{
  networking.applicationFirewall = {
    enable = true;
    blockAllIncoming = false;
  };

  security = {
    pam = {
      services = {
        sudo_local = {
          touchIdAuth = true;
          watchIdAuth = true;
        };
      };
    };
  };
}

{...}: {
  services.xserver = {
    enable = true;
    videoDrivers = ["intel" "amdgpu"];
    windowManager.qtile = {
      enable = true;
      extraPackages = python3Packages:
        with python3Packages; [
          qtile-extras
        ];
    };
  };
}

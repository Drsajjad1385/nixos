{...}: {
  services.mpd = {
    enable = true;
    user = "sajjad";
    group = "users";
    musicDirectory = "/home/sajjad/Music";
    extraConfig = ''
      audio_output {
        type "pulse"
        name "PulseAudio"
        server "unix:/run/user/1000/pulse/native"
      }
    '';
  };
}

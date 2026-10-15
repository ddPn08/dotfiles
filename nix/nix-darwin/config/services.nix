{ pkgs }:
let
  soundFontDir = "/Users/ddpn08/Applications/Domino/SoundFonts";
  shairport-sync = pkgs.callPackage ../packages/shairport-sync.nix { };
in
{
  environment.systemPackages = [ shairport-sync ];

  launchd.user.agents.domino-fluidsynth = {
    script = ''
      exec /opt/homebrew/bin/fluidsynth \
        -i -s -q \
        -a coreaudio \
        -m coremidi \
        -p FluidSynth \
        -g 0.7 \
        -o synth.midi-bank-select=gs \
        ${soundFontDir}/TimGM6mb.sf2 \
        ${soundFontDir}/Equinox_Grand_Pianos.sf2
    '';
    serviceConfig = {
      Label = "com.ddpn08.domino.fluidsynth";
      RunAtLoad = true;
      KeepAlive = true;
      LimitLoadToSessionType = "Aqua";
      StandardOutPath = "/tmp/domino-fluidsynth.log";
      StandardErrorPath = "/tmp/domino-fluidsynth.err";
    };
  };

  launchd.user.agents.shairport-sync = {
    serviceConfig = {
      Label = "com.ddpn08.shairport-sync";
      ProgramArguments = [
        "${shairport-sync}/bin/shairport-sync"
        "--output=coreaudio"
        "--port=5001"
      ];
      RunAtLoad = true;
      KeepAlive = {
        SuccessfulExit = false;
      };
      LimitLoadToSessionType = "Aqua";
      StandardOutPath = "/tmp/shairport-sync.log";
      StandardErrorPath = "/tmp/shairport-sync.err";
    };
  };

  services = {
  };
}

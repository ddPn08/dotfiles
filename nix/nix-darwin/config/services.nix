let
  soundFontDir = "/Users/ddpn08/Applications/Domino/SoundFonts";
in
{
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

  services = {
  };
}

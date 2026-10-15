{
  lib,
  stdenv,
  fetchzip,
  autoreconfHook,
  pkg-config,
  ffmpeg,
  libconfig,
  openssl,
  popt,
  soxr,
}:
stdenv.mkDerivation {
  pname = "shairport-sync";
  version = "5.6";

  src = fetchzip {
    url = "https://github.com/mikebrady/shairport-sync/archive/refs/tags/5.6.tar.gz";
    hash = "sha256-q9v8ge8d1r+nVoLUeZPHPUSo8GRfc2waXMqugqhXO6A=";
  };

  nativeBuildInputs = [
    autoreconfHook
    pkg-config
  ];
  buildInputs = [
    ffmpeg
    libconfig
    openssl
    popt
    soxr
  ];

  configureFlags = [
    "--with-os=darwin"
    "--with-coreaudio"
    "--with-dns_sd"
    "--with-ffmpeg"
    "--with-ssl=openssl"
    "--with-soxr"
    "--without-configfiles"
  ];

  strictDeps = true;
  enableParallelBuilding = true;
  doInstallCheck = true;
  installCheckPhase = ''
    runHook preInstallCheck
    "$out/bin/shairport-sync" --version | grep -F -- "-coreaudio-"
    "$out/bin/shairport-sync" --help | grep -Fx "    coreaudio (default)"
    runHook postInstallCheck
  '';

  meta = {
    description = "AirPlay audio receiver with native CoreAudio output";
    homepage = "https://github.com/mikebrady/shairport-sync";
    license = lib.licenses.mit;
    mainProgram = "shairport-sync";
    platforms = lib.platforms.darwin;
  };
}

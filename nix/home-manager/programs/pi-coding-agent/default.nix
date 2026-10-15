{ pkgs, ... }:
{
  programs.pi-coding-agent = {
    enable = true;
    package = pkgs.pi-coding-agent.overrideAttrs (
      finalAttrs: previousAttrs: {
        version = "1.2.0";
        src = pkgs.fetchFromGitHub {
          owner = "earendil-works";
          repo = "pi";
          tag = "v${finalAttrs.version}";
          hash = "sha256-IjNJvVxjzRur2foQDWPA5iM9sa3ThBoZU1/LT5pU6jc=";
        };
        npmDepsHash = "sha256-P/KWhkvLjtpWRiwLCHu2iUVyI8nragSnQGWUQNsRhw8=";
        npmDeps = pkgs.fetchNpmDeps {
          name = "${finalAttrs.pname}-${finalAttrs.version}-npm-deps";
          inherit (finalAttrs) src;
          hash = finalAttrs.npmDepsHash;
        };
        modelData = pkgs.fetchurl {
          url = "https://registry.npmjs.org/@earendil-works/pi-ai/-/pi-ai-${finalAttrs.version}.tgz";
          hash = "sha256-w+aUI7yrlxLzGn5bbTRIrjVq+EQ57GvHAfYm9uoWRTU=";
        };
        buildPhase = ''
          runHook preBuild
          npm run build:offline
          runHook postBuild
        '';
        # v1 replaces the client/protocol workspaces with codemode/MCP.
        postInstall =
          pkgs.lib.replaceStrings
            [
              "@earendil-works/pi-client:packages/client"
              "@earendil-works/pi-protocol:packages/protocol"
            ]
            [
              "@earendil-works/pi-codemode:packages/codemode"
              "@earendil-works/pi-mcp:packages/mcp"
            ]
            previousAttrs.postInstall;
      }
    );
  };
}

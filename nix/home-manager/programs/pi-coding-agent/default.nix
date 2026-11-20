{ config, pkgs, ... }:
let
  configDir = config.programs.pi-coding-agent.configDir;
in
{
  # Follow the sound selected in macOS System Settings instead of a fixed file.
  home.sessionVariables = pkgs.lib.optionalAttrs pkgs.stdenv.hostPlatform.isDarwin {
    PI_NOTIFY_SOUND_CMD = "afplay /System/Library/Sounds/Tink.aiff";
  };

  home.file = {
    "${configDir}/prompts/self-review.md".source = ./prompts/self-review.md;
    "${configDir}/prompts/split-plan.md".source = ./prompts/split-plan.md;
    "${configDir}/openai-codex-compat.json".source = ./openai-codex-compat.json;
  };

  programs.pi-coding-agent = {
    enable = true;
    # Pi updates changelog markers and preferences in settings.json at runtime.
    mutableSettings = true;
    settings = {
      "$schema" = "https://pi.dev/schemas/settings.schema.json";
      theme = "light";
      defaultProvider = "openai-codex";
      defaultModel = "gpt-6.2-sol";
      defaultThinkingLevel = "medium";
      hideThinkingBlock = false;
      npmCommand = [ "pnpm" ];
      packages = [
        "npm:pi-input-history"
        "npm:pi-openai-codex-compat"
        "npm:pi-notify"
        "npm:@estebanforge/pi-antigravity-bridge"
      ];
    };
    keybindings."app.model.cycleForward" = [ ];
    models.providers.openai-codex.modelOverrides."gpt-6.1-sol".contextWindow = 500000;
    context = ./AGENTS.md;
  };
}

{
  programs.antigravity-cli = {
    enable = true;
    context.AGENTS = ../pi-coding-agent/AGENTS.md;
    skills = {
      self-review = ./skills/self-review/SKILL.md;
      split-plan = ./skills/split-plan/SKILL.md;
    };
  };
}

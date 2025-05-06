{ config, pkgs, ... }:
{
  programs.starship = {
    enable = true;
    # Configuration written to ~/.config/starship.toml
    settings = {
      # palette = "gruvbox_dark";
      username = {
        show_always = true;
        format = "[╭─$user]($style)@";
        style_user = "bold bg:#b16286 fg:#3c3836";
        style_root = "bg:#9A348E";
      };
      hostname = {
        ssh_only = false;
        format = "[$ssh_symbol$hostname]($style) in ";
        style = "bold fg:#3c3836 bg:#b16286";
      };
      directory = {
        truncation_length = 0;
        truncate_to_repo = false;
        format = "[$path]($style) ";
        style = "cyan";
      };
      git_branch = {
        format = "[🌱 $branch]($style) ";
        style = "bold yellow";
      };
      git_commit = {
        commit_hash_length = 4;
        tag_symbol = "🔖 ";
      };
      git_status = {
        untracked = "";
        staged = "+";
        modified = "~";
        conflicted = "!";
        style = "bold green";
      };
      cmd_duration = {
        min_time = 0;
        show_milliseconds = true;
        format = " [$duration]($style)";
        style = "bold white";
      };
      python = {
        format = "[$symbol$version $virtualenv]($style) ";
        style = "fg:#d65d0e bg:#3c3836";
      };
      direnv = {
        disabled = false;
        symbol = "🌀 ";
        format = "[$symbol$dirname]($style) ";
        style = "bold blue";
      };
      gcloud = {
        disabled = true;
        format = "[$symbol$account]($style) ";
        style = "fg:#4285f4 bg:#3c3836";
      };
    };
  };
}

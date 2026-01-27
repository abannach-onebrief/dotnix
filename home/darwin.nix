{
  config,
  pkgs,
  lib,
  ...
}: {
  imports = [
    ./shared.nix
    ../modules/homebrew.nix
  ];
  fonts.fontconfig.enable = true;
  # macOS-specific packages
  home.packages = with pkgs; [
    # macOS-specific tools
  ];

  # macOS-specific program configurations
  programs = {
    ssh = {
      enable = false;
      addKeysToAgent = "yes";
      extraConfig = ''
        UseKeychain yes
      '';
    };
    git = {
      userEmail = "244587300+abannach-onebrief@users.noreply.github.com";
      signing.format = "ssh";
      signing.key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILEFX2ZiAHE1UWQ7f3AWylMJBH+bJXQEss6hxkb+QMPG";
      signing.signer = "/Applications/1Password.app/Contents/MacOS/op-ssh-sign";
      signing.signByDefault = true;
    };
    bash.shellAliases = {
      rebuild = "home-manager switch --flake ~/.config/dotnix#picard";
      rebuildSys = "sudo darwin-rebuild switch --flake ~/.config/dotnix#holodeck";

      # Work aliases
    };
    zsh.initContent = ''
      bindkey "^[[3~" delete-char
    '';
    zsh.shellAliases = {
      rebuild = "home-manager switch --flake ~/.config/dotnix#picard";
      rebuildSys = "sudo darwin-rebuild switch --flake ~/.config/dotnix#holodeck";

      # Work aliases
    };
    zsh.sessionVariables = {
      NODE_EXTRA_CA_CERTS = "$HOME/.certs/zscaler_cert.pem";
      CURL_CA_BUNDLE = "$HOME/.certs/zscaler_cert.pem";
    };
  };

  # Enable homebrew for macOS
  homebrew.enable = true;

  # macOS-specific environment variables
  home.sessionVariables = {
    # Add macOS-specific variables
  };
  home.sessionPath = [
    # Add macOS-specific PATH entries
    "$HOME/.local/bin"
  ];

  # User information
  home = {
    username = "bannach";
    homeDirectory = "/Users/bannach";
  };
}

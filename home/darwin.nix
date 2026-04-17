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
    # SSH is managed by 1Password's ssh-agent, so this is disabled.
    ssh = {
      enable = false;
      matchBlocks."*" = {
        addKeysToAgent = "yes";
        extraOptions = {
          UseKeychain = "yes";
        };
      };
    };
    git = {
      settings = {
        user.email = "244587300+abannach-onebrief@users.noreply.github.com";
      };
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
      CARGO_HTTP_CAINFO = "$HOME/.certs/zscaler_cert.pem";
      CLAUDE_CODE_TMPDIR = "/tmp/claude";
      SANDBOX_INSTALL_SKIP_RC = 1;
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

  home.file.".wgetrc".text = ''
    ca_certificate=/Users/bannach/.certs/zscaler_cert.pem
  '';

  # User information
  home = {
    username = "bannach";
    homeDirectory = "/Users/bannach";
  };
}

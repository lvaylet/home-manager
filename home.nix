{
  config,
  pkgs,
  ...
}: {
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "lvaylet";
  home.homeDirectory = "/home/lvaylet";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.11"; # Please read the comment before changing.

  # Allow unfree packages, e.g. Visual Studio Code.
  # Source: https://nixos.wiki/wiki/Unfree_Software
  nixpkgs.config.allowUnfree = true;

  # Allow fontconfig to discover fonts and configurations installed through `home.packages` and `nix-env`.
  # Source: https://mynixos.com/home-manager/option/fonts.fontconfig.enable
  fonts.fontconfig.enable = true;

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')

    # Fonts
    pkgs.nerd-fonts.fira-code
    pkgs.nerd-fonts.jetbrains-mono

    # Utils
    pkgs.btop
    pkgs.curl
    pkgs.meld
    pkgs.ncdu
    pkgs.wget
    pkgs.wl-clipboard

    # Cloud
    pkgs.google-cloud-sdk # bin/gcloud
    pkgs.google-cloud-sql-proxy # bin/cloud-sql-proxy
    pkgs.google-cloud-bigtable-tool # bin/cbt

    # Development
    # ---
    # Golang
    pkgs.go
    # Nix
    pkgs.nixd
    pkgs.alejandra
    # Node.js
    pkgs.nodejs_22
    # Python
    pkgs.python313Full
    # Rust
    pkgs.rustup

    # NeoVim
    pkgs.luarocks
  ];

  programs = {
    bat.enable = true;
    eza = {
      enable = true;
      enableZshIntegration = true;
    };
    fd.enable = true;
    fzf = {
      enable = true;
      enableZshIntegration = true;
    };
    git = {
      enable = true;
      userName = "Laurent Vaylet";
      userEmail = "laurent.vaylet@gmail.com";
      # https://jvns.ca/blog/2024/02/16/popular-git-config-options/
      extraConfig = {
        color.ui = "auto";
        commit.verbose = true;
        diff = {
          algorithm = "histogram";
          colorMoved = "default";
          mnemonicPrefix = true;
          renames = true;
        };
        fetch.prune = true;
        help.autocorrect = 10;
        init.defaultBranch = "main";
        merge = {
          conflictstyle = "zdiff3";
          tool = "meld";
        };
        pull = {
          ff = "only";
          rebase = true;
        };
        push.autoSetupRemote = true;
        rebase = {
          autosquash = true;
          autostash = true;
        };
        rerere.enable = true;
        url."git@github.com:".insteadOf = "https://github.com/";
      };
    };
    jq.enable = true;
    lazygit.enable = true;
    neovim = {
      enable = true;
      defaultEditor = true;
      viAlias = true;
      vimAlias = true;
    };
    nnn.enable = true;
    pyenv = {
      enable = true;
      enableZshIntegration = true;
    };
    ripgrep.enable = true;
    starship = {
      enable = true;
      enableZshIntegration = true;
    };
    vscode.enable = true;
    zsh = {
      enable = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;
      enableCompletion = true;
      shellAliases = {
        l = "ls";
        ll = "ls -l";
        la = "ls -la";

        c = "clear";
        x = "exit";
        r = "source ~/.zshrc";

        h = "history -10"; # last 10 history commands
        hc = "history -c"; # clear history
        hg = "history | grep "; # + command

        ag = "alias | grep "; # + alias

        b = "btop";
        d = "ncdu --exclude /mnt --color dark "; # + path
      };
    };
  };

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';

    ".config/starship.toml".source = dotfiles/starship.toml;
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/lvaylet/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}

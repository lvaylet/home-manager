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
  home.packages = with pkgs; [
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
    nerd-fonts.fira-code
    nerd-fonts.jetbrains-mono

    # Utils
    gum # A tool for glamourous shell scripts - https://github.com/charmbracelet/gum
    jq
    psmisc # A set of small useful utilities that use the proc filesystem (such as fuser, killall and pstree)
    lazygit
    ripgrep # A line-oriented search tool that recursively searches the current directory for a regex pattern - https://github.com/BurntSushi/ripgrep
    tree # A recursive directory listing command - https://oldmanprogrammer.net/source.php?dir=projects/tree
    yq-go

    # Networking
    socat # SOcket CAT, a flexible, multi-purpose relay tool
    wget
    curl

    # Archives
    p7zip
    unzip
    unrar
    xz
    zip

    # Cloud
    google-cloud-sdk # bin/gcloud
    google-cloud-sql-proxy # bin/cloud-sql-proxy
    google-cloud-bigtable-tool # bin/cbt

    # Development
    # TODO Use shell environment or development environments?
    # ---
    # Common
    dap
    git
    gnumake
    just # A command runner similar to Makefile, but simpler - https://github.com/casey/just
    pre-commit # A framework for managing and maintaining multi-language pre-commit hooks - https://pre-commit.com/
    tree-sitter
    # C/C++
    clang
    # Golang
    go
    # Lua
    lua
    luarocks
    # Markdown
    markdownlint-cli2
    # Nix
    alejandra # The Uncompromising Nix Code Formatter - https://github.com/kamadorueda/alejandra
    nixd # Nix Language Server, for Nix IDE extension in Visual Studio Code for example
    # Node.js
    nodejs_22
    # Python
    python3
    # SQL
    sqlfluff
    # Rust
    cargo
    rustc
    rust-analyzer
    rustfmt
    # Terraform
    terraform
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
    yazi = {
      enable = true;
      enableZshIntegration = true;
    };
    zsh = {
      enable = true;
      autocd = true; # Automatically enter into a directory if typed directly into shell.
      defaultKeymap = "viins"; # The default base keymap to use. One of `emacs` (= `-e`), `vicmd` (= `-a`) or `viins` (= `-v`).
      zplug = {
        enable = true;
        plugins = [
          {name = "zsh-users/zsh-autosuggestions";}
          {name = "zsh-users/zsh-completions";}
          {name = "zsh-users/zsh-syntax-highlighting";}
          {
            name = "plugins/git";
            tags = ["from:oh-my-zsh"];
          }
          {name = "MichaelAquilina/zsh-you-should-use";}
          {
            name = "hlissner/zsh-autopair";
            tags = ["defer:2"];
          }
        ];
      };
      shellAliases = {
        c = "clear";
        x = "exit";
        r = "source ~/.zshrc";

        # `ls` / `eza`
        # See: https://www.avonture.be/blog/linux-eza/
        ls = "eza --group --group-directories-first --icons --header --time-style long-iso";
        ll = "eza --group --group-directories-first --icons --header --time-style long-iso --long";
        la = "eza --group --group-directories-first --icons --header --time-style long-iso --long --all";

        cat = "bat"; # A cat(1) clone with wings
        y = "yazi"; # 💥 Blazing fast terminal file manager written in Rust, based on async I/O

        # History
        h = "history -10"; # last 10 history commands
        hc = "history -c"; # clear history
        hh = "history | cut -c 8-";
        hg = "history | grep "; # + command to search for

        # Aliases
        ag = "alias | grep "; # + alias to search for

        # Utils
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

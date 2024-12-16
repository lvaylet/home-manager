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

    # Crisis Tools
    # See: https://www.brendangregg.com/blog/2024-03-24/linux-crisis-tools.html
    procps
    util-linux
    sysstat
    iproute2
    numactl
    tcpdump
    # perf(1) and turbostat(8) from linux-tools-common and linux-tools-$(uname -r)
    # NOTE: Does not work with Home Manager. See: https://nixos.wiki/wiki/Linux_kernel#Custom_kernel_modules
    # config.boot.kernelPackages.perf
    # config.boot.kernelPackages.turbostat
    bcc
    bpftrace
    trace-cmd
    nicstat
    ethtool
    tiptop
    msr-tools # Includes cpuid(1).

    # Utils
    gum # A tool for glamourous shell scripts - https://github.com/charmbracelet/gum
    psmisc # A set of small useful utilities that use the proc filesystem (such as fuser, killall and pstree)
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
    nixd # Nix Language Server, based on Nix libraries - https://github.com/nix-community/nixd
    # Node.js
    nodejs_22
    # Python
    python3
    # SQL
    sqlfluff
    # Rust
    cargo
    clippy
    rust-analyzer
    rustc
    rustfmt
    # Terraform
    terraform
  ];

  programs = {
    bat.enable = true; # A cat(1) clone with wings - https://github.com/sharkdp/bat
    eza = { # A modern alternative to ls - https://github.com/eza-community/eza
      enable = true;
      enableZshIntegration = true;
    };
    fd.enable = true; # A simple, fast and user-friendly alternative to 'find' - https://github.com/sharkdp/fd
    fzf = {
      enable = true;
      enableZshIntegration = true;
    };
    git = { # A free and open source distributed version control system designed to handle everything from small to very large projects with speed and efficiency - https://git-scm.com/
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
        # url."git@github.com:".insteadOf = "https://github.com/"; # Be careful with this. Some repositories do not support cloning over SSH, for example https://github.com/oxalica/nil.
      };
    };
    jq.enable = true; # A lightweight and flexible command-line JSON processor - https://jqlang.github.io/jq/
    lazygit.enable = true; # A simple terminal UI for git commands - https://github.com/jesseduffield/lazygit
    neovim = { # An hyperextensible Vim-based text editor - https://neovim.io/
      enable = true;
      defaultEditor = true;
      viAlias = true;
      vimAlias = true;
    };
    nnn.enable = true; # n³ The unorthodox terminal file manager - https://github.com/jarun/nnn
    pyenv = { # Simple Python version management - https://github.com/pyenv/pyenv
      enable = true;
      enableZshIntegration = true;
    };
    ripgrep.enable = true; # Recursively search directories for a regex pattern while respecting your gitignore - https://github.com/BurntSushi/ripgrep
    starship = { # The minimal, blazing-fast, and infinitely customizable prompt for any shell! - https://starship.rs/guide/
      enable = true;
      enableZshIntegration = true;
    };
    vscode.enable = true; # Code Editing. Redefined - https://code.visualstudio.com/
    yazi = { # 💥 Blazing fast terminal file manager written in Rust, based on async I/O - https://github.com/sxyazi/yazi
      enable = true;
      enableZshIntegration = true;
    };
    zsh = { # An interactive login shell and a command interpreter for shell scripting - https://www.zsh.org/
      enable = true;
      autocd = true; # Automatically enter into a directory if typed directly into shell.
      defaultKeymap = "viins"; # The default base keymap to use. One of `emacs` (= `-e`), `vicmd` (= `-a`) or `viins` (= `-v`).
      zplug = { # 🌺 A next-generation plugin manager for zsh - https://github.com/zplug/zplug
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
        llt = "eza --group --group-directories-first --icons --header --time-style long-iso --long --tree";
        la = "eza --group --group-directories-first --icons --header --time-style long-iso --long --all";
        lat = "eza --group --group-directories-first --icons --header --time-style long-iso --long --all --tree";

        cat = "bat"; # A cat(1) clone with wings
        y = "yazi"; # 💥 Blazing fast terminal file manager written in Rust, based on async I/O

        take = "() { mkdir -p \"$1\"; cd \"$1\"; }"; # Create a directory tree and `cd` into it.

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

        # Home Manager
        hms = "cd ~/.config/home-manager; git pull; home-manager switch; cd -";
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

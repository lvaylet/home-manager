# home-manager

My declarative and reproducible [Home Manager](https://github.com/nix-community/home-manager) configuration.

## Usage

1. Make sure you have a working Nix installation. For example, check out https://nixos.org/download/ and run:

    ```sh
    sh <(curl -L https://nixos.org/nix/install) --daemon
    ```

1. Add the appropriate Home Manager channel.

    If you are following Nixpkgs `master` or an `unstable` channel you can run:

    ```sh
    nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
    ```
  
    If you follow a Nixpkgs version `24.11` channel you can run:
  
    ```sh
    nix-channel --add https://github.com/nix-community/home-manager/archive/release-24.11.tar.gz home-manager
    ```
  
1. Update all channels:

    ```sh
    nix-channel --update
    ```

1. Run the Home Manager installation command and create the first Home Manager generation:

    ```sh
    nix-shell '<home-manager>' -A install
    ```

1. Remove the sample configuration and replace it with this one:

    ```sh
    cd ~/.config
    rm -rf home-manager
    git clone git@github.com:lvaylet/home-manager.git home-manager
    ```

1. Edit the configuration

    ```sh
    vim ~/.config/home-manager/home.nix
    ```

1. Enable extra Nix features

    ```sh
    echo "extra-experimental-features = nix-command flakes" >> ~/.config/nix/nix.conf
    ```

1. Rebuild your config and/or make it the current one.

    ```sh
    home-manager build # build configuration only, to `result` directory
    home-manager switch # build and activate configuration
    home-manager switch -b backup # build and activate configuration, backing up non-managed, conflicting files with a `backup` extension
    ```

1. Change the default shell of the current user to `zsh`

    ```sh
    sudo chsh -s $(which zsh) $(whoami)
    ```

**NOTE** Depending on the OS, you might have to add the result of $(which zsh) to `etc/shells` too.

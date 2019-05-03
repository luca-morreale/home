## SETUP
* Clone the repository in a temporary directory:

  (HTTPS) `git clone --recursive https://github.com/luca-morreale/home.git ~/home`
  
  (GIT) `git clone --recursive git@github.com:luca-morreale/home.git ~/home`

* Access the temporary directory: `cd ~/home`

* Move every file to the your home:

  (LINUX) `find . -mindepth 1 -maxdepth 1 -exec mv -t.. -- {} +`
  (Mac) `find . -mindepth 1 -maxdepth 1  -execdir mv '{}' .. \;`
  
* Remove the temporary directory: `cd ; rm -r ~/home`

(Optional)
* Install tmux plugins: open tmux and use `<prefix> + I` to install the plugins.

* Update the git profile information with yours in `.gitconfig`
---

## Optional steps
Install fuzzy completion:
https://github.com/junegunn/fzf#installation

## Optional steps for MAC
#### Install homebrew in ~/.homebrew
```
cd ~
mkdir .homebrew && curl -L https://github.com/Homebrew/brew/tarball/master | tar xz --strip 1 -C .homebrew
```

#### Reclaim home to allow to mount FS other than NFS
```
sudo defaults write /Library/Preferences/com.google.corp.machineinfo EnableAutofs -bool FALSE
sudo gmac-updater
```

#### Install useful software via brew
```
brew install coreutils
brew install mosh
```

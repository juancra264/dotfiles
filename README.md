# Dotfiles MacOS***

### Brew Instalation

```sh
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

### Backup homebrew

``` sh
brew bundle dump
```

### Restore homebrew

``` sh
cd brew
brew bundle
```

### Oh-my-zsh - Powerlevel10K and omy plugins

```sh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone https://github.com/romkatv/powerlevel10k.git $ZSH_CUSTOM/themes/powerlevel10k
```

Then, again open the ~/.zshrc file with VS Code or any editor and change the ZHS_THEME value to “powerlevel10k/powerlevel10k“.

Then save the file, quit the Terminal, and re-open it. You will see the Powerlevel10k configuration wizard.

Syntax highlighting instalation:

```sh
brew install zsh-syntax-highlighting
```

After syntax highlighting installation, run the below command.

```sh
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
```

zsh-autosuggestions instalation:

Clone this repository into `$ZSH_CUSTOM/plugins` (by default `~/.oh-my-zsh/custom/plugins`)

```sh
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
```

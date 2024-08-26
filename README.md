# Nvim Config

![Screenshot](images/editor-tokyonight.png)

This is the personal Neovim configuration of [Marc Anton Dahmen](https://marcdahmen.de). It provides a solid setup for TypeScript, PHP and Automad development based on terminal focused workflows.

> Feel free to fork this config or use parts of it for inspiration. However, issues and pull-request will be ignored!

---

<!-- vim-markdown-toc GFM -->

- [Installation](#installation)
  - [Dependencies](#dependencies)
- [Theme](#theme)
  - [Terminal](#terminal)
- [Plugins](#plugins)
  - [Adding Plugins](#adding-plugins)
  - [Lock File](#lock-file)
  - [Compiling Plugins](#compiling-plugins)
- [Tmux](#tmux)
- [Fonts](#fonts)
- [Highlights](#highlights)

<!-- vim-markdown-toc -->

## Installation

Just clone the repository into the `~/.config` directory as follows:

```bash
git clone git@github.com:marcantondahmen/nvim-config.git ~/.config/nvim
```

Or using `https`:

```bash
git clone https://github.com/marcantondahmen/nvim-config.git ~/.config/nvim
```

### Dependencies

The following dependecies have to be installed in order to make all plugins
work correctly:

- ripgrep
- sed
- wget
- [fd](https://github.com/sharkdp/fd)
- [fzf](https://github.com/junegunn/fzf)
- [sad](https://github.com/ms-jpq/sad)
- [bat](https://github.com/sharkdp/bat)
- Python3 provider (see below)
- node neovim package (see below)
- unzip (probably only WSL)
- [Gitui](https://github.com/extrawurst/gitui)
- [Lazydocker](https://github.com/jesseduffield/lazydocker)
- [Tig](https://jonas.github.io/tig/)
- PHP (for Composer)
- Composer (for Psalm)

In order to install the basic dependecies, assuming that PHP and Composer are installed anyways, run the following commands on macOS for example:

```bash
brew install ripgrep
brew install fd
brew install fzf
$(brew --prefix)/opt/fzf/install
brew install gnu-sed
brew install sad
brew install bat
brew install wget
brew install gitui
brew install tig
brew install lazydocker
python3 -m pip install --user --upgrade pynvim
npm install -g neovim
```

## Theme

This config uses the [Tokyo Night (Storm)](https://github.com/folke/tokyonight.nvim) theme.

### Terminal

WezTerm includes already a matching theme. For iTerm and the Windows terminal, matching color schemes can be found here:

- [Tokyo Night (Storm) for iTerm](https://github.com/folke/tokyonight.nvim/blob/main/extras/iterm/tokyonight_storm.itermcolors)
- [Tokyo Night (Storm) for Windows Terminal](https://github.com/folke/tokyonight.nvim/blob/main/extras/windows_terminal/tokyonight_storm.json)

## Plugins

All plugins in this config are managed by [packer.nvim](https://github.com/wbthomason/packer.nvim). Plugins that don't require configuration are defined in [plugins/init.lua](https://github.com/marcantondahmen/nvim-config/blob/master/lua/marcantondahmen/plugins/init.lua). Plugins that require configuration or a function to run after being loaded are defined in separate files inside the [plugins](https://github.com/marcantondahmen/nvim-config/tree/master/lua/marcantondahmen/plugins) directory. The following plugins are included:

- [Comment.nvim](https://github.com/numToStr/Comment.nvim) comment plugin
- [alpha-nvim](https://github.com/goolord/alpha-nvim) dashboard
- [auto-session](https://github.com/rmagatti/auto-session) session manager
- [barbar.nvim](https://github.com/romgrk/barbar.nvim) bufferline
- [barbecue.nvim](https://github.com/utilyre/barbecue.nvim) symbols breadcrumbs
- [conform.nvim](https://github.com/stevearc/conform.nvim) formatting
- [diffview.nvim](https://github.com/sindrets/diffview.nvim) git diff view
- [gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim) git status gutter
- [headlines.nvim](https://github.com/lukas-reineke/headlines.nvim) markdown headings and codeblock highlighting
- [indent-blankline.nvim](https://github.com/lukas-reineke/indent-blankline.nvim) indent guides
- [lsp_signature.nvim](https://github.com/ray-x/lsp_signature.nvim) signature help
- [lspsaga.nvim](https://github.com/glepnir/lspsaga.nvim) language server functions
- [lualine.nvim](https://github.com/nvim-lualine/lualine.nvim) status line
- [markdown-preview.nvim](https://github.com/iamcco/markdown-preview.nvim) markdown preview in browser
- [neogen](https://github.com/danymat/neogen) docblocks
- [nvim-autopairs](https://github.com/windwp/nvim-autopairs) auto pairing
- [nvim-cmp](https://github.com/hrsh7th/nvim-cmp) autocompletion
- [nvim-highlight-colors](https://github.com/brenoprata10/nvim-highlight-colors) highlight colors
- [nvim-lsp-file-operations](https://github.com/antosha417/nvim-lsp-file-operations) lsp file operations for nvim-tree
- [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig) language server config
- [nvim-navbuddy](https://github.com/SmiteshP/nvim-navbuddy) symbols navigation
- [nvim-notify](https://github.com/rcarriga/nvim-notify) notifications
- [nvim-spectre](https://github.com/nvim-pack/nvim-spectre) project wide search and replace
- [nvim-tmux-navigation](https://github.com/alexghergh/nvim-tmux-navigation) navigate between NeoVim and Tmux panes
- [nvim-tree.lua](https://github.com/nvim-tree/nvim-tree.lua) file explorer
- [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter) syntax highlighting
- [nvim-web-devicons](https://github.com/nvim-tree/nvim-web-devicons) icons
- [packer.nvim](https://github.com/wbthomason/packer.nvim) package manager
- [tagalong.nvim](https://github.com/AndrewRadev/tagalong.vim) update tags
- [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim) fuzzy-serch menus
- [toggleterm.nvim](https://github.com/akinsho/toggleterm.nvim) terminal
- [trouble.nvim](https://github.com/folke/trouble.nvim) diagnostics overview
- [typescript-tools.nvim](https://github.com/pmizio/typescript-tools.nvim) TypeScript support
- [vim-ReplaceWithRegister](https://github.com/inkarkat/vim-ReplaceWithRegister) better replace functionality
- [vim-markdown-toc](https://github.com/mzlogin/vim-markdown-toc) markdown toc
- [vim-maximizer](https://github.com/szw/vim-maximizer) maximize panes
- [vim-pencil](https://github.com/preservim/vim-pencil) improve writing experience in Markdown
- [vim-surround](https://github.com/tpope/vim-surround) surround plugin
- [which-key.nvim](https://github.com/folke/which-key.nvim) keymaps help

There are also some custom settings and extensions:

- [Basic options](https://github.com/marcantondahmen/nvim-config/blob/master/lua/marcantondahmen/core/options.lua)
- [Keymaps](https://github.com/marcantondahmen/nvim-config/blob/master/lua/marcantondahmen/core/keymaps.lua)
- [Script Runner](lua/telescope/_extensions/scripts.lua)
- [PHPUnit](https://github.com/marcantondahmen/nvim-config/blob/master/lua/marcantondahmen/plugins/toggleterm.lua#L50)
- [Psalm](https://github.com/marcantondahmen/nvim-config/blob/master/lua/marcantondahmen/plugins/toggleterm.lua#L61)
- [Gitui](https://github.com/marcantondahmen/nvim-config/blob/master/lua/marcantondahmen/plugins/toggleterm.lua#L72)
- [Lazydocker](https://github.com/marcantondahmen/nvim-config/blob/master/lua/marcantondahmen/plugins/toggleterm.lua#L83)
- [Tig](https://github.com/marcantondahmen/nvim-config/blob/master/lua/marcantondahmen/plugins/toggleterm.lua#L94)
- [sad](https://github.com/marcantondahmen/nvim-config/blob/master/lua/marcantondahmen/plugins/toggleterm.lua#L105)

### Adding Plugins

In order to add a new plugin, simply add a `lua` module that returns a [packer.nvim](https://github.com/wbthomason/packer.nvim?tab=readme-ov-file#specifying-plugins) plugin spec. Make sure to also update the [lock file](#lock-file) as described below.

### Lock File

This config uses a lock file to prevent breaking changes on re-installs or config updates. In order to update a plugin, simply update its commit hash inside the `plugins-lock.json`. When adding a new plugin, run the following Neovim command to update the lock file:

```bash
PackerSnapshot plugins-lock.json
```

### Compiling Plugins

Whenever a plugin config is written, all plugins are compiled automatically running `PackerCompile` in a separate headless Neovim instance in order to make sure that all modules a refreshed before compilation. However, in case something looks wrong when editing a plugin config, which can be the case when editing the `event` option of a plugin, a simple restart followed by running `PackerSync` manually should fix most issues.

## Tmux

In order to be able to navigate between Tmux and NeoVim panes, the following configuration has to be added to `~/.config/tmux/tmux.conf`:

```bash
is_vim="ps -o state= -o comm= -t '#{pane_tty}' \
    | grep -iqE '^[^TXZ ]+ +(\\S+\\/)?g?(view|n?vim?x?)(diff)?$'"

bind-key -n 'M-Up' if-shell "$is_vim" 'send-keys M-Up' 'select-pane -U'
bind-key -n 'M-Left' if-shell "$is_vim" 'send-keys M-Left' 'select-pane -L'
bind-key -n 'M-Down' if-shell "$is_vim" 'send-keys M-Down' 'select-pane -D'
bind-key -n 'M-Right' if-shell "$is_vim" 'send-keys M-Right' 'select-pane -R'

bind-key -T copy-mode-vi 'M-Up' select-pane -U
bind-key -T copy-mode-vi 'M-Left' select-pane -L
bind-key -T copy-mode-vi 'M-Down' select-pane -D
bind-key -T copy-mode-vi 'M-Right' select-pane -R
```

## Fonts

Good looking fonts that also works well with symbols are **JetBrainsMono Nerd Font** and **Hack Nerd Font** that can be downloaded [here](https://www.nerdfonts.com/font-downloads). Note, that on **macOS**, nerd fonts can be installed using `brew`.

## Highlights

Run the following command in order to see all used highlight groups:

```bash
so $VIMRUNTIME/syntax/hitest.vim
```

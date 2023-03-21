-- set leader key to space
vim.g.mapleader = ' '

local keymap = vim.keymap

-- window management
keymap.set('n', '<leader>sv', '<C-w>v') -- split window vertically
keymap.set('n', '<leader>sh', '<C-w>s') -- split window horizontally
keymap.set('n', '<leader>se', '<C-w>=') -- make split windows equal width & height
keymap.set('n', '<leader>sx', ':close<CR>') -- close current split window

keymap.set('n', '<c-k>', ':wincmd k<CR>', { silent = true, noremap = true })
keymap.set('n', '<c-j>', ':wincmd j<CR>', { silent = true, noremap = true })
keymap.set('n', '<c-h>', ':wincmd h<CR>', { silent = true, noremap = true })
keymap.set('n', '<c-l>', ':wincmd l<CR>', { silent = true, noremap = true })

-- plugin keybinds

-- barbar
keymap.set('n', '<A-,>', '<Cmd>BufferLineCyclePrev<CR>', { silent = true, noremap = true })
keymap.set('n', '<A-.>', '<Cmd>BufferLineCycleNext<CR>', { silent = true, noremap = true })

-- vim-maximizer
keymap.set('n', '<leader>sm', ':MaximizerToggle<CR>') -- toggle split window maximization

-- nvim-tree
keymap.set('n', '<leader>e', ':NvimTreeToggle<CR>') -- toggle file explorer

-- trouble
keymap.set('n', '<leader>xx', '<cmd>TroubleToggle<cr>', { silent = true, noremap = true })
keymap.set('n', '<leader>xw', '<cmd>TroubleToggle workspace_diagnostics<cr>', { silent = true, noremap = true })
keymap.set('n', '<leader>xd', '<cmd>TroubleToggle document_diagnostics<cr>', { silent = true, noremap = true })
keymap.set('n', '<leader>xl', '<cmd>TroubleToggle loclist<cr>', { silent = true, noremap = true })
keymap.set('n', '<leader>xq', '<cmd>TroubleToggle quickfix<cr>', { silent = true, noremap = true })
keymap.set('n', 'gR', '<cmd>TroubleToggle lsp_references<cr>', { silent = true, noremap = true })

-- gitui
keymap.set('n', '<leader>gu', '<cmd>Gitui<cr>')

-- telescope
keymap.set('n', '<leader>ff', '<cmd>Telescope find_files<cr>') -- find files within current working directory, respects .gitignore
keymap.set('n', '<leader>fs', '<cmd>Telescope live_grep<cr>') -- find string in current working directory as you type
keymap.set('n', '<leader>fc', '<cmd>Telescope grep_string<cr>') -- find string under cursor in current working directory
keymap.set('n', '<leader>fb', '<cmd>Telescope buffers<cr>') -- list open buffers in current neovim instance
keymap.set('n', '<leader>fh', '<cmd>Telescope help_tags<cr>') -- list available help tags
vim.keymap.set("i", "jk", "<Esc>")

-- Configures telescope keymaps
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })


vim.keymap.set('n', '<leader>e', ":NvimTreeToggle<CR>")


vim.keymap.set("n", "<leader>nh", ":nohl<CR>")
vim.keymap.set("n", "<leader>sv", "<C-w>v") -- Splits window vertically
vim.keymap.set("n", "<leader>sh", "<C-w>s") -- Splits window horizontally
vim.keymap.set("n", "<leader>se", "<C-w>=") -- Make split windows equal width
vim.keymap.set("n", "<leader>sx", ":close<CR>") -- CLose current split window

vim.keymap.set("n", "<leader>d", "i<div></div><ESC>F<ha")
vim.keymap.set("n", "<leader>h", "i#")

-- Switch between windows (panes) using <C-e> and <C-t> (reverse)
vim.keymap.set("n", "<C-l>", "<C-w>w", { noremap = true, silent = true })  -- Forward window switch
vim.keymap.set("n", "<C-h>", "<C-w>W", { noremap = true, silent = true })  -- Reverse window switch

vim.keymap.set("n", "<C-j>", "<C-w>j", { noremap = true, silent = true })  -- Down window switch
vim.keymap.set("n", "<C-k>", "<C-w>k", { noremap = true, silent = true })  -- Up window switch

-- Split window vertically and horizontally
vim.keymap.set("n", "<leader>sv", "<C-w>v<C-w>w", { noremap = true, silent = true }) -- Vertical split
vim.keymap.set("n", "<leader>sh", "<C-w>s<C-w>j", { noremap = true, silent = true }) -- Horizontal split

vim.cmd("set expandtab")
vim.cmd("set tabstop=4")
vim.cmd("set softtabstop=4")
vim.cmd("set shiftwidth=4")
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.clipboard:append { 'unnamedplus' }

-- Tells neovim to not paint a background (allows for transparency)
vim.cmd [[
  hi Normal guibg=NONE ctermbg=NONE
  hi NormalNC guibg=NONE ctermbg=NONE
  hi EndOfBuffer guibg=NONE ctermbg=NONE
  hi SignColumn guibg=NONE ctermbg=NONE
]]

-- Has neovim use the system clipboard
vim.api.nvim_set_option("clipboard","unnamed")

-- Puts the cursor in the middle when doing Control-d, Control-u or using n/N to move when searching
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- Setup general keymaps
vim.g.mapleader = " "
vim.keymap.set('i', 'jk', '<Esc>') -- Makes "jk" escape to normal mode
vim.keymap.set('n', '<leader>nh', ':nohl<CR>') -- Removes highlighting after searching for text

-- Keymaps for splitting panes
vim.keymap.set('n', '<leader>sv', ':vsplit<CR><C-w>l<CR>')
vim.keymap.set('n', '<leader>sh', ':split<CR><C-w>j<CR>')
vim.keymap.set("n", "<leader>sx", "<C-w>c", { silent = true, desc = "Close current pane" })

-- Keymaps for window navigation
vim.keymap.set("n", "<C-h>", "<C-w>h", { silent = true })
vim.keymap.set("n", "<C-j>", "<C-w>j", { silent = true })
vim.keymap.set("n", "<C-k>", "<C-w>k", { silent = true })
vim.keymap.set("n", "<C-l>", "<C-w>l", { silent = true })

-- Installs Lazy.nvim (a package manager)
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- A list of the plugins
local plugins = {
    { "catppuccin/nvim", name = "catppuccin", priority = 1000 },
    {
        'nvim-telescope/telescope.nvim', tag = '0.1.8',
        dependencies = { 'nvim-lua/plenary.nvim' }
    },

    -- Makes fuzzy finding better
    {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make',
        config = function()
            require('telescope').load_extension('fzf')
        end
    },
    {"nvim-treesitter/nvim-treesitter", build = ":TSUpdate"},
    {
        'windwp/nvim-autopairs',
        event = "InsertEnter",
        config = true
    },

    {
        "neovim/nvim-lspconfig",
        event = { "BufReadPre", "BufNewFile" },
    },

    {
        "williamboman/mason.nvim",
        build = ":MasonUpdate",
    },
    {
        "williamboman/mason-lspconfig.nvim",
        dependencies = { "williamboman/mason.nvim", "neovim/nvim-lspconfig" },
    },

    {
        "hrsh7th/nvim-cmp",
        event = "InsertEnter",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",   -- LSP source for nvim-cmp
            "hrsh7th/cmp-buffer",     -- buffer words
            "hrsh7th/cmp-path",       -- file paths
            "L3MON4D3/LuaSnip",       -- snippet engine
            "saadparwaiz1/cmp_luasnip"  -- luasnip source
        },
    },

    {
        "nvim-tree/nvim-tree.lua",
        version = "*",
        lazy = false,
        dependencies = {
            "nvim-tree/nvim-web-devicons",
        },
    },
    {
        "ThePrimeagen/harpoon",
    },
    { "mfussenegger/nvim-jdtls"}

}
local opts = {}

-- Setup lazy and the plugins
require("lazy").setup(plugins, opts)

-- Setup nvim-tree
require("nvim-tree").setup()
vim.keymap.set('n', '<leader>e', ':NvimTreeToggle<CR>')

-- Setup harpoon
require("harpoon").setup()
vim.keymap.set("n", "<leader>ha", require("harpoon.mark").add_file, { desc = "Add file to Harpoon" }) -- Marks a file
vim.keymap.set("n", "<leader>hs", require("harpoon.ui").toggle_quick_menu, { desc = "Toggle Harpoon menu" }) -- Lists the marked files
vim.keymap.set("n", "<leader>hr", function() require("harpoon.mark").rm_file() end, { desc = "Unmark file from Harpoon" })

vim.keymap.set("n", "<leader>h1", function() require("harpoon.ui").nav_file(1) end, { desc = "Go to Harpoon file 1" })
vim.keymap.set("n", "<leader>h2", function() require("harpoon.ui").nav_file(2) end, { desc = "Go to Harpoon file 2" })
vim.keymap.set("n", "<leader>h3", function() require("harpoon.ui").nav_file(3) end, { desc = "Go to Harpoon file 3" })
vim.keymap.set("n", "<leader>h4", function() require("harpoon.ui").nav_file(4) end, { desc = "Go to Harpoon file 4" })
vim.keymap.set("n", "<leader>h5", function() require("harpoon.ui").nav_file(5) end, { desc = "Go to Harpoon file 5" })
vim.keymap.set("n", "<leader>h6", function() require("harpoon.ui").nav_file(6) end, { desc = "Go to Harpoon file 6" })
vim.keymap.set("n", "<leader>h7", function() require("harpoon.ui").nav_file(7) end, { desc = "Go to Harpoon file 7" })
vim.keymap.set("n", "<leader>h8", function() require("harpoon.ui").nav_file(8) end, { desc = "Go to Harpoon file 8" })
vim.keymap.set("n", "<leader>h9", function() require("harpoon.ui").nav_file(9) end, { desc = "Go to Harpoon file 9" })

-- Setup the colorscheme
require("catppuccin").setup({
    transparent_background = true
})
vim.cmd.colorscheme "catppuccin"

require('telescope').setup({
  defaults = {
    file_ignore_patterns = { "node_modules", ".git" },
  },
})
--
-- Setup telescope
local builtin = require("telescope.builtin")
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Find files' })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Live grep' })

-- Setup treesitter
local config = require("nvim-treesitter.configs")
config.setup({
    ensure_installed = {"lua", "javascript", "python", "java", "typescript", "tsx"}, -- Added tsx
    highlight = { enable = true },
    indent = { enable = true }
})

-- ========= LSP Setup Section =========

-- Mason Setup (LSP installer)
require("mason").setup()
require("mason-lspconfig").setup({
    ensure_installed = { "lua_ls", "pyright", "ts_ls", "gopls", "tailwindcss", "html", "emmet_ls" }, 
    automatic_installation = true,
})

-- LSP Configurations
local lspconfig = require("lspconfig")
lspconfig.lua_ls.setup({})
lspconfig.pyright.setup({})
lspconfig.ts_ls.setup({}) 
lspconfig.gopls.setup({})
lspconfig.tailwindcss.setup({})
lspconfig.html.setup({}) 
lspconfig.emmet_ls.setup({ 
    filetypes = { "html", "typescriptreact", "javascriptreact", "css", "sass", "scss", "less" },
})


-- nvim-cmp (Completion) Setup
local cmp = require("cmp")
local luasnip = require("luasnip")
cmp.setup({
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },
    mapping = cmp.mapping.preset.insert({
        ["<Tab>"] = cmp.mapping.select_next_item(),
        ["<S-Tab>"] = cmp.mapping.select_prev_item(),
        ["<CR>"] = cmp.mapping.confirm({ select = true }),
    }),
    sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "luasnip" },
        { name = "buffer" },
        { name = "path" },
    }),
})

-- Java LSP Setup
local jdtls = require('jdtls')

-- Only start jdtls when editing Java files
vim.api.nvim_create_autocmd("FileType", {
  pattern = "java",
  callback = function()
    local home = os.getenv("HOME")
    local root_markers = {".git", "mvnw", "gradlew", "pom.xml", "build.gradle"}
    local root_dir = require('jdtls.setup').find_root(root_markers)

    if root_dir == nil then
      return
    end

    local project_name = vim.fn.fnamemodify(root_dir, ":p:h:t")
    local workspace_dir = home .. "/.local/share/eclipse/" .. project_name

    local config = {
      cmd = {
        "jdtls",
        "-data", workspace_dir
      },
      root_dir = root_dir,
      settings = {
        java = {}
      },
      init_options = {
        bundles = {}
      }
    }

    jdtls.start_or_attach(config)
  end
})

-- LSP Keymaps
vim.keymap.set('n', '<leader>gd', vim.lsp.buf.definition, { desc = 'Go to definition' }) -- Goes to where a function or variable is defined
vim.keymap.set('n', 'K', vim.lsp.buf.hover, { desc = 'Hover documentation' }) -- Gives the documentation for a function
vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, { desc = 'Rename symbol' }) -- Renames a function or variable throughout the project
vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, { desc = 'Code actions' }) -- Triggers automatic fixes, applying imports, etc

vim.keymap.set('n', '<leader>ge', vim.diagnostic.open_float, { desc = 'Show error message' })
vim.keymap.set('n', '<leader>ne', vim.diagnostic.goto_next, { desc = 'Show next error message' })
vim.keymap.set('n', '<leader>pe', vim.diagnostic.goto_prev, { desc = 'Show previous error message' })


-- Remaps to use the system clipboard
-- Always yank, paste, delete with system clipboard
-- vim.keymap.set('n', 'y', '"+y')
-- vim.keymap.set('v', 'y', '"+y')
-- vim.keymap.set('n', 'yy', '"+yy')
-- vim.keymap.set('n', 'p', '"+p')
-- vim.keymap.set('n', 'P', '"+P')
-- vim.keymap.set('n', 'd', '"+d')
-- vim.keymap.set('v', 'd', '"+d')

-- Installs Lazy package manager
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    { "scottmckendry/cyberdream.nvim", lazy = false, priority = 1000 },
    { "navarasu/onedark.nvim" },

    -- Mason and LSP config
    {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "neovim/nvim-lspconfig",
    },

    -- Treesitter and telescope
    {"nvim-treesitter/nvim-treesitter", build = ":TSUpdate"},
    { 'nvim-telescope/telescope.nvim', tag = '0.1.8', dependencies = { 'nvim-lua/plenary.nvim' } },

    -- Nvim-tree
    { "nvim-tree/nvim-tree.lua", version = "*", lazy = false, dependencies = { "nvim-tree/nvim-web-devicons" }, config = function() require("nvim-tree").setup {} end, },

    -- Completion and Snippets
    { 'hrsh7th/cmp-nvim-lsp' },  -- LSP completion source
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",    -- LSP completion source
            "hrsh7th/cmp-buffer",      -- Buffer completion source
            "hrsh7th/cmp-path",        -- Path completion source
            "saadparwaiz1/cmp_luasnip", -- Snippet completion source
            "L3MON4D3/LuaSnip",        -- Snippet engine
        },
    },

    -- Auto-tagging and Auto-pairs
    { 'windwp/nvim-ts-autotag' },
    {
        "L3MON4D3/LuaSnip",
        version = "v2.*", -- Use the latest version
        build = "make install_jsregexp"
    },
    {
        'windwp/nvim-autopairs',
        event = "InsertEnter",
        config = true
    },

    {
        'nvim-lualine/lualine.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' }
    }
})

-- Mason setup
require("mason").setup()
require("mason-lspconfig").setup({
    ensure_installed = { "html", "cssls" }, -- Automatically install these LSP servers
    automatic_installation = true,
})

-- Automatically configure LSP servers via Mason
require("mason-lspconfig").setup_handlers({
    function(server_name)
        local status, err = pcall(function()
            require("lspconfig")[server_name].setup({})
        end)
        if not status then
            print("Error setting up LSP server: " .. err)
        end
    end,
})

-- Treesitter configuration for HTML
require'nvim-treesitter.configs'.setup {
    ensure_installed = { "html" },  -- Install HTML parser
    highlight = { enable = true },  -- Enable syntax highlighting
}

-- Setup nvim-autotag for automatic tag completion
require('nvim-ts-autotag').setup()

require('lualine').setup()

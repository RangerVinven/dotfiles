local lspconfig = require("lspconfig")
local cmp = require("cmp")
local luasnip = require("luasnip")
local capabilities = require('cmp_nvim_lsp').default_capabilities()  -- Move this up for reuse

-- If you want insert `(` after select function or method item
local cmp_autopairs = require('nvim-autopairs.completion.cmp')
cmp.event:on(
  'confirm_done',
  cmp_autopairs.on_confirm_done()
)

cmp.setup({
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)  -- For LuaSnip users
        end,
    },
    completion = {
        completeopt = "menu,menuone,noinsert",
    },
    mapping = cmp.mapping.preset.insert({
        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.abort(),
        ["<CR>"] = cmp.mapping.confirm({ select = true }),  -- Accept selected item
    }),
    sources = cmp.config.sources({
        { name = "nvim_lsp" },  -- LSP completions
        { name = "luasnip" },   -- Snippets
    }, {
        { name = "buffer" },    -- Buffer completions
        { name = "path" },      -- File path completions
    }),
})

-- Setup LSP servers with the shared capabilities
local html_capabilities = vim.lsp.protocol.make_client_capabilities()
html_capabilities.textDocument.completion.completionItem.snippetSupport = true

lspconfig.html.setup({
    capabilities = html_capabilities,
    settings = {
    html = {
      format = {
        enable = true
      },
      suggest = {
        html5 = true,
        tagClose = true -- This setting enables auto-closing of tags
      }
    }
  }
})

lspconfig.cssls.setup({
    capabilities = capabilities,
})

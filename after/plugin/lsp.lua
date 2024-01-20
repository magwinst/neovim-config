local lsp_zero = require('lsp-zero')

lsp_zero.on_attach(function(client, bufnr)
  local opts = {buffer = bufnr, remap = false}

  vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
  vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
  vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
  vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
  vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
  vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
  vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
  vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
  vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
  vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
end)

local clangd_opts = {
    cmd = { "clangd", "--clang-tidy", "--header-insertion=iwyu", "--suggest-missing-includes" }
}

local pylsp_opts = {
  settings = {
    pylsp = {
      configurationSources = {"pycodestyle"},
      plugins = {
        pycodestyle = {
          ignore = {"W293", "W291", "W391", "E305"},  -- Continue ignoring specific warnings
          hangClosing = false
        },
        pyflakes = {
          enabled = true  -- Enable real-time linting
        },
        jedi_completion = {
          enabled = true,  -- Robust completion suggestions
          fuzzy = true,  -- Enable fuzzy matching for completions
        },
        jedi_definition = {
          enabled = true,  -- Go to definitions
          follow_imports = true,  -- Follow imports to their source
        },
        jedi_signature_help = {
          enabled = true  -- Signature information for functions
        },
        jedi_symbols = {
          enabled = true,  -- Symbol information for navigation
          all_scopes = true  -- Symbols from all scopes not just the current
        },
        mypy = {
          enabled = true,  -- Static type checking with mypy
          live_mode = false  -- Run mypy on file save, not on the fly
        },
        rope_completion = {
          enabled = true  -- Advanced refactoring library
        }
      }
    }
  }
}

require('mason').setup({})
require('mason-lspconfig').setup({
  ensure_installed = {'clangd', 'pylsp', 'rust_analyzer'},
  handlers = {
    lsp_zero.default_setup,
    clangd = function()
      require('lspconfig').clangd.setup(clangd_opts)
    end,
    lua_ls = function()
      local lua_opts = lsp_zero.nvim_lua_ls()
      require('lspconfig').lua_ls.setup(lua_opts)
    end,
    pylsp = function()
      require('lspconfig').pylsp.setup(pylsp_opts)
    end,
  }
})

local cmp = require('cmp')
local cmp_select = {behavior = cmp.SelectBehavior.Select}

cmp.setup({
  sources = {
    {name = 'path'},
    {name = 'nvim_lsp'},
    {name = 'nvim_lua'},
  },
  formatting = lsp_zero.cmp_format(),
  mapping = cmp.mapping.preset.insert({
    ['<C-k>'] = cmp.mapping.select_prev_item(cmp_select),
    ['<C-j>'] = cmp.mapping.select_next_item(cmp_select),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
    ['<C-Space>'] = cmp.mapping.complete(),
  }),
})


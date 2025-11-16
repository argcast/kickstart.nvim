-- Custom LSP and tool configurations
-- This file configures additional language servers and tools without modifying init.lua

return {
  -- Configure additional LSP servers
  {
    'neovim/nvim-lspconfig',
    opts = function(_, opts)
      -- Add TypeScript/JavaScript LSP
      local servers = opts.servers or {}
      servers.ts_ls = {}
      opts.servers = servers
      return opts
    end,
  },

  -- Configure Mason to install additional tools
  {
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    opts = {
      ensure_installed = {
        'typescript-language-server', -- TypeScript/JavaScript LSP
        'prettier', -- Formatter for web files
        'eslint_d', -- Fast ESLint
      },
    },
  },

  -- Configure conform.nvim to use prettier for TypeScript/JavaScript
  {
    'stevearc/conform.nvim',
    opts = {
      formatters_by_ft = {
        javascript = { 'prettier' },
        typescript = { 'prettier' },
        javascriptreact = { 'prettier' },
        typescriptreact = { 'prettier' },
        json = { 'prettier' },
        html = { 'prettier' },
        css = { 'prettier' },
        markdown = { 'prettier' },
      },
    },
  },

  -- Configure Treesitter for additional languages
  {
    'nvim-treesitter/nvim-treesitter',
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, {
        'javascript',
        'typescript',
        'tsx',
        'css',
        'json',
      })
      return opts
    end,
  },

  -- Configure blink.cmp with custom settings
  {
    'saghen/blink.cmp',
    opts = {
      keymap = {
        preset = 'enter', -- Use Enter to accept completions
      },
      completion = {
        documentation = {
          auto_show = true, -- Automatically show docs
          auto_show_delay_ms = 500,
        },
        menu = {
          draw = {
            columns = { { 'kind_icon', 'label', 'label_description', gap = 1 } },
          },
        },
      },
    },
  },
}

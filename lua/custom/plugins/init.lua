-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information

-- Custom keybindings
vim.keymap.set('i', 'jk', '<Esc>', { desc = 'Exit insert mode easily' })

-- Auto-reload files changed externally (e.g. by Claude Code, git, etc.)
vim.opt.autoread = true
vim.api.nvim_create_autocmd({ 'FocusGained', 'BufEnter', 'CursorHold' }, {
  callback = function()
    vim.cmd 'silent! checktime'
  end,
})

-- Set consistent tab/indent settings (2 spaces)
vim.opt.tabstop = 2 -- Number of spaces that a <Tab> in the file counts for
vim.opt.shiftwidth = 2 -- Number of spaces to use for each step of (auto)indent
vim.opt.softtabstop = 2 -- Number of spaces that a <Tab> counts for while editing
vim.opt.expandtab = true -- Use spaces instead of tabs

-- Make background transparent after colorscheme loads
vim.api.nvim_create_autocmd('ColorScheme', {
  pattern = '*',
  callback = function()
    vim.api.nvim_set_hl(0, 'Normal', { bg = 'NONE', ctermbg = 'NONE' })
    vim.api.nvim_set_hl(0, 'NormalFloat', { bg = 'NONE', ctermbg = 'NONE' })
    vim.api.nvim_set_hl(0, 'NormalNC', { bg = 'NONE', ctermbg = 'NONE' })
    vim.api.nvim_set_hl(0, 'SignColumn', { bg = 'NONE', ctermbg = 'NONE' })
    vim.api.nvim_set_hl(0, 'EndOfBuffer', { bg = 'NONE', ctermbg = 'NONE' })
    -- Gitsigns: ensure colored signs are visible with transparent bg
    vim.api.nvim_set_hl(0, 'GitSignsAdd', { fg = '#b8e6a0', bg = 'NONE' })
    vim.api.nvim_set_hl(0, 'GitSignsChange', { fg = '#a8c8ff', bg = 'NONE' })
    vim.api.nvim_set_hl(0, 'GitSignsDelete', { fg = '#ff9ea8', bg = 'NONE' })
    -- Line numbers: brighter for visibility on transparent bg
    vim.api.nvim_set_hl(0, 'LineNr', { fg = '#8893a8', bg = 'NONE' })
    vim.api.nvim_set_hl(0, 'CursorLineNr', { fg = '#e0e0e0', bold = true, bg = 'NONE' })
    -- Neo-tree specific transparency
    vim.api.nvim_set_hl(0, 'NeoTreeNormal', { bg = 'NONE', ctermbg = 'NONE' })
    vim.api.nvim_set_hl(0, 'NeoTreeNormalNC', { bg = 'NONE', ctermbg = 'NONE' })
    vim.api.nvim_set_hl(0, 'NeoTreeEndOfBuffer', { bg = 'NONE', ctermbg = 'NONE' })
  end,
})

return {
  -- Configure tokyonight to use transparent background
  {
    'folke/tokyonight.nvim',
    opts = {
      transparent = true, -- Enable transparent background
      styles = {
        sidebars = 'transparent', -- Transparent sidebars
        floats = 'transparent', -- Transparent floating windows
      },
    },
  },

  -- Don't auto-open Neo-tree at startup
  {
    'nvim-neo-tree/neo-tree.nvim',
    lazy = true, -- Only load when explicitly called
  },

  -- Auto-closing HTML/JSX tags
  {
    'windwp/nvim-ts-autotag',
    event = 'InsertEnter',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    config = function()
      require('nvim-ts-autotag').setup {
        opts = {
          -- Defaults
          enable_close = true, -- Auto close tags
          enable_rename = true, -- Auto rename pairs of tags
          enable_close_on_slash = false, -- Auto close on trailing </
        },
      }
    end,
  },

  -- Git blame annotations
  {
    'f-person/git-blame.nvim',
    event = 'VeryLazy',
    keys = {
      { '<leader>bo', '<cmd>GitBlameOpenCommitURL<cr>', desc = '[B]lame [O]pen commit in browser' },
      { '<leader>bc', '<cmd>GitBlameCopySHA<cr>', desc = '[B]lame [C]opy SHA' },
      { '<leader>bs', '<cmd>GitBlameOpenFileURL<cr>', desc = '[B]lame open file in browser' },
    },
    opts = {
      enabled = true,
      message_template = ' <summary> • <date> • <author> • <<sha>>',
      date_format = '%m-%d-%Y %H:%M:%S',
      virtual_text_column = 1,
    },
  },

  -- GitHub Copilot
  {
    'github/copilot.vim',
    lazy = false,
  },

  -- GitHub Copilot Chat
  {
    'CopilotC-Nvim/CopilotChat.nvim',
    dependencies = {
      { 'nvim-lua/plenary.nvim', branch = 'master' },
    },
    build = 'make tiktoken',
    opts = {},
  },
}

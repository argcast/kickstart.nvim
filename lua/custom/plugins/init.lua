-- Load every other file in this directory (order unspecified).
local plugins_dir = vim.fs.joinpath(vim.fn.stdpath 'config', 'lua', 'custom', 'plugins')
for file_name, type in vim.fs.dir(plugins_dir, { follow = true }) do
  if (type == 'file' or type == 'link') and file_name:match '%.lua$' and file_name ~= 'init.lua' then require('custom.plugins.' .. file_name:gsub('%.lua$', '')) end
end

vim.keymap.set('i', 'jk', '<Esc>', { desc = 'Exit insert mode easily' })

-- Reload files changed externally (e.g. by Claude Code, git)
vim.opt.autoread = true
vim.api.nvim_create_autocmd({ 'FocusGained', 'BufEnter', 'CursorHold' }, {
  callback = function() vim.cmd 'silent! checktime' end,
})

vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.expandtab = true

local function custom_highlights()
  local none = { bg = 'NONE', ctermbg = 'NONE' }
  for _, group in ipairs { 'Normal', 'NormalFloat', 'NormalNC', 'SignColumn', 'EndOfBuffer', 'NeoTreeNormal', 'NeoTreeNormalNC', 'NeoTreeEndOfBuffer' } do
    vim.api.nvim_set_hl(0, group, none)
  end
  vim.api.nvim_set_hl(0, 'GitSignsAdd', { fg = '#b8e6a0', bg = 'NONE' })
  vim.api.nvim_set_hl(0, 'GitSignsChange', { fg = '#a8c8ff', bg = 'NONE' })
  vim.api.nvim_set_hl(0, 'GitSignsDelete', { fg = '#ff9ea8', bg = 'NONE' })
  vim.api.nvim_set_hl(0, 'LineNr', { fg = '#8893a8', bg = 'NONE' })
  vim.api.nvim_set_hl(0, 'CursorLineNr', { fg = '#e0e0e0', bold = true, bg = 'NONE' })
end
vim.api.nvim_create_autocmd('ColorScheme', { callback = custom_highlights })
-- the colorscheme is applied in init.lua before this file loads
custom_highlights()

local function gh(repo) return 'https://github.com/' .. repo end

-- tiktoken is built on install/update
vim.api.nvim_create_autocmd('PackChanged', {
  callback = function(ev)
    if ev.data.spec.name == 'CopilotChat.nvim' and (ev.data.kind == 'install' or ev.data.kind == 'update') then
      vim.system({ 'make', 'tiktoken' }, { cwd = ev.data.path }):wait()
    end
  end,
})
vim.pack.add {
  gh 'windwp/nvim-ts-autotag',
  gh 'f-person/git-blame.nvim',
  gh 'github/copilot.vim',
  gh 'nvim-lua/plenary.nvim',
  { src = gh 'CopilotC-Nvim/CopilotChat.nvim', version = 'main' },
  gh 'nvim-tree/nvim-web-devicons',
  gh 'nvim-lualine/lualine.nvim',
}

require('nvim-ts-autotag').setup {
  opts = { enable_close = true, enable_rename = true, enable_close_on_slash = false },
}

require('gitblame').setup {
  enabled = true,
  message_template = ' <summary> • <date> • <author> • <<sha>>',
  date_format = '%m-%d-%Y %H:%M:%S',
  virtual_text_column = 1,
}
vim.keymap.set('n', '<leader>bo', '<cmd>GitBlameOpenCommitURL<cr>', { desc = '[B]lame [O]pen commit in browser' })
vim.keymap.set('n', '<leader>bc', '<cmd>GitBlameCopySHA<cr>', { desc = '[B]lame [C]opy SHA' })
vim.keymap.set('n', '<leader>bs', '<cmd>GitBlameOpenFileURL<cr>', { desc = '[B]lame open file in browser' })

require('CopilotChat').setup {}

require('lualine').setup {
  options = {
    theme = 'tokyonight',
    component_separators = { left = '', right = '' },
    section_separators = { left = '', right = '' },
  },
}

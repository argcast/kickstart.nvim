vim.pack.add {
  'https://github.com/nvim-lua/plenary.nvim',
  'https://github.com/nvim-tree/nvim-web-devicons',
  'https://github.com/sindrets/diffview.nvim',
}

local function diff_highlights()
  vim.api.nvim_set_hl(0, 'DvAdded', { bg = '#1a3a2a' })
  vim.api.nvim_set_hl(0, 'DvAddedText', { bg = '#2a4a2a' })
  vim.api.nvim_set_hl(0, 'DvRemoved', { bg = '#3d1e1e' })
  vim.api.nvim_set_hl(0, 'DvRemovedText', { bg = '#5a2a2a' })
  vim.api.nvim_set_hl(0, 'DvChanged', { bg = '#1a2a3a' })
  vim.api.nvim_set_hl(0, 'DvFiller', { bg = 'NONE', fg = 'NONE' })
end
diff_highlights()
vim.api.nvim_create_autocmd('ColorScheme', { callback = diff_highlights })

local left_winhl = 'DiffAdd:DvRemoved,DiffText:DvRemovedText,DiffChange:DvChanged,DiffDelete:DvFiller'
local right_winhl = 'DiffAdd:DvAdded,DiffText:DvAddedText,DiffChange:DvChanged,DiffDelete:DvFiller'

vim.opt.fillchars:append { diff = ' ' }
require('diffview').setup {
  hooks = {
    diff_buf_win_enter = function(_, winid, ctx)
      if ctx.symbol == 'a' then
        vim.api.nvim_set_option_value('winhighlight', left_winhl, { win = winid })
      elseif ctx.symbol == 'b' then
        vim.api.nvim_set_option_value('winhighlight', right_winhl, { win = winid })
      end
    end,
  },
}

vim.keymap.set('n', '<leader>gd', '<cmd>DiffviewOpen<cr>', { desc = '[G]it [D]iff view' })
vim.keymap.set('n', '<leader>gf', '<cmd>DiffviewFileHistory %<cr>', { desc = '[G]it [F]ile history (current)' })
vim.keymap.set('n', '<leader>gF', '<cmd>DiffviewFileHistory<cr>', { desc = '[G]it [F]ile history (repo)' })
vim.keymap.set('n', '<leader>gx', '<cmd>DiffviewClose<cr>', { desc = '[G]it diff close' })

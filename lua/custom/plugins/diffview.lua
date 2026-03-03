return {
  'sindrets/diffview.nvim',
  dependencies = { 'nvim-lua/plenary.nvim', 'nvim-tree/nvim-web-devicons' },
  cmd = { 'DiffviewOpen', 'DiffviewFileHistory', 'DiffviewClose' },
  keys = {
    { '<leader>gd', '<cmd>DiffviewOpen<cr>', desc = '[G]it [D]iff view' },
    { '<leader>gf', '<cmd>DiffviewFileHistory %<cr>', desc = '[G]it [F]ile history (current)' },
    { '<leader>gF', '<cmd>DiffviewFileHistory<cr>', desc = '[G]it [F]ile history (repo)' },
    { '<leader>gx', '<cmd>DiffviewClose<cr>', desc = '[G]it diff close' },
  },
  config = function(_, opts)
    -- Custom highlight groups that no theme or plugin will touch
    vim.api.nvim_set_hl(0, 'DvAdded', { bg = '#1a3a2a' })
    vim.api.nvim_set_hl(0, 'DvAddedText', { bg = '#2a4a2a' })
    vim.api.nvim_set_hl(0, 'DvRemoved', { bg = '#3d1e1e' })
    vim.api.nvim_set_hl(0, 'DvRemovedText', { bg = '#5a2a2a' })
    vim.api.nvim_set_hl(0, 'DvChanged', { bg = '#1a2a3a' })
    vim.api.nvim_set_hl(0, 'DvFiller', { bg = 'NONE', fg = 'NONE' })

    vim.api.nvim_create_autocmd('ColorScheme', {
      callback = function()
        vim.api.nvim_set_hl(0, 'DvAdded', { bg = '#1a3a2a' })
        vim.api.nvim_set_hl(0, 'DvAddedText', { bg = '#2a4a2a' })
        vim.api.nvim_set_hl(0, 'DvRemoved', { bg = '#3d1e1e' })
        vim.api.nvim_set_hl(0, 'DvRemovedText', { bg = '#5a2a2a' })
        vim.api.nvim_set_hl(0, 'DvChanged', { bg = '#1a2a3a' })
        vim.api.nvim_set_hl(0, 'DvFiller', { bg = 'NONE', fg = 'NONE' })
      end,
    })

    local left_winhl = table.concat({
      'DiffAdd:DvRemoved',
      'DiffText:DvRemovedText',
      'DiffChange:DvChanged',
      'DiffDelete:DvFiller',
    }, ',')

    local right_winhl = table.concat({
      'DiffAdd:DvAdded',
      'DiffText:DvAddedText',
      'DiffChange:DvChanged',
      'DiffDelete:DvFiller',
    }, ',')

    opts.hooks = {
      diff_buf_win_enter = function(_, winid, ctx)
        if ctx.symbol == 'a' then
          vim.api.nvim_set_option_value('winhighlight', left_winhl, { win = winid })
        elseif ctx.symbol == 'b' then
          vim.api.nvim_set_option_value('winhighlight', right_winhl, { win = winid })
        end
      end,
    }

    vim.opt.fillchars:append { diff = ' ' }
    require('diffview').setup(opts)
  end,
  opts = {},
}

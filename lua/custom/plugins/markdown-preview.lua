vim.pack.add {
  'https://github.com/selimacerbas/kitehost.nvim',
  'https://github.com/selimacerbas/mdkite.nvim',
}

require('mdkite').setup { open_browser = true, default_theme = 'dark' }

vim.keymap.set('n', '<leader>mp', '<cmd>MdKite start<cr>', { desc = '[M]arkdown [P]review start' })
vim.keymap.set('n', '<leader>mr', '<cmd>MdKite refresh<cr>', { desc = '[M]arkdown [R]efresh' })
vim.keymap.set('n', '<leader>ms', '<cmd>MdKite stop<cr>', { desc = '[M]arkdown [S]top' })

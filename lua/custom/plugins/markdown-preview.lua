vim.pack.add {
  'https://github.com/selimacerbas/live-server.nvim',
  'https://github.com/selimacerbas/markdown-preview.nvim',
}

require('markdown_preview').setup { open_browser = true, default_theme = 'dark' }

vim.keymap.set('n', '<leader>mp', '<cmd>MarkdownPreview<cr>', { desc = '[M]arkdown [P]review start' })
vim.keymap.set('n', '<leader>mr', '<cmd>MarkdownPreviewRefresh<cr>', { desc = '[M]arkdown [R]efresh' })
vim.keymap.set('n', '<leader>ms', '<cmd>MarkdownPreviewStop<cr>', { desc = '[M]arkdown [S]top' })

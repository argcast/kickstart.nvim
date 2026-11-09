return {
  'selimacerbas/markdown-preview.nvim',
  dependencies = { 'selimacerbas/live-server.nvim' },
  ft = { 'markdown' },
  keys = {
    { '<leader>mp', '<cmd>MarkdownPreview<cr>', desc = '[M]arkdown [P]review start' },
    { '<leader>mr', '<cmd>MarkdownPreviewRefresh<cr>', desc = '[M]arkdown [R]efresh' },
    { '<leader>ms', '<cmd>MarkdownPreviewStop<cr>', desc = '[M]arkdown [S]top' },
  },
  config = function()
    require('markdown_preview').setup {
      open_browser = true,
      default_theme = 'dark',
    }
  end,
}

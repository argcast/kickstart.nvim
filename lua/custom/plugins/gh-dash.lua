-- Runs the `gh dash` extension (gh extension install dlvhdr/gh-dash) in a floating terminal.
vim.keymap.set('n', '<leader>gp', function()
  local buf = vim.api.nvim_create_buf(false, true)
  local w, h = math.floor(vim.o.columns * 0.95), math.floor(vim.o.lines * 0.9)
  vim.api.nvim_open_win(buf, true, {
    relative = 'editor',
    width = w,
    height = h,
    col = math.floor((vim.o.columns - w) / 2),
    row = math.floor((vim.o.lines - h) / 2),
    border = 'rounded',
  })
  vim.fn.jobstart({ 'gh', 'dash' }, {
    term = true,
    on_exit = function() vim.api.nvim_buf_delete(buf, { force = true }) end,
  })
  vim.cmd.startinsert()
end, { desc = '[G]it [P]Rs dashboard (gh-dash)' })

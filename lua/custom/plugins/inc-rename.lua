-- https://github.com/smjonas/inc-rename.nvim

return {
  'smjonas/inc-rename.nvim',
  config = function()
    require('inc_rename').setup()
  end,

  -- Rename using empty string
  vim.keymap.set('n', '<leader>rn', ':IncRename ', { desc = 'Rename (empty string)' }),

  -- Rename using the current word under cursor
  vim.keymap.set('n', '<leader>rm', function()
    return ':IncRename ' .. vim.fn.expand '<cword>'
  end, { expr = true, desc = 'Rename (current word)' }),
}

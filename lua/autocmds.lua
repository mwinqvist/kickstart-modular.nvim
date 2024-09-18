-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- Trim whitespace on save
vim.api.nvim_create_autocmd('BufWritePre', {
  pattern = { '*.py', '*.js', '*.lua', '*.c', '*.cpp', '*.java', '*.md', '*.rs' },
  callback = function()
    require('mini.trailspace').trim()
  end,
})

-- Open telescope when opening nvim without passing an argument
vim.api.nvim_create_autocmd('VimEnter', {
  callback = function()
    if vim.fn.argv(0) == '' then
      require('telescope.builtin').find_files()
    end
  end,
})

-- vim: ts=2 sts=2 sw=2 et

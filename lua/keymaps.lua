-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Clear highlights on search when pressing 'q' in normal mode
--  See `:help hlsearch`
vim.keymap.set('n', 'q', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- Disable arrow keys in normal mode
vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- Use 'kj' instead of Escape key
vim.keymap.set({ 'v', 'i' }, 'kj', '<Esc>')
vim.keymap.set('c', 'kj', '<C-c>')

-- Use Tab and S-Tab to indent/outdent
-- Remapping Tab also remaps 'i'...
local opts = { noremap = true, silent = true }
vim.keymap.set('n', '<Tab>', '>>', opts)
vim.keymap.set('n', '<S-Tab>', '<<', opts)
vim.keymap.set('v', '<Tab>', '>gv', opts)
vim.keymap.set('v', '<S-Tab>', '<gv', opts)

-- Use <C-p> and <C-n> to jump to previous/next location
vim.keymap.set('n', '<C-p>', '<C-o>', opts)
vim.keymap.set('n', '<C-n>', '<C-i>', opts)

-- Use 'H', 'L' to move to start/end of line
vim.keymap.set({ 'n', 'v' }, 'H', '^', opts)
vim.keymap.set({ 'n', 'v' }, 'L', '$', opts)

-- Use 'J','K' to move down/up
vim.keymap.set('n', 'J', '<C-d>', opts)
vim.keymap.set('n', 'K', '<C-u>', opts)

-- Use 'ä' to create marks
-- 'm' is used for cut in cutlass.nvim
vim.keymap.set('n', 'ä', 'm', opts)

-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

vim.api.nvim_create_autocmd('BufWritePre', {
  pattern = { '*.py', '*.js', '*.lua', '*.c', '*.cpp', '*.java', '*.md', '*.rs' },
  callback = function()
    MiniTrailspace.trim()
  end,
})
-- vim: ts=2 sts=2 sw=2 et

-- [[ Basic Keymaps ]]

-- Clear highlights on search when pressing 'q' in normal mode
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })
-- Use 'kj' instead of Escape key
vim.keymap.set({ 'v', 'i' }, 'kj', '<Esc>')
vim.keymap.set('c', 'kj', '<C-c>')

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })
vim.keymap.set('n', '<C-q>', '<C-w><C-q>', { desc = 'Close current window' })

local opts = { noremap = true, silent = true }

-- Tabs
vim.api.nvim_set_keymap('n', '<Tab>', ':tabnext<CR>', opts)
vim.api.nvim_set_keymap('n', '<S-Tab>', ':tabprevious<CR>', opts)

-- Visual indent
vim.keymap.set('v', '<', '>gv', opts)
vim.keymap.set('v', '>', '<gv', opts)

-- 'H', 'L' to move to start/end of line
vim.keymap.set({ 'n', 'v', 'o' }, 'H', '^', opts)
vim.keymap.set({ 'n', 'v', 'o' }, 'L', '$', opts)

-- 'J','K' to move down/up
vim.keymap.set('n', 'J', '}', opts)
vim.keymap.set('n', 'K', '{', opts)

-- Jump to previous/next occurence of word under cursor
vim.api.nvim_set_keymap('n', '[o', '#', opts)
vim.api.nvim_set_keymap('n', ']o', '*', opts)

-- 'ä' to create marks
-- 'm' is used for cut in cutlass.nvim
vim.keymap.set('n', 'ä', 'm', opts)

-- 'U' to redo
vim.keymap.set('n', 'U', '<C-r>', opts)

-- vim: ts=2 sts=2 sw=2 et

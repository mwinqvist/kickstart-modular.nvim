-- [[ Basic Keymaps ]]

-- Clear highlights on search when pressing 'q' in normal mode
vim.keymap.set('n', 'q', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

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
vim.keymap.set({ 'n', 'v', 'o' }, 'H', '^', opts)
vim.keymap.set({ 'n', 'v', 'o' }, 'L', '$', opts)

-- Use 'J','K' to move down/up
vim.keymap.set('n', 'J', '}', opts)
vim.keymap.set('n', 'K', '{', opts)

-- Use 'ä' to create marks
-- 'm' is used for cut in cutlass.nvim
vim.keymap.set('n', 'ä', 'm', opts)

-- Use 'U' to redo
vim.keymap.set('n', 'U', '<C-r>', opts)

-- vim: ts=2 sts=2 sw=2 et

-- https://github.com/stevearc/aerial.nvim

return {
  'stevearc/aerial.nvim',
  opts = {},
  dependencies = {
    'nvim-treesitter/nvim-treesitter',
    'nvim-tree/nvim-web-devicons',
  },
  config = function()
    require('aerial').setup {
      on_attach = function(bufnr)
        vim.keymap.set('n', '<', '<cmd>AerialPrev<CR>', { buffer = bufnr, desc = 'Aerial next' })
        vim.keymap.set('n', '>', '<cmd>AerialNext<CR>', { buffer = bufnr, desc = 'Aerial prev' })
      end,
    }
    vim.keymap.set('n', '<leader>a', '<cmd>AerialToggle!<CR>', { desc = 'Toggle [A]erial outline' })
  end,
}

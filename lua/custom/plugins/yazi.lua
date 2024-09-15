-- yazi.nvim
-- https://github.com/mikavilpas/yazi.nvim

return {
  ---@type LazySpec
  {
    'mikavilpas/yazi.nvim',
    event = 'VeryLazy',
    keys = {
      {
        '<leader>y',
        '<cmd>Yazi<cr>',
        desc = 'Open yazi (current dir)',
      },
      {
        '<leader>Y',
        '<cmd>Yazi cwd<cr>',
        desc = 'Open yazi (cwd)',
      },
    },
    ---@type YaziConfig
    opts = {
      -- if you want to open yazi instead of netrw, see below for more info
      open_for_directories = false,
      keymaps = {
        show_help = '<f1>',
      },
    },
  },
}

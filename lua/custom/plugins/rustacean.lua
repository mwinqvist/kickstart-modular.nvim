-- rustacean.nvim
-- https://github.com/mrcjkb/rustaceanvim

return {
  'mrcjkb/rustaceanvim',
  version = '^5', -- Recommended
  lazy = false, -- This plugin is already lazy
  config = function()
    vim.g.rustaceanvim = {
      server = {
        default_settings = {
          ['rust-analyzer'] = {
            checkOnSave = {
              allFeatures = true,
              overrideCommand = {
                'cargo',
                'clippy',
                '--workspace',
                '--message-format=json',
                '--all-targets',
                '--all-features',
              },
            },
          },
        },
      },
    }
  end,
}

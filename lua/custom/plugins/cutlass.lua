-- cutlass.nvim
-- https://github.com/gbprod/cutlass.nvim

return {
  'gbprod/cutlass.nvim',
  opts = {
    cut_key = 'm',
    override_del = true,
    exclude = {},
    register = {
      select = '_',
      delete = '_',
      change = '_',
    },
  },
}

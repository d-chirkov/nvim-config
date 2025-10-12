return {
  'stevearc/aerial.nvim',
  event = { "BufReadPost", "BufNewFile" },
  opts = {},
  dependencies = {
     "nvim-treesitter/nvim-treesitter",
     "nvim-tree/nvim-web-devicons"
  },
}

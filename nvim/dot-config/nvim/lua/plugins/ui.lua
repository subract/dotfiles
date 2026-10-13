-- UI: colorscheme and statusline

return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    opts = {
      flavour = "macchiato",
    },
    config = function(_, opts)
      require("catppuccin").setup(opts)
      vim.cmd.colorscheme("catppuccin-macchiato")
    end,
  },
  {
    "nvim-lualine/lualine.nvim",
    opts = {
      options = { theme = "catppuccin-nvim" },
    },
  },
}

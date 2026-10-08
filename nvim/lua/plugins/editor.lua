-- Editor: syntax, fuzzy finding, git

return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "master", -- legacy branch with the stable configs API
    build = ":TSUpdate",
    main = "nvim-treesitter.configs",
    opts = {
      ensure_installed = {
        "lua", "vim", "vimdoc", "bash", "markdown", "markdown_inline",
        "json", "yaml", "toml", "python", "go",
      },
      highlight = { enable = true },
      indent = { enable = true },
    },
  },

  -- fzf-lua: fuzzy finder for files, grep, buffers, etc.
  -- Requires the `fzf` CLI: brew install fzf
  {
    "ibhagwan/fzf-lua",
    keys = {
      { "<leader>ff", "<cmd>FzfLua files<cr>", desc = "Find files" },
      { "<leader>fg", "<cmd>FzfLua live_grep<cr>", desc = "Grep project" },
      { "<leader>fb", "<cmd>FzfLua buffers<cr>", desc = "Find buffer" },
      { "<leader>fh", "<cmd>FzfLua help_tags<cr>", desc = "Search help" },
    },
    opts = {},
  },

  -- Git signs in the gutter (+ blame, hunk staging via :Gitsigns)
  {
    "lewis6991/gitsigns.nvim",
    opts = {},
  },
}

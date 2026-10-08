-- Editor: syntax, fuzzy finding, git

return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main", -- rewrite branch; requires Neovim 0.12+
    lazy = false, -- plugin does not support lazy-loading
    build = ":TSUpdate",
    config = function()
      -- Install/keep parsers up to date (no-op if already installed)
      require("nvim-treesitter").install({
        "lua", "vim", "vimdoc", "bash", "markdown", "markdown_inline",
        "json", "yaml", "toml", "python", "go",
      })

      -- Enable treesitter highlighting + indentation for every filetype
      -- that has an installed parser (new API: enabled via Nvim core, not plugin opts)
      vim.api.nvim_create_autocmd("FileType", {
        callback = function(args)
          if pcall(vim.treesitter.start, args.buf) then
            vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
          end
        end,
      })
    end,
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

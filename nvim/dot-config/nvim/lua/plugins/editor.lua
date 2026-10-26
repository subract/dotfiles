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
    -- `hidden` controls the runtime --hidden toggle (fzf-lua defaults it to
    -- true and prepends --hidden to fd/rg itself); false keeps dotfiles out
    opts = {
      files = {
        hidden = false,
        fd_opts = "--color=never --type f --type l --exclude .git --exclude .jj",
        rg_opts = [[--color=never --files -g "!.git" -g "!.jj"]],
      },
    },
  },

  -- Comment.nvim: toggle comments with <leader>c (linewise, count-aware)
  {
    "numToStr/Comment.nvim",
    keys = {
      { "<leader>c", function() require("Comment.api").toggle.linewise.count(vim.v.count1) end, desc = "Toggle comment" },
      -- Visual mode: escape first so the selection is available to the API
      { "<leader>c", "<ESC><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<cr>", mode = "v", desc = "Toggle comment" },
    },
    opts = {},
  },

  -- nvim-surround: modern rewrite of tpope's surround.vim
  -- Adds/change/delete surrounding pairs: ys{motion}{char}, cs{old}{new}, ds{char}
  {
    "kylechui/nvim-surround",
    version = "*", -- stable releases only; omit to track main
    event = "VeryLazy",
    opts = {},
  },

  -- Git signs in the gutter (+ blame, hunk staging via :Gitsigns)
  {
    "lewis6991/gitsigns.nvim",
    opts = {},
  },

  -- Neogit: full-screen magit-style git interface
  {
    "NeogitOrg/neogit",
    keys = {
      { "<leader>gg", "<cmd>Neogit<cr>", desc = "Neogit status" },
    },
    dependencies = {
      "nvim-lua/plenary.nvim", -- required by neogit
      "ibhagwan/fzf-lua", -- reuse for fuzzy selection inside neogit
    },
    opts = {
      integrations = {
        fzf_lua = true,
      },
    },
  },
}

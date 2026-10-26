-- Markdown: in-buffer previewer

return {
  {
    "MeanderingProgrammer/render-markdown.nvim",
    ft = { "markdown", "codecompanion" },
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons",
    },
    keys = {
      {
        "<leader>md",
        function() require("render-markdown").toggle() end,
        ft = "markdown",
        desc = "Toggle markdown preview",
      },
    },
    opts = {
      file_types = { "markdown", "codecompanion" },
    },
  },

  -- Browser-based live preview (HTML, sync scrolling); needs node
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = "markdown",
    build = "cd app && npx --yes yarn install",
    keys = {
      {
        "<leader>mb",
        "<cmd>MarkdownPreview<cr>",
        ft = "markdown",
        desc = "Markdown preview in browser",
      },
    },
  },
}

-- Agentic.nvim: AI agent chat via ACP (using pi as the provider)

return {
  {
    "carlos-algms/agentic.nvim",

    --- @type agentic.PartialUserConfig
    opts = {
      provider = "pi-acp",
    },

    keys = {
      {
        "<C-\\>",
        function() require("agentic").toggle() end,
        mode = { "n", "v", "i" },
        desc = "Toggle Agentic Chat",
      },
      {
        "<C-'>",
        function() require("agentic").add_selection_or_file_to_context() end,
        mode = { "n", "v" },
        desc = "Add file or selection to Agentic context",
      },
      {
        "<C-,>",
        function() require("agentic").new_session() end,
        mode = { "n", "v", "i" },
        desc = "New Agentic Session",
      },
      {
        "<A-i>r", -- ai Restore
        function() require("agentic").restore_session() end,
        mode = { "n", "v", "i" },
        desc = "Agentic Restore session",
      },
      {
        "<leader>ad", -- ai Diagnostics
        function() require("agentic").add_current_line_diagnostics() end,
        mode = { "n" },
        desc = "Add current line diagnostic to Agentic",
      },
      {
        "<leader>aD", -- ai all Diagnostics
        function() require("agentic").add_buffer_diagnostics() end,
        mode = { "n" },
        desc = "Add all buffer diagnostics to Agentic",
      },
    },
  },
}

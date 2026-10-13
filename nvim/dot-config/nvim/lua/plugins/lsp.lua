-- LSP: servers installed by mason, configured via Nvim's native vim.lsp API

local servers = {
  "lua_ls",  -- lua
  "pyright", -- python
  "gopls",   -- go
  "bashls",  -- bash
  "yamlls",  -- yaml
  "taplo",   -- toml
}

return {
  -- Installer for language servers, linters, etc.
  {
    "williamboman/mason.nvim",
    opts = {},
  },

  -- Auto-install the servers listed above
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = "mason.nvim",
    opts = {
      ensure_installed = servers,
    },
  },

  -- Server config definitions (cmd, filetypes, ...) consumed by vim.lsp.config
  {
    "neovim/nvim-lspconfig",
    dependencies = { "mason.nvim", "mason-lspconfig.nvim" },
    config = function()
      -- Per-server overrides on top of nvim-lspconfig defaults
      vim.lsp.config("lua_ls", {
        settings = {
          Lua = {
            diagnostics = { globals = { "vim" } },
            workspace = { checkThirdParty = false },
          },
        },
      })

      -- Activate servers: Nvim starts them automatically on matching filetypes
      vim.lsp.enable(servers)

      -- Buffer-local keymaps when a server attaches
      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          local map = function(lhs, rhs, desc)
            vim.keymap.set("n", lhs, rhs, { buffer = args.buf, desc = "LSP: " .. desc })
          end
          map("gd", vim.lsp.buf.definition, "go to definition")
          map("gr", vim.lsp.buf.references, "go to references")
          map("K", vim.lsp.buf.hover, "hover docs")
          map("<leader>rn", vim.lsp.buf.rename, "rename symbol")
          map("<leader>ca", vim.lsp.buf.code_action, "code action")
        end,
      })
    end,
  },
}

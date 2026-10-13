-- Neovim config entry point

require("config.options")
require("config.keymaps")
require("config.autocmds")
require("config.lazy") -- plugin manager, loads lua/plugins/*.lua

-- Autocmds and filetype detection

local augroup = vim.api.nvim_create_augroup("user_config", { clear = true })

-- Start with all markdown folds expanded
vim.api.nvim_create_autocmd("FileType", {
  group = augroup,
  pattern = "markdown",
  callback = function()
    vim.opt_local.foldlevel = 99
  end,
})

-- Briefly highlight yanked text 
vim.api.nvim_create_autocmd("TextYankPost", {
  group = augroup,
  callback = function()
    vim.hl.on_yank()
  end,
})

-- Open the fuzzy finder instead of an empty buffer on startup.
vim.api.nvim_create_autocmd("VimEnter", {
  group = augroup,
  nested = true,
  callback = function()
    local argc = vim.fn.argc()
    if argc > 1 then
      return
    end
    if argc == 1 then
      local arg = vim.fn.argv(0)
      if vim.fn.isdirectory(arg) == 1 then
        vim.cmd.cd(vim.fn.fnamemodify(arg, ":p"))
      else
        return -- a file argument was given, open it normally
      end
    end
    require("fzf-lua").files()
  end,
})

-- Keymaps 

local map = vim.keymap.set

-- j/k move by visual line in wrapped paragraphs, unless a count is given
map("n", "j", function()
  return vim.v.count == 0 and "gj" or "j"
end, { expr = true, silent = true })
map("n", "k", function()
  return vim.v.count == 0 and "gk" or "k"
end, { expr = true, silent = true })

-- Enter inserts a new line below in normal mode
map("n", "<CR>", "o<Esc>")

-- "Very magic" search by default (sane regexes)
map({ "n", "v" }, "/", "/\\v")

-- Clear search highlight with Escape
map("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Disable arrow keys in normal and visual modes
for _, key in ipairs({ "<Up>", "<Down>", "<Left>", "<Right>" }) do
  map({ "n", "v" }, key, "<Nop>")
end

-- Save as sudo with :w!!
map("c", "w!!", "w !sudo tee > /dev/null %")

-- Explicitly use the system clipboard (yanks/puts go to "* by default)
map({ "n", "v" }, "<leader>y", '"+y', { desc = "Yank to system clipboard" })
map({ "n", "v" }, "<leader>Y", '"+Y', { desc = "Yank line to system clipboard" })
map({ "n", "v" }, "<leader>p", '"+p', { desc = "Put from system clipboard" })
map({ "n", "v" }, "<leader>P", '"+P', { desc = "Put from system clipboard (before)" })

-- Window navigation with Ctrl+hjkl
map("n", "<C-h>", "<C-w>h")
map("n", "<C-j>", "<C-w>j")
map("n", "<C-k>", "<C-w>k")
map("n", "<C-l>", "<C-w>l")

-- Terminal

-- Leave terminal (insert) mode with Escape
map("t", "<Esc>", "<C-\\><C-n>")

-- Open a terminal in a new horizontal split
map("n", "<leader>tt", function()
  vim.cmd.split() -- splitbelow is set, so this opens below
  vim.cmd.terminal()
end, { desc = "Terminal in horizontal split" })

-- Move the current tab into a vertical split of the previous tab
map("n", "<leader>tv", function()
  if vim.fn.tabpagenr("$") == 1 then
    vim.notify("Only one tab open", vim.log.levels.WARN)
    return
  end
  local buf = vim.api.nvim_get_current_buf()
  vim.cmd.tabclose() -- returns to the previous tab
  vim.cmd.vsplit()
  vim.api.nvim_win_set_buf(0, buf)
end, { desc = "Move tab into vertical split" })

-- Toggle line numbers
map("n", "<leader>tn", function()
  vim.opt.number = not vim.opt.number:get()
  vim.opt.relativenumber = vim.opt.number:get()
end, { desc = "Toggle line numbers" })

-- Prompt for a shell command and insert its output at the cursor
map("n", "<leader>tc", function()
  vim.ui.input({ prompt = "Shell command: " }, function(cmd)
    if not cmd or cmd == "" then
      return
    end
    local out = vim.fn.system(cmd)
    if vim.v.shell_error ~= 0 then
      vim.notify(("Command failed (%d): %s"):format(vim.v.shell_error, out), vim.log.levels.ERROR)
      return
    end
    local lines = vim.split(out:gsub("\n$", ""), "\n") -- strip trailing newline
    local row, col = unpack(vim.api.nvim_win_get_cursor(0))
    if #lines == 1 then
      -- Single line: insert inline, after the cursor
      local cur = vim.api.nvim_buf_get_lines(0, row - 1, row, false)[1]
      vim.api.nvim_buf_set_lines(0, row - 1, row, false, {
        cur:sub(1, col) .. lines[1] .. cur:sub(col + 1),
      })
      vim.api.nvim_win_set_cursor(0, { row, col + #lines[1] })
    else
      -- Multi-line: insert on new lines below the cursor
      vim.api.nvim_buf_set_lines(0, row, row, false, lines)
    end
  end)
end, { desc = "Run shell command, insert output at cursor" })

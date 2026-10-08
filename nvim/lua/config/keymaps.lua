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

-- Disable arrow keys
for _, key in ipairs({ "<Up>", "<Down>", "<Left>", "<Right>" }) do
  map({ "n", "v", "i" }, key, "<Nop>")
end

-- Save as sudo with :w!!
map("c", "w!!", "w !sudo tee > /dev/null %")

-- Window navigation with Ctrl+hjkl
map("n", "<C-h>", "<C-w>h")
map("n", "<C-j>", "<C-w>j")
map("n", "<C-k>", "<C-w>k")
map("n", "<C-l>", "<C-w>l")

-- Toggle line numbers
map("n", "<leader>tn", function()
  vim.opt.number = not vim.opt.number:get()
  vim.opt.relativenumber = vim.opt.number:get()
end, { desc = "Toggle line numbers" })

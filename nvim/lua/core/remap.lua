vim.keymap.set("n", "<leader>pv", "<CMD>Oil<CR>")
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

vim.keymap.set("n", "<leader>y", '"+y')
vim.keymap.set("v", "<leader>y", '"+y')
vim.keymap.set("n", "<leader>Y", '"+Y')

vim.keymap.set("n", "<leader>o", "o<Esc>")
vim.keymap.set("n", "<leader>O", "O<Esc>")

vim.keymap.set("i", "<C-e>", "<c-o>A")
vim.keymap.set("i", "<C-a>", "<c-o>^")

vim.keymap.set("n", "<C-,>", ":cprevious<cr>")
vim.keymap.set("n", "<C-.>", ":cnext<cr>")

local helper = require("core.helper")
vim.keymap.set("n", "<leader>st", helper.screenshot)
vim.keymap.set("n", "<leader>sp", helper.screenshot_path)

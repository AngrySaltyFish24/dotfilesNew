local opt = vim.opt
local cache_dir = vim.env.HOME .. "/.cache/nvim/"

opt.termguicolors = true
opt.hidden = true
opt.magic = true
opt.virtualedit = "block"
opt.wildignorecase = true
opt.swapfile = false
opt.undofile = true
opt.undodir = cache_dir .. "undo/"
opt.backupdir = cache_dir .. "backup/"
opt.viewdir = cache_dir .. "view/"
opt.spellfile = cache_dir .. "spell/en.uft-8.add"
opt.history = 2000
opt.timeout = true
opt.ttimeout = true
opt.timeoutlen = 500
opt.ttimeoutlen = 10
opt.updatetime = 100
opt.redrawtime = 1500
opt.ignorecase = true
opt.smartcase = true
opt.infercase = true

if vim.fn.executable("rg") == 1 then
	opt.grepformat = "%f:%l:%c:%m,%f:%l:%m"
	opt.grepprg = "rg --vimgrep --no-heading --smart-case"
end

opt.completeopt = "menu,menuone,noselect"
opt.showmode = false
opt.shortmess = "aoOTIcF"
opt.scrolloff = 2
opt.sidescrolloff = 5
opt.ruler = false
opt.showtabline = 0
opt.winwidth = 30
opt.pumheight = 15
opt.showcmd = false

opt.cmdheight = 0
opt.laststatus = 3
opt.list = true
opt.listchars = "tab:»·,nbsp:+,trail:·,extends:→,precedes:←"
opt.pumblend = 10
opt.winblend = 10
opt.undofile = true

opt.smarttab = true
opt.expandtab = true
opt.autoindent = true
opt.tabstop = 4
opt.shiftwidth = 4

vim.g.mapleader = " "

-- wrap
opt.linebreak = true
opt.whichwrap = "h,l,<,>,[,],~"
opt.breakindentopt = "shift:2,min:20"
opt.showbreak = "↳ "

opt.foldlevelstart = 99
opt.foldmethod = "indent"

opt.number = true
opt.relativenumber = true
opt.signcolumn = "yes"
opt.spelloptions = "camel"

opt.textwidth = 80
opt.colorcolumn = "80"

vim.o.exrc = true

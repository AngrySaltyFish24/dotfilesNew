local conf = require("modules.ui.config")
local package = require("core.pack").package

package({
	"folke/which-key.nvim",
	event = "VeryLazy",
	init = function()
		vim.o.timeout = true
		vim.o.timeoutlen = 300
	end,
	config = conf.which_key_config,
	opts = {
		-- your configuration comes here
		-- or leave it empty to use the default settings
		-- refer to the configuration section below
	},
})

local theme_file = os.getenv("XDG_CONFIG_HOME") .. "/nvim/lua/modules/ui/color_scheme.txt"

local function set_theme()
	local file = io.open(theme_file, "r")
	io.input(file)
	vim.cmd("colorscheme rose-pine-" .. io.read())
end

local w = vim.uv.new_fs_event()
local function on_change(err, fname, status)
	set_theme()
	w:stop()
	watch_file(theme_file)
end
function watch_file(fname)
	local fullpath = vim.api.nvim_call_function("fnamemodify", { fname, ":p" })
	w:start(
		fullpath,
		{},
		vim.schedule_wrap(function(...)
			on_change(...)
		end)
	)
end
package({
	"rose-pine/neovim",
	name = "rose-pine",
	lazy = false,
	priority = 1000,
	config = function()
		set_theme()
		watch_file(theme_file)
	end,
})

package({
	"chentoast/marks.nvim",
	config = conf.marks_config,
})
package({
	"MeanderingProgrammer/render-markdown.nvim",
	dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" }, -- if you prefer nvim-web-devicons
	---@module 'render-markdown'
	---@type render.md.UserConfig
	opts = {},
	config = conf.render_markdown,
})

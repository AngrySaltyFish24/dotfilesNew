local package = require("core.pack").package
local conf = require("modules.tools.config")

package({
	"nvim-telescope/telescope.nvim",
	tag = "0.1.2",
	dependencies = { "nvim-lua/plenary.nvim" },
	lazy = false,
	config = conf.telescope_config,
})

package({
	"ThePrimeagen/harpoon",
	dependencies = { "nvim-lua/plenary.nvim" },
	branch = "harpoon2",
	config = conf.harpoon_config,
})

package({
	"glepnir/hlsearch.nvim",
	event = "BufRead",
	config = conf.hlsearch_config,
})

package({
	"lewis6991/gitsigns.nvim",
	config = conf.gitsigns_config,
})

package({
	"mbbill/undotree",
	config = conf.undotree_config,
})

package({
	"elentok/format-on-save.nvim",
	lazy = false,
	config = conf.format_on_save_config,
})

package({ "tpope/vim-fugitive" })

package({
	"pwntester/octo.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-telescope/telescope.nvim",
		"nvim-tree/nvim-web-devicons",
	},
	config = conf.octo_config,
})

package({ "sindrets/diffview.nvim" })

package({
	"stevearc/overseer.nvim",
	config = conf.overseer,
	opts = {},
})

package({
	"stevearc/oil.nvim",
	config = conf.oil,
	opts = {},
})

package({
	"mfussenegger/nvim-dap-python",
	config = conf.dap,
	opts = {},
})

package({
	"mfussenegger/nvim-dap",
	config = conf.python_dap,
	opts = {},
})

package({
	"mikesmithgh/kitty-scrollback.nvim",
	config = conf.kitty_scrollback,
	enabled = true,
	lazy = true,
	cmd = { "KittyScrollbackGenerateKittens", "KittyScrollbackCheckHealth" },
	event = { "User KittyScrollbackLaunch" },
	opts = {},
})

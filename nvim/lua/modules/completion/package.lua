local package = require("core.pack").package
local conf = require("modules.completion.config")

package({
	"windwp/nvim-autopairs",
	event = "InsertEnter",
	opts = {}, -- this is equalent to setup({}) function
})

package({
	"j-hui/fidget.nvim",
	tag = "v1.0.0",
	config = conf.fidget_config,
})

package({
	"neovim/nvim-lspconfig",
	dependencies = {
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"folke/neoconf.nvim",
	},
	config = conf.lspconfig,
})

package({
	"hrsh7th/nvim-cmp",
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
		"hrsh7th/cmp-cmdline",
		"onsails/lspkind.nvim",
		"L3MON4D3/LuaSnip",
		"saadparwaiz1/cmp_luasnip",
		"hrsh7th/cmp-nvim-lsp-signature-help",
	},
	config = conf.cmp_config,
})
package({
	"nvimdev/lspsaga.nvim",
	event = "LspAttach",
	dependencies = {
		"nvim-treesitter/nvim-treesitter", -- optional
		"nvim-tree/nvim-web-devicons", -- optional
	},
	config = conf.lspsaga_config,
})

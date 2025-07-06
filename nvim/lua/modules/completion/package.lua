local package = require("core.pack").package
local conf = require("modules.completion.config")

package({
	"j-hui/fidget.nvim",
	tag = "v1.0.0",
	config = conf.fidget_config,
})

package({
	"ray-x/navigator.lua",
	dependencies = {
		{ "ray-x/guihua.lua", build = "cd lua/fzy && make" },
		{ "neovim/nvim-lspconfig" },
	},
	config = conf.navigator,
})

package({
	"saghen/blink.pairs",
	version = "*", -- (recommended) only required with prebuilt binaries

	-- download prebuilt binaries from github releases
	dependencies = "saghen/blink.download",
	-- OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
	-- build = 'cargo build --release',
	-- If you use nix, you can build from source using latest nightly rust with:
	-- build = 'nix run .#build-plugin',

	--- @module 'blink.pairs'
	--- @type blink.pairs.Config
	opts = {
		mappings = {
			-- you can call require("blink.pairs.mappings").enable() and require("blink.pairs.mappings").disable() to enable/disable mappings at runtime
			enabled = true,
			-- you may also disable with `vim.g.pairs = false` (global) or `vim.b.pairs = false` (per-buffer)
			disabled_filetypes = {},
			-- see the defaults: https://github.com/Saghen/blink.pairs/blob/main/lua/blink/pairs/config/mappings.lua#L12
			pairs = {},
		},
		highlights = {
			enabled = true,
			groups = {
				"BlinkPairsOrange",
				"BlinkPairsPurple",
				"BlinkPairsBlue",
			},
			matchparen = {
				enabled = true,
				group = "MatchParen",
			},
		},
		debug = false,
	},
})

package({
	"yetone/avante.nvim",
	-- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
	-- ⚠️ must add this setting! ! !
	build = function()
		-- conditionally use the correct build system for the current OS
		if vim.fn.has("win32") == 1 then
			return "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false"
		else
			return "make"
		end
	end,
	event = "VeryLazy",
	version = false, -- Never set this value to "*"! Never!
	---@module 'avante'
	---@type avante.Config
	opts = {
		-- add any opts here
		-- for example
		provider = "claude",
		providers = {
			claude = {
				endpoint = "https://api.anthropic.com",
				model = "claude-sonnet-4-20250514",
				timeout = 30000, -- Timeout in milliseconds
				extra_request_body = {
					temperature = 0.75,
					max_tokens = 20480,
				},
			},
		},
	},
	dependencies = {
		"nvim-lua/plenary.nvim",
		"MunifTanjim/nui.nvim",
		--- The below dependencies are optional,
		"echasnovski/mini.pick", -- for file_selector provider mini.pick
		"nvim-telescope/telescope.nvim", -- for file_selector provider telescope
		"hrsh7th/nvim-cmp", -- autocompletion for avante commands and mentions
		"ibhagwan/fzf-lua", -- for file_selector provider fzf
		"stevearc/dressing.nvim", -- for input provider dressing
		"folke/snacks.nvim", -- for input provider snacks
		"nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
		"zbirenbaum/copilot.lua", -- for providers='copilot'
		{
			-- support for image pasting
			"HakonHarnes/img-clip.nvim",
			event = "VeryLazy",
			opts = {
				-- recommended settings
				default = {
					embed_image_as_base64 = false,
					prompt_for_file_name = false,
					drag_and_drop = {
						insert_mode = true,
					},
					-- required for Windows users
					use_absolute_path = true,
				},
			},
		},
		{
			-- Make sure to set this up properly if you have lazy=true
			"MeanderingProgrammer/render-markdown.nvim",
			opts = {
				file_types = { "markdown", "Avante" },
			},
			ft = { "markdown", "Avante" },
		},
	},
})

package({
	"saghen/blink.cmp",
	dependencies = {
		"Kaiser-Yang/blink-cmp-avante",
		"L3MON4D3/LuaSnip",
		-- ... Other dependencies
	},
	opts = {
		sources = {
			-- Add 'avante' to the list
			default = { "avante", "lsp", "path", "buffer" },
			providers = {
				avante = {
					module = "blink-cmp-avante",
					name = "Avante",
					opts = {
						-- options for blink-cmp-avante
					},
				},
			},
		},
	},
})

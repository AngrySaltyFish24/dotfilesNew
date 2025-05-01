local config = {}

function config.which_key_config()
	local wk = require("which-key")

	wk.add({
		-- Move line under selection
		{ "J", ":m '>+1<CR>gv=gv", mode = "v" },
		{ "K", ":m '<-2<CR>gv=gv", mode = "v" },

		-- Scroll half page and recenter
		{ "<C-d>", "<C-d>zz" },
		{ "<C-u>", "<C-u>zz" },

		-- goto next/prev error
		{
			"<C-,>",
			function()
				vim.diagnostic.goto_prev()
			end,
		},
		{
			"<C-.>",
			function()
				vim.diagnostic.goto_next()
			end,
		},

		-- bash shortcut to goto end/begining of line
		{ "<C-e>", "<c-o>A", mode = "i" },
		{ "<C-a>", "<c-o>^", mode = "i" },

		{ "<leader>st", desc = "Take a screenshot (TODO)", function() end },

		-- Copy to clipboard
		{ "<leader>y", '"+y', desc = "Copy to clipboard" },
		{ "<leader>y", '"+y', mode = "v", desc = "Copy to clipboard" },
		{ "<leader>Y", '"+Y', desc = "Copy to clipboard" },

		{ "<leader>pv", "<CMD>Oil<CR>", desc = "File browser" },
		{ "<leader>a", desc = "Add buffer to harpoon" },

		{ "<leader>d", group = "Debug adapter" },
		{ "<leader>db", desc = "toggle breakpoint" },
		{ "<leader>dc", desc = "continue" },
		{ "<leader>dp", desc = "run last" },
		{ "<leader>dq", desc = "terminate" },
		{ "<leader>dr", desc = "run test method" },

		{ "<leader>ds", group = "Step" },
		{ "<leader>dsi", desc = "step into" },
		{ "<leader>dso", desc = "step over" },
		{ "<leader>dsq", desc = "step out" },
		{ "<leader>dv", desc = "toggle repl" },

		{ "<leader>f", group = "find" },
		{ "<leader>fb", desc = "Find Buffers" },
		{ "<leader>ff", desc = "Find Files" },
		{ "<leader>fg", desc = "Find Git Files" },
		{ "<leader>fr", desc = "Find Symbols" },
		{ "<leader>fs", desc = "Find String" },

		{ "<leader>h", group = "Git Signs hunk" },
		{ "<leader>hR", desc = "Reset buffer" },
		{ "<leader>hS", desc = "Stage buffer" },
		{ "<leader>hb", desc = "Toggle blame line" },
		{ "<leader>hp", desc = "Preview diff" },
		{ "<leader>hr", desc = "Reset hunk" },
		{ "<leader>hs", desc = "Stage hunk" },
		{ "<leader>hu", desc = "undo stage hunk" },

		{ "<leader>pv", desc = "File Manager" },

		{ "<leader>u", desc = "Toggle undo tree" },

		{
			"<leader>b",
			group = "buffers",
			expand = function()
				-- TODO: Make this mnemic

				return require("which-key.extras").expand.buf()
			end,
		},
	})
end

function config.marks_config()
	require("marks").setup({})
end

function render_markdown()
	require("render-markdown").setup({
		completions = { lsp = { enabled = true } },
	})
end

return config

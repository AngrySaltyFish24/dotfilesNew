local config = {}

function config.which_key_config()
	local wk = require("which-key")

	wk.register({
		f = {
			name = "find",
			f = { "Find Files" },
			g = { "Find Git Files" },
			b = { "Find Buffers" },
			s = { "Find String" },
			r = { "Find Symbols" },
		},
		a = { "Add buffer to harpoon" },
		u = { "Toggle undo tree" },
		p = {
			v = { "File Manager" },
		},
		d = {
			name = "Debug adapter",
			b = { "toggle breakpoint" },
			c = { "continue" },
			r = { "run test method" },
			p = { "run last" },
			v = { "toggle repl" },
			q = { "terminate" },
			s = {
				name = "Step",
				o = { "step over" },
				i = { "step into" },
				q = { "step out" },
			},
		},
		h = {
			name = "Git Signs hunk",
			s = { "Stage hunk" },
			r = { "Reset hunk" },
			S = { "Stage buffer" },
			u = { "undo stage hunk" },
			R = { "Reset buffer" },
			p = { "Preview diff" },
			b = { "Toggle blame line" },
		},
	}, { prefix = "<leader>" })
end

function config.marks_config()
	require("marks").setup({})
end
return config

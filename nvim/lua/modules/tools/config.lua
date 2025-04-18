local config = {}

function config.telescope_config()
	local builtin = require("telescope.builtin")
	vim.keymap.set("n", "<leader>ff", builtin.find_files, {}) -- Search normal files
	vim.keymap.set("n", "<leader>fg", builtin.git_files, {}) -- Search git files
	vim.keymap.set("n", "<leader>fs", builtin.live_grep, {}) -- Search for a string
	vim.keymap.set("n", "<leader>fr", builtin.lsp_workspace_symbols, {}) -- Search symbols
	vim.keymap.set("n", "<leader>fb", builtin.buffers, {}) -- Search live buffers
end

function config.hlsearch_config()
	require("hlsearch").setup({})
end

function config.harpoon_config()
	local harpoon = require("harpoon")

	harpoon:setup()
	vim.keymap.set("n", "<C-s>", function()
		harpoon.ui:toggle_quick_menu(harpoon:list())
	end)

	vim.keymap.set("n", "<leader>a", function()
		harpoon:list():append()
	end)
	vim.keymap.set("n", "<C-h>", function()
		harpoon:list():select(1)
	end)
	vim.keymap.set("n", "<C-j>", function()
		harpoon:list():select(2)
	end)
	vim.keymap.set("n", "<C-k>", function()
		harpoon:list():select(3)
	end)
	vim.keymap.set("n", "<C-l>", function()
		harpoon:list():select(4)
	end)
end

function config.gitsigns_config()
	require("gitsigns").setup({
		on_attach = function(bufnr)
			local gs = package.loaded.gitsigns

			local function map(mode, l, r, opts)
				opts = opts or {}
				opts.buffer = bufnr
				vim.keymap.set(mode, l, r, opts)
			end

			-- Navigation
			map("n", "]c", function()
				if vim.wo.diff then
					return "]c"
				end
				vim.schedule(function()
					gs.next_hunk()
				end)
				return "<Ignore>"
			end, { expr = true })

			map("n", "[c", function()
				if vim.wo.diff then
					return "[c"
				end
				vim.schedule(function()
					gs.prev_hunk()
				end)
				return "<Ignore>"
			end, { expr = true })

			-- Actions
			map("n", "<leader>hs", gs.stage_hunk)
			map("n", "<leader>hr", gs.reset_hunk)
			map("v", "<leader>hs", function()
				gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
			end)
			map("v", "<leader>hr", function()
				gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
			end)
			map("n", "<leader>hS", gs.stage_buffer)
			map("n", "<leader>hu", gs.undo_stage_hunk)
			map("n", "<leader>hR", gs.reset_buffer)
			map("n", "<leader>hp", gs.preview_hunk)
			map("n", "<leader>hb", function()
				gs.blame_line({ full = true })
			end)
			map("n", "<leader>tb", gs.toggle_current_line_blame)
			map("n", "<leader>hd", gs.diffthis)
			map("n", "<leader>hD", function()
				gs.diffthis("~")
			end)
			map("n", "<leader>td", gs.toggle_deleted)

			-- Text object
			map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>")
		end,
	})
	vim.cmd([[set statusline=%{get(b:,'gitsigns_head','')}]])
end

function config.undotree_config()
	vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)
end

function config.format_on_save_config()
	local format_on_save = require("format-on-save")
	local formatters = require("format-on-save.formatters")

	format_on_save.setup({
		auto_commands = true,
		formatter_by_ft = {
			lua = formatters.stylua,
			rust = formatters.lsp,
			python = formatters.shell({ cmd = { "black", "--stdin-filename", "%", "--quiet", "-" } }),
			typescript = formatters.prettierd,
			typescriptreact = formatters.prettierd,
		},
		run_with_sh = true,
	})
end

function config.indent_blankline_config()
	require("ibl").setup()
end

function config.octo_config()
	require("octo").setup({ timeout = 100000 })
end

function config.overseer()
	local ov = require("overseer")
	require("overseer").setup()

	vim.keymap.set("n", "<leader>rR", ":OverseerRun Run<cr>")
	vim.keymap.set("n", "<leader>rT", ":OverseerRun Test<cr>")
	vim.keymap.set("n", "<leader>rr", ":OverseerQuickAction restart<cr>")
	vim.keymap.set("n", "<leader>rt", ":OverseerQuickAction open tab<cr>")
	vim.keymap.set("n", "<leader>rv", ":OverseerToggle<cr>")
end

function config.oil_conf()
	require("oil").setup({})
	vim.keymap.set("n", "<leader>pv", "<CMD>Oil<CR>")
end

function config.dap()
	local dap = require("dap")
	vim.api.nvim_set_keymap("n", "<leader>db", "", { callback = dap.toggle_breakpoint })
	vim.api.nvim_set_keymap("n", "<leader>dc", "", { callback = dap.continue })
	vim.api.nvim_set_keymap("n", "<leader>dv", "", { callback = dap.repl.toggle })
	vim.api.nvim_set_keymap("n", "<leader>dso", "", { callback = dap.step_over })
	vim.api.nvim_set_keymap("n", "<leader>dsi", "", { callback = dap.step_into })
	vim.api.nvim_set_keymap("n", "<leader>dsq", "", { callback = dap.step_out })
	vim.api.nvim_set_keymap("n", "<leader>dp", "", { callback = dap.run_last })
	vim.api.nvim_set_keymap("n", "<leader>dq", "", { callback = dap.terminate })
end

function config.python_dap()
	local py_dap = require("dap-python")
	py_dap.test_runner = "pytest"
	vim.api.nvim_set_keymap("n", "<leader>dr", "", { callback = py_dap.test_method })
	-- vim.api.nvim_set_keymap("n", "<leader>ds", "", { callback =
	-- py_dap.test_selection })
	py_dap.setup()
end

function config.kitty_scrollback()
	require("kitty-scrollback").setup()
end

return config

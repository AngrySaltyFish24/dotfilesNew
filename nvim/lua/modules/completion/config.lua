local config = {}

function config.fidget_config()
	require("fidget").setup()
end

function config.lspconfig()
	local servers = { "rust_analyzer", "basedpyright", "ts_ls", "lua_ls" }

	require("mason").setup({
		ensured_installed = servers,
	})

	local mason_tools = {
		"rust-analyzer",
		"basedpyright",
		"typescript-language-server",
		"lua-language-server",
		"stylua",
		"isort",
		"black",
	}
	local mason_registry = require("mason-registry")

	for _, pkg_name in ipairs(mason_tools) do
		local pkg = mason_registry.get_package(pkg_name)

		if not pkg:is_installed() then
			pkg:install()
		end
	end

	require("mason-lspconfig").setup({
		ensured_installed = servers,
	})

	function on_lsp_attach(client, bufnr)
		vim.keymap.set("n", "K", vim.lsp.buf.hover, { silent = true, noremap = true })
		vim.keymap.set("n", "gd", vim.lsp.buf.definition, { silent = true, noremap = true })
		vim.keymap.set("n", "<leader>dl", vim.diagnostic.setqflist)
		vim.keymap.set("n", "<leader>dd", vim.diagnostic.open_float)
	end

	local capabilities = vim.lsp.protocol.make_client_capabilities()
	capabilities.textDocument.foldingRange = {
		dynamicRegistration = false,
		lineFoldingOnly = true,
	}
	require("neoconf").setup()
	local lspconfig = require("lspconfig")
	for _, lsp in ipairs(servers) do
		lspconfig[lsp].setup({
			on_attach = on_lsp_attach,
			capabilities = capabilities,
		})
	end
end

function config.cmp_config()
	local cmp = require("cmp")
	local lspkind = require("lspkind")

	cmp.setup({
		formatting = {
			format = lspkind.cmp_format(),
		},
		sources = {
			{ name = "nvim_lsp" },
			-- { name = "nvim_lua" },
			{ name = "luasnip" },
			{ name = "nvim_lsp_signature_help" },
			{ name = "path" },
		},

		snippet = {
			expand = function(args)
				require("luasnip").lsp_expand(args.body)
			end,
		},
		mapping = cmp.mapping.preset.insert({
			["<C-b>"] = cmp.mapping.scroll_docs(-4),
			["<C-f>"] = cmp.mapping.scroll_docs(4),
			["<C-Space>"] = cmp.mapping.complete(),
			["<C-e>"] = cmp.mapping.abort(),
			["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
		}),
	})
end

function config.lspsaga_config()
	require("nvim-web-devicons").setup({})
	require("lspsaga").setup({})
	vim.keymap.set("n", "<leader>lp", "<cmd>Lspsaga peek_definition<cr>")
	vim.keymap.set("n", "<leader>lo", "<cmd>Lspsaga outline<cr>")
	vim.keymap.set("n", "<leader>lr", "<cmd>Lspsaga rename<cr>")
	vim.keymap.set("n", "<leader>lf", "<cmd>Lspsaga finder<cr>")
	vim.keymap.set("n", "<leader>la", "<cmd>Lspsaga code_action<cr>")
	vim.keymap.set("n", "<leader>lci", "<cmd>Lspsaga incoming_calls<cr>")
	vim.keymap.set("n", "<leader>lco", "<cmd>Lspsaga outgoing_calls<cr>")
end

return config

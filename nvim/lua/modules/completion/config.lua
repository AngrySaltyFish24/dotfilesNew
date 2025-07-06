local config = {}

function config.fidget_config()
	require("fidget").setup()
end

function config.navigator()
	-- vim.lsp.enable("luals")
	require("navigator").setup({ lsp = { register = "A" } })
	-- require("blink")
end

return config

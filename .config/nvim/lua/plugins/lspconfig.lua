return {
	{
		"williamboman/mason.nvim",
		opts = {},
	},
	{
		"williamboman/mason-lspconfig.nvim",
		opts = {
			ensure_installed = {
				"lua_ls",
				"rust_analyzer",
				"bashls",
				"tsserver",
                "clangd"
			},
		},
	},
	{
		"neovim/nvim-lspconfig",
		config = function()
			local lsp_capabilities = require("cmp_nvim_lsp").default_capabilities()

			local lspconfig = require("lspconfig")

			lspconfig.lua_ls.setup({
				capabilities = lsp_capabilities,
			})

			lspconfig.rust_analyzer.setup({
				capabilities = lsp_capabilities,
			})

			lspconfig.bashls.setup({
				capabilities = lsp_capabilities,
			})

			lspconfig.tsserver.setup({
				capabilities = lsp_capabilities,
			})

            lspconfig.clangd.setup({
                capabilities = lsp_capabilities
            })

			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("UserLspConfig", {}),
				callback = function(ev)
					local opts = { buffer = ev.buf }
					vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
					vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
					vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)
				end,
			})
		end,
	},
}

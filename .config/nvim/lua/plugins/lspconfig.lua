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
				"clangd",
				"jsonls",
				"cssls",
				"taplo",
				"html",
				"emmet_ls",
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
				capabilities = lsp_capabilities,
			})

			lspconfig.jsonls.setup({
				capabilities = lsp_capabilities,
			})

			lspconfig.cssls.setup({
				capabilities = lsp_capabilities,
			})

			lspconfig.taplo.setup({
				capabilities = lsp_capabilities,
			})

			lspconfig.html.setup({
				capabilities = lsp_capabilities,
			})

			lspconfig.emmet_ls.setup({
				capabilities = lsp_capabilities,
			})

			local _border = "single"
			require("lspconfig.ui.windows").default_options.border = _border

			vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
				border = _border,
			})
			vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
				border = _border,
			})
			vim.diagnostic.config({
				float = { border = _border },
			})

			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("UserLspConfig", {}),
				callback = function(ev)
					local opts = { buffer = ev.buf }
					vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
					vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
					vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)
					vim.keymap.set({ "n", "v" }, "<leader>cr", vim.lsp.buf.rename, opts)
				end,
			})

			-- Hyprlang LSP
			vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
				pattern = { "*.hl", "hypr*.conf", "*/hypr/conf/*.conf" },
				callback = function(event)
					-- print(string.format("starting hyprls for %s", vim.inspect(event)))
					vim.lsp.start({
						name = "hyprlang",
						cmd = { "hyprls" },
						root_dir = vim.fn.getcwd(),
					})
				end,
			})
		end,
	},
}

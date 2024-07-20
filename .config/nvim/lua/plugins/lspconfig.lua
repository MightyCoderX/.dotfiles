return {
    {
        "williamboman/mason.nvim",
        opts = {}
    },
    {
        "williamboman/mason-lspconfig.nvim",
        config = function()
            require("mason-lspconfig").setup({
                ensure_installed = { "lua_ls", "rust_analyzer", "bashls" }
            })
        end
    },
    {
        "neovim/nvim-lspconfig",
        config = function()
            local lspconfig = require("lspconfig")
            lspconfig.lua_ls.setup {}
            lspconfig.rust_analyzer.setup {}
            lspconfig.bashls.setup {}

            vim.keymap.set('n', 'K', vim.lsp.buf.hover, {})
        end
    }
}

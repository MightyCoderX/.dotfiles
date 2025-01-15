return {
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-nvim-lsp",
            "saadparwaiz1/cmp_luasnip",
            "rafamadriz/friendly-snippets",
            "L3MON4D3/LuaSnip",
            "onsails/lspkind.nvim",
            "folke/neodev.nvim"
        },
        config = function()
            -- Set up nvim-cmp.

            local cmp = require("cmp")
            require("luasnip.loaders.from_vscode").lazy_load()

            local lspkind = require("lspkind")

            cmp.setup({
                formatting = {
                    format = lspkind.cmp_format({
                        mode = 'symbol',
                        maxwidth = {
                            menu = 30
                        },
                        ellipsis_char = "…"
                    }),
                },
                snippet = {
                    -- REQUIRED - you must specify a snippet engine
                    expand = function(args)
                        require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
                        -- vim.snippet.expand(args.body) -- For native neovim snippets (Neovim v0.10+)
                    end,
                },
                window = {
                    completion = cmp.config.window.bordered(),
                    documentation = cmp.config.window.bordered(),
                },
                view = {
                    entries = {
                        follow_cursor = true,
                    }
                },
                mapping = cmp.mapping.preset.insert({
                    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
                    ["<C-f>"] = cmp.mapping.scroll_docs(4),
                    ["<C-Space>"] = cmp.mapping.complete(),
                    ["<C-e>"] = cmp.mapping.abort(),
                    ["<CR>"] = cmp.mapping.confirm({ select = false }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
                }),
                sources = cmp.config.sources({
                    { name = "nvim_lsp", priority = 3 },
                    { name = "path",     priority = 2 },
                    { name = "luasnip",  priority = 1 },
                    { name = "buffer",   keyword_length = 5 },
                }),
            })
        end,
    },
    {
        "brenoprata10/nvim-highlight-colors",
        config = function()
            vim.opt.termguicolors = true
            require("nvim-highlight-colors").setup({})
        end,
    },
}

return {
    {
        "williamboman/mason.nvim",
        opts = {},
    },
    { "elkowar/yuck.vim" },
    {
        "eraserhd/parinfer-rust",
        build = "cargo build --release",
        enabled = false,
    },
    {
        "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
        config = function()
            require("lsp_lines").setup()
            -- Disable virtual_text since it's redundant due to lsp_lines.
            vim.diagnostic.config({
                virtual_text = false,
            })
        end,
        keys = {
            {
                "<leader>l",
                function()
                    require("lsp_lines").toggle()
                end,
                desc = "Toggle lsp_lines"
            }
        }
    },
    {
        "williamboman/mason-lspconfig.nvim",
        opts = {
            ensure_installed = {
                "lua_ls",
                "rust_analyzer",
                "clangd",
                "gopls",
                "bashls",
                "ts_ls",
                "jsonls",
                "cssls",
                "taplo",
                "html",
                "emmet_ls",
                "hyprls",
                "cmake",
                "dockerls",
                -- "nginx_language_server",
                "pyright",
                "ruff",
                "spyglassmc_language_server"
            },
        },
    },
    {
        "neovim/nvim-lspconfig",
        config = function()
            local lsp_capabilities = require("cmp_nvim_lsp").default_capabilities()

            require("mason-lspconfig").setup_handlers({
                function(server_name)
                    require("lspconfig")[server_name].setup({
                        capabilities = lsp_capabilities,
                    })
                end,
            })

            vim.cmd("autocmd BufNewFile,BufRead *.mcfunction set filetype=mcfunction")
            vim.lsp.enable('spyglassmc_language_server')

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
                    opts.desc = "Show info popup"
                    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)

                    opts.desc = "Go to definition"
                    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)

                    opts.desc = "Go to references"
                    vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)

                    opts.desc = "Go to implementations"
                    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)

                    opts.desc = "Code actions"
                    vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)

                    opts.desc = "Rename token"
                    vim.keymap.set({ "n", "v" }, "<leader>cr", vim.lsp.buf.rename, opts)
                end,
            })

            -- Hyprlang LSP
            vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
                pattern = { "*.hl", "hypr*.conf", "*/hypr/conf/*.conf" },
                ---@diagnostic disable-next-line: unused-local
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
        keys = {
            {
                '<leader>dd',
                vim.diagnostic.open_float,
                desc = "Open vim diagnostics"
            }
        }
    },
}

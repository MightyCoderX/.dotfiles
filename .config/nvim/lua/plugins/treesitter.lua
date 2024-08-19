return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
        local config = require("nvim-treesitter.configs")
        config.setup({
            ensure_installed = {
                "lua", "javascript", "rust", "bash"
            },
            auto_install = true,
            modules = {},
            sync_install = true,
            ignore_install = {},
            highlight = { enable = true },
            indent = { enable = true },
        })
        vim.filetype.add({
            pattern = { [".*/hypr/.*%.conf"] = "hyprlang" },
        })
    end,
}

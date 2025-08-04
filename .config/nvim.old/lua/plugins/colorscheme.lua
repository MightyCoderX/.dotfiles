return {
    {
        "catppuccin/nvim",
        name = "catppuccin",
        enabled = false,
        priority = 1000,
        config = function()
            require("catppuccin").setup({
                transparent_background = true,
            })
            vim.cmd.colorscheme("catppuccin-mocha")
        end,
    },
    {
        "rebelot/kanagawa.nvim",
        enabled = true,
        config = function()
            require("kanagawa").setup({
                transparent = true,
                colors = {
                    theme = { all = { ui = { bg_gutter = "none" } } },
                },
            })
            vim.cmd.colorscheme("kanagawa")
        end,
    },
    {
        "Everblush/nvim",
        enabled = false,
        name = "everblush",
        config = function()
            vim.cmd.colorscheme("everblush")
        end,
    },
    {
        "navarasu/onedark.nvim",
        enabled = false,
        opts = {
            style = "darker",
        },
        config = function()
            vim.cmd.colorscheme("onedark")
        end,
    },
    {
        "folke/tokyonight.nvim",
        enabled = false,
        priority = 1000,
        config = function()
            vim.cmd.colorscheme("tokyonight-night")
        end,
    },
}

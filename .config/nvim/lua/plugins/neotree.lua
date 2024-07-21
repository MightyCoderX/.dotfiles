return {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons",
        "MunifTanjim/nui.nvim",
    },
    config = function()
        require("neo-tree").setup({
            filesystem = {
                filtered_items = {
                    visible = true,
                    show_hidden_count = true,
                    hide_dotfiles = false,
                    hide_gitignored = true,
                    hide_by_name = {
                        -- add extension names you want to explicitly exclude
                        -- '.DS_Store',
                        -- 'thumbs.db',
                    },
                    never_show = {
                        ".git",
                    },
                },
            },
        })
        vim.keymap.set("n", "<C-n>", ":Neotree filesystem reveal left<CR>", {})
    end,
}

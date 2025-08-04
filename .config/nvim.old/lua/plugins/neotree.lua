return {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons",
        "MunifTanjim/nui.nvim",
    },
    cmd = "Neotree",
    init = function()
        vim.api.nvim_create_autocmd("BufEnter", {
            -- make a group to be able to delete it later
            group = vim.api.nvim_create_augroup("NeoTreeInit", { clear = true }),
            callback = function()
                local f = vim.fn.expand("%:p")
                if vim.fn.isdirectory(f) ~= 0 then
                    vim.cmd("Neotree current dir=" .. f)
                    -- neo-tree is loaded now, delete the init autocmd
                    vim.api.nvim_clear_autocmds({ group = "NeoTreeInit" })
                end
            end,
        })
    end,
    opts = {
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
            hijack_netrw_behavior = "open_current",
            use_libuv_file_watcher = true,
        },
    },
    keys = {
        {
            "<leader>e",
            function()
                vim.cmd(":Neotree filesystem reveal left")
            end,
            desc = "Reveal neo-tree",
        },
    },
}

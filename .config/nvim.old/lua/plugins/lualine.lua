return {
    "nvim-lualine/lualine.nvim",
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    opts = {
        extensions = { "neo-tree" },
        sections = {
            lualine_c = { { "filename", path = 1 } }
        }
    },

}

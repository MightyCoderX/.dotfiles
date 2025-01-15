return {
    "nvim-lualine/lualine.nvim",
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = {
        extensions = { "neo-tree" },
        sections = {
            lualine_c = { { "filename", path = 1 } }
        }
    },

}

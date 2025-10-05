return {
    "rcarriga/nvim-notify",
    lazy = false,
    opts = {
        timeout = 10000,
        fps = 48,
        render = "wrapped-default", -- compact",
        time_formats = {
            notification = "%T",
        },
        max_width = 70,
        stages = "slide"
    },
    config = function()
        vim.notify = require('notify')
    end
}

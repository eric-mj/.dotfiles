return {
    "folke/snacks.nvim",
    opts = {
        gitbrowse = {
            -- your gitbrowse configuration comes here
            -- or leave it empty to use the default settings
            -- refer to the configuration section below
        },
        terminal = {

        },
        lazygit = {}
    },
    keys = {
        { "<leader>gB", function() Snacks.gitbrowse() end,       desc = "Git Browse" },
        { "<C-t>",      function() Snacks.terminal.toggle() end, desc = "Toggle Terminal" },
        { "<leader>lg", function() Snacks.lazygit() end,         desc = "Lazy Git" }
    }
}

return {
    'echasnovski/mini.nvim',
    version = '*',
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' },
    config = function()
        require('mini.surround').setup()
        require('mini.ai').setup()
        require('mini.comment').setup()
        -- require('mini.files').setup()
        require('mini.icons').setup()
    end
}

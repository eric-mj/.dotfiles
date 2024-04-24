function ColorMyPencils(color)
    color = color or "catppuccin-macchiato"
    vim.cmd.colorscheme(color)
    vim.api.nvim_set_hl(0, 'LineNr', { fg = "white" })
end

return

{
    "catppuccin-macchiato/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
        require('catppuccin').setup({
            disable_background = true,
            styles = {
                italic = false,
            },
        })

        vim.cmd("colorscheme catppuccin")

        ColorMyPencils()
    end
}

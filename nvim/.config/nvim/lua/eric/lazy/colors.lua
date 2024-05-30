function ColorMyPencils(color)
    color = color or "catppuccin-macchiato"
    vim.cmd.colorscheme(color)
    vim.api.nvim_set_hl(0, 'LineNr', { fg = "white" })
end

return {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
        require("catppuccin").setup({
            flavour = "macchiato", -- latte, frappe, macchiato, mocha
        })
        vim.cmd.colorscheme("catppuccin-macchiato")
        vim.api.nvim_set_hl(0, 'LineNr', { fg = "white" })
    end
}

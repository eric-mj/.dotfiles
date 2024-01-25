
function ColorMyPencils(color)
	color = color or "catppuccin-macchiato"
	vim.cmd.colorscheme(color)
    vim.api.nvim_set_hl(0, 'LineNr', { fg = "white"} )
end

ColorMyPencils()

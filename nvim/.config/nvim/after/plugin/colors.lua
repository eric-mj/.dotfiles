
function ColorMyPencils(color)
	color = color or "catppuccin"
	vim.cmd.colorscheme(color)
    vim.api.nvim_set_hl(0, 'LineNr', { fg = "white"} )
end

ColorMyPencils()

require("eric")
require("lualine").setup()
require('telescope').load_extension('fzf')
vim.o.termguicolors = true
vim.o.winborder = "rounded"

-- [[rust-analyzer]]
-- Fix for https://github.com/neovim/neovim/issues/30985 whereby rust-analyzer
-- constantly lags user input with the message "server cancelled the request".
-- https://github.com/neovim/neovim/issues/30985#issuecomment-2447329525
for _, method in ipairs({ 'textDocument/diagnostic', 'workspace/diagnostic' }) do
    local default_diagnostic_handler = vim.lsp.handlers[method]
    vim.lsp.handlers[method] = function(err, result, context, config)
        if err ~= nil and err.code == -32802 then
            return
        end
        return default_diagnostic_handler(err, result, context, config)
    end
end

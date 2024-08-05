return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-cmdline",
        "hrsh7th/nvim-cmp",
        "L3MON4D3/LuaSnip",
        "saadparwaiz1/cmp_luasnip",
        "j-hui/fidget.nvim",
    },

    vim.lsp.inlay_hint.enable(true),
    config = function()
        local cmp = require('cmp')
        local cmp_lsp = require("cmp_nvim_lsp")
        local capabilities = vim.tbl_deep_extend(
            "force",
            {},
            vim.lsp.protocol.make_client_capabilities(),
            cmp_lsp.default_capabilities())

        require("fidget").setup({})
        require("mason").setup()
        require("mason-lspconfig").setup({
            ensure_installed = {
                "lua_ls",
                "rust_analyzer",
                "gopls",
            },
            handlers = {
                function(server_name) -- default handler (optional)
                    require("lspconfig")[server_name].setup {
                        capabilities = capabilities,
                        settings = {
                            ["rust-analyzer"] = {
                                diagnostics = {
                                    disabled = {
                                        "needless_return",
                                    },
                                },
                            },
                        },
                    }
                end,

                ["lua_ls"] = function()
                    local lspconfig = require("lspconfig")
                    lspconfig.lua_ls.setup {
                        capabilities = capabilities,
                        settings = {
                            Lua = {
                                runtime = { version = "Lua 5.1" },
                                diagnostics = {
                                    globals = { "vim", "it", "describe", "before_each", "after_each" },
                                }
                            }
                        }
                    }
                end,
            }
        })

        local cmp_select = { behavior = cmp.SelectBehavior.Select }

        cmp.setup({
            snippet = {
                expand = function(args)
                    require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
                end,
            },
            mapping = cmp.mapping.preset.insert({
                ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
                ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
                ['<C-y>'] = cmp.mapping.confirm({ select = true }),
                ["<C-Space>"] = cmp.mapping.complete(),
            }),
            sources = cmp.config.sources({
                { name = 'nvim_lsp' },
                { name = 'luasnip' }, -- For luasnip users.
                { name = 'buffer' },
            }
            )
        })

        vim.diagnostic.config({
            -- update_in_insert = true,
            float = {
                focusable = false,
                style = "minimal",
                border = "rounded",
                source = "always",
                header = "",
                prefix = "",
            },
        })
        local ls = require "luasnip"
        vim.snippet.expand = ls.lsp_expand

        vim.snippet.active = function(filter)
            filter = filter or {}
            filter.direction = filter.direction or 1

            if filter.direction == 1 then
                return ls.expand_or_jumpable()
            else
                return ls.jumpable(filter.direction)
            end
        end

        vim.snippet.jump = function(direction)
            if direction == 1 then
                if ls.expandable() then
                    return ls.expand_or_jump()
                else
                    return ls.jumpable(1) and ls.jump(1)
                end
            else
                return ls.jumpable(-1) and ls.jump(-1)
            end
        end

        vim.keymap.set({ "i", "s" }, "<c-k>", function()
            return vim.snippet.active { direction = 1 } and vim.snippet.jump(1)
        end, { silent = true })
        vim.keymap.set({ "i", "s" }, "<c-j>", function()
            return vim.snippet.active { direction = -1 } and vim.snippet.jump(-1)
        end, { silent = true })
        vim.cmd [[autocmd BufWritePre * lua vim.lsp.buf.format()]]
    end
}

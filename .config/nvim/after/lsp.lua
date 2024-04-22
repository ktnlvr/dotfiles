local on_attach = function(_, bufnr)
	vim.lsp.inlay_hint.enable(bufnr)

    local bufmap = function(keys, func) {
        vim.keymap.set('n', keys, func, { buffer = bufnr })
    }

    bufmap('<leader>r', vim.lsp.buf.rename)

	bufmap('<leader>a', vim.lsp.buf.code_action, { buffer = buffer })
	
	bufmap('gd', vim.lsp.buf.definition)
	bufmap('gD', vim.lsp.buf.declaration)
	bufmap('gI', vim.lsp.buf.implementation)
	bufmap('<leader>D', vim.lsp.buf.type_definition)
	bufmap('gr', require('telescope.builtin').lsp_references)
	bufmap('<leader>s', require('telescope.builtin').lsp_document_symbols)

	bufmap('K', function() 
		vim.diagnostic.open_float()
	end)

	vim.api.nvim_buf_create_user_command(bufnr, "Format", function(_)
		vim.lsp.buf.format()
	end, {})
end

local caps = vim.lsp.protocol.make_client_capabilities()
require('lspconfig').lua_ls.setup {
	on_attach = on_attach,
	capabilities = caps,
	Lua = {
		workspace = { checkThirdParty = false },
		telemetry = { enable = false },
	},
}

require('lspconfig').rust_analyzer.setup {
	on_attach = on_attach,
    settings = {
        ["rust-analyzer"] = {
            imports = {
                granularity = {
                    group = "module",
                },
                prefix = "self",
            },
            cargo = {
                buildScripts = {
                    enable = true,
                },
            },
            procMacro = {
                enable = true
            },
        }
    }
}

require('mason').setup {
	PATH = "append",
}

return {
	on_attach = function(a, bufnr)
		require("lsp_signature").on_attach(a, bufnr)
		--require'virtualtypes'.on_attach(a, bufnr)

		local opts = { noremap = false, silent = true }

		local map = function(key, cmd)
			vim.api.nvim_buf_set_keymap(bufnr, "n", "<Leader>s" .. key, "<cmd>lua " .. cmd .. "<CR>", opts)
		end

		local map_lsp = function(key, cmd)
			map(key, "vim." .. cmd)
		end

		map_lsp("<leader>ca", "lsp.buf.code_action()")
		map_lsp("<leader>ck", "lsp.buf.hover()")
		map_lsp("<leader>cd", "lsp.buf.declaration()")
		-- map_lsp("d", "lsp.buf.definition()")
		-- map_lsp("i", "lsp.buf.implementation()")
		map_lsp("<leader>cs", "lsp.buf.signature_help()")
		map_lsp("<leader>ct", "lsp.buf.type_definition()")
		map_lsp("<leader>cf", "lsp.buf.formatting()")
    

		local map_tel = function(key, cmd)
			map(key, 'require"telescope.builtin".' .. cmd)
		end

--		 map_tel("r", "lsp_references()")
		map_tel("<leader>cb", "lsp_document_diagnostics()")
		map_tel("<leader>ci", "lsp_implementations()")
		--map_tel("<leader>cd", "lsp_definitions()")
		map_tel("<leader>cs", "lsp_document_symbols()")
	end,
}

return {
	'neovim/nvim-lspconfig',
	dependencies = {
		'mason-org/mason.nvim',
		'mason-org/mason-lspconfig.nvim',
	},
	config = function()
		local lspconfig = require('lspconfig')
		local mason = require('mason')
		local mason_lspconfig = require('mason-lspconfig')


		mason.setup({
			ui = {
				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗"
				}
			}
		})

		local servers = { 'pylsp', 'lua_ls', 'clangd' }
		mason_lspconfig.setup({
			ensure_installed = servers,
		})

		local opts = { noremap = true, silent = true }
		vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, opts)
		vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, opts)


		local on_attach = function(client, bufnr)
			local bufopts = { noremap = true, silent = true, buffer = bufnr }
			vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
			vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
			vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
			vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
			vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
			vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
			vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, bufopts)
			vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
			vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, bufopts)
			vim.keymap.set('n', '<leader>r', vim.lsp.buf.rename, bufopts)
			vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, bufopts)
			vim.keymap.set('n', '<leader>F', function()
				vim.lsp.buf.format({ bufnr = bufnr })
			end, bufopts)
		end


		-- Comb through individual setup for each lsp
		for _, server_name in ipairs(servers) do
			local server_setup = {}
			local success, loaded_config = pcall(require, 'lsp.' .. server_name)
			if success and loaded_config and loaded_config.config then
				server_setup = loaded_config.config
			else
				print('Warning: Server config for ' .. server_name .. ' not found in lua/lsp/' .. server_name .. '.lua')
			end
			local config = vim.tbl_deep_extend(
				'force',
				{ on_attach = on_attach }, -- Start with the common on_attach
				server_setup   -- Add server-specific config
			)
			lspconfig[server_name].setup(config)
		end
	end,
}

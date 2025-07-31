return {
	{
		"stevearc/conform.nvim",
		-- Load Conform only when a buffer is read, or when a file type is set.
		-- This ensures it's available when you start editing a file.
		event = { "BufReadPost", "BufNewFile" },
		opts = {
			-- Options passed to conform.setup()
			formatters_by_ft = {
				-- general
				["*"] = { --[[ "codespell", ]]
					"injected",
				},
				["_"] = { "trim_whitespace" },

				-- biome filetypes
				javascript = { "biome" },
				typescript = { "biome" },
				javascriptreact = { "biome" },
				json = { "biome" },
				jsonc = { "biome" },

				-- prettier filetypes
				typescriptreact = { "prettier" },
				svelte = { "prettier" },
				css = { "prettier" },
				html = { "prettier" },
				yaml = { "prettier" },
				markdown = { "prettier" },
				graphql = { "prettier" },
				vue = { "prettier" },

				lua = { "stylua" },
				python = {
					"pyfix_imports",
					"ruff_fix",
					"ruff_organize_imports",
					"ruff_format",
				},
				java = { "astyle" },
				rust = { "rustfmt" },
				sh = { "shfmt" },
				bash = { "shfmt" },
				cpp = { "clang_format" },
				go = { "gofmt", "goimports" },
				cmake = { "cmake_format" },
				typst = { "typstfmt" },
			},

			-- This function runs on save
			format_on_save = function(bufnr)
				local function myCallback(err)
					if err then
						-- Use vim.notify(err, vim.log.levels.ERROR) for error notifications
						vim.notify("Error during formatting: " .. tostring(err), vim.log.levels.ERROR)
					else
						vim.notify("Formatting completed successfully.", vim.log.levels.INFO)
					end
				end

				-- Disable with a global or buffer-local variable
				if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
					return
				end
				-- Disable autoformat for files in a certain path
				local bufname = vim.api.nvim_buf_get_name(bufnr)
				if bufname:match("/node_modules/") then
					return
				end
				-- Call conform.format with options and callback
				require("conform").format({ bufnr = bufnr, timeout_ms = 1000, lsp_fallback = true }, myCallback)
				-- Return nil here because the callback is passed directly to conform.format
				-- The original code was returning a table and then calling myCallback(), which is not how conform.format expects it.
				return nil
			end,
		},
		config = function()
			-- These commands and keymaps need to be set up *after* conform is loaded and configured.
			-- This `config` function runs exactly at that point.
			local conform = require("conform")

			conform.setup({
				formatters = {
					pyfix_imports = {
						command = "pyfix-imports",
						args = { "$FILENAME" },
						stdin = true,
						cwd = require("conform.util").root_file({ "requirements.txt", "pyproject.toml", ".git" }),
					},
				},
			})
			-- Set global variable after conform is loaded
			vim.g.disable_autoformat = true

			-- Define user command "Format"
			vim.api.nvim_create_user_command("Format", function()
				local function myCallback(err)
					if err then
						vim.notify("Error during formatting: " .. tostring(err), vim.log.levels.ERROR)
					else
						vim.notify("Formatting completed successfully.", vim.log.levels.INFO)
					end
				end
				require("conform").format({
					lsp_fallback = true,
					async = false, -- usually `true` for non-blocking, but your original had `false`
					timeout_ms = 1000,
				}, myCallback) -- Pass the callback directly
			end, {
				desc = "format",
			})

			-- Define user command "FormatToggle"
			vim.api.nvim_create_user_command("FormatToggle", function()
				if vim.b.disable_autoformat or vim.g.disable_autoformat then
					-- Prioritize buffer-local for toggle, but also set global for convenience
					vim.b.disable_autoformat = false
					vim.g.disable_autoformat = false
					vim.notify("AutoFormat Enabled", vim.log.levels.INFO)
				else
					vim.b.disable_autoformat = true
					vim.g.disable_autoformat = true
					vim.notify("AutoFormat Disabled", vim.log.levels.INFO)
				end
			end, {
				desc = "Toggle autoformat-on-save",
			})

			-- Define keymap
			-- vim.keymap.set("n", "<Leader>lf", "<Cmd>silent Format<CR>", { desc = "Format the current file", silent = true })
			vim.keymap.set("n", "<M-S-f>", "<Cmd>silent Format<CR>",
				{ desc = "Format current file (Alt+Shift+F)", silent = true })
		end,
	},
}

return {
		"git@github.com:github/copilot.vim.git",
		config = function()
				vim.g.copilot_filetypes = { ["*"] = false }
				vim.cmd('Copilot disable')
				local copilot_enabled = false
				vim.api.nvim_create_user_command("ToggleCopilot", function()
						if copilot_enabled then
								vim.cmd("Copilot disable")
								print("Copilot disabled")
								copilot_enabled = false
						else
								vim.cmd("Copilot enable")
								print("Copilot disabled")
								copilot_enabled = true
						end
				end, {nargs = 0})
				vim.keymap.set('', '<leader>cp', ':ToggleCopilot', { noremap = true, silent = true })
		end
}

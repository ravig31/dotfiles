return {
		"Pocco81/auto-save.nvim",
	  cond = not vim.g.vscode,
		config = function()
		local condition = function (buf)
				if vim.bo[buf].filetype == "harpoon" then
						return false
				end
				return true
		end
		require("auto-save").setup {
				condition = condition,
		}
	end,
}


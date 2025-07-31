return {
  "folke/noice.nvim",
	cond = not vim.g.vscode,
  event = "VeryLazy",
  opts = {
  },
  dependencies = {
    "MunifTanjim/nui.nvim",
    }
}

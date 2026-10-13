return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  opts = {
    ensure_installed = {"c", "lua", "vim", "vimdoc", "cpp", "python", "java", "javascript", "html", "bash"},
    highlight = { enable = true },
    indent = { enable = true },
  },
  config = function(_, opts)
    require("nvim-treesitter").setup(opts)
  end,
}

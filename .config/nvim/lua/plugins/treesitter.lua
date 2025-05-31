return {
    "nvim-treesitter/nvim-treesitter",
		dependencies = {
		},
    build = ":TSUpdate",
    config = function () 
      local configs = require("nvim-treesitter.configs")
      configs.setup({
          ensure_installed = { "c", "lua", "vim", "vimdoc", "cpp", "python", "java", "javascript", "html", "bash"},
          sync_install = true,
          auto_install = true,
          autotage = { enable = true },
          highlight = { enable = true },
          indent = { enable = true },
        })
    end
 }

return {
  "nvim-treesitter/nvim-treesitter",
  branch = "master",
  lazy = false,
  build = ":TSUpdate",
  config = function()
    local config = require("nvim-treesitter.configs")
    config.setup({
      ensure_installed = { 
            "lua",
            "vim",
            "vimdoc",
            "javascript",
            "typescript",
            "java",
            "json",
            "bash",
            "angular",
            "dockerfile",
            "yaml",
            "sql",
            "markdown",
            "markdown_inline",
            "astro",
      },
      highlight = { enable = true },
      indent = { enable = true }
    })
  end
}

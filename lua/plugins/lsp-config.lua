return {
  {
      "mason-org/mason.nvim",
      opts = {
          ui = {
              icons = {
                  package_installed = "✓",
                  package_pending = "➜",
                  package_uninstalled = "✗"
              }
          }
      },
      config = function()
        require("mason").setup()
      end
  },
  {
      "mason-org/mason-lspconfig.nvim",
      dependencies = {
          { "mason-org/mason.nvim", opts = {} },
          "neovim/nvim-lspconfig",
      },
      config = function()
        require("mason-lspconfig").setup({
          ensure_installed = { 
                "lua_ls",
                "html",
                "cssls",
                "ts_ls",
                "angularls",
                "eslint",
                "tailwindcss",
                "jdtls",
                "lemminx",
                "yamlls",
                "jsonls",
          },
        })
      end
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      local lspconfig = require("lspconfig")
      lspconfig.lua_ls.setup({})
      lspconfig.html.setup({})
      lspconfig.cssls.setup({})
      lspconfig.ts_ls.setup({})
      lspconfig.angularls.setup({})
      lspconfig.eslint.setup({})
      lspconfig.jdtls.setup({})
      lspconfig.lemminx.setup({})
      lspconfig.yamlls.setup({})
      lspconfig.jsonls.setup({})
    end
  },
}

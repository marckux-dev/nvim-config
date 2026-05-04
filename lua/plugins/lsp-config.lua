return {
  {
    "mason-org/mason.nvim",
    config = function()
      require("mason").setup()
    end,
  },
  {
    "mason-org/mason-lspconfig.nvim",
    dependencies = { "mason-org/mason.nvim", "neovim/nvim-lspconfig" },
    config = function()
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      require("mason-lspconfig").setup({
        ensure_installed = {
          "lua_ls",
          "bashls",
          "html",
          "cssls",
          "ts_ls",
          "angularls",
          "eslint",
          "jdtls", -- Keep this here so Mason installs it
          "tailwindcss",
          "lemminx",
          "yamlls",
          "jsonls",
          "astro",
          "rust_analyzer",
          "pyright",
        },

        handlers = {
          -- Default handler for all servers *except* jdtls and lua_ls
          function(server_name)
            require("lspconfig")[server_name].setup({
              capabilities = capabilities,
            })
          end,

          -- Specific handler for bash / zsh
          ["bashls"] = function()
            require("lspconfig").bashls.setup({
              capabilities = capabilities,
              filetypes = { "sh", "zsh" },
            })
          end,

          -- Custom handler for lua_ls (as in your old config)
          ["lua_ls"] = function()
            require("lspconfig").lua_ls.setup({
              capabilities = capabilities,
              settings = {
                Lua = {
                  runtime = { version = "LuaJIT" },
                  diagnostics = { globals = { "vim" } },
                  workspace = { checkThirdParty = false },
                },
              },
            })
          end,

          -- Python LSP with venv detection
          ["pyright"] = function()
            require("lspconfig").pyright.setup({
              capabilities = capabilities,
              settings = {
                pyright = { autoImportCompletion = true },
                python = {
                  analysis = {
                    autoSearchPaths = true,
                    diagnosticMode = "openFilesOnly",
                    useLibraryCodeForTypes = true,
                    typeCheckingMode = "basic",
                  },
                },
              },
              on_new_config = function(config, root_dir)
                -- Detect .venv, venv, or env in project root
                local venv_paths = { ".venv", "venv", "env", ".env" }
                for _, venv in ipairs(venv_paths) do
                  local venv_python = root_dir .. "/" .. venv .. "/bin/python"
                  if vim.fn.executable(venv_python) == 1 then
                    config.settings.python.pythonPath = venv_python
                    return
                  end
                end
                -- Fall back to system python
                config.settings.python.pythonPath = vim.fn.exepath("python3") or vim.fn.exepath("python") or "python"
              end,
            })
          end,

          -- Custom handler for jdtls: DO NOTHING.
          -- This prevents mason-lspconfig from starting it.
          -- nvim-jdtls (in its own file) will handle it.
          ["jdtls"] = function()
            -- Intentionally empty
          end,
        },
      })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      -- Keymaps
      vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
      vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
      vim.keymap.set({ "n", "v" }, "<leader>ea", vim.lsp.buf.code_action, { desc = "Code Actions" })
      vim.keymap.set("n", "<leader>ee", vim.diagnostic.open_float, { desc = "Show Diagnostic" })
      vim.keymap.set("n", "<leader>er", vim.lsp.buf.rename, { desc = "Rename symbol" })
    end,
  },
}

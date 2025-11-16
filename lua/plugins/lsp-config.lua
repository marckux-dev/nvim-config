-- path: ./lua/plugins/lsp-config.lua
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
      require("mason-lspconfig").setup({
        ensure_installed = {
          "lua_ls",
          "html",
          "cssls",
          "ts_ls",
          "angularls",
          "eslint",
          "jdtls",
          "tailwindcss",
          "lemminx",
          "yamlls",
          "jsonls",
          "astro",
        },
      })
    end,
  },
  -- ✅ no config block needed here
  { "mfussenegger/nvim-jdtls" },
  {
    "neovim/nvim-lspconfig",
    config = function()
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      -- Common LSPs
      local servers = {
        lua_ls = {
          settings = {
            Lua = {
              runtime = { version = "LuaJIT" },
              diagnostics = { globals = { "vim" } },
              workspace = { checkThirdParty = false },
            },
          },
        },
        html = {},
        cssls = {},
        ts_ls = {},
        angularls = {},
        eslint = {},
        lemminx = {},
        yamlls = {},
        jsonls = {},
      }

      for name, opts in pairs(servers) do
        opts.capabilities = capabilities
        vim.lsp.config(name, opts)
        vim.lsp.enable(name)
      end

      -- Java (special)

vim.api.nvim_create_autocmd("FileType", {
  pattern = "java",
  callback = function()
    local jdtls = require("jdtls")
    local root_markers = { "gradlew", "mvnw", ".git" }
    local root_dir = require("jdtls.setup").find_root(root_markers)
    local home = os.getenv("HOME")
    local lombok_path = home .. "/.local/share/lombok.jar"
    local workspace_dir = vim.fn.expand("~/.cache/jdtls-workspace/") .. vim.fn.fnamemodify(root_dir, ":p:h:t")

    if vim.fn.filereadable(lombok_path) == 0 then
      vim.notify("⚠️ Lombok jar not found at " .. lombok_path, vim.log.levels.WARN)
    end

    local config = {
      cmd = {
        vim.fn.expand("~/.local/share/nvim/mason/bin/jdtls"),
        "-javaagent:" .. lombok_path,
        "-Xbootclasspath/a:" .. lombok_path,
        "-data", workspace_dir,
      },
      root_dir = root_dir,
      capabilities = require("cmp_nvim_lsp").default_capabilities(),
      settings = {
        java = {
          configuration = {
            runtimes = {
              {
                name = "JavaSE-21",
                path = "/usr/lib/jvm/java-21-openjdk-amd64",
              },
            },
          },
        },
      },
    }

    vim.notify("🚀 Starting JDTLS with Lombok at " .. lombok_path)
    jdtls.start_or_attach(config)
  end,
})




      -- Keymaps
      vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
      vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
      vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, {})
      vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show Diagnostic"})
    end,
  },
}


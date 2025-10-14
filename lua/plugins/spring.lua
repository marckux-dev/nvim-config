return {
  -- 🧠 Core Java + Spring Boot ecosystem
  {
    "nvim-java/nvim-java",
    ft = "java",
    dependencies = {
      -- Async helpers
      "nvim-java/lua-async-await",

      -- Core and extensions
      "nvim-java/nvim-java-core",
      "nvim-java/nvim-java-test",
      "nvim-java/nvim-java-dap",
      "nvim-java/nvim-java-refactor",

      -- Spring Boot integration
      "nvim-java/spring-boot.nvim",

      -- Support plugins
      "mfussenegger/nvim-dap",       -- Debugging
      "rcarriga/nvim-dap-ui",        -- DAP UI (optional but recommended)
      "neovim/nvim-lspconfig",       -- LSP base
      "williamboman/mason.nvim",     -- LSP/DAP installers
      "williamboman/mason-lspconfig.nvim",
    },
    config = function()
      ------------------------------------------------------------------
      -- 🚀 Initialize core Java and Spring support
      ------------------------------------------------------------------
      require("java").setup()
      require("spring_boot").setup()
      require("java.dap").setup()

      ------------------------------------------------------------------
      -- 🐞 Optional: nvim-dap UI integration
      ------------------------------------------------------------------
      local dap, dapui = require("dap"), require("dapui")
      dapui.setup()
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end

      ------------------------------------------------------------------
      -- 🧩 Keymaps for Spring Boot / Java development
      ------------------------------------------------------------------
      local map = vim.keymap.set
      map("n", "<leader>sr", ":SpringBootRun<CR>", { desc = "Run Spring Boot app" })
      map("n", "<leader>ss", ":SpringBootStop<CR>", { desc = "Stop Spring Boot app" })
      map("n", "<leader>sl", ":SpringBootLog<CR>", { desc = "Show Spring Boot logs" })
      map("n", "<leader>tj", ":JavaTestRunCurrentClass<CR>", { desc = "Run Java class tests" })
      map("n", "<leader>tm", ":JavaTestRunCurrentMethod<CR>", { desc = "Run Java method test" })
      map("n", "<leader>db", ":DapToggleBreakpoint<CR>", { desc = "Toggle breakpoint" })
      map("n", "<leader>dc", ":DapContinue<CR>", { desc = "Start/Continue debug" })
      map("n", "<leader>du", ":lua require('dapui').toggle()<CR>", { desc = "Toggle Debug UI" })
    end,
  },
}


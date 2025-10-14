local M = {}

function M.setup(capabilities)
  local home = vim.fn.expand("~")
  local lombok = home .. "/.local/share/nvim/lombok.jar"
  local jdtls_dir = home .. "/.local/share/nvim/mason/packages/jdtls"
  local launcher = vim.fn.glob(jdtls_dir .. "/plugins/org.eclipse.equinox.launcher_*.jar")
  local config_dir = jdtls_dir .. "/config_linux" -- adjust for mac/win

  require("lspconfig").jdtls.setup({
    cmd = {
      "java",
      "-javaagent:" .. lombok,
      "-Declipse.application=org.eclipse.jdt.ls.core.id1",
      "-Dosgi.bundles.defaultStartLevel=4",
      "-Declipse.product=org.eclipse.jdt.ls.core.product",
      "-Dlog.protocol=true",
      "-Dlog.level=ALL",
      "-Xms1g",
      "--add-modules=ALL-SYSTEM",
      "--add-opens", "java.base/java.util=ALL-UNNAMED",
      "--add-opens", "java.base/java.lang=ALL-UNNAMED",
      "-jar", launcher,
      "-configuration", config_dir,
      "-data", home .. "/.cache/jdtls/workspace",
    },
    capabilities = capabilities,
    root_dir = require("lspconfig.util").root_pattern("pom.xml", "build.gradle", ".git"),
  })
end

return M


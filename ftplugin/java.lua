local jdtls = require("jdtls")
local home = os.getenv("HOME")

-- 1. DEBUG: Print to messages to prove this file ran
vim.notify("🛠️ Custom Java Config Loaded!", vim.log.levels.INFO)

-- 2. Locate Paths
local mason_base = vim.fn.stdpath("data") .. "/mason" -- Cambiado de mason_path a mason_base
local jdtls_path = mason_base .. "/packages/jdtls"
local lombok_path = vim.fn.expand("~/.local/share/lombok/lombok.jar")
-- Validación de seguridad para Lombok
if vim.fn.filereadable(lombok_path) == 0 then
  vim.notify("❌ Lombok JAR no encontrado en: " .. lombok_path, vim.log.levels.ERROR)
end
local config_path = jdtls_path .. "/config_linux"
-- Manejo seguro del launcher
local launcher_pattern = jdtls_path .. "/plugins/org.eclipse.equinox.launcher_*.jar"
local launcher_path = vim.fn.glob(launcher_pattern)
if launcher_path == "" then
  vim.notify("❌ JDTLS Launcher no encontrado en Mason", vim.log.levels.ERROR)
else
  launcher_path = string.gsub(launcher_path, "\n", "")
end

-- ========================================================
-- 3. BUNDLES (Debug & Testing) - RUTA CORREGIDA
-- ========================================================
local bundles = {}

-- 1. DEBUG ADAPTER: Apuntamos a la carpeta share de Mason
local debug_jar_pattern = mason_base .. "/share/java-debug-adapter/com.microsoft.java.debug.plugin-*.jar"
local debug_jar = vim.fn.glob(debug_jar_pattern, true)
if debug_jar ~= "" then
  table.insert(bundles, debug_jar)
end

-- 2. JAVA TEST (JUnit): Apuntamos a la carpeta share de Mason
local test_jar_pattern = mason_base .. "/share/java-test/*.jar"
local test_jars = vim.fn.glob(test_jar_pattern, true)
if test_jars ~= "" then
  for _, jar in ipairs(vim.fn.split(test_jars, "\n")) do
    table.insert(bundles, jar)
  end
end
---

-- 3. NOTIFICACIÓN DE DIAGNÓSTICO
vim.schedule(function()
  if #bundles == 0 then
    vim.notify("⚠️ ERROR CRÍTICO: Bundles es 0. Revisa: " .. mason_base .. "/share/", vim.log.levels.ERROR)
  else
    vim.notify("✅ JDTLS Bundles cargados: " .. #bundles, vim.log.levels.INFO)
  end
end)

-- 4. Locate Java (SDKMAN! Integration)
local java_bin = home .. "/.sdkman/candidates/java/current/bin/java"
if vim.fn.executable(java_bin) ~= 1 then
  java_bin = "java"
end

-- 4. Define Workspace
local root_markers = { "gradlew", "mvnw", ".git" }
local root_dir = require("jdtls.setup").find_root(root_markers)
if not root_dir then
  return
end
local workspace_dir = vim.fn.expand("~/.cache/jdtls-workspace/") .. vim.fn.fnamemodify(root_dir, ":p:h:t")

-- 6. The Command
local cmd = {
  java_bin,
  "-javaagent:" .. lombok_path,
  "-Declipse.application=org.eclipse.jdt.ls.core.id1",
  "-Dosgi.bundles.defaultStartLevel=4",
  "-Declipse.product=org.eclipse.jdt.ls.core.product",
  "-Dosgi.checkConfiguration=true",
  "-Dosgi.sharedConfiguration.area=" .. config_path,
  "-Dosgi.sharedConfiguration.area.readOnly=true",
  "-Dosgi.configuration.cascaded=true",
  "-Xms4g",

  "--add-modules=ALL-SYSTEM",
  "--add-opens",
  "java.base/java.util=ALL-UNNAMED",
  "--add-opens",
  "java.base/java.lang=ALL-UNNAMED",
  "--add-opens",
  "java.base/sun.nio.ch=ALL-UNNAMED",
  "--add-opens",
  "java.base/sun.net=ALL-UNNAMED",
  "--add-opens",
  "java.base/sun.io=ALL-UNNAMED",

  "-jar",
  launcher_path,
  "-configuration",
  config_path,
  "-data",
  workspace_dir,
}

local config = {
  cmd = cmd,
  root_dir = root_dir,
  capabilities = require("cmp_nvim_lsp").default_capabilities(),
  init_options = {
    bundles = bundles,
  },
}

jdtls.start_or_attach(config)
jdtls.setup_dap({ hotcodereplace = "auto" })

-- =========================
-- JDTLS Keymaps (Java only)
-- =========================
local wk = require("which-key")
local bufopts = { noremap = true, silent = true, buffer = 0 }
local function with_desc(desc)
  return vim.tbl_extend("force", bufopts, { desc = desc })
end

-- Imports
vim.keymap.set(
  "n", "<leader>jo",
  jdtls.organize_imports, with_desc("Organize imports"))
-- Refactors
vim.keymap.set(
  "n", "<leader>jv",
  jdtls.extract_variable, with_desc("Extract variable"))
vim.keymap.set(
  "n", "<leader>jc",
  jdtls.extract_constant, with_desc("Extract constant"))
vim.keymap.set(
  "n", "<leader>jm",
  jdtls.extract_method, with_desc("Extract method"))

-- Tests (JUnit / Spring)
vim.keymap.set(
  "n", "<leader>jt",
  jdtls.test_nearest_method, with_desc("Test nearest method"))
vim.keymap.set(
  "n", "<leader>jT",
  jdtls.test_class, with_desc("Test Class"))

-- Project
vim.keymap.set(
  "n", "<leader>ju",
  jdtls.update_project_config, with_desc("Update project config"))

-- Visual mode refactors
vim.keymap.set("v", "<leader>jv", function()
  jdtls.extract_variable(true)
end, with_desc("Extract variable"))

vim.keymap.set("v", "<leader>jc", function()
  jdtls.extract_constant(true)
end, with_desc("Extract constant"))

vim.keymap.set("v", "<leader>jm", function()
  jdtls.extract_method(true)
end, with_desc("Extract method"))

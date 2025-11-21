local jdtls = require("jdtls")

-- 1. DEBUG: Print to messages to prove this file ran
vim.notify("🛠️ Custom Java Config Loaded!", vim.log.levels.INFO)

-- 2. Locate Paths
local mason_path = vim.fn.stdpath("data") .. "/mason/packages/jdtls"
local lombok_path = mason_path .. "/lombok.jar"
local config_path = mason_path .. "/config_linux"
local launcher_path = vim.fn.glob(mason_path .. "/plugins/org.eclipse.equinox.launcher_*.jar")
launcher_path = string.gsub(launcher_path, "\n", "")

-- 3. Locate Java (Fix for Error 13)
local java_bin = "java"
if vim.fn.executable("/usr/lib/jvm/java-21-openjdk-amd64/bin/java") == 1 then
	java_bin = "/usr/lib/jvm/java-21-openjdk-amd64/bin/java"
elseif vim.fn.executable("/usr/lib/jvm/java-17-openjdk-amd64/bin/java") == 1 then
	java_bin = "/usr/lib/jvm/java-17-openjdk-amd64/bin/java"
end

-- 4. Define Workspace
local root_markers = { "gradlew", "mvnw", ".git" }
local root_dir = require("jdtls.setup").find_root(root_markers)
if not root_dir then
	return
end
local workspace_dir = vim.fn.expand("~/.cache/jdtls-workspace/") .. vim.fn.fnamemodify(root_dir, ":p:h:t")

-- 5. FORCE KILL EXISTING CLIENTS (The conflict solver)
-- If nvim-lspconfig started a client, this kills it so we can start ours.
local existing_client = vim.lsp.get_active_clients({ name = "jdtls" })[1]
if existing_client then
	vim.lsp.stop_client(existing_client.id)
	vim.notify("💀 Killed default JDTLS client to replace with Lombok version", vim.log.levels.WARN)
end

-- 6. The Command
local cmd = {
	java_bin,
	"-Declipse.application=org.eclipse.jdt.ls.core.id1",
	"-Dosgi.bundles.defaultStartLevel=4",
	"-Declipse.product=org.eclipse.jdt.ls.core.product",
	"-Dosgi.checkConfiguration=true",
	"-Dosgi.sharedConfiguration.area=" .. config_path,
	"-Dosgi.sharedConfiguration.area.readOnly=true",
	"-Dosgi.configuration.cascaded=true",
	"-Xms1g",
	"--add-modules=ALL-SYSTEM",
	"--add-opens",
	"java.base/java.util=ALL-UNNAMED",
	"--add-opens",
	"java.base/java.lang=ALL-UNNAMED",
	-- ✅ LOMBOK
	"-javaagent:" .. lombok_path,
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
}

jdtls.start_or_attach(config)

-- path: ~/.config/nvim/lua/plugins/jdtls.lua
return {
	"mfussenegger/nvim-jdtls",

	ft = { "java" }, -- load only for Java files
	config = function()
		local jdtls = require("jdtls")
		local home = os.getenv("HOME")
		local mason_path = home .. "/.local/share/nvim/mason/packages/jdtls"
		local lombok_path = home .. "/.local/share/lombok.jar"
		local config_path = mason_path .. "/config_linux"
		local launcher_path = mason_path .. "/plugins/org.eclipse.equinox.launcher_1.6.900.v20240613-2009.jar"

		-- Detect project root (gradle, maven or git)
		local root_markers = { "gradlew", "mvnw", ".git" }
		local root_dir = require("jdtls.setup").find_root(root_markers)

		-- Create a unique workspace per project
		local workspace_dir = vim.fn.expand("~/.cache/jdtls-workspace/") .. vim.fn.fnamemodify(root_dir, ":p:h:t")

		-- Verify Lombok presence
		if vim.fn.filereadable(lombok_path) == 0 then
			vim.notify("⚠️ Lombok jar not found at " .. lombok_path, vim.log.levels.WARN)
		end

		-- Full JDTLS command
		local cmd = {
      "/usr/lib/jvm/java-17-openjdk-amd64/bin/java",
			"-Declipse.application=org.eclipse.jdt.ls.core.id1",
			"-Dosgi.bundles.defaultStartLevel=4",
			"-Declipse.product=org.eclipse.jdt.ls.core.product",
			"-Dosgi.checkConfiguration=true",
			"-Dosgi.sharedConfiguration.area=" .. config_path,
			"-Dosgi.sharedConfiguration.area.readOnly=true",
			"-Dosgi.configuration.cascaded=true",
			"-Xms1g",
			"-javaagent:" .. lombok_path,
			-- "-Xbootclasspath/a:" .. lombok_path,
			"-jar",
			launcher_path,
			"-configuration",
			config_path,
			"-data",
			workspace_dir,
		}

		local capabilities = require("cmp_nvim_lsp").default_capabilities()

		local config = {
			cmd = cmd,
			root_dir = root_dir,
			capabilities = capabilities,
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
}

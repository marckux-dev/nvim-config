-- Tags
vim.api.nvim_create_user_command("MakeTags", "!ctags -R", {})

-- Format HTML with Prettier
vim.api.nvim_create_user_command("FormatHTML", "%!prettier --parser html --print-width=80", { range = true })

-- Angular Generator
vim.api.nvim_create_user_command("NgGen", function(opts)
	local args = opts.args
	local parts = vim.split(args, " ")
	vim.cmd("!ng generate " .. args) -- Run Angular CLI
	if parts[2] then
		vim.cmd("find " .. parts[2] .. "*") -- Try to open generated file
	end
end, { nargs = "+" })

-- Comando para refrescar el diccionario desde Obsidian
vim.api.nvim_create_user_command("ObsidianRefresh", function()
	local script_path = vim.fn.expand("~/.config/nvim/spell/obsidian-refresh-es.sh")

	vim.notify("🔄 Sincronizando diccionario con Obsidian...", vim.log.levels.INFO)

	-- Ejecutar el script de forma asíncrona para no bloquear Neovim
	vim.fn.jobstart({ "bash", script_path }, {
		on_exit = function(_, exit_code)
			if exit_code == 0 then
				vim.notify("✅ Diccionario actualizado y ordenado.", vim.log.levels.INFO)
				-- Forzar recarga del spellfile en Neovim
				vim.cmd("silent! spellundo")
			else
				vim.notify("❌ Error al ejecutar el script de sincronización.", vim.log.levels.ERROR)
			end
		end,
	})
end, { desc = "Ejecuta el script de refresco de diccionario de Obsidian" })

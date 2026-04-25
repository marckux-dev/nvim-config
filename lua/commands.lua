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

-- Comando para crear archivo de test en un proyecto Maven:
vim.api.nvim_create_user_command("MavenTest", function ()
  local src = vim.fn.expand("%:p")
  if not src:match("src/main/java") then
    return vim.notify("No estas en src/main/java", vim.log.levels.ERROR)
  end
  local test = src
    :gsub("src/main/java", "src/test/java")
    :gsub("%.java$", "Test.java")
  if vim.fn.filereadable(test) == 1 then
    return vim.notify("El archivo de Test ya existe", vim.log.levels.ERROR)
  end
  vim.fn.mkdir(vim.fn.fnamemodify(test, ":h"), "p")
  assert(io.open(test, "w")):close()
  vim.notify("Creado: " .. test)
end, {}
)

-- Comando para ejecutar api-test.zsh en el buffer actual si es tipo yml
-- Función para ejecutar el script actual en una terminal abierta
local function ejecutar_yaml_en_terminal()
    -- 1. Comprobar si el archivo es YAML
    if vim.bo.filetype ~= "yaml" then
        print("Operación cancelada: El buffer actual no es un archivo YAML")
        return
    end

    -- 2. Guardar el archivo automáticamente para asegurar que los cambios se apliquen
    vim.cmd('silent w')

    -- 3. Capturar la ruta del archivo actual
    local ruta = vim.fn.expand('%:p')

    -- 4. Buscar un buffer de terminal activo
    local terminal_buf = -1
    for _, buf in ipairs(vim.api.nvim_list_bufs()) do
        if vim.bo[buf].buftype == 'terminal' then
            terminal_buf = buf
            break
        end
    end

    if terminal_buf == -1 then
        print("Error: No hay ninguna terminal abierta para recibir el comando")
        return
    end

    -- 5. Obtener el job_id de ese buffer de terminal
    local job_id = vim.b[terminal_buf].terminal_job_id

    if job_id then
        -- Enviamos 'clear', luego el comando con la ruta, y un 'Enter' (\n)
        -- Usamos 'nombre_de_tu_script' (cámbialo si es necesario)
        local comando = "clear && api-test.zsh -v " .. vim.fn.shellescape(ruta) .. "\n"
        vim.api.nvim_chan_send(job_id, comando)
        print("Script enviado a la terminal...")
    else
        print("No se pudo encontrar el ID del proceso de la terminal")
    end
end

-- 6. Asignar el Keymapping (Ejemplo: Espacio + ry)
-- 'n' significa modo normal
vim.keymap.set('n', '<leader>ty', ejecutar_yaml_en_terminal, { desc = 'Ejecutar script con buffer YAML' })

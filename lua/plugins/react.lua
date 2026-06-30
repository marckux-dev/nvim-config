-- React / TS / JSX development helpers.
-- Plugins: auto-close/rename JSX tags + context-aware comment string.
-- Keymaps: filetype-local LSP refactors + npm runner en tmux.

local react_fts = { "javascript", "javascriptreact", "typescript", "typescriptreact" }

local SHELLS = { zsh = true, bash = true, fish = true, sh = true, dash = true }

-- Devuelve el comando que corre en primer plano en la window "npm" o nil
-- si la window no existe. Si el resultado está en `SHELLS`, la window
-- está libre (prompt esperando).
local function npm_window_command()
  local out = vim.fn.system({
    "tmux", "list-windows", "-F", "#{window_name}\t#{pane_current_command}",
  })
  if vim.v.shell_error ~= 0 then return nil end
  for line in out:gmatch("[^\n]+") do
    local name, cmdline = line:match("^(.-)\t(.+)$")
    if name == "npm" then return cmdline end
  end
  return nil
end

local function send_to_tmux_window(cmd)
  if vim.fn.executable("tmux") ~= 1 or vim.env.TMUX == nil then
    vim.notify("No estoy en una sesión tmux", vim.log.levels.WARN)
    return
  end
  local running = npm_window_command()
  if running and not SHELLS[running] then
    vim.notify(("tmux:npm ocupado (%s) — usa <leader>rk para parar"):format(running),
               vim.log.levels.WARN)
    return
  end
  if running == nil then
    -- La window no existe: créala.
    vim.fn.system({ "tmux", "new-window", "-d", "-n", "npm", "-c", vim.fn.getcwd() })
  end
  vim.fn.system({ "tmux", "send-keys", "-t", "npm", cmd, "Enter" })
  vim.notify("tmux:npm → " .. cmd)
end

local function npm_run(script)
  return function() send_to_tmux_window("npm run " .. script) end
end

-- Ejecuta una code action filtrada por su `kind` (source.organizeImports.ts, etc.).
local function lsp_action(kind, title)
  return function()
    vim.lsp.buf.code_action({
      apply = true,
      context = { only = { kind }, diagnostics = {} },
    })
    if title then vim.notify(title) end
  end
end

return {
  {
    "windwp/nvim-ts-autotag",
    event = { "BufReadPre", "BufNewFile" },
    ft = { "html", "xml", "astro", "vue", "svelte",
           "javascript", "javascriptreact", "typescript", "typescriptreact" },
    config = function()
      require("nvim-ts-autotag").setup({
        opts = {
          enable_close = true,
          enable_rename = true,
          enable_close_on_slash = false,
        },
      })
    end,
  },

  {
    "JoosepAlviste/nvim-ts-context-commentstring",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("ts_context_commentstring").setup({ enable_autocmd = false })
      -- Integración con el `gcc`/`gc` nativo de nvim 0.10+:
      local get = require("ts_context_commentstring.internal").calculate_commentstring
      vim.g.skip_ts_context_commentstring_module = true
      local orig = vim.bo.commentstring
      vim.api.nvim_create_autocmd({ "FileType", "BufEnter" }, {
        callback = function()
          local cs = get({ key = "__default" })
          if cs then vim.bo.commentstring = cs end
        end,
      })
      _ = orig
    end,
  },

  {
    "neovim/nvim-lspconfig",
    init = function()
      -- which-key groups
      local ok, wk = pcall(require, "which-key")
      if ok then
        wk.add({
          { "<leader>r",  group = "React / npm" },
          { "<leader>ej", group = "JS/TS refactor" },
        })
      end

      -- npm runner: atajos globales (disponibles en cualquier buffer).
      local gmap = function(lhs, rhs, desc)
        vim.keymap.set("n", lhs, rhs, { silent = true, desc = desc })
      end
      gmap("<leader>rd", npm_run("dev"),     "npm run dev")
      gmap("<leader>rb", npm_run("build"),   "npm run build")
      gmap("<leader>rl", npm_run("lint"),    "npm run lint")
      gmap("<leader>rp", npm_run("preview"), "npm run preview")
      gmap("<leader>rt", npm_run("test"),    "npm test")
      gmap("<leader>ri",
          function() send_to_tmux_window("npm install") end,
          "npm install")
      gmap("<leader>rk",
          function()
            vim.fn.system({ "tmux", "send-keys", "-t", "npm", "C-c", "" })
            vim.notify("tmux:npm ← C-c")
          end,
          "Kill npm window process")
      gmap("<leader>rc", function()
        local path = vim.api.nvim_buf_get_name(0)
        local base = path:gsub("%.[jt]sx?$", "")
        for _, ext in ipairs({ ".css", ".module.css", ".scss", ".module.scss" }) do
          local target = base .. ext
          if vim.fn.filereadable(target) == 1 then
            vim.cmd("edit " .. vim.fn.fnameescape(target))
            return
          end
        end
        vim.notify("No hay CSS hermano para " .. vim.fs.basename(path),
                   vim.log.levels.WARN)
      end, "Abrir CSS hermano")

      -- Refactors de LSP: siguen siendo buffer-local en JS/TS porque
      -- dependen de ts_ls / eslint.
      vim.api.nvim_create_autocmd("FileType", {
        pattern = react_fts,
        callback = function(args)
          local buf = args.buf
          local bmap = function(lhs, rhs, desc)
            vim.keymap.set("n", lhs, rhs, { buffer = buf, silent = true, desc = desc })
          end

          bmap("<leader>ejo",
              lsp_action("source.organizeImports.ts", "Imports organizados"),
              "Organize imports")
          bmap("<leader>eja",
              lsp_action("source.addMissingImports.ts", "Imports añadidos"),
              "Add missing imports")
          bmap("<leader>ejr",
              lsp_action("source.removeUnused.ts", "Unused eliminados"),
              "Remove unused")
          bmap("<leader>ejf",
              lsp_action("source.fixAll.ts", "Fix all aplicado"),
              "Fix all (ts_ls)")
          bmap("<leader>eje",
              lsp_action("source.fixAll.eslint", "ESLint --fix aplicado"),
              "ESLint fix all")
        end,
      })
    end,
  },
}

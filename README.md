# Configuración de Neovim — Manual de referencia

Configuración personal optimizada para **Java (Spring Boot)**, **Flutter/Dart**, **Web (React + Vite, Angular, Astro)**, **Python/Jupyter**, **Rust** y toma de notas en **Markdown** con diccionario en español.



> **Tecla líder:** `<Space>`  
> **Gestor de plugins:** `lazy.nvim`  
> **Versión mínima:** Neovim 0.10+

---

## Índice

1. [Lenguajes soportados](#lenguajes-soportados)
2. [Keymaps globales](#keymaps-globales)
3. [LSP y diagnósticos](#lsp-y-diagnósticos)
4. [Búsqueda y navegación](#búsqueda-y-navegación)
5. [Git](#git)
6. [Testing](#testing)
7. [Depuración (DAP)](#depuración-dap)
8. [Base de datos (Dadbod)](#base-de-datos-dadbod)
9. [Java (JDTLS)](#java-jdtls)
10. [Flutter / Dart](#flutter--dart)
11. [Jupyter / Python](#jupyter--python)
12. [LaTeX (VimTeX)](#latex-vimtex)
13. [Emmet (HTML / CSS)](#emmet-html--css)
14. [React / TypeScript / Vite](#react--typescript--vite)
15. [Asistencia IA (Minuet + Ollama)](#asistencia-ia-minuet--ollama)
16. [Notas y Markdown](#notas-y-markdown)
17. [Comandos de usuario](#comandos-de-usuario)
18. [Estructura del repositorio](#estructura-del-repositorio)
19. [Dependencias del entorno](#dependencias-del-entorno)

---

## Lenguajes soportados

| Lenguaje | LSP | Formatter | Treesitter |
|:---|:---:|:---:|:---:|
| Java | JDTLS + Lombok | — | ✓ |
| Dart / Flutter | flutter-tools | — | ✓ |
| TypeScript / JS | ts_ls + eslint | Prettier | ✓ |
| React (`.tsx`/`.jsx`) | ts_ls + eslint + emmet | Prettier | ✓ (`tsx`) |
| Angular | angularls | Prettier | ✓ |
| Astro | astro | Prettier | ✓ |
| Python | pyright | black | ✓ |
| Rust | rust_analyzer | — | ✓ |
| HTML / CSS | html, cssls | Prettier | ✓ |
| Lua | lua_ls | Stylua | ✓ |
| Bash / Zsh | bashls | — | ✓ |
| YAML / JSON | yamlls, jsonls | Prettier | ✓ |
| XML | lemminx | — | — |
| Markdown / MDX | — | Prettier | ✓ |
| LaTeX | VimTeX | latexmk | ✓ |
| SQL | — | — | ✓ |
| Tailwind CSS | tailwindcss | — | — |

---

## Keymaps globales

### Archivo y sesión

| Atajo | Modo | Acción |
|:---|:---:|:---|
| `<leader>ww` | N | Guardar archivo |
| `<leader>wa` | N | Guardar todos los buffers |
| `<leader>wqq` | N | Guardar y cerrar |
| `<leader>wqa` | N | Guardar todo y cerrar |
| `<leader>qq` | N | Cerrar ventana |
| `<Esc><Esc>` | N | Limpiar resaltado de búsqueda |
| `<F5>` | N | Alternar CWD entre el inicial y el del archivo actual |
| `<leader>ct` | N | Cambiar tema Catppuccin (Mocha ↔ Latte) |
| `<leader><leader>` | N | Resaltar posición del cursor (Beacon) |

### Buffers

| Atajo | Modo | Acción |
|:---|:---:|:---|
| `<leader>bn` o `<Tab>` | N | Siguiente buffer |
| `<leader>bp` o `<S-Tab>` | N | Buffer anterior |
| `<leader>bd` | N | Eliminar buffer actual |
| `<leader>bt` | N | Buscar buffer con Telescope |

### Portapapeles (WSL)

| Atajo | Modo | Acción |
|:---|:---:|:---|
| `<leader>y` | N | Copiar archivo al portapapeles de Windows |
| `<leader>y` | V | Copiar selección al portapapeles de Windows |

### Wrappers — Modo visual

Con texto seleccionado, `<leader>` + carácter de apertura envuelve la selección
con el par correspondiente.

| Atajo | Acción |
|:---|:---|
| `<leader>(` | Envolver con `()` |
| `<leader>[` | Envolver con `[]` |
| `<leader>{` | Envolver con `{}` |
| `<leader>"` | Envolver con `""` |
| `<leader>'` | Envolver con `''` |
| `` <leader>` `` | Envolver con `` `` `` |

### Edición — Modo insertar

| Atajo | Acción |
|:---|:---|
| `(` `[` `{` | Inserta el par y deja el cursor dentro |
| `)` `]` `}` | Salta el cierre si ya está escrito, o lo inserta |
| `<C-h>` | Mover cursor a la izquierda |
| `<C-j>` | Mover cursor hacia abajo |
| `<C-k>` | Mover cursor hacia arriba |
| `<C-l>` | Mover cursor a la derecha |
| `<A-;>` | Insertar `;` al final de la línea |
| `<A-,>` | Insertar `,` al final de la línea |
| `<A-.>` | Insertar `.` al final de la línea |

### Terminal

| Atajo | Modo | Acción |
|:---|:---:|:---|
| `<Esc><Esc>` | T | Salir del modo terminal |

---

## LSP y diagnósticos

Todos los servidores se instalan y gestionan con **Mason**. Python detecta automáticamente el virtualenv del proyecto (`.venv`, `venv`, `env`, `.env`).

| Atajo | Modo | Acción |
|:---|:---:|:---|
| `K` | N | Documentación hover |
| `gd` | N | Ir a la definición |
| `<leader>ea` | N/V | Acciones de código |
| `<leader>ee` | N | Mostrar diagnóstico flotante |
| `<leader>ef` | N | Formatear archivo (Prettier / Stylua / black) |
| `<leader>er` | N | Renombrar símbolo |

---

## Búsqueda y navegación

### Telescope

| Atajo | Acción |
|:---|:---|
| `<leader>ff` | Buscar archivos |
| `<leader>fg` | Búsqueda global de texto (live grep) |

### Neo-tree

| Atajo | Acción |
|:---|:---|
| `<leader>ft` | Abrir / cerrar explorador de archivos |

---

## Git

### Hunks — Gitsigns

| Atajo | Modo | Acción |
|:---|:---:|:---|
| `<leader>ghn` | N | Siguiente hunk |
| `<leader>ghp` | N | Hunk anterior |
| `<leader>ghs` | N/V | Stagear hunk |
| `<leader>ghS` | N | Stagear buffer completo |
| `<leader>ghu` | N | Deshacer stage de hunk |
| `<leader>ghr` | N | Resetear hunk |
| `<leader>ghR` | N | Resetear buffer completo |
| `<leader>ghb` | N | Blame de la línea actual |
| `<leader>ghB` | N | Blame completo (con cuerpo del commit) |
| `<leader>ghd` | N | Diff contra index |
| `<leader>ghD` | N | Diff contra último commit |
| `<leader>gtb` | N | Toggle blame en línea |
| `<leader>gtd` | N | Toggle mostrar líneas eliminadas |

### Comandos Git — Fugitive

| Atajo | Acción |
|:---|:---|
| `<leader>ga` | `git add .` |
| `<leader>gg` | `git status` (interfaz Fugitive) |
| `<leader>gc` | `git commit` |
| `<leader>gl` | `git log --oneline` |
| `<leader>gL` | `git log` completo |
| `<leader>gpp` | `git push` |
| `<leader>gpl` | `git pull` |
| `<leader>gfe` | `git fetch` |
| `<leader>gw` | `git add` del archivo actual (`Gwrite`) |
| `<leader>gde` | Diff split del archivo actual (`Gdiffsplit`) |

---

## Testing

Ejecuta los tests en un panel TMUX via **vimux**. Requiere `tmux` activo.

| Atajo | Acción |
|:---|:---|
| `<leader>tt` | Ejecutar test más cercano al cursor |
| `<leader>tf` | Ejecutar todos los tests del archivo |
| `<leader>ta` | Ejecutar suite completa |
| `<leader>tl` | Repetir el último test |
| `<leader>tv` | Ir al archivo de test del buffer actual |
| `<leader>ty` | Enviar buffer YAML a `api-test.zsh` en terminal abierta |

---

## Depuración (DAP)

La UI se abre automáticamente al iniciar una sesión de debug.

| Atajo | Acción |
|:---|:---|
| `<leader>db` | Toggle breakpoint |
| `<leader>dc` | Iniciar / continuar |
| `<leader>di` | Step into |
| `<leader>do` | Step over |
| `<leader>du` | Toggle interfaz DAP |
| `<leader>dx` | Cerrar interfaz DAP |
| `<leader>dr` | Abrir consola REPL |

**Layout de la UI:**
- Panel izquierdo: Scopes · Breakpoints · Call stack · Watches
- Panel inferior: REPL · Consola de output

---

## Base de datos (Dadbod)

Conexiones guardadas en `~/.local/share/db_ui/`. Formato de URL de conexión:

```
postgresql://usuario:contraseña@host:puerto/base_de_datos
mysql://usuario:contraseña@host:puerto/base_de_datos
sqlite:///ruta/al/archivo.db
```

### Keymaps globales

| Atajo | Acción |
|:---|:---|
| `<leader>Do` | Abrir / cerrar panel DB UI |
| `<leader>Da` | Añadir nueva conexión |
| `<leader>Df` | Buscar buffer de query activo |

### Dentro del panel DB UI

| Tecla | Acción |
|:---|:---|
| `o` | Expandir / contraer nodo (conexión, schema, tabla) |
| `R` | Refrescar |
| `d` | Eliminar conexión |
| `A` | Añadir conexión |
| `?` | Mostrar ayuda |

### Dentro de un buffer SQL

| Atajo | Acción |
|:---|:---|
| `<leader>S` | Ejecutar query (o selección en visual mode) |

> El autocompletado SQL usa `vim-dadbod-completion` con prioridad máxima (1000) en buffers `.sql`.

---

## Java (JDTLS)

Activado automáticamente al abrir cualquier archivo `.java`. Configurado en `ftplugin/java.lua`.

**Requisitos:**
- Lombok JAR en `~/.local/share/lombok/lombok.jar`
- Java via SDKMAN en `~/.sdkman/candidates/java/current`
- Mason: `jdtls`, `java-debug-adapter`, `java-test`
- Workspace en `~/.cache/jdtls-workspace/<proyecto>`

### Refactoring

| Atajo | Modo | Acción |
|:---|:---:|:---|
| `<leader>jo` | N | Organizar imports |
| `<leader>jv` | N/V | Extraer variable |
| `<leader>jc` | N/V | Extraer constante |
| `<leader>jm` | N/V | Extraer método |
| `<leader>ju` | N | Actualizar configuración del proyecto |

### Tests (JUnit)

| Atajo | Acción |
|:---|:---|
| `<leader>jt` | Ejecutar test más cercano al cursor |
| `<leader>jT` | Ejecutar todos los tests de la clase |

### Utilidades Maven

| Comando | Acción |
|:---|:---|
| `:MavenTest` | Crea el archivo `*Test.java` correspondiente en `src/test/java` |

---

## Flutter / Dart

Integración con `flutter-tools.nvim`. Los keymaps solo están disponibles en buffers `.dart`.

| Atajo | Acción |
|:---|:---|
| `<leader>FR` | Hot restart |
| `<leader>FD` | Mostrar dispositivos disponibles |
| `<leader>FO` | Toggle widget outline |

### Hot reload automático via TMUX

| Comando | Acción |
|:---|:---|
| `:FlutterWatch` | Toggle hot reload al guardar (pane por defecto: `.+`) |
| `:FlutterWatch <pane>` | Activa y apunta al pane tmux especificado |

Requiere una sesión `flutter run` activa en el pane tmux de destino.

---

## Jupyter / Python

Integración con **molten-nvim** (runner de kernels) + **jupytext** (convierte `.ipynb` ↔ `.py`).

El kernel usa el virtualenv en `~/.venv/jupyter/`. Inicializar con `<leader>ji` y seleccionar el kernel.

| Atajo | Modo | Acción |
|:---|:---:|:---|
| `<leader>Ji` | N | Inicializar kernel Jupyter |
| `<leader>Je` | N | Evaluar operador (motion) |
| `<leader>Jl` | N | Evaluar línea actual |
| `<leader>Jv` | V | Evaluar selección visual |
| `<leader>Jc` | N | Re-evaluar celda actual |
| `<leader>Jd` | N | Eliminar output de la celda |
| `<leader>Jh` | N | Ocultar output |
| `<leader>Js` | N | Mostrar output |
| `<leader>Jo` | N | Abrir output en el navegador |

---

## LaTeX (VimTeX)

Integración con **VimTeX** (`lervag/vimtex`). Configurado en `lua/plugins/vimtex.lua`.

Al abrir cualquier archivo `.tex`, **latexmk** arranca automáticamente en modo continuo: el PDF se recompila cada vez que guardas el buffer. **Zathura** es el visor por defecto.

**Flujo típico:**

1. Abre un `.tex` → la compilación arranca sola (`:VimtexCompile` se invoca por autocomando).
2. Pulsa `<leader>lv` para abrir Zathura con el PDF.
3. Edita y guarda (`:w`) → el PDF se actualiza en segundo plano.

### Keymaps (sólo en buffers `.tex`)

| Atajo | Acción |
|:---|:---|
| `<leader>ll` | Toggle compilación continua (`:VimtexCompile`) |
| `<leader>lv` | Abrir / enfocar PDF en Zathura (`:VimtexView`) |
| `<leader>ls` | Detener compilador (`:VimtexStop`) |
| `<leader>lc` | Limpiar artefactos auxiliares (`:VimtexClean`) |
| `<leader>le` | Ver errores de compilación (`:VimtexErrors`) |
| `<leader>lt` | Toggle tabla de contenidos (`:VimtexTocToggle`) |

### Opciones de latexmk

Pasadas en `g:vimtex_compiler_latexmk`: `-pdf -synctex=1 -file-line-error -interaction=nonstopmode -verbose`. El SyncTeX queda activo para forward-search.

> **Nota WSL2/Wayland:** el aviso `Viewer cannot find Zathura window ID` puede aparecer porque `xdotool` no localiza la ventana bajo Wayland. No impide compilar ni visualizar — sólo limita el forward-search (saltar del cursor en `.tex` a la línea exacta del PDF).

---

## Emmet (HTML / CSS)

Soporte Emmet en dos capas complementarias:

- **`emmet_language_server`** (LSP, vía Mason) — ofrece las abreviaturas dentro del popup de **nvim-cmp** mientras escribes. Configurado en `lua/plugins/lsp-config.lua`.
- **`mattn/emmet-vim`** (`lua/plugins/emmet.lua`) — añade los atajos clásicos para **expandir** una abreviatura existente y, sobre todo, para **envolver** una selección con una etiqueta (algo que el LSP no expone de forma fiable como code action).

**Filetypes activos:** `html`, `css`, `scss`, `sass`, `less`, `astro`, `vue`, `svelte`, `typescriptreact`, `javascriptreact`, `xml`.

### Atajos

| Atajo | Modo | Acción |
|:---|:---:|:---|
| `<C-y>,` | N / I | Expandir la abreviatura bajo el cursor (p. ej. `ul>li*3` → `<ul><li></li>…</ul>`) |
| `<C-y>,` | V | Envolver la selección con la abreviatura que pidas (p. ej. selecciona y escribe `section.hero>div.container`) |

> El leader interno de Emmet es `<C-y>` (Ctrl-y) — distinto de `<leader>y`, que sigue copiando al portapapeles de Windows.

**Flujo "wrap with tag":**

1. Selecciona en modo visual el bloque a envolver.
2. Pulsa `<C-y>,` — emmet-vim pide la abreviatura en la línea de comandos.
3. Escribe (`div.card`, `nav>ul>li*3>a`, etc.) y `<CR>`.

---

## React / TypeScript / Vite

Stack soportado: **Vite + React + TypeScript**. Configurado en `lua/plugins/react.lua` (atajos y runner npm) y `lua/plugins/lsp-config.lua` (servidores LSP).

**Servidores LSP que se enganchan en `.tsx` / `.jsx`:** `ts_ls`, `eslint`, `emmet_language_server`, más `null-ls` (Prettier) y `tailwindcss` si el proyecto tiene Tailwind. Auto-instalación via Mason: `typescript-language-server`, `vscode-eslint-language-server`, `emmet-language-server`, `tailwindcss-language-server`, `vscode-html-language-server`, `vscode-css-language-server`, `prettier`.

### Plugins añadidos para JSX

- **`nvim-ts-autotag`** — cierra y renombra etiquetas JSX/HTML automáticamente (`<div>` ↔ `</div>` se renombran en pareja).
- **`nvim-ts-context-commentstring`** — `gcc` usa `{/* */}` dentro de JSX, `//` en TS plano, `/* */` dentro de un bloque CSS embebido, etc.

### Refactors LSP (buffer-local en `js` / `jsx` / `ts` / `tsx`)

Grupo `<leader>ej` (JS/TS refactor):

| Atajo | Acción |
|:---|:---|
| `<leader>ejo` | Organize imports (`source.organizeImports.ts`) |
| `<leader>eja` | Add missing imports |
| `<leader>ejr` | Remove unused |
| `<leader>ejf` | Fix all (ts_ls) |
| `<leader>eje` | ESLint fix all (`source.fixAll.eslint`) |

### Runner npm en TMUX (globales)

Cada atajo abre — o reutiliza — una window de tmux llamada `npm` en el `cwd` actual y manda el comando. Antes envía `C-c` para parar lo que estuviera corriendo:

| Atajo | Comando |
|:---|:---|
| `<leader>rd` | `npm run dev` |
| `<leader>rb` | `npm run build` |
| `<leader>rl` | `npm run lint` |
| `<leader>rp` | `npm run preview` |
| `<leader>rt` | `npm test` |
| `<leader>ri` | `npm install` |
| `<leader>rk` | Manda `C-c` a la window `npm` (matar proceso) |
| `<leader>rc` | Salta al CSS/SCSS hermano del componente (`App.tsx` ↔ `App.css` / `App.module.css` / `App.scss`) |

> Estos atajos son **globales** (no chequean si hay `package.json`), así que funcionan en cualquier proyecto Node con los scripts correspondientes — Vite, Next, Astro, Express con nodemon, etc.

### Flujo típico

```sh
npm create vite@latest mi-app -- --template react-ts
cd mi-app && nvim src/App.tsx
```

1. `<leader>ri` → instala dependencias en la window `npm`.
2. `<leader>rd` → arranca Vite en `http://localhost:5173/`.
3. Edita el `.tsx`: ts_ls y eslint dan diagnósticos en vivo, `nvim-ts-autotag` mantiene los tags balanceados, Minuet propone completions con ghost text.
4. Al guardar, Vite hace HMR automático (`[vite] (client) hmr update /src/App.tsx`).

### Treesitter override para HTML

El parser `html_tags` de `nvim-treesitter` (master archivado) crashea en nvim 0.12.x por la directiva rota `#set-lang-from-mimetype!`. Solución aplicada: `queries/html_tags/injections.scm` en el config del usuario sustituye esa directiva por reglas explícitas (`module`, `text/javascript`, `application/json`, `importmap`, `text/typescript`).

---

## Asistencia IA (Minuet + Ollama)

Completado de código por IA mediante **minuet-ai.nvim** con backend local **Ollama**. Configurado en `lua/plugins/minuet.lua`.

- **Modelo:** `qwen2.5-coder:7b` (servido en `http://localhost:11434`), soporta FIM (fill-in-middle).
- **Provider:** `openai_fim_compatible` (Ollama expone endpoint OpenAI compatible).
- **Auto-trigger en:** `java`, `python`, `lua`, `javascript`, `typescript`. Otros filetypes: invocar manualmente con el toggle.

Las sugerencias aparecen como **ghost text** (virtual text) tras escribir, sin interferir con el popup de nvim-cmp (`show_on_completion_menu = true`).

### Atajos (modo insertar)

| Atajo | Acción |
|:---|:---|
| `<M-y>` | Aceptar la sugerencia completa |
| `<M-l>` | Aceptar sólo la primera línea |
| `<M-]>` | Siguiente sugerencia |
| `<M-[>` | Sugerencia anterior |
| `<M-e>` | Descartar sugerencia |

### Toggle global

| Atajo | Acción |
|:---|:---|
| `<leader>am` | Activar / desactivar ghost text en el buffer actual |

**Requisitos:** `ollama serve` corriendo y el modelo descargado (`ollama pull qwen2.5-coder:7b`). Verificación rápida de FIM:

```sh
curl -s -X POST http://localhost:11434/v1/completions \
  -H 'Content-Type: application/json' \
  -d '{"model":"qwen2.5-coder:7b","prompt":"def fib(n):\n    return ","suffix":"\n\nprint(fib(10))","max_tokens":30}'
```

---

## Notas y Markdown

Configuración en `ftplugin/markdown.lua`. Se activa automáticamente en archivos `.md`.

- Corrector ortográfico en español (`es`) e inglés (`en`)
- Diccionario personal: `spell/obsidian-es.utf-8.add`

### Prioridad de autocompletado en Markdown

| Prioridad | Fuente |
|:---:|:---|
| 1000 | LSP |
| 750 | LuaSnip |
| 500 | Buffers abiertos |
| 250 | Diccionario Obsidian |
| 100 | Rutas de archivo |

### Sincronización del diccionario

| Atajo / Comando | Acción |
|:---|:---|
| `<leader>sr` | Sincronizar diccionario con Obsidian |
| `:ObsidianRefresh` | Igual que el atajo (ejecución asíncrona) |

El script `spell/obsidian-refresh-es.sh` extrae palabras del vault y actualiza el archivo `.add`.

---

## Comandos de usuario

| Comando | Descripción |
|:---|:---|
| `:MakeTags` | Genera etiquetas ctags de forma recursiva (`ctags -R`) |
| `:FormatHTML` | Formatea el buffer HTML con Prettier a 80 caracteres |
| `:NgGen <tipo> <nombre>` | Ejecuta `ng generate` y abre el archivo generado |
| `:ObsidianRefresh` | Sincroniza palabras del vault de Obsidian al diccionario |
| `:MavenTest` | Crea el archivo de test espejo en `src/test/java` |
| `:FlutterWatch [pane]` | Activa / desactiva hot-reload al guardar archivos Dart |
| `:ToDelete` | Inserta bloque `// TO DELETE` + `console.log()` para debug |

---

## Estructura del repositorio

```
~/.config/nvim/
├── init.lua                    # Punto de entrada: carga basic, keymappings, commands y lazy
├── lazy-lock.json              # Lockfile de versiones de plugins
├── lua/
│   ├── basic.lua               # Opciones core de Neovim
│   ├── keymappings.lua         # Keymaps globales y auto-pairs
│   ├── commands.lua            # Comandos de usuario personalizados
│   └── plugins/                # Un archivo por plugin o grupo lógico
│       ├── beacon.lua          # Resaltado de cursor al saltar
│       ├── catppuccin.lua      # Tema
│       ├── completion.lua      # nvim-cmp + LuaSnip + fuentes
│       ├── dadbod.lua          # Cliente de base de datos
│       ├── dap.lua             # Depurador + UI
│       ├── emmet.lua           # Emmet (mattn/emmet-vim) — atajos y wrap
│       ├── flutter-tools.lua   # LSP Dart + hot reload TMUX
│       ├── git.lua             # Gitsigns + Fugitive
│       ├── jdtls.lua           # Spec lazy para nvim-jdtls
│       ├── jupyter.lua         # molten-nvim + jupytext
│       ├── lsp-config.lua      # Mason + mason-lspconfig + nvim-lspconfig
│       ├── lualine.lua         # Barra de estado
│       ├── mdx.lua             # Soporte MDX
│       ├── minuet.lua          # Completado IA (minuet-ai + Ollama)
│       ├── neo-tree.lua        # Explorador de archivos
│       ├── none-ls.lua         # Formatters via null-ls
│       ├── react.lua           # Autotag JSX + commentstring + atajos npm
│       ├── sorround.lua        # vim-surround
│       ├── telescope.lua       # Búsqueda fuzzy
│       ├── treesitter.lua      # Resaltado sintáctico
│       ├── vimtest.lua         # vim-test + vimux
│       ├── vimtex.lua          # LaTeX + Zathura + latexmk
│       └── wich-key.lua        # Grupos de keymaps con popup
├── ftplugin/
│   ├── java.lua                # JDTLS + Lombok + keymaps Java
│   └── markdown.lua            # Spell + diccionario Obsidian
├── queries/
│   ├── markdown/
│   │   └── injections.scm     # Override de queries rotas en nvim 0.12.x
│   └── html_tags/
│       └── injections.scm     # Override de queries rotas en nvim 0.12.x
└── spell/
    ├── obsidian-es.utf-8.add   # Diccionario español personalizado
    └── obsidian-refresh-es.sh  # Script de sincronización con Obsidian
```

---

## Dependencias del entorno

| Dependencia | Uso | Ruta |
|:---|:---|:---|
| WSL2 | `<leader>y` usa `clip.exe`; hot reload usa terminal WSL | — |
| TMUX | vim-test (vimux) y `:FlutterWatch` | — |
| SDKMAN | Java binary para JDTLS | `~/.sdkman/candidates/java/current` |
| Lombok JAR | Soporte Lombok en JDTLS | `~/.local/share/lombok/lombok.jar` |
| Jupyter venv | Kernel de molten-nvim | `~/.venv/jupyter/` |
| ctags | Comando `:MakeTags` | en `$PATH` |
| prettier | Formateo web, YAML, JSON, Markdown | en `$PATH` |
| api-test.zsh | `<leader>ty` para tests YAML | en `$PATH` |
| latexmk | Compilador continuo para VimTeX | en `$PATH` |
| Zathura | Visor PDF para VimTeX (con soporte SyncTeX) | en `$PATH` |
| Ollama | Backend local para minuet-ai (completado IA) | `http://localhost:11434` |
| qwen2.5-coder:7b | Modelo FIM usado por minuet (`ollama pull qwen2.5-coder:7b`) | ~4.7 GB en disco |

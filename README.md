# Configuración de Neovim de Marckux

Configuración personalizada de Neovim optimizada para desarrollo en **Java (Spring Boot)**, **Flutter/Dart**, **Web (Angular, Astro)** y toma de notas en **Markdown** con integración de diccionario en español.

---

## Características Principales

- **Gestor de Plugins:** `lazy.nvim` para una carga eficiente y diferida.
- **Tema:** Catppuccin con toggle rápido entre Mocha (oscuro) y Latte (claro).
- **Autocompletado:** `nvim-cmp` con LSP, LuaSnip, buffers y diccionario personalizado.
- **LSP:** Configuración robusta para múltiples lenguajes via `mason.nvim` + `lspconfig`.
- **Sintaxis:** Treesitter para resaltado avanzado de ~20 lenguajes.
- **Depuración:** DAP con interfaz gráfica (`nvim-dap-ui`).
- **Testing:** `vim-test` con integración TMUX.
- **Escritura:** Corrector ortográfico Español/Inglés sincronizado con Obsidian.

---

## Lenguajes Soportados

| Lenguaje | LSP | Formatter | Treesitter |
| :--- | :---: | :---: | :---: |
| Java | JDTLS + Lombok | — | ✓ |
| Dart / Flutter | flutter-tools | — | ✓ |
| TypeScript / JS | ts_ls + eslint | Prettier | ✓ |
| Angular | angularls | Prettier | ✓ |
| Astro | astro | Prettier | ✓ |
| HTML / CSS | html, cssls | Prettier | — |
| Lua | lua_ls | Stylua | ✓ |
| Bash / Zsh | bashls | — | ✓ |
| YAML / JSON | yamlls, jsonls | Prettier | ✓ |
| XML | lemminx | — | — |
| Rust | rust_analyzer | — | ✓ |
| Markdown / MDX | — | Prettier | ✓ |
| Tailwind CSS | tailwindcss | — | — |

---

## Keymappings

> **Tecla líder:** `<Space>`

### General (Modo Normal)

| Atajo | Acción |
| :--- | :--- |
| `<leader>ww` | Guardar archivo actual |
| `<leader>wa` | Guardar todos los buffers |
| `<leader>wqq` | Guardar y salir |
| `<leader>wqa` | Guardar todo y salir |
| `<leader>bn` / `<Tab>` | Siguiente buffer |
| `<leader>bp` / `<S-Tab>` | Buffer anterior |
| `<leader>bd` | Eliminar buffer actual |
| `<Esc><Esc>` | Limpiar resaltado de búsqueda |
| `<F5>` | Alternar CWD entre el inicial y el del archivo actual |
| `<leader>ct` | Cambiar tema Catppuccin (Claro ↔ Oscuro) |
| `<leader><leader>` | Resaltar posición del cursor (Beacon) |
| `<leader>y` | Copiar selección al portapapeles de Windows (WSL) |
| `<leader>sr` | Sincronizar diccionario de Obsidian |

### Edición (Modo Insertar)

| Atajo | Acción |
| :--- | :--- |
| `(`, `[`, `{` | Auto-cierre de paréntesis/llaves con cursor al interior |
| `<C-h/j/k/l>` | Movimiento del cursor (Izquierda/Abajo/Arriba/Derecha) |
| `<A-;>` | Insertar `;` al final de la línea |
| `<A-,>` | Insertar `,` al final de la línea |
| `<A-.>` | Insertar `.` al final de la línea |

### Navegación y Búsqueda

| Atajo | Acción |
| :--- | :--- |
| `<leader>ff` | Buscar archivos (Telescope) |
| `<leader>fg` | Búsqueda global de texto (Grep) |
| `<leader>bt` | Buscar buffers abiertos |
| `<leader>ft` | Alternar explorador Neo-tree |

### LSP y Formateo

| Atajo | Acción |
| :--- | :--- |
| `K` | Mostrar documentación (Hover) |
| `gd` | Ir a la definición |
| `<leader>ea` | Acciones de código |
| `<leader>ee` | Mostrar diagnósticos de error |
| `<leader>s` | Formatear archivo (Prettier / Stylua) |

### Testing (vim-test + TMUX)

| Atajo | Acción |
| :--- | :--- |
| `<leader>tt` | Ejecutar test más cercano |
| `<leader>tf` | Ejecutar todos los tests del archivo |
| `<leader>ta` | Ejecutar suite de tests completa |
| `<leader>tl` | Ejecutar el último test |
| `<leader>tv` | Ir al último archivo de test |

### Depuración (DAP)

| Atajo | Acción |
| :--- | :--- |
| `<leader>db` | Toggle breakpoint |
| `<leader>dc` | Iniciar / Continuar depuración |
| `<leader>di` | Step into |
| `<leader>do` | Step over |
| `<leader>du` | Alternar interfaz DAP |
| `<leader>dx` | Cerrar interfaz DAP |
| `<leader>dr` | Abrir consola REPL |

---

## Java (JDTLS)

Configuración específica en `ftplugin/java.lua`. Activado automáticamente al abrir un archivo `.java`.

- Soporte **Lombok** (`~/.local/share/lombok/lombok.jar`)
- Integración con **SDKMAN** para detección de JDK
- Workspace en `~/.cache/jdtls-workspace/[proyecto]`
- JVM con 4 GB de heap (`-Xms4g`)

| Atajo | Acción |
| :--- | :--- |
| `<leader>jo` | Organizar imports |
| `<leader>jv` | Extraer variable |
| `<leader>jc` | Extraer constante |
| `<leader>jm` | Extraer método |
| `<leader>jt` | Testear método más cercano |
| `<leader>jT` | Testear clase completa |
| `<leader>ju` | Actualizar configuración del proyecto |

---

## Flutter / Dart

Integración con `flutter-tools.nvim` y hot-reload automático via TMUX.

| Atajo | Acción |
| :--- | :--- |
| `<leader>FR` | Flutter Hot Restart |
| `<leader>FD` | Mostrar dispositivos disponibles |
| `<leader>FO` | Alternar esquema de widgets (Outline) |

---

## Comandos de Usuario

| Comando | Descripción |
| :--- | :--- |
| `:MakeTags` | Genera etiquetas ctags de forma recursiva |
| `:FormatHTML` | Formatea el buffer HTML con Prettier (80 chars) |
| `:NgGen [args]` | Ejecuta `ng generate` y abre el archivo generado |
| `:ObsidianRefresh` | Sincroniza palabras del vault de Obsidian al diccionario |
| `:ToDelete` | Inserta bloque de depuración `// TO DELETE` + `console.log()` |
| `:MavenTest` | Crea el archivo de test correspondiente en `src/test/java` |
| `:FlutterWatch [pane]` | Activa hot-reload automático al guardar archivos Dart via TMUX |
| `<leader>ty` | Ejecuta `api-test.zsh` en la terminal con el buffer YAML activo |

---

## Notas y Diccionario en Español

Configuración en `ftplugin/markdown.lua` para archivos `.md`.

- **Corrector ortográfico:** Español (`es`) + Inglés (`en`)
- **Diccionario personalizado:** `spell/obsidian-es.utf-8.add`
- **Prioridad de autocompletado en Markdown:**
  1. LSP (1000)
  2. LuaSnip (750)
  3. Buffers abiertos (500)
  4. Diccionario Obsidian (250)
  5. Rutas de archivo (100)
- **Sincronización:** `:ObsidianRefresh` ejecuta `spell/obsidian-refresh-es.sh` de forma asíncrona para extraer palabras del vault y actualizar el diccionario.

---

## Estructura del Repositorio

```
~/.config/nvim/
├── init.lua                  # Punto de entrada principal
├── lua/
│   ├── basic.lua             # Opciones core de Vim/Neovim
│   ├── keymappings.lua       # Atajos de teclado globales
│   ├── commands.lua          # Comandos de usuario personalizados
│   ├── snippets.lua          # Configuración de snippets
│   ├── config/
│   │   └── lazy.lua          # Bootstrap de lazy.nvim
│   └── plugins/              # Especificaciones de plugins (lazy.nvim)
│       ├── catppuccin.lua
│       ├── lsp-config.lua
│       ├── completion.lua
│       ├── telescope.lua
│       ├── neo-tree.lua
│       ├── treesitter.lua
│       ├── lualine.lua
│       ├── wich-key.lua
│       ├── flutter-tools.lua
│       ├── dap.lua
│       ├── vimtest.lua
│       ├── none-ls.lua
│       ├── sorround.lua
│       ├── beacon.lua
│       └── mdx.lua
├── ftplugin/
│   ├── java.lua              # JDTLS + Lombok + atajos Java
│   └── markdown.lua          # Corrector ortográfico + diccionario
└── spell/
    ├── obsidian-es.utf-8.add # Diccionario español personalizado
    └── obsidian-refresh-es.sh# Script de sincronización con Obsidian
```

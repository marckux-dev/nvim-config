# Configuración de Neovim de Marckux

Este repositorio contiene una configuración personalizada de Neovim optimizada para desarrollo en **Java (Spring Boot)**, **Flutter/Dart**, **Web (Angular, Astro)** y toma de notas en **Markdown** con integración de diccionario en español.

## 🚀 Características Principales
- **Gestor de Plugins:** `lazy.nvim` para una carga eficiente.
- **Tema:** Catppuccin (con toggle rápido entre Mocha y Latte).
- **Autocompletado:** `nvim-cmp` configurado con LSP, snippets y un diccionario personalizado para Markdown.
- **LSP:** Configuración robusta para múltiples lenguajes mediante `mason.nvim` y `lspconfig`.
- **Escritura:** Autocompletado en español que prioriza buffers abiertos y un diccionario sincronizado con Obsidian.

---

## ⌨️ Keymappings Personalizados

### General (Modo Normal)
| Atajo | Acción |
| :--- | :--- |
| `<leader>ww` | Guardar archivo actual |
| `<leader>wa` | Guardar todos los buffers |
| `<leader>wqq` | Guardar y salir |
| `<leader>wqa` | Guardar todo y salir |
| `<leader>bn` | Siguiente buffer |
| `<leader>bp` | Buffer anterior |
| `<leader>bd` | Eliminar buffer actual |
| `<Esc><Esc>` | Limpiar resaltado de búsqueda (`:noh`) |
| `<F5>` | Alternar CWD entre el inicial y el del archivo |
| `<leader>ct` | Cambiar tema Catppuccin (Claro/Oscuro) |
| `<leader><leader>` | Resaltar posición del cursor (Beacon) |
| `<leader>y` | Copiar al portapapeles de Windows (WSL) |

### Edición (Modo Insertar)
| Atajo | Acción |
| :--- | :--- |
| `(`, `[`, `{` | Auto-cerrado de paréntesis/llaves |
| `<C-h/j/k/l>` | Movimiento del cursor (Izquierda/Abajo/Arriba/Derecha) |
| `<A-;>` | Insertar `;` al final de la línea |
| `<A-,>` | Insertar `,` al final de la línea |
| `<A-.>` | Insertar `.` al final de la línea |

### Navegación y Búsqueda (Telescope / Neo-tree)
| Atajo | Acción |
| :--- | :--- |
| `<leader>ff` | Buscar archivos |
| `<leader>fg` | Búsqueda global de texto (Grep) |
| `<leader>bt` | Buscar buffers abiertos |
| `<leader>ft` | Alternar explorador de archivos Neo-tree |

### LSP y Formateo
| Atajo | Acción |
| :--- | :--- |
| `K` | Mostrar documentación (Hover) |
| `gd` | Ir a la definición |
| `<leader>ea` | Acciones de código |
| `<leader>ee` | Mostrar diagnósticos de error |
| `<leader>s` | Formatear archivo (Prettier/Stylua) |

### Testing (Vim-test)
| Atajo | Acción |
| :--- | :--- |
| `<leader>tt` | Ejecutar test más cercano |
| `<leader>tf` | Ejecutar tests del archivo |
| `<leader>ta` | Ejecutar suite de tests |
| `<leader>tl` | Ejecutar último test |

---

## ☕ Desarrollo Java (JDTLS)
Configuración específica para Java con soporte para **Lombok**.

| Atajo | Acción |
| :--- | :--- |
| `<leader>jo` | Organizar imports |
| `<leader>jv` | Extraer variable |
| `<leader>jc` | Extraer constante |
| `<leader>jm` | Extraer método |
| `<leader>jt` | Testear método más cercano |
| `<leader>jT` | Testear clase |
| `<leader>ju` | Actualizar configuración del proyecto |

---

## 💙 Flutter & Dart
Integración con `flutter-tools.nvim` y hot-reload automático mediante TMUX.

| Atajo | Acción |
| :--- | :--- |
| `<leader>FR` | Flutter Hot Restart |
| `<leader>FD` | Mostrar dispositivos de Flutter |
| `<leader>FO` | Alternar esquema de Flutter (Outline) |

---

## 📝 Comandos de Usuario
- `:ToDelete`: Inserta un bloque de comentario `// TO DELETE` para depuración rápida.
- `:FlutterWatch [pane]`: Activa el Hot Reload automático al guardar archivos Dart.
- `:NgGen [args]`: Ejecuta `ng generate` de Angular y abre el archivo resultante.
- `:FormatHTML`: Formatea HTML usando Prettier.
- `:MakeTags`: Genera etiquetas ctags de forma recursiva.

---

## 📖 Notas y Diccionario
La configuración de Markdown utiliza un diccionario en español ubicado en `~/.config/nvim/spell/obsidian-es.utf-8.add`.
- **Prioridad de Autocompletado:** 1. Buffer actual.
  2. Otros buffers abiertos.
  3. Diccionario personal.
- **Sincronización:** Incluye el script `obsidian-refresh-es.sh` para extraer palabras de un vault de Obsidian y actualizar el diccionario de Neovim.



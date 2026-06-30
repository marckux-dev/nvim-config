-- Snippets propios (LuaSnip). friendly-snippets se carga aparte en completion.lua.
local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node

local function filename_no_ext()
  return vim.fn.expand("%:t:r")
end

ls.add_snippets("typescriptreact", {
  s("rafc", {
    t("export const "),
    f(filename_no_ext, {}),
    t({ " = () => {", "\treturn (", "\t\t" }),
    i(0),
    t({ "", "\t);", "};" }),
  }),
})

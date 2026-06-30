; Override de queries/html_tags/injections.scm de nvim-treesitter (master archivado).
; La directiva original `#set-lang-from-mimetype!` crashea en nvim 0.12.x
; con "attempt to call method 'range' (a nil value)". Aquí se sustituye por
; reglas explícitas con #set! injection.language para los MIME types comunes,
; y se conserva el resto de la query original.

((comment) @injection.content
  (#set! injection.language "comment"))

; <style>...</style>
((style_element
  (start_tag) @_no_type_lang
  (raw_text) @injection.content)
  (#not-lua-match? @_no_type_lang "%slang%s*=")
  (#not-lua-match? @_no_type_lang "%stype%s*=")
  (#set! injection.language "css"))

((style_element
  (start_tag
    (attribute
      (attribute_name) @_type
      (quoted_attribute_value
        (attribute_value) @_css)))
  (raw_text) @injection.content)
  (#eq? @_type "type")
  (#eq? @_css "text/css")
  (#set! injection.language "css"))

; <script>...</script>
((script_element
  (start_tag) @_no_type_lang
  (raw_text) @injection.content)
  (#not-lua-match? @_no_type_lang "%slang%s*=")
  (#not-lua-match? @_no_type_lang "%stype%s*=")
  (#set! injection.language "javascript"))

; <script type="module"> (ES modules) — sigue siendo JavaScript
((script_element
  (start_tag
    (attribute
      (attribute_name) @_attr
      (quoted_attribute_value
        (attribute_value) @_type)))
  (raw_text) @injection.content)
  (#eq? @_attr "type")
  (#any-of? @_type "module" "text/javascript" "application/javascript" "application/ecmascript")
  (#set! injection.language "javascript"))

; <script type="application/json"> u otros JSON
((script_element
  (start_tag
    (attribute
      (attribute_name) @_attr
      (quoted_attribute_value
        (attribute_value) @_type)))
  (raw_text) @injection.content)
  (#eq? @_attr "type")
  (#any-of? @_type "application/json" "application/ld+json" "importmap")
  (#set! injection.language "json"))

; <script type="text/typescript">
((script_element
  (start_tag
    (attribute
      (attribute_name) @_attr
      (quoted_attribute_value
        (attribute_value) @_type)))
  (raw_text) @injection.content)
  (#eq? @_attr "type")
  (#any-of? @_type "text/typescript" "application/typescript")
  (#set! injection.language "typescript"))

; <a style="/* css */">
((attribute
  (attribute_name) @_attr
  (quoted_attribute_value
    (attribute_value) @injection.content))
  (#eq? @_attr "style")
  (#set! injection.language "css"))

; lit-html style template interpolation
((attribute
  (quoted_attribute_value
    (attribute_value) @injection.content))
  (#lua-match? @injection.content "%${")
  (#offset! @injection.content 0 2 0 -1)
  (#set! injection.language "javascript"))

((attribute
  (attribute_value) @injection.content)
  (#lua-match? @injection.content "%${")
  (#offset! @injection.content 0 2 0 -2)
  (#set! injection.language "javascript"))

; <input pattern="...">
(element
  (_
    (tag_name) @_tagname
    (#eq? @_tagname "input")
    (attribute
      (attribute_name) @_attr
      [
        (quoted_attribute_value
          (attribute_value) @injection.content)
        (attribute_value) @injection.content
      ]
      (#eq? @_attr "pattern"))
    (#set! injection.language "regex")))

; <input onchange="...">
(attribute
  (attribute_name) @_name
  (#lua-match? @_name "^on[a-z]+$")
  (quoted_attribute_value
    (attribute_value) @injection.content)
  (#set! injection.language "javascript"))

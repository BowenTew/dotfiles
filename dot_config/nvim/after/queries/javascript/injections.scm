; Vue.js template 模板字符串使用 HTML 高亮
; template: `<html>`
(pair
  key: (property_identifier) @_name
    (#eq? @_name "template")
  value: (template_string) @html
)

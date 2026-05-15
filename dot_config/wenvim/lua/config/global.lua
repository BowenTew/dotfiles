-- 全局配置对象
_G.AeonVim = {
  version = "0.1.0",
  colorscheme = "base46-vscode_dark",
  
  -- 图标配置
  icons = require("utils.icons"),
  
  -- 键位配置
  keys = {
    leader = " ",
    localleader = ",",
  },
}
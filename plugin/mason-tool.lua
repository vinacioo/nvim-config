local mason_tool_status, mason_tool = pcall(require, "mason-tool-installer")
if not mason_tool_status then
  vim.notify("Read Error: mason.lua")
  return
end

mason_tool.setup({
  ensure_installed = {
    "prettierd",
    "black",
    "isort",
    "cspell",
    "stylua",
  },
})

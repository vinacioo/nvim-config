local mason_status, mason = pcall(require, "mason")
if not mason_status then
	vim.notify("Read Error: mason.lua")
	return
end

mason.setup()

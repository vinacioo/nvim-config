local mason_lspconfig_status, mason_lspconfig = pcall(require, "mason-lspconfig")
if not mason_lspconfig_status then
	vim.notify("Read Error: mason.lua")
	return
end

mason_lspconfig.setup({
	ensure_installed = {
		"tsserver",
		"pyright",
		"sumneko_lua",
		"jsonls",
		"yamlls",
		"eslint",
		"omnisharp",
	},
})

-- local randomhead = function()
-- 	math.randomseed(os.time())
-- 	local headers = {
-- 		{
-- 			[[]],
-- 			[[  ███╗   ██╗██╗   ██╗██╗███╗   ███╗ ]],
-- 			[[  ████╗  ██║██║   ██║██║████╗ ████║ ]],
-- 			[[  ██╔██╗ ██║██║   ██║██║██╔████╔██║ ]],
-- 			[[  ██║╚██╗██║╚██╗ ██╔╝██║██║╚██╔╝██║ ]],
-- 			[[  ██║ ╚████║ ╚████╔╝ ██║██║ ╚═╝ ██║ ]],
-- 			[[  ╚═╝  ╚═══╝  ╚═══╝  ╚═╝╚═╝     ╚═╝ ]],
-- 			[[]],
-- 		},
-- 	}
-- 	return table.concat(headers[math.random(1, #headers)], "\n")
-- end
-- return {

-- 	{
-- 		"echasnovski/mini.starter",
-- 		version = false,
-- 		enabled = true,
-- 		event = "VimEnter",
-- 		opts = function()
-- 			local function new_section(name, action, section)
-- 				return { name = name, action = action, section = section }
-- 			end
-- 			local pad = string.rep(" ", 10)
-- 			local starter = require("mini.starter")
-- 			local config = {
-- 				evaluate_single = false,
-- 				header = randomhead(),
-- 				items = {
-- 					starter.sections.recent_files(5, true, true),
-- 					new_section("Recent Files", "Telescope oldfiles", "Telescope"),
-- 					new_section("Grep", "Telescope live_grep", "Telescope"),
-- 					new_section("Config", "e $MYVIMRC", "Config"),
-- 					new_section("Find Session", "Telescope persisted", "Session"),
-- 					new_section("Restore Session", [[lua require("persistence").load()]], "Session"),
-- 					new_section("Last Session", [[lua require("persistence").load({ last = true })]], "Session"),
-- 					new_section("Lazy", "Lazy", "Config"),
-- 					new_section("New file", "ene | startinsert", "Built-in"),
-- 					new_section("Quit", "qa", "Built-in"),
-- 				},
-- 				content_hooks = {
-- 					starter.gen_hook.adding_bullet(pad .. "░ ", false),

-- 					starter.gen_hook.indexing("all", { "Builtin actions" }),
-- 					starter.gen_hook.padding(14, 7),
-- 				},
-- 			}
-- 			return config
-- 		end,
-- 		config = function(_, config)
-- 			-- close Lazy and re-open when starter is ready
-- 			if vim.o.filetype == "lazy" then
-- 				vim.cmd.close()
-- 				vim.api.nvim_create_autocmd("User", {
-- 					pattern = "MiniStarterOpened",
-- 					callback = function()
-- 						require("lazy").show()
-- 					end,
-- 				})
-- 			end

-- 			local starter = require("mini.starter")
-- 			starter.setup(config)

-- 			vim.api.nvim_create_autocmd("User", {
-- 				pattern = "LazyVimStarted",
-- 				callback = function()
-- 					local stats = require("lazy").stats()
-- 					local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
-- 					-- local pad_footer = string.rep(" ", 0)
-- 					starter.config.footer = "⚡ Neovim loaded " .. stats.count .. " plugins in " .. ms .. "ms"
-- 					pcall(starter.refresh)
-- 				end,
-- 			})
-- 		end,
-- 	},
-- }

-- return {
-- 	"echasnovski/mini.starter",
-- 	version = false, -- wait till new 0.7.0 release to put it back on semver
-- 	event = "VimEnter",
-- 	opts = function()
-- 		local logo = table.concat({
-- 			[[                                                                     ]],
-- 			[[       ████ ██████           █████      ██                     ]],
-- 			[[      ███████████             █████                             ]],
-- 			[[      █████████ ███████████████████ ███   ███████████   ]],
-- 			[[     █████████  ███    █████████████ █████ ██████████████   ]],
-- 			[[    █████████ ██████████ █████████ █████ █████ ████ █████   ]],
-- 			[[  ███████████ ███    ███ █████████ █████ █████ ████ █████  ]],
-- 			[[ ██████  █████████████████████ ████ █████ █████ ████ ██████ ]],
-- 			[[                                                                       ]],
-- 		}, "\n")
-- 		local pad = string.rep(" ", 22)
-- 		local new_section = function(name, action, section)
-- 			return { name = name, action = action, section = pad .. section }
-- 		end

-- 		local starter = require("mini.starter")
--     --stylua: ignore
--     local config = {
--       evaluate_single = true,
--       header = logo,
--       items = {
--         new_section("Pind file",           "Telescope find_files", "Telescope"),
--         new_section("Recent files",        "Telescope oldfiles",   "Telescope"),
--         new_section("Grep text",           "Telescope live_grep",  "Telescope"),
--         new_section("init.lua",            "e $MYVIMRC",           "Config"),
--         new_section("Lazy",                "Lazy",                 "Config"),
--         new_section("-Explorer",           "ex .",                 "Oil"),
--         new_section("New file",            "ene | startinsert",    "Built-in"),
--         new_section("Quit",                "qa",                   "Built-in"),
--         new_section("Session restore",     [[lua require("persistence").load()]], "Session"),
--       },
--       content_hooks = {
--         starter.gen_hook.adding_bullet(pad .. "░ ", false),
--         starter.gen_hook.aligning("center", "center"),
--       },
--     }
-- 		return config
-- 	end,
-- 	config = function(_, config)
-- 		-- close Lazy and re-open when starter is ready
-- 		if vim.o.filetype == "lazy" then
-- 			vim.cmd.close()
-- 			vim.api.nvim_create_autocmd("User", {
-- 				pattern = "MiniStarterOpened",
-- 				callback = function()
-- 					require("lazy").show()
-- 				end,
-- 			})
-- 		end

-- 		local starter = require("mini.starter")
-- 		starter.setup(config)

-- 		vim.api.nvim_create_autocmd("User", {
-- 			pattern = "LazyVimStarted",
-- 			callback = function()
-- 				local stats = require("lazy").stats()
-- 				local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
-- 				local pad_footer = string.rep(" ", 8)
-- 				starter.config.footer = pad_footer
-- 					.. "⚡ Neovim loaded "
-- 					.. stats.count
-- 					.. " plugins in "
-- 					.. ms
-- 					.. "ms"
-- 				pcall(starter.refresh)
-- 			end,
-- 		})
-- 	end,
-- }

return {
	--dashboard
	"nvimdev/dashboard-nvim",
	event = "VimEnter",
	opts = function()
		local logo = [[
███╗   ██╗██╗   ██╗██╗███╗   ███╗
████╗  ██║██║   ██║██║████╗ ████║
██╔██╗ ██║██║   ██║██║██╔████╔██║
██║╚██╗██║╚██╗ ██╔╝██║██║╚██╔╝██║
██║ ╚████║ ╚████╔╝ ██║██║ ╚═╝ ██║
╚═╝  ╚═══╝  ╚═══╝  ╚═╝╚═╝     ╚═╝
     ]]
		local ver = vim.version()
		local version = "Neovim v" .. ver.major .. "." .. ver.minor .. "." .. ver.patch

		logo = string.rep("\n", 8) .. logo .. version .. "\n\n"

		local opts = {
			theme = "doom",
			hide = {
				-- this is taken care of by lualine
				-- enabling this messes up the actual laststatus setting after loading a file
				statusline = true,
			},
			config = {
				header = vim.split(logo, "\n"),
        -- stylua: ignore
        center = {
          { action = "Telescope find_files",              desc = " Find file",       icon = " ", key = "f" },
          { action = "ene | startinsert",                 desc = " New file",        icon = " ", key = "n" },
          { action = "Telescope oldfiles",                desc = " Recent files",    icon = " ", key = "r" },
          { action = "Telescope live_grep",               desc = " Find text",       icon = " ", key = "g" },
          { action = "e $MYVIMRC",                        desc = " Config",          icon = " ", key = "c" },
          { action = [[lua require("persistence").load({ last = true })]], desc = " Last Session", icon = " ", key = "s" },
          { action = [[lua require("auto-session.session-lens").search_session()]], desc = " Find Session", icon = "S ", key = "S"},
          -- { action = "LazyExtras",                        desc = " Lazy Extras",     icon = " ", key = "e" },
          { action = "Lazy",                              desc = " Lazy",            icon = "󰒲 ", key = "l" },
          { action = "qa",                                desc = " Quit",            icon = " ", key = "q" },
        },
				footer = function()
					local stats = require("lazy").stats()
					local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
					return { "⚡ Neovim loaded " .. stats.loaded .. "/" .. stats.count .. " plugins in " .. ms .. "ms" }
				end,
			},
		}

		for _, button in ipairs(opts.config.center) do
			button.desc = button.desc .. string.rep(" ", 43 - #button.desc)
		end

		-- close Lazy and re-open when the dashboard is ready
		if vim.o.filetype == "lazy" then
			vim.cmd.close()
			vim.api.nvim_create_autocmd("User", {
				pattern = "DashboardLoaded",
				callback = function()
					require("lazy").show()
				end,
			})
		end

		return opts
	end,
}

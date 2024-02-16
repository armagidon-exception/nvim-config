require("nvim-surround").buffer_setup {
	surrounds = {
		["m"] = {
			add = function(char)
				local config = require "nvim-surround.config"
				local result = config.get_input "Enter the surround name: "
				if result then
					if result == "bold" then
						return { { "**" }, { "**" } }
					elseif result == "italic" then
						return { { "*" }, { "*" } }
					elseif result == "strike" then
						return { { "~~" }, { "~~" } }
					elseif result == "codeblock" then
						return { { "```" }, { "```" } }
					elseif result == "code" then
						return { { "`" }, { "`" } }
					end
				end
			end,
		},
	},
}

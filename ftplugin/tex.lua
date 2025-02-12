local opt = vim.opt

opt.wrap = true

local keymap = vim.keymap.set

-- Text objects
keymap({ "o", "x" }, "alc", "<plug>(vimtex-ac)", { desc = "Around latex command" })
keymap({ "o", "x" }, "ilc", "<plug>(vimtex-ic)", { desc = "Inside latex command" })
keymap({ "o", "x" }, "ald", "<plug>(vimtex-ad)", { desc = "Around latex delimiters ( \\left(, \\right), etc. )" })
keymap({ "o", "x" }, "ild", "<plug>(vimtex-id)", { desc = "Inside latex delimiters ( \\left(, \\right), etc. )" })
keymap({ "o", "x" }, "ale", "<plug>(vimtex-ae)", { desc = "Around environments" })
keymap({ "o", "x" }, "ile", "<plug>(vimtex-ie)", { desc = "Inside environments" })
keymap({ "o", "x" }, "al$", "<plug>(vimtex-a$)", { desc = "Around math environments" })
keymap({ "o", "x" }, "il$", "<plug>(vimtex-i$)", { desc = "Inside math environments" })
keymap({ "o", "x" }, "alP", "<plug>(vimtex-aP)", { desc = "Around sections" })
keymap({ "o", "x" }, "ilP", "<plug>(vimtex-iP)", { desc = "Inside sections" })
keymap({ "o", "x" }, "alm", "<plug>(vimtex-am)", { desc = "Around list items" })
keymap({ "o", "x" }, "ilm", "<plug>(vimtex-im)", { desc = "Inside list items" })

keymap("n", "ltsf", "<plug>(vimtex-cmd-toggle-frac)", { desc = "Toggle between inline and command fraction" })
keymap("n", "<leader>ltd", "<plug>(vimtex-delim-toggle-modifier)", { desc = "Toggle between delimter modifiers" })
keymap("n", "<leader>ltb", "<plug>(vimtex-cmd-toggle-break)", { desc = "Toggle break" })
keymap(
	"n",
	"<leader>lam",
	"<plug>(vimtex-delim-add-modifiers)",
	{ desc = "Add modifiers to all delimiters im math scope" }
)

local get_input = require("nvim-surround.input").get_input
require("nvim-surround").buffer_setup {
	surrounds = {
		["c"] = {
			add = function()
				local input = get_input "Enter the command: "
				if input then
					return { { "\\" .. input .. "{" }, { "}" } }
				end
			end,
		},

		["e"] = {
			add = function()
				local input = get_input "Enter the environment: "
				if input then
					return { { "\\begin{" .. input .. "}" }, { "\\end{" .. input .. "}" } }
				end
			end,
		},

		["g"] = {
			add = function()
				local input = get_input "Enter the group: "
				if input then
					return { { "{\\" .. input .. " " }, { " }" } }
				end
			end,
		},
	},
}

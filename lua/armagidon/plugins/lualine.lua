return {
	"nvim-lualine/lualine.nvim",
	event = "VeryLazy",
	opts = {
		extensions = { "lazy" },
		options = {
			disabled_filetypes = {},
			component_separators = { left = "", right = "" },
			section_separators = { left = "|", right = "|" },
		},
		sections = {
			lualine_a = { "mode" },
			lualine_b = { "branch", "diff", { "diagnostics", sources = { "nvim_lsp" } } },
            lualine_c = {},
			lualine_x = { "filetype" },
			lualine_y = { "progress" },
			lualine_z = { "location" },
		},
	},
	config = function(_, opts)
		-- Show info when recording a macro
		local function is_macro_recording()
			local reg = vim.fn.reg_recording()
			if reg == "" then
				return ""
			end
			return "󰑋 " .. reg
		end

		table.insert(opts.sections.lualine_x, 1, {
			is_macro_recording,
			color = { fg = "#333333", bg = "#ff6666" },
			separator = { left = "", right = "" },
			cond = function()
				return is_macro_recording() ~= ""
			end,
		})

		-- Don't display encoding if encoding is UTF-8
		local function encoding()
		  local ret, _ = (vim.bo.fenc or vim.go.enc):gsub("^utf%-8$", "")
		  return ret
		end

		table.insert(opts.sections.lualine_x, 1, {
		  encoding,
		  cond = function()
		    return encoding() ~= ""
		  end,
		})

		-- Don't display fileformat if fileformat is unix
		local function fileformat()
			local ret, _ = vim.bo.fileformat:gsub("^unix$", "")
			return ret
		end

		table.insert(opts.sections.lualine_x, 1, {
			fileformat,
			cond = function()
				return fileformat() ~= ""
			end,
		})

		local function wordCount()
			local wc = vim.fn.wordcount()
			if wc == nil then
				return ""
			end
			if wc["visual_words"] then -- text is selected in visual mode
				return wc["visual_words"] .. " Words/" .. wc["visual_chars"] .. " Chars (Vis)"
			else -- all of the document
				return wc["words"] .. " Words"
			end
		end

		table.insert(opts.sections.lualine_y, 1, {
			wordCount,
			cond = function()
				local ft = vim.bo.filetype
				local count = {
					latex = true,
					tex = true,
					text = true,
					markdown = true,
					vimwiki = true,
				}
				return count[ft] ~= nil
			end,
		})

		require("lualine").setup(opts)
	end,
}

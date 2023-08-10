require "math"
return {
	'Vigemus/iron.nvim',
	config = function()
		require('iron.core').setup {
			config = {
				-- Whether a repl should be discarded or not
				scratch_repl = true,
				-- Your repl definitions come here
				repl_definition = {
					sh = {
						-- Can be a table or a function that
						-- returns a table (see below)
						command = { "bash" }
					},
					zsh = {
						-- Can be a table or a function that
						-- returns a table (see below)
						command = { "zsh" }
					}
				},
				-- How the repl window will be displayed
				-- See below for more information
				-- repl_open_cmd = require('iron.view').center("30%", 20),
				repl_open_cmd = require('iron.view').offset {
					width = 60,
					height = math.floor(vim.api.nvim_win_get_height(0) * 0.75),
					-- `view.helpers.flip` will subtract the size of the REPL
					-- window from the total dimension, then apply an offset.
					-- Effectively, it flips the top/left to bottom/right orientation
					-- v
					--
					w_offset = require('iron.view').helpers.flip(2),
					h_offset = require('iron.view').helpers.proportion(0.5)
				}
			},
			-- Iron doesn't set keymaps by default anymore.
			-- You can set them here or manually add keymaps to the functions in iron.core
			keymaps = {
				send_motion = "<space>sc",
				visual_send = "<space>sc",
				send_file = "<space>sf",
				send_line = "<space>sl",
				send_until_cursor = "<space>su",
				send_mark = "<space>sm",
				mark_motion = "<space>mc",
				mark_visual = "<space>mc",
				remove_mark = "<space>md",
				cr = "<space>s<cr>",
				interrupt = "<space>s<space>",
				exit = "<space>sq",
				clear = "<space>cl",
			},
			-- If the highlight is on, you can change how it looks
			-- For the available options, check nvim_set_hl
			highlight = {
				italic = true
			},
			ignore_blank_lines = true, -- ignore blank lines when sending visual select lines
			repl_definition = {
				sh = {
					command = function(meta)
						local filename = vim.api.nvim_buf_get_name(meta.current_bufnr)
						return { 'cabal', 'v2-repl', filename }
					end
				},
				zsh = {
					command = function(meta)
						local filename = vim.api.nvim_buf_get_name(meta.current_bufnr)
						return { 'cabal', 'v2-repl', filename }
					end
				},
				python = {
					command = function(meta)
						local filename = vim.api.nvim_buf_get_name(meta.current_bufnr)
						return { 'cabal', 'v2-repl', filename }
					end
				}
			}
		}

		-- iron also has a list of commands, see :h iron-commands for all available commands
		vim.keymap.set('n', '<space>rs', '<cmd>IronRepl<cr>')
		vim.keymap.set('n', '<space>rr', '<cmd>IronRestart<cr>')
		vim.keymap.set('n', '<space>rf', '<cmd>IronFocus<cr>')
		vim.keymap.set('n', '<space>rh', '<cmd>IronHide<cr>')
	end
}

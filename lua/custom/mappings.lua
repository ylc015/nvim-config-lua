local M = {}

M.dap = {
	plugin = true,
	n = {
		["<leader>db"] = {
			"<cmd> DapToggleBreakpoint <CR>",
			"Add Breakpoint at line",
		},
		["<leader>dr"] = {
			"<cmd> DapContinue <CR>",
			"Start or continue the debugger",
		},

	}
}

return M

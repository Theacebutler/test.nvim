-- open a new tmux window in the root of the project
local function open_tmux_window()
	local cmd = "tmux split-window -h"
	os.execute(cmd)
end

vim.api.nvim_create_user_command("OpenTmuxWindow", function()
	open_tmux_window()
end, {})

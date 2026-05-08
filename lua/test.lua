local M = {}

local function getTestCommand(ft)
	if ft == "go" then
		return "go test  -v ./..."
	elseif ft == "javascript" then
		return "bun run test"
	elseif ft == "typescript" then
		return "bun test"
	elseif ft == "tsx" then
		return "bun run test"
	else
		vim.notify("No test command found for filetype '" .. ft .. "'", vim.log.levels.ERROR)
		return false
	end
end

M.open = function()
	local buf = vim.api.nvim_create_buf(false, true)
	local ft = vim.bo.filetype
	local c = getTestCommand(ft)
	if not c then
		return
	end
	vim.cmd("vsplit")
	local win = vim.api.nvim_get_current_win()
	vim.api.nvim_win_set_buf(win, buf)
	vim.fn.jobstart(c, {
		term = true,
		on_exit = function(_, code, _)
			if code == 0 then
				vim.notify("Test passed", vim.log.levels.INFO)
			else
				vim.notify("Test failed", vim.log.levels.ERROR)
			end
		end,
	})
	vim.api.nvim_buf_set_keymap(buf, "n", "q", ":q<CR>", { noremap = true, silent = true })
	M.win = win
end

vim.keymap.set("n", "<leader>tt", ":Test<CR>", { noremap = true, silent = true })
vim.api.nvim_create_user_command("Test", function()
	if M.win and vim.api.nvim_win_is_valid(M.win) then
		vim.api.nvim_win_close(M.win, true)
	end
	M.open()
end, {})

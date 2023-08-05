local home_dir=os.getenv("HOME")
local zprint_version = '1.2.7'
local zprint_path = home_dir .. "/zprintl-" .. zprint_version
if vim.fn.has('macunix') then
	zprint_path = home_dir .. "/zprintm-" .. zprint_version
end

function InstallZprintFiler()
	local f=io.open(zprint_path)
	print("setting key with " .. zprint_path)
	vim.keymap.set('v', '<leader>cf',  ":'<,'>!" .. zprint_path .. "<cr>")
	vim.keymap.set('n', '<leader>cx',  ":'<,'>!somethingdump<cr>")

	if vim.fn.executable('wget') ~= 1 then
		error('wget is not installed. please install first')
		return false
	end

	if f~=nil then
		io.close(f)
	        print("zprint exists " .. zprint_path)
	else
	        print("zprint does not exists at " .. zprint_path .. " installing")
		local command = "cd " .. home_dir .. " && curl -LJO https://github.com/kkinnear/zprint/releases/download/" .. zprint_version .. "/zprintm-".. zprint_version .. " && chmod +x " .. zprint_path
		-- local command = "cd " .. home_dir .. " && echo 'this is test' > nvim.test" 

		print("Command is " .. command)
		local status, err = pcall(os.execute, command)
		if status then
			print("command ran successfuly")
		else
			print("failed to run command " .. err)
		end
	end

end



local M = {}

M.setup = InstallZprintFiler

return M



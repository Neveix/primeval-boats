local M = {}

local players_mounted = {}

M.mount = {}

function M.mount.register_mount(pid, unmount_func)
	players_mounted[pid] = unmount_func
end

function M.mount.unmount(pid)
	local unmount_func = players_mounted[pid]
	players_mounted[pid] = nil
	if unmount_func ~= nil then
		unmount_func()
	end
end

function M.mount.unregister_mount(pid)
	players_mounted[pid] = nil
end

return M

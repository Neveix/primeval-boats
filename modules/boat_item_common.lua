local M = {}

local WATER_ID = block.index("base:water")
local RUST_ID = block.index("base:rust")
local MAX_BOAT_SPAWN_DISTANCE = 4

local function delete_item(pid)
	local inv, slot = player.get_inventory(pid)

	local item_id, item_count = inventory.get(inv, slot)
	if item_count > 0 then
		inventory.set(inv, slot, item_id, item_count - 1)
	end
end

function M.try_delete_item(pid)
	if not player.is_infinite_items(pid) then
		delete_item(pid)
	end
end

---@param pos vec3
local function spawn_particle(pos)
	gfx.particles.emit(pos, 1, {
		texture = "blocks:" .. block.get_textures(RUST_ID)[1],
		spawn_interval = 0,
		lifetime = 1,
		acceleration = { 0, 0, 0 },
		explosion = { 0, 0, 0 },
		size = { 0.1, 0.1, 0.1 },
		spawn_spread = { 0, 0, 0 },
	})
end

---@param pos1 vec3
---@param pos2 vec3
local function spawn_particles_between(pos1, pos2)
	local step = 0.1
	for x = pos1[1], pos2[1], step do
		spawn_particle({ x, pos1[2], pos1[3] })
		spawn_particle({ x, pos2[2], pos1[3] })
		spawn_particle({ x, pos1[2], pos2[3] })
		spawn_particle({ x, pos2[2], pos2[3] })
	end
	for y = pos1[2], pos2[2], step do
		spawn_particle({ pos1[1], y, pos1[3] })
		spawn_particle({ pos2[1], y, pos1[3] })
		spawn_particle({ pos1[1], y, pos2[3] })
		spawn_particle({ pos2[1], y, pos2[3] })
	end
	for z = pos1[3], pos2[3], step do
		spawn_particle({ pos1[1], pos1[2], z })
		spawn_particle({ pos2[1], pos1[2], z })
		spawn_particle({ pos1[1], pos2[2], z })
		spawn_particle({ pos2[1], pos2[2], z })
	end
end

M.placement_mutex = {
	locked_at = time.uptime(),
	lock_interval = 0.3,
}

--- It is used for preventing several boats spawning inside each other
---@return boolean success
function M.placement_mutex.try_lock()
	if time.uptime() - M.placement_mutex.locked_at < M.placement_mutex.lock_interval then
		return false
	end
	M.placement_mutex.locked_at = time.uptime()
	return true
end

--- Should be called when item used, to calculate boat position
---@param pid integer player id
---@param boat_entity_index integer
---@return boolean success, vec3|nil pos
function M.get_boat_placement_by_player(pid, boat_entity_index)
	local x, y, z = player.get_pos(pid)
	local dir = player.get_dir(pid)

	local res = block.raycast(
		{ x, y + 0.7, z },
		dir,
		MAX_BOAT_SPAWN_DISTANCE,
		{ nil, nil, nil, nil, nil, nil },
		{},
		true
	)
	if res == nil or res.block ~= WATER_ID and false then
		return false, nil
	end

	local pos = res.iendpoint
	if block.is_solid_at(pos[1], pos[2], pos[3]) or block.get(pos[1], pos[2], pos[3]) == WATER_ID then
		pos[2] = pos[2] + 1
	end

	if block.is_solid_at(pos[1], pos[2], pos[3]) then
		return false, nil
	end

	pos[1] = pos[1] + 0.5
	pos[3] = pos[3] + 0.5

	local hitbox = entities.def_hitbox(boat_entity_index)
	hitbox = vec3.mul(hitbox, 2)
	local hitbox_pos = vec3.add(pos, { 0, hitbox[2] / 2, 0 })
	local hibox_left_corner = vec3.sub(hitbox_pos, vec3.div(hitbox, 2))
	-- local hibox_right_corner = vec3.add(hitbox_pos, vec3.div(hitbox, 2))
	-- spawn_particles_between(hibox_left_corner, hibox_right_corner)

	local all_ents = entities.get_all_in_box(hibox_left_corner, hitbox)
	if table.count_pairs(all_ents) ~= 0 then
		return false, nil
	end

	return true, pos
end

function M.get_player_rotation_mat4(pid)
	local rx, _, _ = player.get_rot(pid, false)
	rx = rx + 90
	rx = math.round(rx / 45) * 45
	local rot = mat4.rotate({ 0, 1, 0 }, rx)
	return rot
end

return M

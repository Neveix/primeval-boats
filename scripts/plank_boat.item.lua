local PACK_ID = "primeval_boats"
local boat_item_common = require(PACK_ID .. ":boat_item_common")

local ENTITY_ID = PACK_ID .. ":plank_boat"

function on_use(pid)
	if boat_item_common.placement_mutex.try_lock() == false then
		return
	end
	local success, pos = boat_item_common.get_boat_placement_by_player(pid, entities.def_index(ENTITY_ID))
	if not success then
		return
	end
	boat_item_common.try_delete_item(pid)
	local rot = boat_item_common.get_player_rotation_mat4(pid)
	entities.spawn(ENTITY_ID, pos, {
		[PACK_ID .. "__boat"] = {
			rotation_mat4 = rot,
		},
	})
end

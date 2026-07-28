local PACK_ID = "primeval_boats"
local boat_utils = require("seat_commons:item_utils/boat")
local vehicle_utils = require("seat_commons:item_utils/vehicle")

local ENTITY_ID = PACK_ID .. ":kayak"

function on_use(pid)
	if boat_utils.placement_mutex.try_lock() == false then
		return
	end
	local success, pos = boat_utils.get_boat_placement_by_player(pid, entities.def_index(ENTITY_ID))
	if not success then
		return
	end
	boat_utils.try_delete_item(pid)
	local rot = vehicle_utils.get_vehicle_rotation_mat4(pid)
	entities.spawn(ENTITY_ID, pos, {
		["seat_commons__boat"] = {
			rotation_mat4 = rot,
		},
	})
end

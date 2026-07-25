local boat_comp = require("vehicle_api:components/boat")
---@type BoatComp
local C = boat_comp.C

function on_world_open()
	local old_on_used = C.on_used
	C.on_used = function(self, pid)
		-- console.chat("used!")
		old_on_used(self, pid)
	end
end

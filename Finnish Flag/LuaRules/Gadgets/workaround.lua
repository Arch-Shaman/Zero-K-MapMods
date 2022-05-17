if not (gadgetHandler:IsSyncedCode()) then
	return
end
function gadget:GetInfo()
	return {
		name      = "Workaround for Hovers",
		desc      = "Bypass water damage for hovers.",
		author    = "Shaman based on Kloot's original gadget",
		date      = "November 2013",
		license   = "CC-0",
		layer     = -3,
		enabled   = true
	}
end
local DAMAGE_EXTSOURCE_WATER = -5

function gadget:UnitPreDamaged(unitID, unitDefID, unitTeam, damage, paralyzer, weaponDefID, projectileID)
	local moveDef = UnitDefs[unitDefID].moveDef
	if weaponDefID ~= DAMAGE_EXTSOURCE_WATER or (moveDef == nil or moveDef.family ~= "hover") then
		return damage, 1.0 -- not water damage or not a hovercraft, do not modify
	else
		return 0.0, 1.0
	end
end

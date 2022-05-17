function gadget:GetInfo()
  return {
    name      = "Workaround for Hovers",
    desc      = "Gadget I took off the internet to bypass water damage in later spring versions. Precautionary measures.",
    author    = "Kloot made it I think, I just copy pasted",
    date      = "Idk..",
    license   = "I took it off the internet",
    layer     = -3,
    enabled   = true
  }
end
	

	

    if (gadgetHandler:IsSyncedCode()) then
      local DAMAGE_EXTSOURCE_WATER = -5
     
      function gadget:UnitPreDamaged(unitID, unitDefID, unitTeam, damage, paralyzer, weaponDefID, projectileID)
        if (weaponDefID ~= DAMAGE_EXTSOURCE_WATER) then
           -- not water damage, do not modify
           return damage, 1.0
        end
     
        local unitDef = UnitDefs[unitDefID]
        local moveDef = unitDef.moveDef
     
        if (moveDef == nil or moveDef.family ~= "hover") then
          -- not a hovercraft, do not modify
          return damage, 1.0
        end
     
        return 0.0, 1.0
      end
    end


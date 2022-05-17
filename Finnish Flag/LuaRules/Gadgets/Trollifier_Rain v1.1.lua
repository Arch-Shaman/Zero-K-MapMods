  function gadget:GetInfo()
    return {
      name      = "Trollifier: Suicidal Storm Module  v1.2",
      desc      = "A little release as part of the trollifier gadget. Makes units fall from the sky!",
      author    = "IrishDruid with help from xponen",
      date      = "Last Thursday",
      license   = "PINGAS",
      layer     = 5,
      enabled   = true,
    }
  end
  
    --declare variables--
  local rany 		= 0
  local ranx 		= 0
  local mapy 		= 0
  local mapx 		= 0
  local gaiaid 		= 0
  local testunit 	= 0
  local hello 		= 0
  local impx 		= 0
  local impy 		= 0
  local impz 		= 0
  local ticknum 	= 0
  local intensity 	= 30
  local missiles 	= false
  local ran 		= 0
  local hpbonus		= 0.3
  local barrage		= 4
  local gaiaunits
  local nuker		= {}
  local coms		= {}
  local randomtime	= 300
  local unitnotbounds	= false
  local unitarray	= {}
  local shiparray	= {}
  local techlevel 	= 1
  local nuketime	= 960
  local missiletime	= 100
  local nukers 		= 0
  local Zenith
  local DRP
  local zenithtime	= 300
  local drptime		= 300
  local missilearray	= {}
  local shiptime 	= 300
  local nukefrq		= 45
  local years		= 68
  local watchforme	= 0
  local comarray	= {}
  local arraypull	= 1
  local randomsecs	= 1
  
  --Speedups--
  local Echo 		= Spring.Echo
  local CreateUnit	= Spring.CreateUnit
  local DestroyUnit	= Spring.DestroyUnit
  local PlaySound	= Spring.PlaySoundFile
  local DamageUnit	= Spring.AddUnitDamage
  local Impulse 	= Spring.AddUnitImpulse
  local Order 		= Spring.GiveOrderToUnit
  local GetZ		= Spring.GetGroundHeight
  local Rotate		= Spring.SetUnitRotation
  local AlwaysVisible	= Spring.SetUnitAlwaysVisible
  local IsDead		= Spring.GetUnitIsDead
  
  --Sounds--
  local sounds_nuke 	= "Sounds\\Alert.ogg"		-- remove me later? possibly.
  local sounds_drain 	= "Sounds\\Bankrupt.ogg"
  local sounds_interest	= "Sounds\\interest.ogg"
  local sounds_die 	= "Sounds\\DIE.ogg"
  local sounds_spanish	= "Sounds\\Expect.ogg"
  local sounds_pingas	= "Sounds\\Pingas.ogg"
  local sounds_spam	= "Sounds\\spam.ogg"
  local sounds_wham	= "Sounds\\Whammy.ogg"
  local sounds_intense	= "Sounds\\intense.ogg"
  local sounds_diff	= "Sounds\\completely_different.ogg"
  local sounds_havoc	= "Sounds\\havoc.ogg"
  local sounds_song	= "Sounds\\PINGASSONG.ogg"
  local sounds_9000	= "Sounds\\9000.ogg"
  local sounds_EA	= "Sounds\\EA.ogg"
  local array_sounds	= {"Sounds\\Bankrupt.ogg", "Sounds\\interest.ogg", "Sounds\\DIE.ogg", "Sounds\\Expect.ogg", "Sounds\\Pingas.ogg", "Sounds\\spam.ogg", "Sounds\\Whammy.ogg", "Sounds\\intense.ogg", "Sounds\\completely_different.ogg", "Sounds\\havoc.ogg", "Sounds\\9000.ogg", "Sounds\\EA.ogg"}
  
  --Unitdefs--
  local roach 		= "corroach"
  local dirtbox 	= "corclog"
  local tick		= "armtick"
  local scuttle 	= "corsktl"
  local crusader	= "armroy"
  local enforcer	= "corroy"
  local frigate		= "coresupp"
  local skeeter		= "armpt"
  local pyro		= "corpyro2"
  local aaship		= "corarch"
  local carrier		= "armcarry"
  local destroyer	= "destroyer"
  local hca		= "assaultcruiser"
  local battleship	= "corbats"
  local racketeer	= "shieldarty"
  local pillager	= "cormart"
  local crabe		= "armcrabe"
  local punisher	= "hovershotgun"
  local morning		= "hoversonic"
  local duck		= "amphraider3"
  local flea		= "armflea"
  local merl		= "armmerl"
  local pene		= "armmanni"
  local sniper		= "armsnipe"
  local dodo		= "chicken_dodo"
  local soniccom	= "comm_sonic"
  local nuke		= "corsilo"
  local jug		= "gorg"
  local scorp		= "scorpion"
  local banisher	= "tawf114"
  local tremor		= "trem"
  local support		= "commsupport1"
  local reaper		= "correap"
  local sumo		= "corsumo"
  local dante		= "dante"
  local strikecom	= "cremcom1"
  local bhj		= "jumpblackhole"
  local funnel		= "funnelweb"
  local goliath		= "corgol"
  local battlecom	= "corcom1"
  local buoy		= "amphfloater"
  local dguner		= "armcomdgun"
  local hammer		= "armham"
  local detri		= "armorco"
  local cata		= "armraven"
  local razorback	= "armraz"
  local rocko		= "armrock"
  local recluse		= "armsptk"
  local warrior		= "armwar"
  local zeus		= "armzeus"
  local toad		= "chicken_shield"
  local white		= "chicken_dragon"
  local welder		= "coracv"
  local bandit		= "corak"
  local jack		= "corcan"
  local vandal		= "corcrash"
  local dart		= "corfav"
  local wolverine	= "corgarp"
  local scorcher	= "corgator"
  local leveler		= "corlevlr"
  local outlaw		= "cormak"
  local ravager		= "corraid"
  local copperhead	= "corsent"
  local scrubber	= "corsh"
  local rogue		= "corstorm"
  local thug		= "corthud"
  local firewalker	= "firewalker"
  local flail		= "hoveraa"
  local haldbard	= "hoverassault"
  local mace		= "hoverriot"
  local billshot	= "hoverskirm"
  local koda		= "logkoda"
  local scapel		= "nsaclash"
  local pather		= "panther"
  local hermit		= "spiderassault"
  local grizzley	= "amphassault"
  local scallop		= "amphriot"
  local bantha		= "armbanth"
  local scythe		= "spherepole"
  local moderator	= "slowmort"
  local glaive		= "armpw"
  local disco		= "raveparty"
  local blastwing	= "blastwing"
  local queen		= "chickenlandqueen"
  
  -- Constants --
  
  local array_tech1	= {flea,tick,dirtbox,welder,dart,scorcher,outlaw,scrubber,koda,moderator,glaive,duck,bandit,pyro}
  local array_tech2	= {roach,buoy,hammer,dodo,racketeer,rocko,warrior,toad,vandal,leveler,ravager,rogue,thug,mace,haldbard,panther,scallop}
  local array_tech3	= {reaper,merl,sniper,scuttle,banisher,armsptk,bhj,zeus,pillager,punisher,wolverine,copperhead,billshot,scapel,scythe,support}
  local array_tech4	= {"subscout",tremor,morning,jack,firewalker,flail,battlecom,strikecom}
  local array_tech5	= {goliath,sumo,pene,crabe,white,dguner,grizzley,soniccom}
  local array_ship	= {skeeter, crusader, enforcer, aaship, frigate, carrier, destroyer, hca, battleship}
  local array_strider	= {dguner,jug,scorp,dante,funnel,detri,cata,razorback,bantha,queen}
  local array_missile	= {"napalmmissile", "seismic", "tacnuke", "empmissile"}
  local array_strings	= {"Stupid Nub, Kills are for pros.", "Forgot to eat their wheaties.", "Forgot Poland.", "Stick to Commander Junior next time. It suits your skill level.",
			   "Silly Kamakazi, you Missed WWII by " .. years .. " years","Got Pingas'ed","Forgot their big stick","Didn't find love here","Won the death lottery","LOL! What a nub!",
			   "The reason why we can't have nice things", "Next time, read the newbie guide, noob","-_- WHY?!","No comment", "Wasn't Korean enough.", "Leave the micro to the Koreans pls.",
			   "Noob Alert!", "Fail", "Failed like Failer fails.", "Forgot to plop a brain.", "Boom! Headshot!", "TANGO DOWN!", "Commander Raeg Quit", "Fire is the best way to unwant something",
			   "Protip: You suck", "Protip: Read the newbie guide", "Protip: To kill enemy units, shoot at them until they die.", "Naaab!", "Nab", "L2Play nub", "Lol Fail", "U mad bro?",
			   "Trololololol", "Forgot their AA", "Fucks in sky.", "Y So mad?", "Too much porn, not enough game", "Was Under 9000!", "Became An Hero.", "Party V&","protip: Don't allow yourself to be provoked and don't be a douche.",
			   "Uses Attack instead of Fight", "NO YOU!!!", "BRB, FBI", "Forgot to water his cactus.", "fucks fucking fuck fucker","Less threatening than the love boat.","Earned their derploma",
			   "Ban Hammered", "Modabuse is srs business", "Raeg moar nub!", "Bananaed", "Spam moar fleas next time", "Honk!", "Lolwut?", "xponen was here", "Dont commorph next time!", "Didn't expect a kind of Spanish Inquisition", "Phailure is the path to n00bdom.",
			   "Every time a n00b dies, an angel cries.", "NOT TODAY ZURG!", "EPIC FAIL!", "Daily dose of FAIL right here."}
  -- local nukeweapon	= WeaponDefNames["corsilo_crblmssl"].id -- dont need this any more.
  -- BEGIN SCRIPT--
  
  if (gadgetHandler:IsSyncedCode()) then
    
    -- Toolbox Functions --
    
    local function NilCorrector(key,unittype)
      if unittype == "ship" then
	shiparray[key] = array_ship[math.random(1,#array_ship)]
	return
      end
      if unittype == "unit" then
	unitarray[key] = array_tech1[math.random(1,#array_tech1)]
	return
      end
      if unittype == "missile" then
	missilearray[key] = array_missile[math.random(1,#array_missile)]
	return
      end
    end
    
    
    local function BuildMissileArray(size)
      for i = 1, size do
        missilearray[i] = array_missile[math.random(1,#array_missile)]
      end
    end
    
    local function NukeCom(uid,x,y)
      Spring.SetUnitStockpile(uid,1,0)
      Order(uid,CMD.ATTACK,{x,GetZ(x,y),y},{})
    end
    
    local function NukeMe(uid,x,y)
      Spring.SetUnitStockpile(uid,1,0)
      Order(uid,CMD.ATTACK,{x,GetZ(x,y),y},{})
      SendToUnsynced("speccheat", "Real location is " .. x .. "," .. y .. ".")
      random = math.random(1,3)
      if random == 1 then
	ranx = math.random(0,mapx)
	rany = math.random(0,mapy)
	SendToUnsynced("mapmarker", "Incoming nuke!" ,ranx,rany)
	SendToUnsynced("mapmarker", "Incoming nuke!" ,x,y)
	ranx = math.random(0,mapx)
	rany = math.random(0,mapy)
	SendToUnsynced("mapmarker", "Incoming nuke!" ,ranx,rany)
      end
      if random == 2 then
	SendToUnsynced("mapmarker", "Incoming nuke!" ,x,y)
	ranx = math.random(0,mapx)
	rany = math.random(0,mapy)
	SendToUnsynced("mapmarker", "Incoming nuke!" ,ranx,rany)
	ranx = math.random(0,mapx)
	rany = math.random(0,mapy)
	SendToUnsynced("mapmarker", "Incoming nuke!" ,ranx,rany)
      end
      if random == 3 then
	ranx = math.random(0,mapx)
	rany = math.random(0,mapy)
	SendToUnsynced("mapmarker", "Incoming nuke!" ,ranx,rany)
	ranx = math.random(0,mapx)
	rany = math.random(0,mapy)
	SendToUnsynced("mapmarker", "Incoming nuke!" ,ranx,rany)
	SendToUnsynced("mapmarker", "Incoming nuke!" ,x,y)
      end
    end
    
    local function BuildUnitArray(size)
     for i=1, size do
	rannum = math.random(1,techlevel)
	if rannum == 1 then
	  unitarray[i] = array_tech1[math.random(1,#array_tech1)]
	end
	if rannum == 2 then
	  unitarray[i] = array_tech2[math.random(1,#array_tech2)]
	end
	if rannum == 3 then
	  unitarray[i] = array_tech3[math.random(1,#array_tech3)]
	end
	if rannum == 4 then
	  unitarray[i] = array_tech4[math.random(1,#array_tech4)]
	end
	if rannum == 5 then
	  unitarray[i] = array_tech5[math.random(1,#array_tech5)]
	end
	if rannum == 6 then
	  unitarray[i] = array_strider[math.random(1,#array_strider)]
	end
      end
   end
   
    local function BuildShipArray(size)
      for i=1, size do
	shiparray[i] = array_ship[math.random(1,#array_ship)]
      end
    end   
    
    local function teleportunit(uid,x,y,z)
      Spring.MoveCtrl.Enable(uid)
      Spring.MoveCtrl.SetPosition(uid,x,y,z)
      Spring.MoveCtrl.Disable(uid)
    end
    
    local function teleport(uid,x,y,z)
      Spring.MoveCtrl.Enable(uid)
      Spring.MoveCtrl.SetPosition(uid,x,y,z)
    end
    
    local function Impulser(uid,x,z,y)
      Impulse(uid, 0, 40, 0)
      Impulse(uid, x, z, y)
    end
    
    local function CheckPos(uid)
     --check x--
     if Spring.ValidUnitID(uid) == true then
       ux,uz,uy = Spring.GetUnitPosition(uid)
       if ux <= -200 then
         Impulse(uid, 1, 0.1, 0)
         unitnotbounds = true
       end
       if ux >= mapx+200 then
	  Impulse(uid, -1, 0.1, 0)
	  unitnotbounds = true
       end
       --check y--
       if uy <= -200 then
	  Impulse(uid, 0, 0.1, 1)
	  unitnotbounds = true
       end
       if uy >= mapy+200 then
         Impulse(uid, 0, 0.1, -1)
         unitnotbounds = true
       end
       if uz == GetZ(ux,uy) or uz <= 0 and unitnotbounds == false then
         DestroyUnit(uid, true, false)
       end
       if uz <= 0 and unitnotbounds == false then		-- Fix to hovercraft on water issue.
         DestroyUnit(uid,true,false)
       end
       unitnotbounds = false
     end
    end
    
    local function SpawnMacro(unittype,key)
      ranx = math.random(0, mapx)
      rany = math.random(0, mapy)
      impx = math.random(-4, 4)
      impy = math.random(-4, 4)
      impz = math.random(0, 5)
      impz = -impz-48
      if unittype == nil then
	NilCorrector(key, "unit")
	unittype = unitarray[math.random(1,#unitarray)]
      end
      testunit = CreateUnit(unittype, ranx, 1001, rany, "s", 0)				--work around?
      if Spring.ValidUnitID(testunit) == true then
	Spring.TransferUnit(testunit,gaiaid,false)
	Spring.SetUnitMaxHealth(testunit, (400*hpbonus))
	Spring.SetUnitHealth(testunit,(400*hpbonus))
	Impulser(testunit, impx, impz, impy)
	ran = math.random(0,10)
	if ran >= 4 then  
	  impx = math.random(-2,2)
	  impy = math.random(-2,2)
	  Rotate(testunit,impx,0,impy)
	else
	  impx = math.random(-2,2)
	  Rotate(testunit,0,impx,0)
	end
      end
    end
    
    local function UpdateArtilleryAttack(uid)
      ranx = math.random(0,mapx)
      rany = math.random(0,mapy)
      Order(testunit,CMD.ATTACK,{ranx,GetZ(ranx,rany),rany},{})
    end
    
    local function SpawnNuker()
     nuker[nukers+1] = CreateUnit(nuke, mapx, 1001, mapy, "s", 0)
     Spring.TransferUnit(nuker[nukers+1],gaiaid,false)
     teleport(nuker[nukers+1],mapx/2+math.random(-500,500),4500,mapy/2+math.random(-500,500))
     Spring.SetUnitCloak(nuker[nukers+1],true,4,1)
     Spring.SetUnitArmored(nuker[nukers+1],true,100)
     Spring.SetUnitStealth(nuker[nukers+1],true)
     nukers = nukers+1
    end
    
    local function SpawnMissile(unitdef,key)
    if key == nil or key == "bypass" then		-- bypass the checks.
      ranx = math.random(100, mapx)
      rany = math.random(100, mapy)
      testunit = CreateUnit(unitdef, ranx, 1001, rany, "s", 0)
      if Spring.ValidUnitID(testunit) == true then
	Spring.TransferUnit(testunit,gaiaid,false)
	teleport(testunit,ranx,1200,rany)
	ranx = ranx + math.random(-100, 100)
	rany = rany + math.random(-100, 100)
	Order(testunit,CMD.ATTACK,{ranx,GetZ(ranx,rany),rany},{})
      end
    else
      if missilearray[key] == nil then
	NilCorrector(key,"missile")
	unitdef = missilearray[math.random(1,#missilearray)]
      end
     ranx = math.random(100, mapx)
     rany = math.random(100, mapy)
     testunit = CreateUnit(unitdef, ranx, 1001, rany, "s", 0)
     if Spring.ValidUnitID(testunit) == true then
	Spring.TransferUnit(testunit,gaiaid,false)
	teleport(testunit,ranx,1200,rany)
	ranx = ranx + math.random(-100, 100)
       rany = rany + math.random(-100, 100)
       Order(testunit,CMD.ATTACK,{ranx,GetZ(ranx,rany),rany},{})
       end
     end
   end
   
    
    local function SpawnShip(unittype)
      ranx = math.random(100, mapx)
      rany = math.random(100, mapy)
      impx = math.random(0,4)
      impy = math.random(0,4)
      testunit = CreateUnit(unittype, ranx, 1001, rany, "s", 0)
      if Spring.ValidUnitID(testunit) == true then
	Spring.TransferUnit(testunit,gaiaid,false)
	Impulser(testunit, impx, -42, impy)
	Spring.SetUnitMaxHealth(testunit, (750*hpbonus))
	Spring.SetUnitHealth(testunit,(750*hpbonus))
	Rotate(testunit,impx,2,impy)
      end
    end
    
    local function tickstorm()
      arraypull = math.random(1,#unitarray)
      SpawnMacro(unitarray[arraypull],arraypull)
      if barrage >= 0 and missiles then
	arraypull = math.random(1,#missilearray)
        SpawnMissile(missilearray[arraypull],arraypull)
        barrage = barrage - 1
      end
      if math.random(0,10) >= 5 and Spring.GetGameFrame() >= shiptime then
	SpawnShip(shiparray[arraypull])
      end
    end
    
    local function SkuttleStorm(unittype)
      ranx = math.random(100, mapx)
      rany = math.random(100, mapy)
      impx = math.random(0,4)
      impy = math.random(0,4)
      unit = CreateUnit(unittype, ranx, 1001, rany, "s", 0)
      Spring.TransferUnit(unit,gaiaid,false)
      Spring.SetUnitCloak(unit,true,4,1)
      Spring.SetUnitStealth(unit,true)
      Impulser(unit, impx, -49, impy)
      Rotate(unit,impx,2,impy)
    end
    
    local function CheckMessage(frame)
      if frame == 30 then
	eta = randomsecs + math.random(-30,30)
	Echo("Trollstorm ETA: " .. eta .. " seconds.")
      end
      if frame == missiletime then
	BuildMissileArray(30)
	missiles = true
	Echo("Warning: The Trollgeon General suggests eating missiles. Heres some on the house!")
	SendToUnsynced("sounder", sounds_wham)
      end
      if frame == nuketime then
	missiles = false
	SpawnNuker()
	SpawnNuker()
	SendToUnsynced("sounder", sounds_EA)
	Echo("WARNING: You have failed to end the game by this point. Nukes will start launching. Yeah? Well fuck you too mate.")
      end
      if frame == drptime then
       DRP = CreateUnit(disco, -750, 1001, -750, "s", 0)
       teleport(DRP,-750,1001,-750)
       Spring.TransferUnit(DRP,gaiaid,false)
       Spring.SetUnitCloak(DRP,true,4,1)
       Spring.SetUnitArmored(DRP,true,100)
       Spring.SetUnitStealth(DRP,true)
       Echo("WARNING: Epic lulz launch detected!")
      end
      if frame == zenithtime then
       Echo("Warning: Lulz shower incoming.")
       missiles = false
       Zenith = CreateUnit("zenith", 1000, 1001, 1000, 0, "s")
       Spring.TransferUnit(Zenith,gaiaid,false)
       teleport(Zenith,mapx/2,3001,mapy/2)
       Spring.SetUnitStealth(Zenith,true)
       Spring.SetUnitCloak(Zenith,true,4,1)
       Spring.SetUnitArmored(Zenith,true,100)
       SendToUnsynced("sounder", sounds_spanish,2.0)
      end
    end
    
    local function DetriDrop(unittype)
      ranx = math.random(100, mapx)
      rany = math.random(100, mapy)
      impx = math.random(0,4)
      impy = math.random(0,4)
      unit = CreateUnit(unittype, ranx, 1001, rany, "s", 0)
      Spring.TransferUnit(unit,gaiaid,false)
      Spring.SetUnitCloak(unit,true,4,1)
      Spring.SetUnitStealth(unit,true)
      Impulser(unit, impx, -40, impy)
      Rotate(unit,impx,2,impy)
    end
    
    local function DropUnit(unittype,x,y)
      impx = math.random(0,4)
      impy = math.random(0,4)
      unit = CreateUnit(unittype,x,1001,y,"s",0)
      Spring.TransferUnit(unit,gaiaid,false)
      Spring.SetUnitCloak(unit,true,4,1)
      Spring.SetUnitStealth(unit,true)
      Impulser(unit,impx,-47,impy)
      Rotate(unit,impx,2,impy)
    end
    
    
    local function EventSystem()
      eventid = math.random(0,20)
     if eventid == 0 then			-- Carrier Fleet!
       for i=1, 10 do
	  SpawnShip(carrier)
	end
      Echo("Chickens unleashing plot: Carrier assault!")
      end
      if eventid == 1 then			-- Battleship Fleet
       for i=1, 5 do
	  SpawnShip(battleship)
	end
	Echo("Chickens unleashing plot: Orbital Bombardment!")
      end
      if eventid == 2 then
	if #nuker == 0 then
	  SpawnNuker()
	  SpawnNuker()
	end
        for i=1, #nuker do
	  NukeMe(nuker[i], math.random(0,mapx), math.random(0,mapy))
        end
        Echo("World War III has started!!!")
      end
      if eventid == 3 then			 -- Skuttle Storm!
        for i=1, 40 do
	  SkuttleStorm(scuttle)
        end
        Echo("Chickens unleashing plot: SkuttleStorm!")
      end
      if eventid == 4 then			 -- Roach Storm!
        for i=1, 40 do
	  SkuttleStorm(roach)
        end
        Echo("Chickens unleashing plot: RoachStorm!")
      end
      if eventid == 5 then			 -- Detri drop!
        Echo("Chickens unleashing plot: Detri Drop")
        DetriDrop(detri)
        DetriDrop(detri)
      end
      if eventid == 6 then			 -- Flying ultis
        Echo("Chickens unleashing plot: LOL WUT?")
        for i=1, 10 do
	  DetriDrop(dguner)
        end
      end
      if eventid == 7 then			 -- Flying sonic coms
        Echo("Chickens unleashing plot: Your mum")
        for i=1, 40 do
	  DetriDrop(soniccom)
        end
      end
      if eventid == 8 then			 -- Let's shuffle all units' positions for teh lulz.
        Echo("Chickens unleashing plot: Fuck in sky.")
        allunits = Spring.GetAllUnits()
        for i=1, #allunits do
	  x,y,z = Spring.GetUnitPosition()
	  if y == GetZ(x,z) then
	    isOnGround = true
	  end
	  if Spring.GetUnitTeam(allunits[i]) ~= gaiaid and isOnGround then
	    x = math.random(0,mapx)
	    y = math.random(0,mapy)
	    teleportunit(allunits[i],x,GetZ(x,y),y)
	  end
        end
      end
      if eventid == 9 then			 -- Profit!
	allunits = Spring.GetAllUnits()
	for i=1, #allunits do
	  uid = allunits[i]
	  unitDefID = Spring.GetUnitDefID(allunits[i])
	  if Spring.GetUnitTeam(allunits[i]) ~= gaiaid and UnitDefs[unitDefID].customParams.commtype or UnitDefs[unitDefID].customParams.iscommander then
	    comarray[#comarray+1] = allunits[i]
	  end
	end
	if #comarray == 0 then
	  return
	else
	  watchforme = comarray[math.random(1,#comarray)]
	  x,_,y = Spring.GetUnitPosition(watchforme)
	  DropUnit(scuttle,x,y)
	  Echo("Chickens unleashing plot: Hammer Time")
	end
      end
      if eventid == 10 then			 -- Nuke com
	allunits = Spring.GetAllUnits()
	for i=1, #allunits do
	  uid = allunits[i]
	  unitDefID = Spring.GetUnitDefID(allunits[i])
	  if Spring.GetUnitTeam(allunits[i]) ~= gaiaid and UnitDefs[unitDefID].customParams.commtype or UnitDefs[unitDefID].customParams.iscommander then
	    comarray[#comarray+1] = allunits[i]
	  end
	end
	if #comarray == 0 then
	  return
	end
	watchforme = comarray[math.random(1,#comarray)]
	x,_,y = Spring.GetUnitPosition(watchforme)
	for i=1, #nuker do
	  NukeCom(nuker[i],x,y)
	end
      end
      if eventid == 11 then			-- Carpetbombing
	y = math.random(0,mapy)
	for i=1, mapx/100 do
	  DropUnit(roach,i*100,y)
	end
	Echo("Chickens unleashing plot: U MAD BRO?")
      end
      if eventid == 12 then			--
	num = math.random(1,5)*3
	for i=1, num do
	  SendToUnsynced("mapmarker", "Incoming nuke!" ,math.random(0,mapx),math.random(0,mapy))
	end
	Echo("World War III has started!!!")
      end
      if eventid == 13 then			-- rain debris
	for i=1, 40 do
	  unit = CreateUnit(blastwing,0,1001,0,"s",0)
	  Spring.TransferUnit(unit, gaiaid, false)
	  teleport(unit,math.random(0,mapx),400,math.random(0,mapy))
	  DestroyUnit(unit,true,false)
	end
      end
      if eventid == 14 then			-- additional nukers
	for i=1, 40 do
	  SpawnMissile("tacnuke", "bypass")
	end
	Echo("Chickens unleashing plot: Penetrator Drop!")
      end
      if eventid == 15 then			-- hammer time
	for i=1, 40 do
	  SpawnMacro(hammer)
	end
	Echo("Its hammer time!")
      end
      if eventid == 16 then			-- Carpet Bomb
	x = math.random(0,mapx)
	for i=1, mapy/100 do
	  DropUnit(roach,x,i*100)
	end
	Echo("Chickens unleashing plot: U MAD BRO?")
      end
      if eventid == 17 then			-- QUEEN DROP!
	for i=1, 3 do
	  DetriDrop(queen)
	end
	Echo("The Hive is angered!")
      end
      if eventid == 18 then			-- Tickstorm!
	Echo("Chickens unleashing plot: FAIL MODE!")
	for i=1, 40 do
	  DropUnit(tick, math.random(0,mapx),math.random(0,mapy))
	end
      end
      if eventid == 19 then			-- Penes!!!
	for i=1, 30 do
	  DetriDrop(pene)
	end
	Echo("Chickens unleashing plot: Siberian Husky assault.")
      end
      if eventid == 20 then			--SNIPERS OMFG
	for i=1,40 do
	  DetriDrop(sniper)
	end
	Echo("Chickens unleashing plot: Orbital Sniper Base")
      end
    end
    
    -- Gadget Functions --
    
    function gadget:GameStart()
     gaiaid = Spring.GetGaiaTeamID()
     hello = math.random(1,3)
     if hello == 1 then
       SendToUnsynced("sounder", sounds_pingas,2.0)
     end
     if hello == 2 then
       SendToUnsynced("sounder", sounds_die,1.5)
     end
     if hello == 3 then
       SendToUnsynced("sounder", sounds_drain,1.0)
     end
     BuildShipArray(40)
     SpawnNuker()
     SpawnNuker()
     SendToUnsynced("announcement", "Trolly Rain Gadget v1.2 by [ISP]IrishDruid. Please enjoy your doom. Thank you :-)")
     SendToUnsynced("speccheat", "Startup time is: " .. randomtime/30 .. " seconds into the game.")
     SendToUnsynced("speccheat", "Nukes will arrive in " .. nuketime/30 .. " seconds.")
     SendToUnsynced("speccheat", "Zenith comes at: " .. zenithtime/30 .. ".")
     SendToUnsynced("speccheat", "Tech progression rate is: " .. techrate/30 .. ".")
     SendToUnsynced("playerchat", 0, "We recommend you turn off gui_news_ticker.lua widget or the battle will get very annoying.")
     SendToUnsynced("setcolour", gaiaid,math.random(),math.random(),math.random())
     allunits = Spring.GetAllUnits()		-- am i neccessary?
     BuildMissileArray(30)
    end
    
    function gadget:GameFrame(frame)
      if frame >= randomtime and frame%techrate == 0 and techlevel <= 5 then
	techlevel = techlevel + 1
      end
      if frame%900 == 0 then
	BuildUnitArray(30)
	hpbonus = hpbonus+0.05
      end
      if frame%1800 == 1799 then
	BuildShipArray(30)
	nukefrq = math.random(30,120)
	nukefrq = nukefrq*30
      end
      if frame == randomtime then
       hello = math.random(1,30)
	if hello <= 10 then
	  SendToUnsynced("sounder", sounds_nuke)
	end
	if hello >= 11 and hello <= 20 then
	  SendToUnsynced("sounder", sounds_song)
	end
	if hello >= 21 then
	  SendToUnsynced("sounder", sounds_EA, 2.0)
	end
      end
      if frame%30 == 0 and frame <= zenithtime+1 then
	CheckMessage(frame)
      end
      ran = math.random(0,4)
      if frame == 90 and ran == 2 then
	NukeMe(nuker[1],math.random(0,mapx),math.random(0,mapy))
      end
      if frame == 90 and ran == 3 then
	NukeMe(nuker[1],math.random(0,mapx),math.random(0,mapy))
	NukeMe(nuker[2],math.random(0,mapx),math.random(0,mapy))
      end
      if frame%3600 == 30 and missiles then
	BuildMissileArray(30)
      end
      if frame%10 == 0 then
	gaiaunits = Spring.GetTeamUnits(gaiaid)
	for i=1, #gaiaunits do
	  CheckPos(gaiaunits[i])
	end
      end
      if frame >= randomtime and frame%6000 == 0 then
	EventSystem()
      end
      if frame >= nuketime and frame%10800 == 0 then
	SpawnNuker()
      end
      if frame >= nuketime and frame%nukefrq == 0 then
	for i=1, #nuker do
	  NukeMe(nuker[i], math.random(0,mapx), math.random(0,mapy))
	end
     end
     if frame >= zenithtime and frame%300 == 0 then
       UpdateArtilleryAttack(Zenith)
     end
     if frame >= drptime and frame%300 == 5 then
       UpdateArtilleryAttack(DRP)
     end
      if frame%3600 == 0 and frame >= missiletime and missiles then
	barrage = barrage + math.random(1,10) + 600/intensity
      end
      if frame >= randomtime and frame%intensity == 0 then
	tickstorm()
      end
      if frame >= randomtime and frame%1800 == 0 then
	intensity = math.random(5,60)
	stormlvl = 30/intensity
	Echo("New intensity level: " .. stormlvl .. " drops per second.")
      end
    end
    
    function gadget:UnitDestroyed(unitID, unitDefID, UnitTeam, attackerID, attackerTeamID)
      if UnitDefs[unitDefID].customParams.commtype or UnitDefs[unitDefID].customParams.iscommander then
	if Spring.GetUnitRulesParam(unitID, "wasMorphedTo") == nil and UnitTeam ~= gaiaid then
	  if unitID ~= watchforme then
	    x,y,z = Spring.GetUnitPosition(unitID)
	    SendToUnsynced("sounder", array_sounds[math.random(1,#array_sounds)], 1.0)
	    SendToUnsynced("mapmarker", array_strings[math.random(1,#array_strings)], x, z)
	  else
	    x,y,z = Spring.GetUnitPosition(unitID)
	    SendToUnsynced("sounder", array_sounds[math.random(1,#array_sounds)], 1.0)
	    SendToUnsynced("mapmarker", "U Mad?", x, z)
	  end
	end
      end
      for i=1, #nuker do											-- Check if nuker is alive
	if unitID == nuker[i] then
	  nuker[i] = CreateUnit(nuke, mapx, 1001, mapy, "s", 0)
	  Spring.TransferUnit(nuker[i],gaiaid,false)
	  teleport(nuker[i],mapx/2+math.random(-500,500),1500,mapy/2+math.random(-500,500))
	  Spring.SetUnitCloak(nuker[i],true,4,1)
	  Spring.SetUnitArmored(nuker[i],true,100)
	  Spring.SetUnitStealth(nuker[i],true)
	end
      end
    end
    
    function gadget:Initialize()
     if Game.modShortName ~= "ZK" then
       Echo("[WARNING]: Trollifier Gadget is not compatiable with this Mod. Please use Zero-K for the time being.")
       gadgetHandler:RemoveGadget()
       return
     end
     mapx = Game.mapSizeX
     mapy = Game.mapSizeZ
     randomtime = math.random(70,300)
     randomsecs = randomtime
     nuketime = math.random(randomtime+900,randomtime+1500)
     missiletime = math.random(randomtime+300,randomtime+600)
     zenithtime = math.random(randomtime+1000,randomtime+1600)
     drptime = math.random(randomtime+1500,randomtime+2000)
     shiptime = math.random(randomtime+240,randomtime+600)
     techrate = math.random(30,450)
     randomtime = randomtime*30
     techrate = techrate*30
     missiletime = missiletime*30
     nuketime = nuketime*30
     zenithtime = zenithtime*30
     drptime = drptime*30
     shiptime = shiptime*30
    end
    
    function gadget:GameOver()
      Echo("[Trollifier Rain Gadget]: Game over. Writing variables to infolog for review.")
      Echo("Gaia ID: " .. gaiaid)
      Echo("Start time: " .. randomtime/30)
      Echo("Missiles start time: " .. missiletime/30)
      Echo("Nuke start time: " .. nuketime/30)
      Echo("Zenith time: " .. zenithtime/30)
      Echo("Rave Party time: " .. drptime/30)
      Echo("Ship time: " .. shiptime/30)
      Echo("Tech Progression rate: " .. techrate/30)
      Echo("--Nuke IDs--")
      for i=1, #nuker do
	Echo("nuker[" .. i .. "] = " .. nuker[i])
      end
    end
    
    
else
    
    local function sounder(_,file,vol)
      if vol == nil or vol == 0 then
	vol = 1.0
      end
      PlaySound(file,vol)
    end
    
    local function teamchat(_,id,text)
      Spring.SendMessageToAllyTeam(id,text)
    end
    
    local function setcolour(_,id,r,b,g)
      Spring.SetTeamColor(id,r,b,g)
    end
    
    local function mapmarker(_,text,x,y)
      Spring.MarkerAddPoint(x,GetZ(x,y),y,text,true)
    end
    
    local function announcement(_,text)
      Spring.SendMessage(text)
    end
    
    local function speccheat(_,text)
      Spring.SendMessageToSpectators(text)
    end
    
    local function playerchat(_,id,text)
      Spring.SendMessageToPlayer(id,text)
    end
    
    function gadget:Initialize()
      gadgetHandler:AddSyncAction("sounder", sounder)
      gadgetHandler:AddSyncAction("mapmarker", mapmarker)
      gadgetHandler:AddSyncAction("announcement", announcement)
      gadgetHandler:AddSyncAction("speccheat", speccheat)
      gadgetHandler:AddSyncAction("playerchat", playerchat)
      gadgetHandler:AddSyncAction("teamchat", teamchat)
      gadgetHandler:AddSyncAction("setcolour", setcolour)
    end
  end
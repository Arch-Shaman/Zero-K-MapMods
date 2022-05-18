function gadget:GetInfo()
	return {
		name      = "Finnish Flag Announcer",
		desc      = "Handles the Unsynced stuff.",
		author    = "Shaman",
		date      = "17 May 2022",
		license   = "CC-0",
		layer     = -100,
		enabled   = true,
	}
end

local spEcho = Spring.Echo

if not gadgetHandler:IsSyncedCode() then
	local spGetGroundHeight = Spring.GetGroundHeight
	local spGetSpectatingState = Spring.GetSpectatingState
	local spMarkerAddPoint = Spring.MarkerAddPoint
	local spPlaySoundFile = Spring.PlaySoundFile
	local spSetTeamColor = Spring.SetTeamColor
	
	local function SendMapMarker(_, x, z, text, specsreceive, playersreceive)
		local y = spGetGroundHeight(x, z)
		local spectating = spGetSpectatingState()
		if (specsreceive and spectating) or (playersreceive and not spectating) then
			spMarkerAddPoint(x, y, z, text, true)
		end
	end
	
	local function SendAnnouncementToSpecs(_, text)
		if spGetSpectatingState() then
			spEcho("game_message: " .. text)
		end
	end
	
	local function PlaySound(_, file, vol)
		if not vol then
			vol = 1
		end
		spPlaySoundFile(file, vol)
	end
	
	local function SetTeamColor(_, teamID, r, g, b) -- takes 0 - 255 for each.
		spSetTeamColor(teamID, r/255, g/255, b/255)
	end
	
	function gadget:Initialize()
		gadgetHandler:AddSyncAction("sendmapmarker", SendMapMarker)
		gadgetHandler:AddSyncAction("sendannouncementtospecs", SendAnnouncementToSpecs)
		gadgetHandler:AddSyncAction("playsound", PlaySound)
		gadgetHandler:AddSyncAction("setteamcolor", SetTeamColor)
	end
	return
end

local function SendAnnouncement(text, specsonly)
	if specsonly then
		SendToUnsynced("sendannouncementtospecs", text)
	else
		spEcho("game_message: " .. text)
	end
end

local function SendMapMarker(x, z, text, specs, players)
	SendToUnsynced("sendmapmarker", x, z, text, specs, players)
end

local function PlaySound(file, vol)
	SendToUnsynced("playsound", file, vol)
end

local function SetTeamColor(teamID, r, b, g)
	SendToUnsynced("setteamcolor", teamID, r, b, g)
end

function gadget:GameStart()
	SendAnnouncement("Warning: Coffee Magic has reached critical levels!\nThings are about to get weird, Commander.\nBuild your shelter quickly!")
end

GG.Announcements = {SetTeamColor = SetTeamColor, Say = SendAnnouncement, MapMarker = SendMapMarker, PlaySound = PlaySound}

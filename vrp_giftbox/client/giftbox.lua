--[[
    FiveM Scripts
    The Official HackerGeo Script 
	WEBISTE: www.HackerGeo.com
	GITHUB: GITHUB.com/HackerGeoTheBest
	STEAM: SteamCommunity.com/id/HackerGeo1

]]

--------------------------------------------------------------------------------------------------------------------
------------------------------------------- Official Scripts by HackerGeo ------------------------------------------
--------------------------------------------------------------------------------------------------------------------




local giftbox = {
	{ ['x'] = -1693.3385009766, ['y'] = -1099.624633789,['z'] = 13.152355194092} -- giftbox
}

Citizen.CreateThread(function()
	for i = 1, #giftbox, 1 do
		local szGiftBox = giftbox[i].x, giftbox[i].y, giftbox[i].z
	end
end)
tagH = 1

local function RGBRainbow( frequency )
	local result = {}
	local curtime = GetGameTimer() / 1000

	result.r = math.floor( math.sin( curtime * frequency + 0 ) * 127 + 128 )
	result.g = math.floor( math.sin( curtime * frequency + 2 ) * 127 + 128 )
	result.b = math.floor( math.sin( curtime * frequency + 4 ) * 127 + 128 )
	
	return result
end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(2)
		local pos = GetEntityCoords(GetPlayerPed(-1), true)

		for i = 1, #giftbox, 1 do
			local rainbow = RGBRainbow( 1 )
			infogift( giftbox[i].x, giftbox[i].y, giftbox[i].z + tagH, "GiftBox")
            DrawMarker(42, giftbox[i].x, giftbox[i].y, giftbox[i].z , 0, 0, 0, 0, 0, 0, 1.0001,1.0001,1.0001, rainbow.r, rainbow.g, rainbow.b, 255, 1, 0, 2, 1, 0, 0)
		end
	end
end)

function infogift(x,y,z, text) 
	local onScreen,_x,_y=World3dToScreen2d(x,y,z)
	local px,py,pz=table.unpack(GetGameplayCamCoords())
	local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)
  
	local scale = (1/dist)*2
	local fov = (1/GetGameplayCamFov())*130
	local scale = scale*fov
	

	
	if onScreen then
		SetTextScale(0.4*scale, 0.7*scale)
		SetTextFont(1)
		SetTextProportional(1)
		local rainbow = RGBRainbow( 1 )
		SetTextColour( rainbow.r, rainbow.g, rainbow.b, 255 )
		SetTextDropshadow(0, 0, 0, 0, 255)
		SetTextEdge(2, 0, 0, 0, 150)
		SetTextDropShadow()
		SetTextOutline()
		SetTextEntry("STRING")
		SetTextCentre(1)
		AddTextComponentString(text)
	  World3dToScreen2d(x,y,z, 0) 
		DrawText(_x,_y)
	end
  end
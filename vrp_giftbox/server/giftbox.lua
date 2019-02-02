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




local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","vrp_giftbox")

local giftOn = false
local giftReward = math.random(1000,5000)

bID = {}

local giftPos = {
	{-1693.3385009766,-1099.624633789,13.152355194092}
}

RegisterNetEvent('autoStopGiftBox')
AddEventHandler('autoStopTGiftBox', function()
	giftOn = false
	TriggerClientEvent('chatMessage', -1, "^4[GIFTBOX] ^7NIMENI NU A LUAT ^1GIFTBOX-ul!")
	local users = vRP.getUsers({})
	for k, v in pairs(users) do
		thePlayer = v
		plyerIndex = k
		for i, v in pairs(giftPos) do
			local blipID = "vRP:giftBlip:"..i..":"..plyerIndex
			vRPclient.removeNamedBlip(thePlayer,{blipID})
		end
		local areaID = "vRP:giftLoc:"..plyerIndex
		vRPclient.removeNamedMarker(thePlayer,{"vRP:giftMarker:"..plyerIndex})
		vRP.removeArea({thePlayer,areaID})	
	end
end)

function startGiftBox()
	if(giftOn == false)then
		giftOn = true
		giftReward = math.random(1000,5000)
		TriggerClientEvent('chatMessage', -1, "^4[GIFTBOX] ^1GIFTBOX-ul ^7A INCEPUT! MERGI LA ^4DOLARUL ALBASTRU ^7DE PE PLAJA PENTRU A-L LUA!")
		local function gift_enter(source,area)
			local user_id = vRP.getUserId({source})
			local users = vRP.getUsers({})
			for k, v in pairs(users) do
				thePlayer = v
				plyerIndex = k
				for i, v in pairs(giftPos) do
					local blipID = "vRP:giftBlip:"..i..":"..plyerIndex
					vRPclient.removeNamedBlip(thePlayer,{blipID})
				end
				local areaID = "vRP:giftLoc:"..plyerIndex
				vRPclient.removeNamedMarker(thePlayer,{"vRP:giftMarker:"..plyerIndex})
				vRP.removeArea({thePlayer,areaID})
			end
		
			vRPclient.notify(source,{"~r~AI PRIMIT ~g~"..giftReward.." ~r~LEI!"})
			vRP.giveMoney({user_id,giftReward})
			TriggerClientEvent('chatMessage', -1, "^4[GIFTBOX] ^1"..GetPlayerName(source).." ^7a luat primul ^1GIFTBOX-ul^7 si a primit ^4"..giftReward.." Lei")
			giftOn = false
		end
			local function gift_leave(source,area)
			return true
		end
		
		local users = vRP.getUsers({})
		for k, v in pairs(users) do
			thePlayer = v
			plyerIndex = k
			for i, v in pairs(giftPos) do
				local pos = v
				local x, y, z = v[1], v[2], v[3]
				local blipID = "vRP:giftBlip:"..i..":"..plyerIndex
				vRPclient.setNamedBlip(thePlayer,{blipID,x,y,z,108,3,"GiftBox"})
			end
		end
		
		local randLoc = math.random(#giftPos)
		
		local x, y, z = giftPos[randLoc][1], giftPos[randLoc][2], giftPos[randLoc][3]
		for i, v in pairs(users) do
			vRP.setArea({v,"vRP:giftLoc:"..i,x,y,z,1,1.5,gift_enter,gift_leave})
			vRPclient.setNamedMarker(v,{"vRP:giftMarker:"..i,x,y,z,0.7,0.7,0.5,255,245,0,125,150})
	end
	
	SetTimeout(1800000, function()
		if (giftOn == true) then
				TriggerEvent('autoStopGiftBox')
			end
		end)
	end	
end

RegisterCommand("giftbox", function(source, args, rawCommand)
	local user_id = vRP.getUserId({source})
	if user_id ~= nil and vRP.hasPermission({user_id,"admin.giftbox"}) then
		if(giftOn == false)then
			startGiftBox()
		else
			vRPclient.notify(source,{"~r~SE AFLA DEJA UN GIFTBOX!"})
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Wait(3600000)
		startGiftBox()
	end
end)

_GIFTBOXv = '0.1.6'
PerformHttpRequest( "https://www.hackergeo.com/version.txt", function( err, text, headers )
	Citizen.Wait( 1000 ) -- just to reduce clutter in the console on startup 
	RconPrint( "\nYour GiftBox Version: " .. _GIFTBOXv)
	RconPrint( "\nNew GiftBox Version: " .. text)
	
	if ( text ~= _GIFTBOXv ) then
		RconPrint( "\n\n\t|||||||||||||||||||||||||||||||||\n\t||     Giftbox is Outdated     ||\n\t|| Download the latest version ||\n\t||    From the HackerGeo.com   ||\n\t|||||||||||||||||||||||||||||||||\n\n" )
	else
		RconPrint( "\n\n\t|||||||||||||||||||||||||||||||||\n\t||                             ||\n\t||    GiftBox is up to date    ||\n\t||                             ||\n\t|||||||||||||||||||||||||||||||||\n\n" )
		RconPrint( "\nGiftBox is up to date!\n" )
	end
end, "GET", "", { what = 'this' } )

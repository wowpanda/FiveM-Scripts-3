--[[
    FiveM Scripts
    The Official HackerGeo Script 
	WEBISTE: www.HackerGeo.com
	GITHUB: GITHUB.com/HackerGeo-sp1ne
	STEAM: SteamCommunity.com/id/HackerGeo1

]]

--------------------------------------------------------------------------------------------------------------------
------------------------------------------- Official Scripts by HackerGeo ------------------------------------------
--------------------------------------------------------------------------------------------------------------------



local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","HG_AntiCheat")

RegisterServerEvent("HG_AntiCheat:Weapon")
AddEventHandler("HG_AntiCheat:Weapon", function()
	local user_id = vRP.getUserId({source})
	local player = vRP.getUserSource({user_id})
	local name = GetPlayerName(source)
	print("[HG_AntiCheat] | " ..name.. "["..user_id.. "] A PRIMIT KICK (WEAPON BLACKLISTED)!")
	TriggerClientEvent('chatMessage', -1, '^3[HG_AntiCheat]', {255, 0, 0}, "^1" ..name.. "^3[ID:" ..user_id.. "]^1 A PRIMIT KICK ^3(reason: WEAPON BLACKLISTED)!" )
    DropPlayer(source, "[HG_AntiCheat] | AI FOST DETECTAT CU HACK! (WEAPON BLACKLISTED)")
end)

RegisterServerEvent("HG_AntiCheat:Cars")
AddEventHandler("HG_AntiCheat:Cars", function()
	local user_id = vRP.getUserId({source})
	local player = vRP.getUserSource({user_id})
	local name = GetPlayerName(source)
	print("[HG_AntiCheat] | " ..name.. "["..user_id.. "] A PRIMIT KICK (CARS BLACKLISTED)!")
	TriggerClientEvent('chatMessage', -1, '^3[HG_AntiCheat]', {255, 0, 0}, "^1" ..name.. "^3[ID:" ..user_id.. "]^1 A PRIMIT KICK ^3(reason: CARS BLACKLISTED)!" )
    DropPlayer(source, "[HG_AntiCheat] | AI FOST DETECTAT CU HACK! (CARS BLACKLISTED)")
end)

_vHG_AntiCheat = '1.0.0'
PerformHttpRequest( "https://www.hackergeo.com/anticheat.txt", function( err, text, headers )
	Citizen.Wait( 1000 )
	local resourceName = "("..GetCurrentResourceName()..")"
	RconPrint( "\nYour AntiCheat Version: " .. _vHG_AntiCheat)
	RconPrint( "\nNew AntiCheat Version: " .. text)
	
	if ( text ~= _vHG_AntiCheat ) then
		RconPrint( "\n\n\t|||||||||||||||||||||||||||||||||\n\t|| ".. resourceName .." is Outdated! ||\n\t|| Download the latest version ||\n\t||    From the HackerGeo.com   ||\n\t|||||||||||||||||||||||||||||||||\n\n" )
	else
		RconPrint( "\n\n\t|||||||||||||||||||||||||||||||||\n\t||                             ||\n\t||".. resourceName .." is up to date!||\n\t||                             ||\n\t|||||||||||||||||||||||||||||||||\n\n" )
	end
end, "GET", "", { what = 'this' } )

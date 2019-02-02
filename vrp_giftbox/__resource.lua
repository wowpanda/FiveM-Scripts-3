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




description "vRP GiftBox"

dependency "vrp"

client_scripts{ 
  "Proxy.lua",
  "client/giftbox.lua"
}

server_scripts{ 
  "@vrp/lib/utils.lua",
  "server/giftbox.lua"
}
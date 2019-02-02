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


description "HG_AntiCheat"

dependency "vrp"

client_scripts {
    "lib/Tunnel.lua",
    "lib/Proxy.lua",
    "client.lua"
}
server_scripts {
    "@vrp/lib/utils.lua",
    '@mysql-async/lib/MySQL.lua',
    "server.lua"
}
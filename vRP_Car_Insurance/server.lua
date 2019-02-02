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



MySQL = module("vrp_mysql", "MySQL")
local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","vrp_Car_Insurance")

local Lang = module("vrp", "lib/Lang")
local cfg = module("vrp", "cfg/base")
local lang = Lang.new(module("vrp", "cfg/lang/"..cfg.lang) or {})

--Car insurance
MySQL.createCommand("vRP/insurance_column", "ALTER TABLE vrp_users ADD CarInsurance varchar(55) NOT NULL default 'No'")
MySQL.createCommand("vRP/insurance_success", "UPDATE vrp_users SET CarInsurance='Yes' WHERE id = @id")
MySQL.createCommand("vRP/insurance_search", "SELECT * FROM vrp_users WHERE id = @id AND CarInsurance = 'Yes'")
-- init
MySQL.query("vRP/insurance_column")


RegisterServerEvent("insurance:success")
AddEventHandler("insurance:success", function()
	local user_id = vRP.getUserId({source})
	MySQL.query("vRP/insurance_success", {id = user_id})
end)

RegisterServerEvent("insurance:buysuccess")
AddEventHandler("insurance:buysuccess", function()
	local user_id = vRP.getUserId({source})
	local player = vRP.getUserSource({user_id})
	if vRP.tryPayment({user_id,200}) then
        TriggerClientEvent('insurance:EndBuyInsurance',player)
	 else
		vRPclient.notifyPicture(player,{"CHAR_BANK_FLEECA",1,"~g~Flecca Bank",false,"Nu ai ~r~Bani~w~ de asigurare."})
	end
end)

AddEventHandler("vRP:playerSpawn", function(user_id, source, first_spawn)
	MySQL.query("vRP/insurance_search", {id = user_id}, function(rows, affected)
      if #rows > 0 then
          TriggerClientEvent('insurance:CheckInscStatus',source)
      end
    end)
end)

local choice_askinsurance = {function(player,choice)
  vRPclient.getNearestPlayer(player,{10},function(nplayer)
    local nuser_id = vRP.getUserId({nplayer})
    if nuser_id ~= nil then
      vRPclient.notify(player,{"Asigurare..."})
      vRP.request({nplayer,"Vrei sa arati asigurarea?",15,function(nplayer,ok)
        if ok then
          MySQL.query("vRP/insurance_search", {id = nuser_id}, function(rows, affected)
            if #rows > 0 then
			  vRPclient.notify(player,{"Asigurare: ~g~DA"})
			else
			  vRPclient.notify(player,{"Asigurare: ~r~NU"})
            end
          end)
        else
          vRPclient.notify(player,{lang.common.request_refused()})
        end
      end})
    else
      vRPclient.notify(player,{lang.common.no_player_near()})
    end
  end)
end, "Verifica asigurarea masinii."}

vRP.registerMenuBuilder({"police", function(add, data)
  local player = data.player

  local user_id = vRP.getUserId({player})
  if user_id ~= nil then
    local choices = {}

    if vRP.hasPermission({user_id,"police.askid"}) then
       choices["Asigurare Masina"] = choice_askinsurance
    end
	
    add(choices)
  end
end})
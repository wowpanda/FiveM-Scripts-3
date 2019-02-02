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



local options = {
    x = 0.1,
    y = 0.2,
    width = 0.2,
    height = 0.04,
    scale = 0.4,
    font = 0,
    menu_title = "car insurance",
    menu_subtitle = "options",
    color_r = 128,
    color_g = 0,
    color_b = 0,
}

local DTutOpen = false
BuyInsurance = false

RegisterNetEvent('insurance:CheckInscStatus')
AddEventHandler('insurance:CheckInscStatus', function()

	BuyInsurance = true
end)

function drawNotification(text)
	SetNotificationTextEntry("STRING")
	AddTextComponentString(text)
	DrawNotification(false, false)
end

function LocalPed()
	return GetPlayerPed(-1)
end

function drawTxt(text,font,centre,x,y,scale,r,g,b,a)
	SetTextFont(font)
	SetTextProportional(0)
	SetTextScale(scale, scale)
	SetTextColour(r, g, b, a)
	SetTextDropShadow(0, 0, 0, 0,255)
	SetTextEdge(1, 0, 0, 0, 255)
	SetTextDropShadow()
	SetTextOutline()
	SetTextCentre(centre)
	SetTextEntry("STRING")
	AddTextComponentString(text)
	DrawText(x , y)
end

BuyInsurance = true

function startbuy()
        if BuyInsurance then
		    TriggerServerEvent('insurance:buysuccess')
		end
end

RegisterNetEvent('insurance:startbuy')
AddEventHandler('insurance:startbuy', function()
	openGui()
	Menu.hidden = not Menu.hidden
end)

RegisterNetEvent('insurance:EndBuyInsurance')
AddEventHandler('insurance:EndBuyInsurance', function()
	EndBuyInsurance()
end)

function EndBuyInsurance()
        if BuyInsurance then
			TriggerServerEvent('insurance:success')
			BuyInsurance = true
			drawNotification("Ai cumparat ~y~asigurare pentru masina~w~!")
			EndTestTasks()
		end
end

RegisterNUICallback('close', function(data, cb)
  closeGui()
  cb('ok')
  BuyInsurance = true
end)

function DrawSpecialText(m_text, showtime)
	SetTextEntry_2("STRING")
	AddTextComponentString(m_text)
	DrawSubtitleTimed(showtime, 1)
end

local talktoped = true

coordonatlocatieasigurare = {
	{443.50399780274,  -981.12884521484,  30.68959236145}
}

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		for i = 1, #coordonatlocatieasigurare do
		    asigurareCoord2 = coordonatlocatieasigurare[i]
			DrawMarker(36, asigurareCoord2[1], asigurareCoord2[2], asigurareCoord2[3], 0, 0, 0, 0, 0, 0, 1.0, 1.0, 1.0, 254, 179, 0, 155, 0, 0, 2, 0, 0, 0, 0)
			if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), asigurareCoord2[1], asigurareCoord2[2], asigurareCoord2[3], true ) < 1 then
				DrawSpecialText("~w~Apasa ~g~[E] ~w~pentru a cumpara ~asigurare~!")
				if(IsControlJustReleased(1, 38))then
				    if talktoped then
						Citizen.Wait(500)
					    INSURANCEMenu()
						Menu.hidden = false
						talktoped = false
					else
						talktoped = true
					end
				end
				Menu.renderGUI(options)
			end
		end
	end
end)


function INSURANCEMenu()
	ClearMenu()
    options.menu_title = "Cumpara Asigurare"
	Menu.addButton("Asigurare","CarMenu",nil)
    Menu.addButton("Inchide","CloseMenu",nil) 
end

function CarMenu()
    ClearMenu()
    options.menu_title = "Asigurare Masina"
	Menu.addButton("Asigurare [200 LEI]","startbuy",nil)
    Menu.addButton("Return","INSURANCEMenu",nil) 
end

function CloseMenu()
		Menu.hidden = true
end

function Notify(text)
    SetNotificationTextEntry('STRING')
    AddTextComponentString(text)
    DrawNotification(false, false)
end

function drawNotification(text)
	SetNotificationTextEntry("STRING")
	AddTextComponentString(text)
	DrawNotification(true, true)
end

function DrawMissionText2(m_text, showtime)
    ClearPrints()
	SetTextEntry_2("STRING")
	AddTextComponentString(m_text)
	DrawSubtitleTimed(showtime, 1)
end
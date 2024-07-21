local Keys = {
    ["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
    ["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
    ["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
    ["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
    ["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
    ["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
    ["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
    ["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
}

cachedData = {}


local CanDraw = function(action)
	if action == "vehicle" then
		if IsPedInAnyVehicle(PlayerPedId()) then
			local vehicle = GetVehiclePedIsIn(PlayerPedId())

			if GetPedInVehicleSeat(vehicle, -1) == PlayerPedId() then
				return true
			else
				return false
			end
		else
			return false
		end
	end

	return true
end


Citizen.CreateThread(function()
    for k,v in pairs(Config.Garage) do
        if v.showBlip then
        local blip = AddBlipForCoord(v.ritiro)
        SetBlipSprite(blip, 50)
        SetBlipDisplay(blip, 4)
        SetBlipScale (blip, 0.7)
        SetBlipColour(blip, 29)
        SetBlipAsShortRange(blip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString("Garage")
        EndTextCommandSetBlipName(blip)
        end
    end
end)



Citizen.CreateThread(function()
	for k, v in pairs(Config.Garage) do
		TriggerEvent('gridsystem:registerMarker', {
			name = "garage_" .. k,
			pos = v.ritiro,
			scale = vector3(1.0, 1.0, 1.0),
			size = vector3(1.0, 1.0, 1.0),
			type = 9,
			msg = 'Ritira Veicolo',
			markertipo = 'garage',
			control = 'E',
			show3D = false,
			action = function()
				if (Config.ShouldLockOnCash and not hasBankMoney() and not hasContantiMoney()) then
					ESX.ShowNotification("Non hai abbastanza soldi in contanti per usare il garage (500$)", 'error')
					TriggerEvent("inmenu",false)
				else
					cachedData["currentGarage"] = k
					MenuGarage("menu")
				end
			end
		})

		TriggerEvent('gridsystem:registerMarker', {
			name = "garage_depo" .. k,
			pos = v.deposito,
			scale = vector3(1.0, 1.0, 1.0),
			size = vector3(1.0, 1.0, 1.0),
			type = 9,
			msg = 'Deposita Veicolo',
			markertipo = 'garage',
			control = 'E',
			show3D = false,
			action = function()
				if not IsPedOnFoot(PlayerPedId()) then
					cachedData["currentGarage"] = k
					MenuGarage("vehicle")
				end
			end
		})
	end
end)

function hasBankMoney()
	local playerData = ESX.GetPlayerData()
	for k,v in pairs(playerData.accounts) do
		if v.name == "bank" then
			return tonumber(v.money) > 0
		end
	end
end

function hasContantiMoney()
	local playerData = ESX.GetPlayerData()
	for k,v in pairs(playerData.accounts) do
		if v.name == "money" then
			return tonumber(v.money) > 499
		end
	end
end



-------------------------------------------------------------------------------------------------------------------------


function DrawText3Ds(x,y,z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 370
    DrawRect(_x,_y+0.0125, 0.005+ factor, 0.03, 0, 0, 0, 100)
end
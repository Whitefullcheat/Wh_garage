
DeleteActualVeh = function()
    if DoesEntityExist(cachedData["vehicle"]) then
		DeleteEntity(cachedData["vehicle"])
	end
end

SpawnLocalVehicle = function(data)
    local vehicleProps = data    
	WaitForModel(data)

	if DoesEntityExist(cachedData["vehicle"]) then
		DeleteEntity(cachedData["vehicle"])
	end

	if not ESX.Game.IsSpawnPointClear(Config.Garage[cachedData["currentGarage"]]['deposito'], 3.0) then 
        ESX.ShowNotification('Il parcheggio è occupato, sposta il veicolo', 'error')
		return
	end
	
	if not IsModelValid(data) then
		return
	end

    local x,y,z = table.unpack(Config.Garage[cachedData["currentGarage"]]['deposito'])

	ESX.Game.SpawnLocalVehicle(data, {
    x = x,
    y = y,
    z = z + 1}, 
    Config.Garage[cachedData["currentGarage"]]['heading'], 
    function(yourVehicle)
		cachedData["vehicle"] = yourVehicle

        FreezeEntityPosition(yourVehicle, true)
		SetVehicleProperties(yourVehicle, data)
        SetVehicleDoorsLocked(yourVehicle, 2)

		SetModelAsNoLongerNeeded(data)
	end)
end

SpawnVehicle = function(data, veriProps)
    local vehicleProps = data
	WaitForModel(data)
	if DoesEntityExist(cachedData["vehiclePerRitiro"]) then
		DeleteEntity(cachedData["vehiclePerRitiro"])
	end
    if DoesEntityExist(cachedData["vehicle"]) then
		DeleteEntity(cachedData["vehicle"])
	end
	if not ESX.Game.IsSpawnPointClear(Config.Garage[cachedData["currentGarage"]]['deposito'], 3.0) then 
        ESX.ShowNotification('Il parcheggio è occupato, sposta il veicolo', 'error')
		return
	end
	CloseMenu()
	local gameVehicles = ESX.Game.GetVehicles()

	for i = 1, #gameVehicles do
		local vehicle = gameVehicles[i]

        if DoesEntityExist(vehicle) then
			if Config.Trim(GetVehicleNumberPlateText(vehicle)) == Config.Trim(data.plate) then
              ESX.ShowNotification('Questo veicolo non è presente nel garage', 'error')
				return
			end
		end
	end



	ESX.Game.SpawnVehicle(data, Config.Garage[cachedData["currentGarage"]]['deposito'], Config.Garage[cachedData["currentGarage"]]['heading'], function(yourVehicle)
		ESX.Game.SetVehicleProperties(yourVehicle, veriProps)
        SetVehicleNumberPlateText(yourVehicle, veriProps.plate)
		SetModelAsNoLongerNeeded(data)

		TaskWarpPedIntoVehicle(PlayerPedId(), yourVehicle, -1)

        SetEntityAsMissionEntity(yourVehicle, true, true)
        
        local plate = GetVehicleNumberPlateText(yourVehicle)
        Citizen.Wait(100)
        cachedData["vehiclePerRitiro"] = yourVehicle
        TriggerServerEvent('wh_garage:changeState', plate, false)
    end)
end

PutInVehicle = function()
    local vehicle = GetVehiclePedIsUsing(PlayerPedId())

    if DoesEntityExist(vehicle) then
        local vehicleProps = GetVehicleProperties(vehicle)
                lib.registerContext({
                    id = 'garage_menu_putvehicle',
                    title = 'Menu Garage',
                    options = {
                        {
                            title = 'Chiudi',
                            event = "wh_garage:stopMenu"
                        },
                        {
                            title = 'Deposita [' .. cachedData["currentGarage"] .. "]",
                            event = 'wh_garage:DepositaVeicolo',
                        },
                        
                    },
                })

                lib.showContext('garage_menu_putvehicle')
	end
end


AddEventHandler("wh_garage:DepositaVeicolo", function()
    if cachedData["currentGarage"] then
     SaveInGarage(cachedData["currentGarage"])
    else
        ESX.ShowNotification("C'è stato un errore, contatta un admin")
    end
end)


SaveInGarage = function(garage)

    local vehicle = GetVehiclePedIsIn(PlayerPedId())
    local vehicleProps = ESX.Game.GetVehicleProperties(vehicle)
    TaskLeaveVehicle(PlayerPedId(), vehicle, 0)
	
    while IsPedInVehicle(PlayerPedId(), vehicle, true) do
        Citizen.Wait(0)
    end
    Citizen.Wait(300)
    Citizen.Wait(500)
    ESX.Game.DeleteVehicle(vehicle)
    TriggerServerEvent('wh_garage:saveProps', vehicleProps.plate, vehicleProps)
    TriggerServerEvent('wh_garage:changeState', vehicleProps.plate, 1)
    TriggerServerEvent('garage:SalvaGarage', vehicleProps.plate, garage)
    CloseMenu()
end

SetVehicleProperties = function(vehicle, vehicleProps)
    ESX.Game.SetVehicleProperties(vehicle, vehicleProps)
    SetVehicleFuelLevel(vehicle, vehicleProps["fuelLevel"] and vehicleProps["fuelLevel"] + 0.0 or 1000.0)
    if vehicleProps["tyres"] then
        for tyreId = 1, 7, 1 do
            if vehicleProps["tyres"][tyreId] ~= false then
                SetVehicleTyreBurst(vehicle, tyreId, true, 1000)
            end
        end
    end

    if vehicleProps["doors"] then
        for doorId = 0, 5, 1 do
            if vehicleProps["doors"][doorId] ~= false then
                SetVehicleDoorBroken(vehicle, doorId - 1, true)
            end
        end
    end
end

GetVehicleProperties = function(vehicle)
    if DoesEntityExist(vehicle) then
        local vehicleProps = ESX.Game.GetVehicleProperties(vehicle)

        vehicleProps["tyres"] = {}
        --vehicleProps["windows"] = {}
        vehicleProps["doors"] = {}

        for id = 1, 7 do
            local tyreId = IsVehicleTyreBurst(vehicle, id, false)
        
            if tyreId then
                vehicleProps["tyres"][#vehicleProps["tyres"] + 1] = tyreId
        
                if tyreId == false then
                    tyreId = IsVehicleTyreBurst(vehicle, id, true)
                    vehicleProps["tyres"][ #vehicleProps["tyres"]] = tyreId
                end
            else
                vehicleProps["tyres"][#vehicleProps["tyres"] + 1] = false
            end
        end

        --[[for id = 1, 13 do
            local windowId = IsVehicleWindowIntact(vehicle, id)

            if windowId ~= nil then
                vehicleProps["windows"][#vehicleProps["windows"] + 1] = windowId
            else
                vehicleProps["windows"][#vehicleProps["windows"] + 1] = true
            end
        end--]]
        
        for id = 0, 5 do
            local doorId = IsVehicleDoorDamaged(vehicle, id)
        
            if doorId then
                vehicleProps["doors"][#vehicleProps["doors"] + 1] = doorId
            else
                vehicleProps["doors"][#vehicleProps["doors"] + 1] = false
            end
        end

        --vehicleProps["engineHealth"] = GetVehicleEngineHealth(vehicle)
        --vehicleProps["bodyHealth"] = GetVehicleBodyHealth(vehicle)
        vehicleProps["fuelLevel"] = GetVehicleFuelLevel(vehicle)

        return vehicleProps
    end
end

HandleAction = function(action)
    if action == "menu" then
        OpenGarageMenu()
    elseif action == "vehicle" then
        PutInVehicle()
    end
end

DrawScriptMarker = function(markerData)
    DrawMarker(markerData["type"] or 1, 
        markerData["pos"] or vector3(0.0, 0.0, 0.0), 
        0.0, 0.0, 0.0, 
        (markerData["type"] == 6 and -90.0 or markerData["rotate"] and -180.0) or 0.0, 0.0, 0.0, 
        markerData["sizeX"] or 1.0, 
        markerData["sizeY"] or 1.0, 
        markerData["sizeZ"] or 1.0, 
        markerData["r"] or 1.0, 
        markerData["g"] or 1.0, 
        markerData["b"] or 1.0, 
        100, false, true, 2, false, false, false, false)
end

PlayAnimation = function(ped, dict, anim, settings)
	if dict then
        Citizen.CreateThread(function()
            RequestAnimDict(dict)

            while not HasAnimDictLoaded(dict) do
                Citizen.Wait(100)
            end

            if settings == nil then
                TaskPlayAnim(ped, dict, anim, 1.0, -1.0, 1.0, 0, 0, 0, 0, 0)
            else 
                local speed = 1.0
                local speedMultiplier = -1.0
                local duration = 1.0
                local flag = 0
                local playbackRate = 0

                if settings["speed"] then
                    speed = settings["speed"]
                end

                if settings["speedMultiplier"] then
                    speedMultiplier = settings["speedMultiplier"]
                end

                if settings["duration"] then
                    duration = settings["duration"]
                end

                if settings["flag"] then
                    flag = settings["flag"]
                end

                if settings["playbackRate"] then
                    playbackRate = settings["playbackRate"]
                end

                TaskPlayAnim(ped, dict, anim, speed, speedMultiplier, duration, flag, playbackRate, 0, 0, 0)
            end
      
            RemoveAnimDict(dict)
		end)
	else
		TaskStartScenarioInPlace(ped, anim, 0, true)
	end
end

WaitForModel = function(model)
    local DrawScreenText = function(text, red, green, blue, alpha)
        SetTextFont(4)
        SetTextScale(0.0, 0.5)
        SetTextColour(red, green, blue, alpha)
        SetTextDropshadow(0, 0, 0, 0, 255)
        SetTextEdge(1, 0, 0, 0, 255)
        SetTextDropShadow()
        SetTextOutline()
        SetTextCentre(true)
    
        BeginTextCommandDisplayText("STRING")
        AddTextComponentSubstringPlayerName(text)
        EndTextCommandDisplayText(0.5, 0.5)
    end

    if not IsModelValid(model) then
        return
    end

	if not HasModelLoaded(model) then
		RequestModel(model)
	end
	
	while not HasModelLoaded(model) do
		Citizen.Wait(0)

		DrawScreenText("Modello " .. GetDisplayNameFromVehicleModel(model) .. "...", 255, 255, 255, 150)
	end
end
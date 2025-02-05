TriggerEvent('chat:addSuggestion', '/daiveicolo', 'Dai una macchina a un player', {
	{ name="id", help="ID giocatore" },
    { name="vehicle", help="Modello veicolo" },
    { name="<plate>", help="Targa veicolo, lascia vuoto per una targa casuale" }
})


TriggerEvent('chat:addSuggestion', '/eliminaveicolo', 'Elimina un veicolo dalla targa', {
	{ name="plate", help="Targa veicolo" }
})

function randomCharacter(length)
	local res = ""
	for i = 1, length do res = res .. string.char(math.random(97, 122))	end
	return res
end

function randomNumber(length)
	local res = ""
	for i = 1, length do res = res .. string.char(math.random(48,  57)) end
	return res
end

CustomizePlate = function()
    return string.upper(randomNumber(2) .. randomCharacter(3) .. randomNumber(3))
end


RegisterNetEvent('esx_giveownedcar:spawnVehicle')
AddEventHandler('esx_giveownedcar:spawnVehicle', function(playerID, model, playerName, type, vehicleType)
    local playerPed = PlayerPedId()
    local coords    = GetEntityCoords(playerPed)
    local carExist  = false

    -- Ensure playerName is not nil
    if not playerName then
        playerName = "unknown"
    end

    ESX.Game.SpawnVehicle(model, coords, 0.0, function(vehicle) 
        if DoesEntityExist(vehicle) then
            carExist = true
            SetEntityVisible(vehicle, false, false)
            SetEntityCollision(vehicle, false)
            
            local newPlate     = CustomizePlate()
            local vehicleProps = ESX.Game.GetVehicleProperties(vehicle)
            vehicleProps.plate = newPlate
            TriggerServerEvent('esx_giveownedcar:setVehicle', vehicleProps, playerID, vehicleType, model, GetEntityModel(model))
            ESX.Game.DeleteVehicle(vehicle)    
            if type ~= 'console' and type ~= 'discord' then
                TriggerEvent('notifica', "Il veicolo " ..model.." con targa "..newPlate.." è stato assegnato a "..playerName) 
            elseif type == 'discord' then
                local msg = 'Il veicolo **' ..model.. '** con targa **' ..newPlate.. '** è stato assegnato a **' ..playerName..'**'
                --TriggerServerEvent('DiscordComm:printToDiscord', msg, true)
            else
                local msg = ('addCar: ' ..model.. ', plate: ' ..newPlate.. ', toPlayer: ' ..playerName)
                TriggerServerEvent('esx_giveownedcar:printToConsole', msg)
            end                
        end        
    end)
    
    Wait(2000)
    if not carExist then
        if type ~= 'console' and type ~= 'discord' then
            TriggerEvent('notifica',"modello "..model.." sconosciuto")
        elseif type == 'discord' then
            local msg = 'Il veicolo **' ..model.. '** non è stato trovato!'
            TriggerServerEvent('DiscordComm:printToDiscord', msg, false)
        else
            TriggerServerEvent('esx_giveownedcar:printToConsole', "ERROR: "..model.." is an unknown vehicle model")
        end        
    end
end)


RegisterNetEvent('esx_giveownedcar:spawnVehiclePlate')
AddEventHandler('esx_giveownedcar:spawnVehiclePlate', function(playerID, model, plate, playerName, type, vehicleType)
	local playerPed = PlayerPedId()
	local coords    = GetEntityCoords(playerPed)
	local generatedPlate = string.upper(plate)
	local carExist  = false

	ESX.TriggerServerCallback('wh_garage:checktarga', function (check)
		if not check then
			ESX.Game.SpawnVehicle(model, coords, 0.0, function(vehicle) 
				if DoesEntityExist(vehicle) then
					carExist = true
					SetEntityVisible(vehicle, false, false)
					SetEntityCollision(vehicle, false)	
					
					local newPlate     = string.upper(plate)
					local vehicleProps = ESX.Game.GetVehicleProperties(vehicle)
					vehicleProps.plate = newPlate
					TriggerServerEvent('esx_giveownedcar:setVehicle', vehicleProps, playerID, vehicleType)
					ESX.Game.DeleteVehicle(vehicle)
					TriggerEvent('notifica', "Il veicolo " ..model.." con targa "..newPlate.." è stato assegnato a "..playerName) 	
				end
			end)
		else
			carExist = true
			TriggerEvent('notifica', "Questa targa è stata già usata per un veicolo")
		end
	end, generatedPlate)
	
	Wait(2000)
	if not carExist then
			TriggerEvent('notifica',"Modello veicolo sconosciuto"..model)
	end	
end)

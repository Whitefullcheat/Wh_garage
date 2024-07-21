local ESX = exports.es_extended:getSharedObject()
local ultimaAccion = nil
local currentGarage = nil
local fetchedVehicles = {}
local fueravehicles = {}

AddEventHandler("wh_garage:resetMenu", function(a)
    MenuGarage("menu")
end)

AddEventHandler("wh_garage:stopMenu", function()
    CloseMenu()
end)

function MenuGarage(action)
    if not action then action = ultimaAccion; elseif not action and not ultimaAccion then action = "menu"; end
    ped = PlayerPedId();
    ultimaAccion = action
    Citizen.Wait(150)
    DeleteActualVeh()

    if action == "menu" then
        lib.registerContext({
            id = 'garage_menu',
            title = 'Menu Garage [' .. cachedData["currentGarage"] .. "]",
            options = {
                {
                    title = 'Apri il Garage',
                    event = 'wh_garage:apriGarage',
                },
            },
        })

        lib.showContext('garage_menu')
    elseif action == "vehicle" then
        PutInVehicle()
    end
    
end

RegisterNetEvent('wh_garage:vaisequestro', function()
    ESX.ShowNotification('Vai alla rimozione forzata per dissequestrare il tuo veicolo!')
end)


AddEventHandler("wh_garage:apriGarage", function()
    DeleteActualVeh()
    ESX.TriggerServerCallback("wh_garage:loadVehicles", function(fetchedVehicles)
        ESX.TriggerServerCallback('wh_garage:veicolisequestrati', function(veicoliSequestrati)
        local menu = {
            {
                title = "Indietro",
                iconColor = "red",
                icon = "arrow-left",
                event = "wh_garage:resetMenu"
            }
        }
        for k, v in pairs(fetchedVehicles) do
            local label = v.label
            if v.stored == true then
                v.stored = 1
            else
                v.stored = 0
            end
            menu[#menu+1] = {
               title = "Modello: " .. label .. " | " .. v.plate,
               event = "wh_garage:selezioneVeicolo",
               iconColor = "green",
               icon = "car",
               args = { veh = v.modelname, stato = v.stored, plate = v.plate, vehicle = v.vehicle}
            }
        end
        for negro,bianco in pairs(veicoliSequestrati) do
                local label = bianco.label
                menu[#menu+1] = {
                   title = "Modello: " .. label .. " | " .. bianco.plate.. " | SEQUESTRATO",
                   iconColor = "red",
                   icon = "car",
                   event = "wh_garage:vaisequestro",
                   args = { }
                }
        end


        lib.registerContext({
            id = 'garage_menu_apri',
            title = 'Lista Veicoli [' .. cachedData["currentGarage"] .. "]",
            onExit = function()
                DeleteActualVeh()
            end,
            options = menu
        })


        lib.showContext('garage_menu_apri')

        end)
    end,k)
    TriggerEvent("inmenu",true)
end)

AddEventHandler("wh_garage:selezioneVeicolo", function(data)
    SpawnLocalVehicle(data.veh)

    local dMenu = {
        {
            title = "Indietro",
            event = "wh_garage:apriGarage"
        },
    }

    if data.stato == 0 then
        dMenu[#dMenu+1] = {
            title = "[ (FUORI) - Recupera Veicolo] - 1500$",
            description = "Il veicolo attualmente non si trova in garage.",
            event = "wh_garage:ritiraVeicolo",
            args = { veh = data.veh, vehicle = data.vehicle, recupero = true}
        }
    else
        dMenu[#dMenu+1] = {
            title = "[Ritira Veicolo]",
            description = "Targa: " .. data.plate .. " | Vita: 100%",
            event = "wh_garage:ritiraVeicolo",
            args = { veh = data.veh, targa = data.plate, stato = data.stato, vehicle = data.vehicle}
        }
    end

    lib.registerContext({
        id = 'garage_menu_vehselezionato',
        onExit = function()
            DeleteActualVeh()
        end,
        title = 'Menu Garage',
        options = dMenu
    })

    lib.showContext('garage_menu_vehselezionato')

end)

AddEventHandler("wh_garage:ritiraVeicolo", function(data)
    if data.recupero then
        TriggerServerEvent('wh_garage:pagaRecupero')
    end
    SpawnVehicle(data.veh, data.vehicle)
end)

function EnvioVehLocal(veh)
    local slots = {}
    for c,v in pairs(veh) do
        table.insert(slots,{["garage"] = v.garage, ["vehiculo"] = json.decode(v.vehicle)})
    end
    fetchedVehicles = slots
end

function EnvioVehFuera(data)
    local slots = {}
    for c,v in pairs(data) do
        if v.state == 0 or v.state == 2 or v.state == false or v.garage == nil then
            table.insert(slots,{["vehiculo"] = json.decode(v.vehicle),["state"] = v.state})
        end
    end
    fueravehicles = slots
end



function pagorecupero(data)
    SpawnVehicle({data,nil})
end

function round(n)
    if not n then return 0; end
    return n % 1 >= 0.5 and math.ceil(n) or math.floor(n)
end


function CloseMenu()
	TriggerEvent("inmenu",false)

end

function LocalPed()
	return PlayerPedId()
end
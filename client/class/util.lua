function showSubtitle(message, time)
    BeginTextCommandPrint('STRING')
    AddTextComponentSubstringPlayerName(message)
    EndTextCommandPrint(time, 1)
end

function playerBuyTicketMenu()
    local elements = {}
    local index = 0
    local ticketMenu = MenuAPI:CreateMenu("ticket_menu")

    ticketMenu.SetMenuTitle(_U("ticket_menu"))

    ticketMenu.SetProperties({
        float = "right",
        position = "middle",
    })

    for k, v in pairs(Config.ticketPrice) do
        index = index + 1
        ticketMenu.AddItem(index, _U("ticket_label", k) .. " <span style='color: green;'>$" .. v.price .. "</span>", function()
            TriggerServerEvent("rcore_arcade:buyTicket", k)
            ticketMenu.Destroy()
        end)
    end

    ticketMenu.On("selectitem", function(index)
        print(index, "joujou")
    end)

    ticketMenu.On("close", function()
        print("mg funguju")
    end)

    ticketMenu.Open()
end

function returnTicketMenu()
    local returnMenu = MenuAPI:CreateMenu("returnMenu")

    returnMenu.SetMenuTitle(_U("give_back_ticket"))

    returnMenu.SetProperties({
        float = "right",
        position = "middle",
    })

    returnMenu.AddItem(1, _U("yes"), function()
        minutes = 0
        seconds = 0
        gotTicket = false
        returnMenu.Close()
    end)

    returnMenu.AddItem(2, _U("no"), function()
        returnMenu.Close()
    end)

    returnMenu.Open()
end

function showHelpNotification(text)
    BeginTextCommandDisplayHelp("THREESTRINGS")
    AddTextComponentSubstringPlayerName(text)
    EndTextCommandDisplayHelp(0, false, true,5000)
end

function showNotification(text)
    SetNotificationTextEntry('STRING')
    AddTextComponentString(text)
    DrawNotification(0, 1)
end

function createBlip(name, blip, coords, options)
    local x, y, z = table.unpack(coords)
    local ourBlip = AddBlipForCoord(x, y, z)
    SetBlipSprite(ourBlip, blip)
    if options.type then SetBlipDisplay(ourBlip, options.type) end
    if options.scale then SetBlipScale(ourBlip, options.scale) end
    if options.color then SetBlipColour(ourBlip, options.color) end
    if options.shortRange then SetBlipAsShortRange(ourBlip, options.shortRange) end
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(name)
    EndTextCommandSetBlipName(ourBlip)
    return ourBlip
end

function createLocalPed(pedType, model, position, heading, cb)
    requestModel(model, function()
        local ped = CreatePed(pedType, model, position.x, position.y, position.z, heading, false, false)
        SetModelAsNoLongerNeeded(model)
        cb(ped)
    end)
end

function requestModel(modelName, cb)
    if type(modelName) ~= 'number' then
        modelName = GetHashKey(modelName)
    end

    local breaker = 0

    RequestModel(modelName)

    while not HasModelLoaded(modelName) do
        Citizen.Wait(1)
        breaker = breaker + 1
        if breaker >= 100 then
            break
        end
    end

    if breaker >= 100 then
        cb(false)
    else
        cb(true)
    end
end

function openComputerMenu(listGames, computer_)
    local computer = computer_
    local index = 0
    if not gotTicket and computer.isInGamingHouse then
        showNotification(_U("need_to_buy_ticket"))
        return
    end
    local gameMenu = MenuAPI:CreateMenu("gamelist")

    gameMenu.SetMenuTitle(_U("computer_menu"))

    gameMenu.SetProperties({
        float = "right",
        position = "middle",
    })

    for key, value in pairs(listGames) do
        index = index + 1
        print(index, value.name)
        gameMenu.AddItem(index, value.name, function()
            SendNUIMessage({
                type = "on",
                game = value.link,
                gpu = computer.computerGPU,
                cpu = computer.computerCPU
            })
            SetNuiFocus(true, true)
            gameMenu.Close()
        end)
    end

    gameMenu.Open()
end

function hasPlayerRunOutOfTime()
    return (minutes == 0 and seconds <= 1)
end

function countTime()
    seconds = seconds - 1
    if seconds == 0 then
        seconds = 59
        minutes = minutes - 1
    end

    if minutes == -1 then
        minutes = 0
        seconds = 0
    end
end

function displayTime()
    showSubtitle(_U("time_left_count", minutes, seconds), 1001)
end
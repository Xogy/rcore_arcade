MinigameCamera = nil
FreezeCommand = false

function showSubtitle(message, time)
    BeginTextCommandPrint('STRING')
    AddTextComponentSubstringPlayerName(message)
    EndTextCommandPrint(time, 1)
end

--- Will register key action
--- @param fc function
--- @param uniqid string
--- @param description string
--- @param key string
--- @param inputDevice string
function RegisterKey(fc, uniqid, description, key, inputDevice)
    if inputDevice == nil then
        inputDevice = "keyboard"
    end
    RegisterCommand(uniqid .. key, fc, false)
    RegisterKeyMapping(uniqid .. key, description, inputDevice, key)
end

function playerBuyTicketMenu()
    freezeMarker = true

    local elements = {}
    local index = 0
    local ticketMenu = CreateMenu("ticket_menu")

    ticketMenu.SetMenuTitle(_U("ticket_menu"))

    ticketMenu.SetProperties({
        float = "right",
        position = "middle",
    })

    for k, v in ipairs(Config.ticketPrice) do
        index = index + 1
        ticketMenu.AddItem(index, { _U("ticket_label", v.label), " <span style='color: green;'>$" .. CommaValue(v.price) .. "</span>" }, function()
            TriggerServerEvent("rcore_arcade:buyTicket", k)
            ticketMenu.Destroy()

            CreateThread(function()
                Wait(100)
                freezeMarker = false
            end)
        end)
    end

    local closed = function()
        CreateThread(function()
            Wait(100)
            freezeMarker = false
        end)
    end

    ticketMenu.On("close", closed)
    ticketMenu.On("exit",closed)

    ticketMenu.Open()
end

function returnTicketMenu()
    freezeMarker = true
    local returnMenu = CreateMenu("returnMenu")

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

        Wait(100)
        freezeMarker = false
    end)

    returnMenu.AddItem(2, _U("no"), function()
        returnMenu.Close()

        CreateThread(function()
            Wait(100)
            freezeMarker = false
        end)
    end)

    local closed = function()
        CreateThread(function()
            Wait(100)
            freezeMarker = false
        end)
    end

    returnMenu.On("close", closed)
    returnMenu.On("exit",closed)

    returnMenu.Open()
end

--- @param amount integer
--- add comma to separate thousands
--- stolen from: http://lua-users.org/wiki/FormattingNumbers
function CommaValue(amount)
    local formatted = amount
    while true do
        formatted, k = string.gsub(formatted, "^(-?%d+)(%d%d%d)", '%1,%2')
        if (k == 0) then
            break
        end
    end
    return formatted
end

function showHelpNotification(text)
    BeginTextCommandDisplayHelp("THREESTRINGS")
    AddTextComponentSubstringPlayerName(text)
    EndTextCommandDisplayHelp(0, false, true, 5000)
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
    if options.type then
        SetBlipDisplay(ourBlip, options.type)
    end
    if options.scale then
        SetBlipScale(ourBlip, options.scale)
    end
    if options.color then
        SetBlipColour(ourBlip, options.color)
    end
    if options.shortRange then
        SetBlipAsShortRange(ourBlip, options.shortRange)
    end
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(name)
    EndTextCommandSetBlipName(ourBlip)
    return ourBlip
end

function createLocalPed(pedType, model, position, heading)
    local loaded = requestModel(model)
    if loaded then
        local ped = CreatePed(pedType, model, position.x, position.y, position.z, heading, false, false)
        SetModelAsNoLongerNeeded(model)
        return ped
    end
    return nil
end

function requestModel(modelName, cb)
    if type(modelName) ~= 'number' then
        modelName = GetHashKey(modelName)
    end

    local breaker = 0

    RequestModel(modelName)

    while not HasModelLoaded(modelName) do
        Wait(33)
        breaker = breaker + 1
        if breaker >= 100 then
            break
        end
    end

    if breaker >= 100 then
        return false
    else
        return true
    end
end

function openComputerMenu(listGames, computer_)
    if FreezeCommand then
        return
    end

    local computer = computer_
    local index = 0
    if not gotTicket and computer.isInGamingHouse then
        showNotification(_U("need_to_buy_ticket"))
        return
    end
    local gameMenu = CreateMenu("gamelist")

    gameMenu.SetMenuTitle(_U("computer_menu"))

    gameMenu.SetProperties({
        float = "right",
        position = "middle",
    })

    for key, value in pairs(listGames) do
        index = index + 1
        gameMenu.AddItem(index, value.name, function()
            FreezeCommand = true
            gameMenu.Close()
            local obj = GetClosestObjectOfType(GetEntityCoords(PlayerPedId()), 1.5, GetHashKey("prop_arcade_01"), false, false, false)
            if obj ~= 0 then
                SpawnArcadeGameCamera(obj)

                RequestAnimDict("mini@repair")
                local breakMe = 0
                while not HasAnimDictLoaded("mini@repair") do
                    Wait(33)
                    breakMe = breakMe + 1
                    if breakMe == 20 then
                        return false
                    end
                end

                Wait(100)
                TaskPlayAnim(PlayerPedId(), "mini@repair", "fixing_a_ped", 8.0, 8.0, 6000, 49, 0, 0, 0, 0)
                RemoveAnimDict("mini@repair")
            end

            SendNUIMessage({
                type = "on",
                game = value.link,
                gpu = computer.computerGPU,
                cpu = computer.computerCPU
            })

            SetPlayerVisible(false)
            SetNuiFocus(true, true)
            FreezeCommand = false
        end)
    end

    Wait(33)
    gameMenu.Open()
end

function SpawnArcadeGameCamera(entity)
    local ped = PlayerPedId()
    FreezeEntityPosition(ped, true)

    local camera = GetOffsetFromEntityInWorldCoords(entity, 0.0, -0.9, 0.4)
    local player = GetOffsetFromEntityInWorldCoords(entity, 0.0, -1.0, -1.0)

    MinigameCamera = CreateCamera("view_minigame_carneval", GetGameplayCamCoord(), GetGameplayCamRot(), GetGameplayCamFov())
    MinigameCamera.Render()

    MinigameCamera.ChangePosition(camera, camera, vector3(-10, 0, GetEntityHeading(entity)), 1500)

    SetEntityCoords(ped, player)
    SetEntityHeading(ped, GetEntityHeading(entity) - 0.0)
end

function RevertMinigameCamera()
    local ped = PlayerPedId()
    FreezeEntityPosition(ped, false)
    if MinigameCamera and MinigameCamera.ChangePosition then
        MinigameCamera.ChangePosition(GetGameplayCamCoord(), GetGameplayCamCoord(), GetGameplayCamRot(), 1500)
        MinigameCamera.Destroy()
        MinigameCamera = nil

        StopRendering()
    end
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
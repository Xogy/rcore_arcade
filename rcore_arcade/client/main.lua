-------------------
-- variables for arcade and time left
-------------------
SharedObject = GetSharedObject()
gotTicket = false

freezeMarker = false

minutes = 0
seconds = 0
-------------------
function doesPlayerHaveTicket()
    return gotTicket
end

exports('doesPlayerHaveTicket', doesPlayerHaveTicket)

--count time
CreateThread(function()
    while true do
        Wait(1000)
        if gotTicket then
            if hasPlayerRunOutOfTime() then
                showNotification(_U("ticket_expired"))
                gotTicket = false

                SendNUIMessage({
                    type = "off",
                    game = "",
                })
                SetNuiFocus(false, false)
                SetPlayerVisible(true)
                RevertMinigameCamera()
            end

            countTime()
            displayTime()
        end
    end
end)

--create npc, blip, marker
CreateThread(function()
    -- we will wait few seconds just in case the shared object would take more ms to load.
    Wait(2500)

    if Config.Framework.Active == Framework.STANDALONE then
        -- since it is on standalone.. it will be free.
        for k, v in pairs(Config.computerList) do
            v.isInGamingHouse = false
        end
    end

    for k, v in pairs(Config.Arcade) do
        if Config.Framework.Active ~= Framework.STANDALONE then
            local newPos = v.marker.markerPosition - vector3(0, 0, 0.4)
            local computerMarker = createMarker()

            computerMarker.setKeys({ 38 })

            computerMarker.setRenderDistance(10)
            computerMarker.setPosition(newPos)

            computerMarker.render()

            computerMarker.setColor(v.marker.options.color)
            computerMarker.setScale(v.marker.options.scale)
            computerMarker.setType(v.marker.markerType)

            computerMarker.on('enter', function()
                showHelpNotification(_U("open_ticket_menu"))
            end)
            computerMarker.on('leave', function()
                CloseAll()
            end)
            computerMarker.on('key', function()
                if freezeMarker then
                    return
                end

                if gotTicket == false then
                    playerBuyTicketMenu()
                else
                    returnTicketMenu()
                end
            end)
        end

        if v.blip and v.blip.enable then
            createBlip(v.blip.name, v.blip.blipId, v.blip.position, v.blip)
        end
    end
end)

CreateThread(function()
    if Config.Framework.Active ~= Framework.STANDALONE then
        while true do
            Wait(500)
            local pPos = GetEntityCoords(PlayerPedId())
            for k, v in pairs(Config.Arcade) do
                if #(pPos - v.NPC.position) < 30 then
                    if not v.NPC.Spawned then
                        local ped = createLocalPed(4, v.NPC.model, v.NPC.position, v.NPC.heading)

                        SetEntityAsMissionEntity(ped)
                        SetBlockingOfNonTemporaryEvents(ped, true)
                        FreezeEntityPosition(ped, true)
                        SetEntityInvincible(ped, true)
                        v.NPC.Entity = ped
                        v.NPC.Spawned = true
                    end
                else
                    DeleteEntity(v.NPC.Entity)
                    v.NPC.Entity = nil
                    v.NPC.Spawned = false
                end
            end
        end
    end
end)

--create markers for computers
CreateThread(function()
    for k, v in pairs(Config.computerList) do
        local newPos = v.position - vector3(0, 0, 0.4)
        local computerMarker = createMarker()

        computerMarker.setKeys({ 38 })

        computerMarker.setRenderDistance(10)
        computerMarker.setPosition(newPos)

        computerMarker.render()

        computerMarker.setColor(v.markerOptions.color)
        computerMarker.setScale(v.markerOptions.scale)
        computerMarker.setType(v.markerType)

        computerMarker.setRotation(v.markerOptions.rotate)

        computerMarker.on('enter', function()
            showHelpNotification(_U("open_computer"))
        end)
        computerMarker.on('leave', function()
            CloseAll()
        end)
        computerMarker.on('key', function()
            openComputerMenu(v.computerType, v)
        end)
    end
end)

AddEventHandler("onResourceStop", function(resourceName)
    if (GetCurrentResourceName() ~= resourceName) then
        return
    end

    if Config.Framework.Active ~= Framework.STANDALONE then
        for k, v in pairs(Config.Arcade) do
            DeleteEntity(v.NPC.Entity)
            v.NPC.Entity = nil
            v.NPC.Spawned = false
        end
    end
end)

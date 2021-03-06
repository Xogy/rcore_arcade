-------------------
-- Exports
-------------------
MenuAPI = exports.MenuAPI
-------------------
-- variables for arcade and time left
-------------------
gotTicket = false

minutes = 0
seconds = 0
-------------------
function doesPlayerHaveTicket()
    return gotTicket
end

exports('doesPlayerHaveTicket', doesPlayerHaveTicket)

--count time
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1000)
        if gotTicket then
            if hasPlayerRunOutOfTime() then
                showNotification(_U("ticket_expired"))
                gotTicket = false

                SendNUIMessage({
                    type = "off",
                    game = "",
                })
                SetNuiFocus(false, false)
            end

            countTime()
            displayTime()
        end
    end
end)

--create npc, blip, marker
Citizen.CreateThread(function()
    for k, v in pairs(Config.Arcade) do
        local newPos = v.marker.markerPosition - vector3(0, 0, 0.4)
        local computerMarker = createMarker()

        computerMarker.setKeys({38})

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
            MenuAPI:CloseAll()
        end)
        computerMarker.on('key', function()
            if gotTicket == false then
                playerBuyTicketMenu()
            else
                returnTicketMenu()
            end
        end)

        if v.blip and v.blip.enable then
            createBlip(v.blip.name, v.blip.blipId, v.blip.position, v.blip)
        end

        createLocalPed(4, v.NPC.model, v.NPC.position, v.NPC.heading, function(ped)
            SetEntityAsMissionEntity(ped)
            SetBlockingOfNonTemporaryEvents(ped, true)
            FreezeEntityPosition(ped, true)
            SetEntityInvincible(ped, true)
        end)
    end
end)

--create markers for computers
Citizen.CreateThread(function()
    for k, v in pairs(Config.computerList) do
        local newPos = v.position - vector3(0, 0, 0.4)
        local computerMarker = createMarker()

        computerMarker.setKeys({38})

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
            MenuAPI:CloseAll()
        end)
        computerMarker.on('key', function()
            openComputerMenu(v.computerType, v)
        end)
    end
end)
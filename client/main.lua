-------------------
-- Exports
-------------------
rcore = exports.rcore
ESX = rcore:getEsxInstance()
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
                rcore:showHelpNotification(_U("ticket_expired"))
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
        rcore:createDistanceMarker(v.marker.markerType, v.marker.markerPosition, 10,
            {
                onEnter = function()
                    rcore:showHelpNotification(_U("open_ticket_menu"))
                end,
                onLeave = function()
                    ESX.UI.Menu.CloseAll()
                end,
                onEnterKey = function(key)
                    if key == rcore:getKeys()[Config.keyToOpenTicketMenu] then
                        if gotTicket == false then
                            playerBuyTicketMenu()
                        else
                            returnTicketMenu()
                        end
                    end
                end
            },v.marker.options)

        if v.blip and v.blip.enable then
            rcore:createBlip(v.blip.name, v.blip.blipId, v.blip.position, v.blip)
        end

        rcore:createLocalPed(4, v.NPC.model, v.NPC.position, v.NPC.heading, function(ped)
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
        local newPos = vector3(v.position.x, v.position.y, v.position.z - 0.4)
        rcore:createDistanceMarker(v.markerType, newPos, 10,
            {
                onEnter = function()
                    rcore:showHelpNotification(_U("open_computer"))
                end,
                onLeave = function()
                    ESX.UI.Menu.CloseAll()
                end,
                onEnterKey = function(key)
                    local listGames = v.computerType
                    if key == rcore:getKeys()[Config.keyToOpenComputer] then
                        openComputerMenu(listGames, v)
                    end
                end
            }, v.markerOptions)
    end
end)
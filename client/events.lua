RegisterNetEvent("rcore_arcade:ticketResult")
AddEventHandler("rcore_arcade:ticketResult", function(ticket)
    showNotification(_U("bought_ticket", ticket, Config.ticketPrice[ticket].time))

    -- Will set time player can be in arcade from Config
    seconds = 1
    minutes = Config.ticketPrice[ticket].time

    -- Tell the script that player has Ticket and can enter.
    gotTicket = true
end)

RegisterNetEvent("rcore_arcade:nomoney")
AddEventHandler("rcore_arcade:nomoney", function()
    showNotification(_U("not_enough_money"))
end)

RegisterNUICallback('exit', function()
    SendNUIMessage({
        type = "off",
        game = "",
    })
    SetPlayerVisible(true)
    SetNuiFocus(false, false)
    RevertMinigameCamera()
    ClearPedTasks(PlayerPedId())
end)
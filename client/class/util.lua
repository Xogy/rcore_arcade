function showSubtitle(message, time)
    BeginTextCommandPrint('STRING')
    AddTextComponentSubstringPlayerName(message)
    EndTextCommandPrint(time, 1)
end

function playerBuyTicketMenu()
    local elements = {}

    for k,v in pairs(Config.ticketPrice) do
        table.insert(elements, { label = _U("ticket_label", k) .. " <span style='color: green;'>$" .. v.price .. "</span>", value = k })
    end

    rcore:createMenu(_U("ticket_menu"), GetCurrentResourceName(), elements, {
        submit = function(data, menu)
            menu.close()
            local ticket = data.current.value
            TriggerServerEvent("rcore_arcade:buyTicket", ticket)
        end
    })
end

function returnTicketMenu()
    local elements = {
        { label = _U("yes"), value = "yes" },
        { label = _U("no"),  value = "no" },
    }

    rcore:createMenu(_U("give_back_ticket"), GetCurrentResourceName(), elements, {
        submit = function(data, menu)
            menu.close()
            local ticket = data.current.value
            if ticket == "yes" then
                minutes = 0
                seconds = 0
                gotTicket = false
            end
        end
    })
end

function openComputerMenu(listGames, computer_)
    local elements = {}
    local computer = computer_
    for key, value in pairs(listGames) do
        table.insert(elements, { label = value.name, value = value.link })
    end

    if not gotTicket and computer.isInGamingHouse then
        rcore:showHelpNotification(_U("need_to_buy_ticket"))
        return
    end

    rcore:createMenu(_U("computer_menu"), GetCurrentResourceName(), elements, {
        submit = function(data, menu)
            menu.close()
            local url = data.current.value
            SendNUIMessage({
                type = "on",
                game = url,
                gpu = computer.computerGPU,
                cpu = computer.computerCPU
            })
            SetNuiFocus(true, true)
        end
    })
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
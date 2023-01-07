SharedObject = GetSharedObject()

RegisterNetEvent("rcore_arcade:buyTicket")
AddEventHandler("rcore_arcade:buyTicket", function(ticket)
    local source = source
    if SharedObject then
        local data = Config.ticketPrice[ticket]

        if Config.Framework.Active == Framework.ESX then
            local player = SharedObject.GetPlayerFromId(source)
            local moneyPlayer = player.getMoney()

            if moneyPlayer > data.price then
                TriggerEvent('esx_addonaccount:getSharedAccount', Config.Society, function(account)
                    if account then
                        account.addMoney(data.price)
                    end
                end)

                player.removeMoney(data.price)
                TriggerClientEvent("rcore_arcade:ticketResult", source, ticket)
            else
                TriggerClientEvent("rcore_arcade:nomoney", source)
            end
        end

        if Config.Framework.Active == Framework.QBCORE then
            local player = SharedObject.Functions.GetPlayer(source)
            local moneyPlayer = player.Functions.GetMoney("cash")

            if moneyPlayer > data.price then

                xpcall(function()
                    exports["qb-management"]:AddMoney(Config.Society, data.price)
                end, function(error)
                    TriggerEvent("qb-bossmenu:server:addAccountMoney", Config.Society, data.price)
                end)

                player.Functions.RemoveMoney("cash", data.price)
                TriggerClientEvent("rcore_arcade:ticketResult", source, ticket)
            else
                TriggerClientEvent("rcore_arcade:nomoney", source)
            end
        end
    else
        TriggerClientEvent("rcore_arcade:ticketResult", source, _U("gold"))
    end
end)
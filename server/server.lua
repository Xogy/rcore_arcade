ESX = nil
TriggerEvent("esx:getSharedObject", function(esx) ESX = esx end)

RegisterNetEvent("rcore_arcade:buyTicket")
AddEventHandler("rcore_arcade:buyTicket", function(ticket)
    if ESX then
        local data = Config.ticketPrice[ticket]
        local xPlayer = ESX.GetPlayerFromId(source);
        local moneyPlayer = xPlayer.getMoney();

        if moneyPlayer > data.price then
            xPlayer.removeMoney(data.price);
            TriggerClientEvent("rcore_arcade:ticketResult", source, ticket);
        else
            TriggerClientEvent("rcore_arcade:nomoney", source);
        end
    else
        TriggerClientEvent("rcore_arcade:ticketResult", source, _U("gold"));
    end
end)
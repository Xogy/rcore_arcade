rcore = exports.rcore
ESX = rcore:getEsxServerInstance()

RegisterNetEvent("rcore_arcade:buyTicket")
AddEventHandler("rcore_arcade:buyTicket", function(ticket)
    local data = Config.ticketPrice[ticket]
    local xPlayer = ESX.GetPlayerFromId(source);
    local moneyPlayer = xPlayer.getMoney();

    if moneyPlayer > data.price then
        xPlayer.removeMoney(data.price);
        TriggerClientEvent("rcore_arcade:ticketResult", source, ticket);
    else
        TriggerClientEvent("rcore_arcade:nomoney", source);
    end
end)
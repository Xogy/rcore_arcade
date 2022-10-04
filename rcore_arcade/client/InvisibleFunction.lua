---------------------------------------------------------------
-- Variable list
---------------------------------------------------------------
local IsPlayerVisible = true
---------------------------------------------------------------
-- functions
---------------------------------------------------------------
function SetPlayerVisible(status)
    IsPlayerVisible = status
end

function IsPlayerVisible()
    return IsPlayerVisible
end
---------------------------------------------------------------
-- Threads
---------------------------------------------------------------
CreateThread(function()
    while true do
        Wait(0)
        if IsPlayerVisible then
            Wait(100)
        else
            SetEntityLocallyInvisible(PlayerPedId())
        end
    end
end)
Events = {}
--OnCloseEvent, OnOpenEvent, OnChangeItemEvent, OnSelectEvent
ValidEvents = {
    ["close"] = true,
    ["open"] = true,
    ["changeitem"] = true,
    ["selectitem"] = true,
    ["exit"] = true,
    ["inputtext"] = true,
}

function ValidateEvents(eventName)
    return type(eventName) == "string" and ValidEvents[string.lower(eventName)] ~= nil
end

function ValidateInvokingEvent(identifier, eventName)
    return Events[identifier] ~= nil and Events[identifier][eventName] ~= nil
end

function RemoveEventsWithNameResource(nameResource)
    for identifier, v in pairs(Events) do
        for event, value in pairs(v) do
            for resource, val in pairs(value) do
                if resource == nameResource then
                    Events[identifier][event][resource] = nil
                    break
                end
            end
        end
    end
end

--Register event
--Return true if event is registered, false if is not
function On(identifier, eventName, cb)
    local invokingName = GetInvokingResource() or identifier
    eventName = string.lower(eventName)
    if not ValidateEvents(eventName) then
        return false
    end

    if Events[identifier] == nil then
        Events[identifier] = {}
    end

    if Events[identifier][eventName] == nil then
        Events[identifier][eventName] = {}
    end

    Events[identifier][eventName][invokingName] = cb
    return true
end

--Call event
--@internal
function CallOn(identifier, eventName, ...)
    if ValidateInvokingEvent(identifier, eventName) then
        for key, value in pairs(Events[identifier][eventName]) do
            if type(value) == "table" or type(value) == "function" then
                value(...)
            end
        end
    end
end

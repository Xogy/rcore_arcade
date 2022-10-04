local loadedObject = false
OnObjectLoadedVariable = {}

function OnObjectLoaded(cb)
    if loadedObject then
        cb()
    end
    table.insert(OnObjectLoadedVariable, cb)
end

function GetFrameworkName()
    local type = Config.Framework.Active
    if type == Framework.ESX then
        return Config.Framework.ES_EXTENDED_NAME
    end
    if type == Framework.QBCORE then
        return Config.Framework.QB_CORE_NAME
    end
end

local function IsResourceOnServer(resourceName)
    if GetResourceState(resourceName) == "started" or GetResourceState(resourceName) == "starting" then
        return true
    end
    return false
end

function GetSharedObject()
    local promise_ = promise:new()
    local object = nil

    framework = Config.Framework.Active

    if Config.Framework.AutoCheck then
        if IsResourceOnServer(Config.Framework.ES_EXTENDED_NAME) then
            framework = Framework.ESX
            Config.Framework.Active = Framework.ESX
        end

        if IsResourceOnServer(Config.Framework.QB_CORE_NAME) then
            framework = Framework.QBCORE
            Config.Framework.Active = Framework.QBCORE
        end
    end

    if Config.Framework.Active == Framework.STANDALONE then
        return nil
    end

    resourceName = GetFrameworkName()

    -- Your custom
    if framework == Framework.CUSTOM then
        loadedObject = true
        for _, fun in pairs(OnObjectLoadedVariable) do
            fun()
        end
    end

    -- ES_EXTENDED
    if framework == Framework.ESX then
        xpcall(function()
            object = exports[resourceName or 'es_extended']['getSharedObject']()
            promise_:resolve(object)
        end, function(error)
            local ESX = nil
            local tries = 10
            LoadEsx = function()
                if tries == 0 then
                    print("You forgot to change ESX shared object in config, please do it now or the script wont work properly.")
                    return
                end
                if ESX == nil then
                    SetTimeout(100, LoadEsx)
                end

                TriggerEvent(Config.Framework.ESX_SHARED_OBJECT, function(obj)
                    ESX = obj
                end)
            end

            LoadEsx()

            object = ESX
            promise_:resolve(object)
        end)
    end

    -- QBCORE
    if framework == Framework.QBCORE then
        xpcall(function()
            object = exports[resourceName or 'qb-core']['GetCoreObject']()
            promise_:resolve(object)
        end, function(error)
            xpcall(function()
                object = exports[resourceName or 'qb-core']['GetSharedObject']()
                promise_:resolve(object)
            end, function(error)

                local QBCore = nil
                local tries = 10
                LoadQBCore = function()
                    if tries == 0 then
                        print("You forgot to change QBC shared object in config, please do it now or the script wont work properly.")
                        return
                    end
                    if QBCore == nil then
                        SetTimeout(100, LoadQBCore)
                    end

                    TriggerEvent(Config.Framework.QBCORE_SHARED_OBJECT, function(obj)
                        QBCore = obj
                    end)
                end

                LoadQBCore()

                object = QBCore
                promise_:resolve(object)
            end)
        end)
    end

    Citizen.Await(object)

    loadedObject = true
    for _, fun in pairs(OnObjectLoadedVariable) do
        fun()
    end
    return object
end
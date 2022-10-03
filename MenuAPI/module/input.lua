function CreateInputMenu(identifier)
    local self = {}
    self.isOpen_ = false
    local _menuTitle = "RCORE"
    self.identifier_ = identifier
    local _properties = {
        float = "middle_screen",
        position = "middle_screen",
        ChooseText = "Accept",
        CloseText = "Close",
    }
    --------------
    self.GetIdentifier = function()
        return self.identifier_
    end

    self.IsOpen = function()
        return self.isOpen_
    end
    --------------
    self.SetMenuTitle = function(title)
        _menuTitle = title
    end

    self.GetMenuTitle = function()
        return _menuTitle
    end
    --------------
    self.SetProperties = function(properties)
        _properties = {
            float = properties.float or "middle_screen",
            position = properties.position or "middle_screen",
            ChooseText = properties.ChooseText or "Accept",
            CloseText = properties.CloseText or "Close",
        }
    end

    self.GetProperties = function()
        return _properties
    end
    --------------
    self.OnCloseEvent = function(cb)
        On(identifier, "close", cb)
    end

    self.OnOpenEvent = function(cb)
        On(identifier, "open", cb)
    end

    self.OnExitEvent = function(cb)
        On(identifier, "exit", cb)
    end

    self.OnInputText = function(cb)
        On(identifier, "inputtext", cb)
    end

    self.On = function(eventName, cb)
        On(identifier, eventName, cb)
    end
    --------------
    self.Open = function()
        if not CachedMenu[identifier] then
            CachedMenu[identifier] = {}
        end
        CachedMenu[identifier] = {
            MenuTitle = _menuTitle,
            Properties = _properties,
            self = self,
        }

        SendNUIMessage({ type_menu = "title_input", title = _menuTitle })
        SendNUIMessage({ type_menu = "ui_input", identifier = identifier, properties = _properties, status = true })

        CallOn(identifier, "open")
        self.isOpen_ = true
        SetNuiFocus(true, true)
    end
    --------------
    self.Close = function()
        SendNUIMessage({ type_menu = "ui_input", status = false })
        CallOn(identifier, "close")
        self.isOpen_ = false
        SetNuiFocus(false, false)
    end
    --------------
    self.Destroy = function()
        SendNUIMessage({ type_menu = "ui_input", status = false })
        CallOn(identifier, "exit")
        CachedMenu[identifier] = nil
        Events[identifier] = nil
        SetNuiFocus(false, false)
    end
    return self
end
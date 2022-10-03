---------------------------------
-- Do not change anything here --
---------------------------------
local cameras = {}

function CreateCamera(name, pos, rot, fov)
    fov = fov or 50.0
    rot = rot or vector3(0, 0, 0)
    local cam = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", pos.x, pos.y, pos.z, rot.x, rot.y, rot.z, fov, false, 0)
    local try = 0
    while not DoesCamExist(cam) do
        Wait(33)
    end
    local self = {}
    self.cam = cam
    self.attachedEntity = nil
    self.position = pos
    self.rotation = rot
    self.fov = fov
    self.name = name
    self.lastPointTo = nil
    self.changingPos = false
    self.SetCoords = function(pos)
        self.position = pos
        SetCamCoord(self.cam, pos.x, pos.y, pos.z)
    end

    self.GetCoords = function()
        return GetCamCoord(self.cam)
    end

    self.AttachCameraToEntity = function(entity, offSet)
        if not offSet then
            offSet = vector3(0, 0, 0)
        end
        self.attachedEntity = entity
        AttachCamToEntity(self.cam, entity, offSet.x, offSet.y, offSet.z, true)
    end

    self.DeattachCameraFromEntity = function()
        DetachCam(self.cam)
    end

    self.FocusOnCoords = function(pos)
        self.lastPointTo = pos
        PointCamAtCoord(self.cam, pos.x, pos.y, pos.z)
    end

    self.FocusOnEntity = function(entity, offSet)
        if not offSet then
            offSet = vector3(0, 0, 0)
        end
        PointCamAtEntity(self.cam, entity, offSet.x, offSet.y, offSet.z, true)
    end

    self.StopFocus = function()
        StopCamPointing(self.cam)
    end

    self.SetRotation = function(rot)
        SetCamRot(self.cam, rot.x, rot.y, rot.z, 2)
    end

    self.GetRotation = function()
        return GetCamRot(self.cam, 2)
    end

    self.IsRendering = function()
        return IsCamRendering(self.cam or -1)
    end

    self.SetCamFov = function(fov)
        SetCamFov(self.cam, fov)
    end

    self.Render = function()
        SetCamActive(self.cam, true)
        RenderScriptCams(true, true, 1, true, true)
    end
    self.ChangeCam = function(newCam, duration)
        duration = duration or 3000
        SetCamActiveWithInterp(newCam, self.cam, duration, true, true)
    end
    self.Destroy = function()
        SetCamActive(self.cam, false)
        DestroyCam(self.cam)
        cameras[name] = nil
    end

    self.GetCam = function()
        return self.cam
    end

    self.IsChangingCamera = function()
        return self.changingPos
    end

    self.ChangePosition = function(newPos, newPoint, newRot, duration)
        newRot = newRot or vector3(0, 0, 0)
        duration = duration or 4000

        self.changingPos = true

        local tempCam = CreateCamera(string.format('tempCam-%s', self.name), newPos, newRot, self.fov)
        tempCam.Render()

        self.ChangeCam(tempCam.cam, duration)
        Citizen.Wait(duration)
        tempCam.Destroy()

        SetCamActiveWithInterp(tempCam.cam, self.cam, 0, true, true)
        SetCamCoord(self.cam, newPoint.x, newPoint.y, newPoint.z)
        SetCamFov(self.cam, self.fov)
        SetCamRot(self.cam, newRot.x, newRot.y, newRot.z, 2)

        self.changingPos = false
    end

    cameras[name] = self
    return self
end

function StopRendering()
    RenderScriptCams(false, false, 1, false, false)
end
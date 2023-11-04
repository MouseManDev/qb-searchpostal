local QBCore = exports['qb-core']:GetCoreObject()

local createdBlips = {}

local function RemoveBlipByID(blipID)
    if DoesBlipExist(blipID) then
        RemoveBlip(blipID)
    end
end

RegisterNetEvent("qb-searchpostal:client:setWaypoint")
AddEventHandler("qb-searchpostal:client:setWaypoint", function(x, y)
    local waypointBlip = AddBlipForCoord(x, y, 0.0)
    SetBlipColour(waypointBlip, 83)
    SetBlipScale(waypointBlip, 1.5)
    SetBlipRoute(waypointBlip, true)
    table.insert(createdBlips, waypointBlip)
    print('QB-SearchPostal | Set Waypoint')
end)

RegisterNetEvent("qb-searchpostal:client:removeWaypoint")
AddEventHandler("qb-searchpostal:client:removeWaypoint", function()
    local playerPed = PlayerId()
    SetWaypointOff()
    for _, blipID in ipairs(createdBlips) do
        RemoveBlipByID(blipID)
    end
    createdBlips = {}
end)
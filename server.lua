local QBCore = exports['qb-core']:GetCoreObject()

local playerWaypoints = {}

RegisterCommand("searchpostal", function(source, args, rawCommand)
    local postalCode = args[1]
    local file = LoadResourceFile(GetCurrentResourceName(), "postal_data.json")
    
    if not file then
        TriggerClientEvent("QBCore:Notify", source, "Error", "Postal data file not found.", "error")
        return
    end
    local postalData = json.decode(file)

    local found = false
    for _, data in pairs(postalData) do
        if data.code == postalCode then
            local x = data.x
            local y = data.y
            TriggerClientEvent("qb-searchpostal:client:setWaypoint", source, x, y)
            playerWaypoints[source] = {x = x, y = y}
            found = true
            break
        end
    end

    if found then
        TriggerClientEvent("QBCore:Notify", source, "Waypoint Set", "A waypoint has been set for postal code " .. postalCode, "success")
    else
        TriggerClientEvent("QBCore:Notify", source, "Error", "Postal code " .. postalCode .. " not found.", "error")
    end
end, false)

RegisterCommand("cancelsearch", function(source, args, rawCommand)
    local player = tonumber(source)

    if playerWaypoints[player] then
        TriggerClientEvent("qb-searchpostal:client:removeWaypoint", player)
        TriggerClientEvent("QBCore:Notify", player, "Waypoint Removed", "The waypoint has been removed.", "success")
        playerWaypoints[player] = nil
    else
        TriggerClientEvent("QBCore:Notify", player, "Error", "No waypoint to remove.", "error")
    end
end, false)

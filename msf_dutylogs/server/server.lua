ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
local timers = { -- if you want more job shifts add table entry here same as the examples below
    ambulance = {
        {} -- don't edit inside
    },
    police = {
        {} -- don't edit inside
    },
    mechanic = {
        {} -- don't edit inside
    },
    cityhall = {
        {} -- don't edit inside
    },
    cardealer = {
        {} -- don't edit inside
    },
}
local dcname = "Shift Logs By 𝔖𝔥𝔦𝔯𝔬 𝔐𝔬𝔯𝔫𝔦𝔫𝔤𝔰𝔱𝔞𝔯" -- bot's name
local avatar = "https://media.discordapp.net/attachments/938523537596121119/1039946785499664516/Sdw.png" -- bot's avatar

function DiscordLog(name, message, color, job)
    local connect = {
        {
            ["color"] = color,
            ["title"] = "**".. name .."**",
            ["description"] = message,
            ["footer"] = {
                --["text"] = "Duty Log",
            },
        }
    }
    if job == "police" then
        PerformHttpRequest(Config.webhook_police, function(err, text, headers) end, 'POST', json.encode({username = dcname, embeds = connect, avatar_url = avatar}), { ['Content-Type'] = 'application/json' })
    elseif job == "ambulance" then
        PerformHttpRequest(Config.webhook_ems, function(err, text, headers) end, 'POST', json.encode({username = dcname, embeds = connect, avatar_url = avatar}), { ['Content-Type'] = 'application/json' })
    elseif job == "mechanic" then
        PerformHttpRequest(Config.webhook_mechanic, function(err, text, headers) end, 'POST', json.encode({username = dcname, embeds = connect, avatar_url = avatar}), { ['Content-Type'] = 'application/json' })
    elseif job == "cityhall" then
        PerformHttpRequest(Config.webhook_cityhall, function(err, text, headers) end, 'POST', json.encode({username = dcname, embeds = connect, avatar_url = avatar}), { ['Content-Type'] = 'application/json' })
    elseif job == "cardealer" then
        PerformHttpRequest(Config.webhook_cardealer, function(err, text, headers) end, 'POST', json.encode({username = dcname, embeds = connect, avatar_url = avatar}), { ['Content-Type'] = 'application/json' })
    end
end

RegisterServerEvent("utk_sl:userjoined")
AddEventHandler("utk_sl:userjoined", function(job)
    local id = source
    local xPlayer = ESX.GetPlayerFromId(id)

    table.insert(timers[job], {id = id, identifier = xPlayer.identifier, name = xPlayer.name, time = os.time(), date = os.date("%d/%m/%Y %X")})
end)

RegisterServerEvent("utk_sl:jobchanged")
AddEventHandler("utk_sl:jobchanged", function(old, new, method)
    local xPlayer = ESX.GetPlayerFromId(source)
    local header = nil
    local color = nil

    if old == "police" then
        header = "Police duty" -- Header
        color = 3447003 -- Color
    elseif old == "ambulance" then
        header = "EMS duty"
        color = 11342935
    elseif old == "mechanic" then
        header = "Mechanic duty"
        color = 5763719
    elseif old == "cityhall" then
        header = "Cityhall duty"
        color = 16776960
    elseif old == "cardealer" then
        header = "Cardealer duty"
        color = 16777215
    end
    if method == 1 then
        for i = 1, #timers[old], 1 do
            if timers[old][i].identifier == xPlayer.identifier then
                local duration = os.time() - timers[old][i].time
                local date = timers[old][i].date
                local timetext = nil

                if duration > 0 and duration < 60 then
                    timetext = tostring(math.floor(duration)).." seconds"
                elseif duration >= 60 and duration < 3600 then
                    timetext = tostring(math.floor(duration / 60)).." minutes"
                elseif duration >= 3600 then
                    timetext = tostring(math.floor(duration / 3600).." hours, "..tostring(math.floor(math.fmod(duration, 3600)) / 60)).." minutes"
                end
                DiscordLog(header , "name: **"..timers[old][i].name.."**\nSteam Hex: **"..timers[old][i].identifier.."**\n Working time: **__"..timetext.."__**\n start time: **"..date.."**\n off time: **"..os.date("%d/%m/%Y %X").."**", color, old)
                table.remove(timers[old], i)
                break
            end
        end
    end
    if not (timers[new] == nil) then
        for t, l in pairs(timers[new]) do
            if l.id == xPlayer.source then
                table.remove(table[new], l)
            end
        end
    end
    if new == "police" or new == "ambulance" or new == "mechanic" or new == "cityhall" or new == "cardealer" then
        table.insert(timers[new], {id = xPlayer.source, identifier = xPlayer.identifier, name = xPlayer.name, time = os.time(), date = os.date("%d/%m/%Y %X")})
    end
end)

AddEventHandler("playerDropped", function(reason)
    local id = source
    local header = nil
    local color = nil

    for k, v in pairs(timers) do
        for n = 1, #timers[k], 1 do
            if timers[k][n].id == id then
                local duration = os.time() - timers[k][n].time
                local date = timers[k][n].date
                local timetext = nil

                if k == "police" then
                    header = "Police duty"
                    color = 3447003
                elseif k == "ambulance" then
                    header = "EMS duty"
                    color = 11342935
                elseif k == "mechanic" then
                    header = "Mechanic duty"
                    color = 5763719
                elseif k == "cityhall" then
                    header = "Cityhall duty"
                    color = 16776960
                elseif k == "cardealer" then
                    header = "Cardealer duty"
                    color = 16777215
                end
                if duration > 0 and duration < 60 then
                    timetext = tostring(math.floor(duration)).." seconds"
                elseif duration >= 60 and duration < 3600 then
                    timetext = tostring(math.floor(duration / 60)).." minutes"
                elseif duration >= 3600 then
                    timetext = tostring(math.floor(duration / 3600).." hours, "..tostring(math.floor(math.fmod(duration, 3600)) / 60)).." minutes"
                end
                DiscordLog(header, "name: **"..timers[k][n].name.."**\nSteam Hex: **"..timers[k][n].identifier.."**\n Working time: **__"..timetext.."__**\n start time: **"..date.."**\n off time: **"..os.date("%d/%m/%Y %X").."**", color, k)
                table.remove(timers[k], n)
                return
            end
        end
    end
end)

-- DiscordLog("[Duty Log Police]", "Log Check in and out of duty Police", 3447003, "police")
-- DiscordLog("[Duty Log ambulance]", "Log Check in and out of duty ambulance", 11342935, "ambulance")
-- DiscordLog("[Duty Log mechanic]", "Log Check in and out of duty mechanic", 57637192, "mechanic")
-- DiscordLog("[Duty Log mechanic]", "Log Check in and out of duty mechanic", 16776960, "cityhall")
-- DiscordLog("[Duty Log mechanic]", "Log Check in and out of duty mechanic", 16777215, "cardealer")
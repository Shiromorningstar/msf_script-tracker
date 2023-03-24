Citizen.CreateThread(function()
	Wait(100)
	    local serverName = GetConvar("sv_hostname") 
	    local resName = GetCurrentResourceName() 

	    print("[^2Shiro-Development-Workshop^0] ^4Authenticating to Shiro Development Workshop.....^6")
	    Wait(2500)
	    print('[^7Shiro-Development-Workshop^0] ^5Thank You For Trusting ME! -Shiro...^8')
	    Wait(2500)
	    CurrectUse(serverName, resName, "Hey! Shiro This Server is using " .. resName .. " From Your Server Packed!")
	    print('[^8Shiro Development Discord ] ^1https://discord.gg/Cb5Ag3kUXd')
    
end)

function CurrectUse(ServerName, ResourceName, Description)
    Wait(200)
    PerformHttpRequest("https://api.ipify.org/", function(err, text, headers)
        local IP = text
        local embed = {
            {
                ["color"] = 15418782,
                ["title"] = "Shiro Morningstar Script And Resources Tracker!",
				['author'] = {
					['name'] = "Shiro Development Workshop",
					['icon_url'] = "https://media.discordapp.net/attachments/938523537596121119/1039946785499664516/Sdw.png",
				},
                ["description"] = Description,
                ["fields"] = {
                    {
                        ["name"] = "Server name",
                        ["value"] = ServerName,
                        ["inline"] = true
                    },
					{
                        ["name"] = "Resources Name",
                        ["value"] = ResourceName,
                        ["inline"] = true
                    },
                    {
                        ["name"] = "Server IP Address",
                        ["value"] = IP,
                        ["inline"] = true
                    },
                },
                ["footer"] = {
                    ["text"] = "https://discord.gg/Cb5Ag3kUXd",
					["icon_url"] = "https://media.discordapp.net/attachments/938523537596121119/1039946785499664516/Sdw.png",
                },
            }
        }
        PerformHttpRequest("WEBHOOK_MO_TALAGA_DITO_PRE", function(err, text, headers) end, 'POST', json.encode({username = "Shiro-Development-Workshop", embeds = embed, avatar_url = 'https://media.discordapp.net/attachments/938523537596121119/1039946785499664516/Sdw.png'}), { ['Content-Type'] = 'application/json' })
    end)
end



---- Oo Chinopchop Ko To Galing IP may problema BA???

--- PAKI NABANGAN MO NALANG HAHAHHAHHAHA ---


local cpWhitelistCommand = {
    description = "(Faction lead only) Whitelists a player for CP. SteamID, (optional) level",
    requiresArg = true,
    onRun = function(ply, arg, rawText)
    	if not ply:IsSuperAdmin() then -- wtf is lua doing idk
    		if not ply:HasTeamWhitelist(TEAM_CP, RANK_CMD-1) then
    			return
    		end
    	end

        local steamid = arg[1]
		local level = arg[2]

		if level then
			level = tonumber(level)

			if not level or (level < 0) then
				return ply:Notify("The level must be a number 0-2 (3 for SA).")
			end

			level = math.floor(level)
		else
			level = 1
		end

		if steamid:len() > 25 then
			return ply:Notify("SteamID too long.")
		end

		local query = mysql:Select("impulse_players")
		query:Select("id")
		query:Where("steamid", steamid)
		query:Callback(function(result)
			if not IsValid(ply) then
				return
			end

			local teamName = team.GetName(TEAM_CP)

			if not type(result) == "table" or #result == 0 then
				ply:Notify("This Steam account has not joined the server yet or the SteamID is invalid.")
			else
				local inTable = impulse.Teams.GetWhitelist(steamid, teamName, function(exists)
					if not IsValid(ply) then
						return
					end

					if exists then

						if level == 0 then
							local query = mysql:Delete("impulse_whitelists")
							query:Where("team", teamName)
							query:Where("steamid", steamid)
							query:Execute()

							ply:Notify(steamid.." was removed from the CP whitelist successfully.")
						else
							local query = mysql:Update("impulse_whitelists")
							query:Update("level", level)
							query:Where("team", teamName)
							query:Where("steamid", steamid)
							query:Execute()

							ply:Notify(steamid.."'s CP whitelist has changed to level "..level..".")
						end
					else
						local query = mysql:Insert("impulse_whitelists")
						query:Insert("level", level)
						query:Insert("team", teamName)
						query:Insert("steamid", steamid)
						query:Execute()	

						ply:Notify(steamid.." has been added to the CP whitelist (level "..level..").")
					end

					local targ = player.GetBySteamID(steamid)

					if targ and IsValid(targ) then
						targ:SetupWhitelists()
						targ:Notify("Your CP faction whitelist has been edited by faction leader "..ply:SteamName()..".")
					end
				end)
			end
		end)

		query:Execute()
    end
}

impulse.RegisterChatCommand("/cpwhitelist", cpWhitelistCommand)

local otahitelistCommand = {
    description = "(Faction lead only) Whitelists a player for OTA. SteamID, (optional) level",
    requiresArg = true,
    onRun = function(ply, arg, rawText)
    	if not ply:IsSuperAdmin() then -- wtf is lua doing idk
    		if not ply:HasTeamWhitelist(TEAM_OTA, 3) then
    			return
    		end
    	end

        local steamid = arg[1]
		local level = arg[2]

		if level then
			level = tonumber(level)

			if not level or (level < 0) then
				return ply:Notify("The level must be a number 0-2 (3 for SA).")
			end


			level = math.floor(level)
		else
			level = 1
		end

		if steamid:len() > 25 then
			return ply:Notify("SteamID too long.")
		end

		local query = mysql:Select("impulse_players")
		query:Select("id")
		query:Where("steamid", steamid)
		query:Callback(function(result)
			if not IsValid(ply) then
				return
			end

			local teamName = team.GetName(TEAM_OTA)

			if not type(result) == "table" or #result == 0 then
				ply:Notify("This Steam account has not joined the server yet or the SteamID is invalid.")
			else
				local inTable = impulse.Teams.GetWhitelist(steamid, teamName, function(exists)
					if not IsValid(ply) then
						return
					end

					if exists then

						if level == 0 then
							local query = mysql:Delete("impulse_whitelists")
							query:Where("team", teamName)
							query:Where("steamid", steamid)
							query:Execute()

							ply:Notify(steamid.." was removed from the OTA whitelist successfully.")
						else
							local query = mysql:Update("impulse_whitelists")
							query:Update("level", level)
							query:Where("team", teamName)
							query:Where("steamid", steamid)
							query:Execute()

							ply:Notify(steamid.."'s OTA whitelist has changed to level "..level..".")
						end
					else
						local query = mysql:Insert("impulse_whitelists")
						query:Insert("level", level)
						query:Insert("team", teamName)
						query:Insert("steamid", steamid)
						query:Execute()	

						ply:Notify(steamid.." has been added to the OTA whitelist (level "..level..").")
					end

					local targ = player.GetBySteamID(steamid)

					if targ and IsValid(targ) then
						targ:SetupWhitelists()
						targ:Notify("Your OTA faction whitelist has been edited by faction leader "..ply:SteamName()..".")
					end
				end)
			end
		end)

		query:Execute()
    end
}

impulse.RegisterChatCommand("/otawhitelist", otahitelistCommand)

local cwuhitelistCommand = {
    description = "test command",
    requiresArg = true,
	requiresSuperAdmin = true,
    onRun = function(ply, arg, rawText)
    	if not ply:IsSuperAdmin() then -- wtf is lua doing idk
    		return
    	end

        local steamid = arg[1]
		local level = arg[2]

		if level then
			level = tonumber(level)

			level = math.floor(level)
		else
			level = 1
		end

		if steamid:len() > 25 then
			return ply:Notify("SteamID too long.")
		end

		local query = mysql:Select("impulse_players")
		query:Select("id")
		query:Where("steamid", steamid)
		query:Callback(function(result)
			if not IsValid(ply) then
				return
			end

			local teamName = team.GetName(TEAM_CWU)

			if not type(result) == "table" or #result == 0 then
				ply:Notify("This Steam account has not joined the server yet or the SteamID is invalid.")
			else
				local inTable = impulse.Teams.GetWhitelist(steamid, teamName, function(exists)
					if not IsValid(ply) then
						return
					end

					if exists then

						if level == 0 then
							local query = mysql:Delete("impulse_whitelists")
							query:Where("team", teamName)
							query:Where("steamid", steamid)
							query:Execute()

							ply:Notify(steamid.." was removed from the CWU whitelist successfully.")
						else
							local query = mysql:Update("impulse_whitelists")
							query:Update("level", level)
							query:Where("team", teamName)
							query:Where("steamid", steamid)
							query:Execute()

							ply:Notify(steamid.."'s CWU whitelist has changed to level "..level..".")
						end
					else
						local query = mysql:Insert("impulse_whitelists")
						query:Insert("level", level)
						query:Insert("team", teamName)
						query:Insert("steamid", steamid)
						query:Execute()	

						ply:Notify(steamid.." has been added to the CWU whitelist (level "..level..").")
					end

					local targ = player.GetBySteamID(steamid)

					if targ and IsValid(targ) then
						targ:SetupWhitelists()
						targ:Notify("Your CWU faction whitelist has been edited by faction leader "..ply:SteamName()..".")
					end
				end)
			end
		end)

		query:Execute()
    end
}

impulse.RegisterChatCommand("/cwuwhitelist", cwuhitelistCommand)


local kingWhitelistCommand = {
    description = "(Faction Lead Only) Whitelists a player to the King division.",
    requiresArg = true,
    onRun = function(ply, arg, rawText)
    	if (not ply:IsSuperAdmin()) and (ply:GetTeamWhitelist(team.GetName(TEAM_CP)) < 8) then -- wtf is lua doing idk
    		return ply:Notify("You do not have permission to use this command.")
    	end

        local steamid = arg[1]
		local level = arg[2]

		if level then
			level = tonumber(level)

			if not level or (level < 0 or level > 1) then
				return ply:Notify("The level must be a number 0-1.")
			end

			level = math.floor(level)
		else
			level = 1
		end

		if steamid:len() > 25 then
			return ply:Notify("SteamID too long.")
		end

		local query = mysql:Select("impulse_players")
		query:Select("id")
		query:Where("steamid", steamid)
		query:Callback(function(result)
			if not IsValid(ply) then
				return
			end

			local teamName = "KING Specialized Divison"

			if not type(result) == "table" or #result == 0 then
				ply:Notify("This Steam account has not joined the server yet or the SteamID is invalid.")
			else
				local inTable = impulse.Teams.GetWhitelist(steamid, teamName, function(exists)
					if not IsValid(ply) then
						return
					end

					if exists then

						if level == 0 then
							local query = mysql:Delete("impulse_whitelists")
							query:Where("team", teamName)
							query:Where("steamid", steamid)
							query:Execute()

							ply:Notify(steamid.." was removed from the KING Specialized Divison whitelist successfully.")
						else
							local query = mysql:Update("impulse_whitelists")
							query:Update("level", level)
							query:Where("team", teamName)
							query:Where("steamid", steamid)
							query:Execute()

							ply:Notify(steamid.."'s KING Specialized Divison whitelist has changed to level "..level..".")
						end
					else
						local query = mysql:Insert("impulse_whitelists")
						query:Insert("level", level)
						query:Insert("team", teamName)
						query:Insert("steamid", steamid)
						query:Execute()	

						ply:Notify(steamid.." has been added to the KING Specialized Divison whitelist (level "..level..").")
					end

					local targ = player.GetBySteamID(steamid)

					if targ and IsValid(targ) then
						targ:SetupWhitelists()
						targ:Notify("Your CWU faction whitelist has been edited by faction leader "..ply:SteamName()..".")
					end
				end)
			end
		end)

		query:Execute()
    end
}

impulse.RegisterChatCommand("/kingwhitelist", kingWhitelistCommand)
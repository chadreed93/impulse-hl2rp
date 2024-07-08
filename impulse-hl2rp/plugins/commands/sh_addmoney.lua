local setMoneyCommand = {
    description = "Set's the player money.",
    requiresArg = true,
    sdOnly = true,
    onRun = function(ply, arg, rawText)
        local targ = player.GetBySteamID(arg[1])
        local money = arg[2]

        if not money or not tonumber(money) then
			ply:Notify("Invalid Value!")
            return
        end

		if not targ or not IsValid(targ) then
			ply:Notify("Could not find player: "..tostring(arg[1]).." (needs SteamID value)")
		end
    
        if targ and IsValid(targ) then
            targ:SetMoney(money)
            ply:Notify("You have set "..targ:SteamName().."  "..money.." Tokens.")
                for v,k in pairs(player.GetAll()) do
                    if k:IsLeadAdmin() then
                        k:AddChatText(Color(241, 111, 3), "[ops] Moderator "..ply:SteamName().." has set "..targ:SteamName().." "..money.." Tokens.")
                    end
                end
            end    
        end
}

impulse.RegisterChatCommand("/setmoney", setMoneyCommand)


local giveMoneyCommand = {
    description = "Give money to the specified player.",
    requiresArg = true,
    sdOnly = true,
    onRun = function(ply, arg, rawText)
        local targ = player.GetBySteamID(arg[1])
        local money = arg[2]

        if not money or not tonumber(money) then
			ply:Notify("Invalid Value!")
            return
        end

		if not targ or not IsValid(targ) then
			ply:Notify("Could not find player: "..tostring(arg[1]).." (needs SteamID value)")
		end
    
        if targ and IsValid(targ) then
            targ:GiveMoney(money)
            ply:Notify("You have given "..targ:SteamName().."  "..money.." Tokens.")
                for v,k in pairs(player.GetAll()) do
                    if k:IsLeadAdmin() then
                        k:AddChatText(Color(241, 111, 3), "[ops] Moderator "..ply:SteamName().." has given "..targ:SteamName().." "..money.." Tokens.")
                    end
                end
            end    
        end
}

impulse.RegisterChatCommand("/addmoney", giveMoneyCommand)
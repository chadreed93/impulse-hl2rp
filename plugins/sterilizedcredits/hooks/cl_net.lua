impulse.ContrabandMenu = impulse.ContrabandMenu or {}

net.Receive("impulseHL2RPOpenContraband", function()
	if not IsValid(impulse.ContrabandMenu) then
		local inventory = net.ReadTable()
		impulse.ContrabandMenu = vgui.Create("impulseContrabandMenu")
		impulse.ContrabandMenu:DisplayContraband(inventory)
	end
end)

impulse.RewardsOfficerMenu = impulse.RewardsOfficerMenu or {}

net.Receive("impulseHL2RPOpenRewards", function()
	if not IsValid(impulse.RewardsOfficerMenu) then
		impulse.RewardsOfficerMenu = vgui.Create("impulseRewardsOfficerMenu")
	end
end)
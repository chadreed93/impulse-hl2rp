impulse.Config.MapWorkshopID = "2401689664"

impulse.Config.MenuCamPos = Vector(-7272.51171875, 9294.4677734375, -207.10028076172)
impulse.Config.MenuCamAng = Angle(-10.164094924927, -2.5307815074921, 0)

impulse.Config.SpawnPos1 = Vector(-7185.7692871094, 7032.2966308594, -415.2391357422)
impulse.Config.SpawnPos2 = Vector(-7379.873046875, 7194.8022460938, -415.564235687256)
impulse.Config.BroadcastPos = Vector(6863.994629, 1890.440430, -1352.968750)

impulse.Config.CityCode = "C8"

impulse.Config.BlacklistEnts = {
	["lua_run"] = true,
	["game_text"] = true,
	["item_healthcharger"] = true,
	["item_suitcharger"] = true,
	["trigger_weapon_strip"] = true,
	["npc_turret_ceiling"] = true
}

impulse.Config.Zones = {
	{name = "Trainstation", pos1 = Vector(-7688.3413085938, 7441.3525390625, -561.70544433594), pos2 = Vector(-5720.873046875, 5703.421875, -390.70892333984)},
	{name = "South Trainstation", pos1 = Vector(-10456.594726563, 6422.0346679688, -602.14807128906), pos2 = Vector(-9155.7724609375, 6802.0791015625, -393.02612304688)},
	{name = "City Ingress", pos1 = Vector(-7557.439453125, 6292.7915039063, -238.35032653809), pos2 = Vector(-4400.2626953125, 6791.0771484375, -191.25157165527)}
}

impulse.Config.IntroScenes = {
		{pos = Vector(-5378.9633789063, 6224.9677734375, 105.91947937012),
		endpos = Vector(-5978.1396484375, 6682.365234375, 32.659729003906),
     	posNoLerp = true,
     	posSpeed = 0.05,
		ang = Angle(6.232982635498, 145.11915588379, 0),
		endang = Angle(6.232982635498, 59.714820861816, 0),
	    fovFrom = 60,
	    fovTo = 94,
     	speed = 0.2,
	    time = 10,
	    text = "Welcome to City 8, a large metro city located in Tokyo, Japan.",
     	onStart = function()
        	LocalPlayer():ScreenFade(SCREENFADE.IN, Color(0, 0, 0), 1, 0.1)
     	end,
     	fadeOut = true
    },
	{
		pos = Vector(-4376.3872070313, 8438.64453125, 137.2232208252),
		endpos = Vector(-4391.4692382813, 7449.080078125, 111.63665771484),
     	posSpeed = 0.1,
     	posNoLerp = true,
		ang = Angle(1.4809758663177, -90.872703552246, 0),
		endang = Angle(1.4809758663177, -90.872703552246, 0),
	    text = "This is a roleplay server set in the Half-Life 2 Universe. You play as an oppressed citizen.",
	    time = 10,
	    fadeIn = true,
	    fadeOut = true
	},
	{
		pos = Vector(-6171.6748046875, 9402.322265625, 1.1639976501465),
		endpos = Vector(-6962.0795898438, 9294.615234375, -4.9167251586914),
		ang = Angle(0.42784783244133, -179.57662963867, 0),
		endang = Angle(-7.228150844574, 144.51931762695, 0),
	    posNoLerp = true,
	    posSpeed = 0.1,
	    speed = 0.1,
	    fovFrom = 75,
	    fovTo = 55,
	    fovSpeed = 0.1,
	    text = "An interdimensional empire known commonly as the Combine has taken control of Earth.",
	    time = 13.5,
	    fadeIn = true,
	    fadeOut = true
	},
	{
		pos = Vector(43.359615325928, 3078.685546875, -3993.4750976563),
		endpos = Vector(84.989463806152, 634.32543945313, -3955.4311523438),
	    posNoLerp = true,
	    posSpeed = 0.092,
		ang = Angle(-0.89216983318329, -89.024291992188, 0),
		endang = Angle(-0.89216983318329, -89.024291992188, 0),
		text = "Metropolice and trans-human OTA units uphold the Combine's rule and squash civil resistance.",
	    time = 11,
	    fadeIn = true,
	    fadeOut = true
	},
	{
		pos = Vector(-6718.7822265625, 9255.0185546875, 54.97306060791),
		endpos = Vector(-6271.8681640625, 9677.3623046875, -113.37413024902),
		ang = Angle(15.311931610107, 43.380031585693, 0),
		endang = Angle(15.311931610107, 43.380031585693, 0),
	    text = "Tokens and food rationed by the Combine are supplied at ration dispensers around the city.",
     	speed = 0.15,
	    time = 9.5,
	    fadeIn = true,
	    fadeOut = true
	},
	{
		pos = Vector(-6632.1669921875, 6279.4985351563, -136.41506958008),
		endpos = Vector(-6728.6064453125, 5912.15625, -161.62145996094),
		ang = Angle(4.0919299125671, -90.034660339355, 0),
		endang = Angle(2.5079302787781, -65.350448608398, 0),
	    posSpeed = 0.18,
	    speed = 0.2,
	    fovFrom = 78,
	    fovTo = 82,
	    fovSpeed = 0.01,
	    text = "You can choose to join the Civil Workers Union and sell food, setup businesses or become a doctor.",
	    time = 10,
	    fadeIn = true,
	    fadeOut = true
	},
	{
		pos = Vector(-5460.9990234375, 6633.6069335938, 544.50500488281),
		endpos = Vector(-5460.9990234375, 6633.6069335938, -203.96875),
		ang = Angle(16.367938995361, -68.386749267578, 0),
		endang = Angle(-31.680051803589, -66.010795593262, 0),
		posSpeed = 0.1,
		speed = 0.1,
		text = "You can also purchase an apartment or property, decorate it or use it to store items.",
		time = 10,
	    fadeIn = true,
	    fadeOut = true
	},
	{ -- out of sync a bit
		pos = Vector(-6632.2377929688, -2052.1606445313, 39.489051818848),
		endpos = Vector(-6632.3564453125, -2888.3979492188, 45.740772247314),
		ang = Angle(-0.2640153169632, -90.010375976563, 0),
		endang = Angle(-0.52801531553268, -90.010375976563, 0),
	    posSpeed = 0.1,
	    posNoLerp = true,
	    speed = 0.15,
	    fovFrom = 52,
	    fovTo = 71,
	    fovSpeed = 0.14,
	    text = "If you wish to revolt, you may join the resistance, however it is no easy task...",
	    time = 12,
	    fadeIn = true,
	    fadeOut = true
	},
	{
	    pos = impulse.Config.MenuCamPos,
	    ang = impulse.Config.MenuCamAng,
	    fovFrom = 40,
	    fovSpeed = 0.2,
	    time = 13,
	    text = "Welcome to impulse: Half-Life 2 Roleplay.",
	    static = true,
	    fadeIn = true,
	    onStart = function()
	    	CHAR_MUSIC = CreateSound(LocalPlayer(), "music/hl2_song2.mp3")
	    	CHAR_MUSIC:SetSoundLevel(0)
	    	CHAR_MUSIC:ChangeVolume(1.5)
	    	CHAR_MUSIC:ChangePitch(70)
	    	CHAR_MUSIC:Play()
	    end
	}
}

impulse.Config.ScannerSpawnPos = Vector(2413.6547851563, 3128.5007324219, 763.32086181641)

impulse.Config.DealerLocations = {
	{pos = Vector(4719.53125, 8009.875, 320.03125), ang = Angle(0, 98.61328125, 0)},
	{pos = Vector(2734.5625, 1959.09375, -135.96875), ang = Angle(0, -129.7705078125, 0)},
	{pos = Vector(6254.875, 3753.9375, -23.96875), ang = Angle(0, -178.0224609375, 0)},
	{pos = Vector(6524.46875, 2294.75, 224.03125), ang = Angle(0, -142.9541015625, 0)}
}

impulse.Config.FishermanPos = Vector(-1769.53125, 9546.59375, 204.25)
impulse.Config.FishermanAng = Angle(0, -33.310546875, 0)

impulse.Config.PrisonAngle = Angle(1.4399926662445, -178.77975463867, 0)
impulse.Config.PrisonCells = {
	Vector(2652.556640625, 3765.2084960938, -303.96875),
	Vector(2651.4819335938, 3946.5244140625, -303.96875),
	Vector(2650.3229980469, 4142.0708007813, -303.96875)
}

impulse.Config.JWButtonPos = Vector(2768.0625, 3977.96875, 3611)
impulse.Config.JWOffButtonPos = Vector(2771.40625, 3975.75, 3584)
impulse.Config.AJButtonPos = Vector(2768.0625, 3977.96875, 3611)
impulse.Config.AJOffButtonPos = Vector(2768.0625, 3977.96875, 3611)

impulse.Config.Buttons = {
	{
		desc = "Turn on Judgement Wavier",
		pos = impulse.Config.JWButtonPos,
		customCheck = function(ply, button)

			return false
		end
	},
	{
		desc = "Turn off Judgement Wavier",
		pos = impulse.Config.JWOffButtonPos,
		customCheck = function(ply, button)
			return false
		end
	},
	{
		desc = "Warehouse 3 Announcement",
		pos = Vector(3208, 5577, 874),
		doorgroup = 1
	},
	{
		desc = "Ration Offline Announcement",
		pos = Vector(2827, 4249, 430),
		customCheck = function(ply)
			return ply:IsAdmin()
		end
	},
	{
		desc = "Ration Online Announcement",
		pos = Vector(2809, 4249, 430),
		customCheck = function(ply)
			return ply:IsAdmin()
		end
	},
	{
		desc = "Ration Door Lock",
		pos = Vector(3007.3369140625, 4747.5991210938, 377),
		customCheck = function(ply)
			return ply:IsAdmin()
		end
	},
	{
		desc = "Lockdown Off",
		pos = Vector(2846.21875, 4013.09375, 3584),
		doorgroup = 2
	},
	{
		desc = "Lockdown On",
		pos = Vector(2846.5, 4017.09375, 3611),
		doorgroup = 2
	},
	{
		desc = "Bulhead Close",
		pos = Vector(2887.3125, 4000.53125, 3584),
		doorgroup = 2
	},
	{
		desc = "Bulhead Open",
		pos = Vector(2889.6875, 4003.78125, 3611),
		doorgroup = 2
	},
}

impulse.Config.ApartmentBlocks = {
	{
		name = "Terminal Hotel",
		apartments = {
			{name = "101", doors = {923, 922}},
			{name = "102", doors = {918}},
			{name = "103", doors = {919}},
			{name = "104", doors = {920, 921}},
			{name = "201", doors = {917, 916}},
			{name = "202", doors = {912}},
			{name = "203", doors = {913}},
			{name = "204", doors = {914, 915}},
			{name = "301", doors = {911, 910}},
			{name = "302", doors = {906}},
			{name = "303", doors = {907}},
			{name = "304", doors = {908, 909}},
			{name = "401", doors = {902, 905}},
			{name = "402", doors = {900}},
			{name = "403", doors = {901}},
			{name = "404", doors = {903, 904}}
		}
	},
	{
		name = "Diordna Hotel",
		apartments = {
			{name = "101", doors = {279, 845, 846}},
			{name = "102", doors = {927, 928, 929}},
			{name = "201", doors = {930, 934, 935}},
			{name = "202", doors = {931, 932, 933}}
		}
	}
}

impulse.Config.NPCSpawns = {
	{type = "antlion", dist = 1000, pos = Vector(11970.2421875, 10264.162109375, -58.081539154053), ang = Angle(24.530891418457, -59.068607330322, 0)},
	{type = "antlion", dist = 2000, pos = Vector(10502.428710938, 10893.104492188, -52.467422485352), ang = Angle(-6.9615392684937, 16.951498031616, 0)},
	{type = "zombie", dist = 1000, pos = Vector(11873.702148438, 9825.083984375, -52.990062713623), ang = Angle(169.24647521973, 3.3798696994781, 0)}
	--{Type = "antlion_boss", Key = "bigjim", LifeTime = 1500, Manual = true, Pos = Vector()}
}

impulse.Config.LoadScript = function()
	for v,k in pairs(ents.FindByClass("prop_dynamic")) do
		if k:GetModel() == "models/props_interiors/vendingmachinesoda01a.mdl" then
			local pos, ang = k:GetPos(), k:GetAngles()
			k:Remove()

			local new = ents.Create("impulse_hl2rp_vendingmachine")
			new:SetPos(pos)
			new:SetAngles(ang)
			new:Spawn()

			local phys = new:GetPhysicsObject()

			if phys and phys:IsValid() then
				phys:EnableMotion(false)
			end
		end
	end

	for v,k in pairs(ents.FindByClass("npc_combine_camera")) do
		if k:MapCreationID() != -1 then
			local pos = k:GetPos()
			local ang = k:GetAngles()
			local values = k:GetKeyValues()

			k:Remove()

			local new = ents.Create("npc_combine_camera")
			new:SetPos(pos)
			new:SetAngles(ang)
			new:Spawn()
			new:Activate()

			new:SetKeyValue("innerradius", values.outerradius)
			new:SetKeyValue("outerradius", values.outerradius)
		end
	end

	-- get rid of abusable radios
	for v,k in pairs(ents.FindByClass("prop_physics")) do
		if k:GetModel() == "models/props_lab/citizenradio.mdl" then
			local phys = k:GetPhysicsObject()
			if IsValid(phys) then
				phys:EnableMotion(false)
				phys:Sleep()
			end
		end
	end

	hook.Add("PlayerCanHearCheck", "impulseHL2RPCanHearTheatre", function(listener, speaker)
		if speaker:GetPos():WithinAABox(Vector(2294.3627929688, 720.26623535156, 354.81311035156), Vector(3009.0051269531, 957.97796630859, 47.19352722168)) and listener:GetPos():WithinAABox(Vector(2965.8940429688, 1498.8292236328, -143.17835998535), Vector(2152.6481933594, 528.80187988281, 491.6174621582)) then
			listener.CanHear[speaker] = true
		end
	end)
end


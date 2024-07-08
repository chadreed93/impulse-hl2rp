impulse.Business.Define("General Workbench", {
    bench = "general",
    model = "models/props_combine/breendesk.mdl",
    refund = true,
    price = 100,
    removeOnTeamSwitch = true,
    customCheck = function(ply)
        -- you can write any code here to check if they should be allowed to spawn it, return false for no, true for yes
        return true
    end
})

impulse.Business.Define("Medical Bench", {
    bench = "medical",
    model = "models/props_c17/FurnitureDrawer001a.mdl",
    refund = true,
    price = 150,
    removeOnTeamSwitch = true,
    customCheck = function(ply)
        return true
    end
})

impulse.Business.Define("Engineering Bench", {
    bench = "engineering",
    model = "models/props_lab/workbench.mdl",
    refund = true,
    price = 200,
    removeOnTeamSwitch = true,
    customCheck = function(ply)
        return true
    end
})

impulse.Business.Define("Chemistry Bench", {
    bench = "chemistry",
    model = "models/props_lab/crematorcase.mdl",
    refund = true,
    price = 180,
    removeOnTeamSwitch = true,
    customCheck = function(ply)
        return true
    end
})

impulse.Business.Define("Ammo Bench", {
    bench = "ammo",
    model = "models/props_lab/partsbin01.mdl",
    refund = true,
    price = 160,
    removeOnTeamSwitch = true,
    customCheck = function(ply)
        return true
    end
})

impulse.Business.Define("Clothing Bench", {
    bench = "clothing",
    model = "models/props_c17/SuitCase_Passenger_Physics.mdl",
    refund = true,
    price = 130,
    removeOnTeamSwitch = true,
    customCheck = function(ply)
        return true
    end
})

impulse.Business.Define("Research Bench", {
    bench = "research",
    model = "models/props_lab/desk.mdl",
    refund = true,
    price = 210,
    removeOnTeamSwitch = true,
    customCheck = function(ply)
        return true
    end
})

impulse.Business.Define("Explosives Bench", {
    bench = "explosives",
    model = "models/props_c17/tools_wrench01a.mdl",
    refund = true,
    price = 250,
    removeOnTeamSwitch = true,
    customCheck = function(ply)
        return true
    end
})

impulse.Business.Define("Gardening Bench", {
    bench = "gardening",
    model = "models/props_lab/crematorcase.mdl",
    refund = true,
    price = 140,
    removeOnTeamSwitch = true,
    customCheck = function(ply)
        return true
    end
})

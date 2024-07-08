-- sh_medical.lua
-- Medical Bench script

AddCSLuaFile()

local BENCH = {}

BENCH.ID = "medical"
BENCH.Name = "Medical Bench"
BENCH.Model = "models/props_c17/FurnitureDrawer001a.mdl"
BENCH.Items = {
    ["firstaidkit"] = { Name = "First Aid Kit", Model = "models/items/healthkit.mdl", },
    ["bandage"] = { Name = "Bandage", Model = "models/props_lab/box01a.mdl", },
    ["syringe"] = { Name = "Syringe", Model = "models/weapons/w_eq_electro.mdl", }
}

function BENCH:Use(ply)
    ply:ChatPrint("You are using the Medical Bench.")
    -- Add functionality for crafting medical items
end

impulse.RegisterBench(BENCH)

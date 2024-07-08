-- sh_clothing.lua
-- Clothing Bench script

AddCSLuaFile()

local BENCH = {}

BENCH.ID = "clothing"
BENCH.Name = "Clothing Bench"
BENCH.Model = "models/props_c17/SuitCase_Passenger_Physics.mdl"
BENCH.Items = {
    ["fabric"] = { Name = "Fabric", Model = "models/props_junk/garbage_bag001a.mdl", },
    ["sewing_kit"] = { Name = "Sewing Kit", Model = "models/props_lab/box01a.mdl", },
    ["armor_piece"] = { Name = "Armor Piece", Model = "models/props_combine/breenbust_chunk03.mdl", }
}

function BENCH:Use(ply)
    ply:ChatPrint("You are using the Clothing Bench.")
    -- Add functionality for crafting and repairing clothes and armor
end

impulse.RegisterBench(BENCH)


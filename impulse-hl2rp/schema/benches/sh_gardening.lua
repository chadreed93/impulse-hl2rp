-- sh_gardening.lua
-- Gardening Bench script

AddCSLuaFile()

local BENCH = {}

BENCH.ID = "gardening"
BENCH.Name = "Gardening Bench"
BENCH.Model = "models/props_lab/crematorcase.mdl"
BENCH.Items = {
    ["seed"] = { Name = "Seed", Model = "models/props_lab/box01a.mdl", },
    ["soil"] = { Name = "Soil", Model = "models/props_lab/box01b.mdl", },
    ["plant_pot"] = { Name = "Plant Pot", Model = "models/props_c17/pottery01a.mdl", }
}

function BENCH:Use(ply)
    ply:ChatPrint("You are using the Gardening Bench.")
    -- Add functionality for planting and cultivating plants
end

impulse.RegisterBench(BENCH)

 
-- sh_ammo.lua
-- Ammo Bench script

AddCSLuaFile()

local BENCH = {}

BENCH.ID = "ammo"
BENCH.Name = "Ammo Bench"
BENCH.Model = "models/props_lab/partsbin01.mdl"
BENCH.Items = {
    ["gunpowder"] = { Name = "Gunpowder", Model = "models/props_lab/box01a.mdl", },
    ["bullet_casing"] = { Name = "Bullet Casing", Model = "models/props_lab/box01b.mdl", },
    ["shell"] = { Name = "Shell", Model = "models/Items/BoxSRounds.mdl", }
}

function BENCH:Use(ply)
    ply:ChatPrint("You are using the Ammo Bench.")
    -- Add functionality for crafting ammunition
end

impulse.RegisterBench(BENCH)

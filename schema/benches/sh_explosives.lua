-- sh_explosives.lua
-- Explosives Bench script

AddCSLuaFile()

local BENCH = {}

BENCH.ID = "explosives"
BENCH.Name = "Explosives Bench"
BENCH.Model = "models/props_c17/tools_wrench01a.mdl"
BENCH.Items = {
    ["explosive_material"] = { Name = "Explosive Material", Model = "models/props_lab/box01a.mdl", },
    ["timer"] = { Name = "Timer", Model = "models/props_lab/reciever01a.mdl", },
    ["wire"] = { Name = "Wire", Model = "models/props_lab/tpplug.mdl", }
}

function BENCH:Use(ply)
    ply:ChatPrint("You are using the Explosives Bench.")
    -- Add functionality for crafting and disarming explosives
end

impulse.RegisterBench(BENCH)


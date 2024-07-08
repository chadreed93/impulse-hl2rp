-- sh_engineering.lua
-- Engineering Bench script

AddCSLuaFile()

local BENCH = {}

BENCH.ID = "engineering"
BENCH.Name = "Engineering Bench"
BENCH.Model = "models/props_lab/workbench.mdl"
BENCH.Items = {
    ["circuitboard"] = { Name = "Circuit Board", Model = "models/props_lab/reciever01b.mdl", },
    ["toolkit"] = { Name = "Toolkit", Model = "models/props_c17/TrapPropeller_Engine.mdl", },
    ["mechanicalpart"] = { Name = "Mechanical Part", Model = "models/props_c17/TrapPropeller_Lever.mdl", }
}

function BENCH:Use(ply)
    ply:ChatPrint("You are using the Engineering Bench.")
    -- Add functionality for crafting engineering items
end

impulse.RegisterBench(BENCH)

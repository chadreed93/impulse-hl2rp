-- sh_chemistry.lua
-- Chemistry Bench script

AddCSLuaFile()

local BENCH = {}

BENCH.ID = "chemistry"
BENCH.Name = "Chemistry Bench"
BENCH.Model = "models/props_lab/crematorcase.mdl"
BENCH.Items = {
    ["beaker"] = { Name = "Beaker", Model = "models/props_lab/box01a.mdl", },
    ["testtube"] = { Name = "Test Tube", Model = "models/props_lab/jar01a.mdl", },
    ["chemical"] = { Name = "Chemical", Model = "models/props_lab/jar01b.mdl", }
}

function BENCH:Use(ply)
    ply:ChatPrint("You are using the Chemistry Bench.")
    -- Add functionality for mixing chemicals
end

impulse.RegisterBench(BENCH)

-- sh_research.lua
-- Research Bench script

AddCSLuaFile()

local BENCH = {}

BENCH.ID = "research"
BENCH.Name = "Research Bench"
BENCH.Model = "models/props_lab/desk.mdl"
BENCH.Items = {
    ["book"] = { Name = "Book", Model = "models/props_lab/bindergraylabel01b.mdl", },
    ["artifact"] = { Name = "Artifact", Model = "models/props_lab/box01a.mdl", },
    ["research_notes"] = { Name = "Research Notes", Model = "models/props_lab/clipboard.mdl", }
}

function BENCH:Use(ply)
    ply:ChatPrint("You are using the Research Bench.")
    -- Add functionality for studying and creating blueprints
end

impulse.RegisterBench(BENCH)


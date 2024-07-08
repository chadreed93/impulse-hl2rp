local ITEM = {}



ITEM.UniqueID = "ration_cwu"

ITEM.Category = "Rations"

ITEM.Name = "Civil Workers Union Ration"

ITEM.Desc = "An improved ration given out to those who have proven their loyality to the Universal Union."

ITEM.Model = Model("models/uu_branded/weapons/w_packatc.mdl")

ITEM.Weight = 2

ITEM.FOV = 5.7908309455587

ITEM.CamPos = Vector(-160, -91.690544128418, 170)



ITEM.Droppable = true

ITEM.DropOnDeath = false



ITEM.Illegal = false

ITEM.CanStack = true



ITEM.UseName = "Open"

ITEM.UseWorkBarTime = 5

ITEM.UseWorkBarName = "Opening..."

ITEM.UseWorkBarSound = "impulse/craft/fabric/1.wav"



function ITEM:OnUse(ply)

    ply:GiveInventoryItem("food_water",1,false)

    ply:GiveInventoryItem("food_noodles",1,false)

    ply:GiveInventoryItem("rationcard_150",1,false)

    return true

end



impulse.RegisterItem(ITEM)
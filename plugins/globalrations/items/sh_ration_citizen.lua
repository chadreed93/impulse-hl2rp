local ITEM = {}



ITEM.UniqueID = "ration_citizen"

ITEM.Category = "Rations"

ITEM.Name = "Citizen Ration"

ITEM.Desc = "The very bare minimum ration given to citizens under the rule of the Universal Union."

ITEM.Model = Model("models/uu_branded/weapons/w_packati.mdl")

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

    ply:GiveInventoryItem("food_bread",1,false)

    ply:GiveInventoryItem("rationcard_100",1,false)

    return true

end



impulse.RegisterItem(ITEM)


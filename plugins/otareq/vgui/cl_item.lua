local PANEL = {}

function PANEL:Init()
	self.model = vgui.Create("DModelPanel", self)
	self.model:SetPaintBackground(false)
	self:SetMouseInputEnabled(true)
	self:SetTall(74)
	self:SetCursor("hand")
end

function PANEL:SetUpItem(item, sellData)
	self.Item = item
	self.SellData = sellData

	local panel = self

	self.model:SetPos(0, 0)
	self.model:SetSize(74, 74)
	self.model:SetMouseInputEnabled(true)
	self.model:SetModel(item.Model)
	self.model:SetFOV(item.FOV or 35)

	function self.model:LayoutEntity(ent)
		ent:SetAngles(Angle(0, 90, 0))

		if panel.Item.Material then
			ent:SetMaterial(panel.Item.Material)
		end

		if not item.NoCenter then
			self:SetLookAt(Vector(0, 0, 0))
		end

		if item.Skin then
			ent:SetSkin(item.Skin)
		end
	end

	function self.model:DoClick()
		panel:OnMousePressed()
	end

	local camPos = self.model.Entity:GetPos()
	camPos:Add(Vector(0, 25, 25))

	local min, max = self.model.Entity:GetRenderBounds()

	if item.CamPos then
		self.model:SetCamPos(item.CamPos)
	else
		self.model:SetCamPos(camPos -  Vector(10, 0, 16))
	end

	self.model:SetLookAt((max + min) / 2)
end

local activeCol = Color(35, 35, 35, 88)
local hoverCol = Color(120, 120, 120, 88)
local disabledCol = Color(15, 15, 15, 150)
local grey = Color(170, 170, 170, 255)


function PANEL:Paint(w,h)
	local col = activeCol
	local cost = self.SellData.Cost
	local max = self.SellData.Max
	local hasItem, amount = LocalPlayer():HasInventoryItem(impulse.Inventory.ClassToNetID(self.Item.UniqueID))
	local disabled = false
	local maxed = false

	if (self.SellData.CanBuy and self.SellData.CanBuy(LocalPlayer()) == false) then
		col = disabledCol
		disabled = true
	end

	if max and hasItem and amount >= max then
		col = disabledCol
		disabled = true
		maxed = true
	end

	surface.SetDrawColor(0, 0, 0, 195)
	surface.DrawRect(0, 0, w, h)

	surface.SetDrawColor(Color(65, 105, 200))
	surface.DrawOutlinedRect(0, 0, w, h)

	if self:IsHovered() then
		if disabled then
			surface.SetDrawColor(disabledCol)
		else
			surface.SetDrawColor(hoverCol)
		end

		surface.DrawRect(0, 0, w, h)
	end

	draw.SimpleText(self.Item.Name, "budgetLabel", 80, 10, (disabled and grey) or color_white)

	local desc = ""

	if cost then
		desc = cost
	else
		desc = "Free"
	end

	if self.SellData.Desc then
		desc = desc.." ("..self.SellData.Desc..")"
	end

	draw.SimpleText(desc, "budgetLabel", 80, 30, grey)

	if max then
		draw.SimpleText((amount or 0).."/"..max.." (max limit)", "budgetLabel", 80, 45, grey)
	end

end


function PANEL:OnMousePressed(key)
	if key == MOUSE_LEFT then
		if self.SellData.CanBuy then
			net.Start("vanilla_ota_req_buy")
				net.WriteString(self.Item.UniqueID)
			net.SendToServer()
		end
	end
end

vgui.Register("vanilla_ota_req_item", PANEL, "DPanel") 
local PANEL = {}

function PANEL:Init()
	self:SetSize(610,425)
	self:MakePopup()
	self:SetTitle("<:: Combine Requisition Vendor")
	self:SetSkin("combineSkin")

	self.Scroll = self:Add("DScrollPanel")
	self.Scroll:Dock(LEFT)
	self.Scroll:SetWidth(self:GetWide() * .15)
	--self.Scroll.Paint = nil

	self.Body = self:Add("DPanel")
	self.Body:Dock(FILL)
	self.Body:DockMargin(5,0,0,0)
	self.Body.Paint = nil

	self.LabelHeader = self.Body:Add("DLabel")
	self.LabelHeader:SetText("Information")
	self.LabelHeader:SetFont("chatfont")
	self.LabelHeader:Dock(TOP)

	self.Label = self.Body:Add("DLabel")
	self.Label:SetText("Gather Your Items here")
	self.Label:SetFont("chatfont")
	self.Label:Dock(TOP)
	self.Label:SetWidth(self.Body:GetWide())
	self.Label:SetAutoStretchVertical(true)

	self:PopulateButtons()


end

function PANEL:AddButtons(data)
	self.Navigation = self.Navigation or {}
	table.insert(self.Navigation, data)

	self.NavigationPanels = self.NavigationPanels or {}
	local option = self.Scroll:Add("DButton")
	option:Dock(TOP)
	option:SetFont("BudgetLabel")
	option:DockMargin(0,0,0,50)
	option:SetTall(30)
	option:SetWidth(self.Scroll:GetWide())
	option:SetText(data.name)
	option:DockMargin(0, 0 ,0 ,0)
	option.DoClick = function()
		if not data.callback then return end
		for k, v in pairs(self.Body:GetChildren()) do
			v:Remove()
		end
		data.callback(self.body)
	end
	self.NavigationPanels[#self.NavigationPanels + 1 or 1] = option
end

function PANEL:PopulateButtons()
	local ply = LocalPlayer()

	-- unranked, return
	if ply:GetTeamRank() == nil then
		return
	end

	self:AddButtons({
		name = "Firearms",
		callback = function(body)
			self:Firearms()
		end,
	})

	self:AddButtons({
		name = "Utilities",
		callback = function(body)
			self:Utilities()
		end,
	})

	if not self.Navigation then
		return self:Remove()
	end
end

function PANEL:Firearms()
	local side = self.Body:Add("DScrollPanel")
	side:Dock(FILL)
	for k,v in pairs(impulse.Config.OTAReqCreditsBuyables) do
		if v.Category ~= "Firearms" then 
			continue 
		end
		local itemid = impulse.Inventory.ClassToNetID(k)

		if not itemid then
			print("[impulse] "..k.." is invalid!")
			continue
		end

		local item = impulse.Inventory.Items[itemid]

		if not item then
			print("[impulse] Failed to resolve ItemID "..itemid.."! (Class "..k..")!")
			continue
		end
		local vendorItem = side:Add("vanilla_ota_req_item")
		vendorItem:SetUpItem(item, v)
		vendorItem.Parent = self
		vendorItem:Dock(TOP)

	end
end

function PANEL:Utilities()
	local side = self.Body:Add("DScrollPanel")
	side:Dock(FILL)
	for k,v in pairs(impulse.Config.OTAReqCreditsBuyables) do
		if v.Category ~= "Utilities" then 
			continue 
		end
		local itemid = impulse.Inventory.ClassToNetID(k)

		if not itemid then
			print("[impulse] "..k.." is invalid!")
			continue
		end

		local item = impulse.Inventory.Items[itemid]

		if not item then
			print("[impulse] Failed to resolve ItemID "..itemid.."! (Class "..k..")!")
			continue
		end

		local vendorItem = side:Add("vanilla_ota_req_item")
		vendorItem:SetUpItem(item, v)
		vendorItem.Parent = self
		vendorItem:Dock(TOP)

	end
end
vgui.Register("vanilla_ota_req_Menu", PANEL, "DFrame")

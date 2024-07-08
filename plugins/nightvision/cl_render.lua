
local gpnightvision = {
	["$pp_colour_addr"] = 0,
	["$pp_colour_addg"] = 0,
	["$pp_colour_addb"] = 0,
	["$pp_colour_brightness"] = 0,
	["$pp_colour_contrast"] = 1,
	["$pp_colour_colour"] = 0,
	["$pp_colour_mulr"] = 0,
	["$pp_colour_mulg"] = 0,
	["$pp_colour_mulb"] = 0
}

function PLUGIN:RenderScreenspaceEffects()
	local me = LocalPlayer()


	if not me:GetSyncVar(SYNC_NVG,false) then
		impulse.noBloom = false
		return
	end
	impulse.noBloom = true
	
	DrawColorModify(gpnightvision)
	DrawSharpen(1.1, 1.2)
	DrawMaterialOverlay( "effects/nightvision", 1 )
end

local vignette = Material("impulse/vignette.png")

impulse.NVG = impulse.NVG or nil

function PLUGIN:PreRender()
	local me = LocalPlayer()
	if not me:GetSyncVar(SYNC_NVG,false) then
		if IsValid(impulse.NVG) then
			impulse.NVG:Remove()
			impulse.NVG = nil
		end
		return
	end

	render.SetGoalToneMappingScale(8)
end

function PLUGIN:PostRender()
end

function PLUGIN:PostDrawOpaqueRenderables()
	
end

function PLUGIN:HUDPaint()
end
local dofmat = Material("pp/dof")
function PLUGIN:HUDPaintBackground()
	local me = LocalPlayer()


	if not me:GetSyncVar(SYNC_NVG,false) then
		return
	end
	surface.SetMaterial(vignette)
	surface.SetDrawColor(color_black)

	for i = 1, 3 do
		surface.DrawTexturedRect(0, 0, ScrW(), ScrH())
	end
end

function PLUGIN:PreDrawViewModel(vm, ply, wep)
	if wep.IsLongsword then return end
	if wep.IsLongsword and not Longsword.Overdraw then
		
		--Longsword.OverDraw = true
		--local vm = self:GetOwner():GetViewModel()
    render.UpdateScreenEffectTexture()
    render.ClearStencil()
    render.SetStencilEnable(true)
    render.SetStencilCompareFunction(STENCIL_ALWAYS)
    render.SetStencilPassOperation(STENCIL_REPLACE)
    render.SetStencilFailOperation(STENCIL_KEEP)
    render.SetStencilZFailOperation(STENCIL_REPLACE)
    render.SetStencilWriteMask(0xFF)
    render.SetStencilTestMask(0xFF)
    render.SetBlend(1)
    render.SetStencilReferenceValue(55)
    Longsword.Overdraw = true
    vm:DrawModel()
    Longsword.Overdraw = false
    render.SetBlend(0)
    render.SetStencilPassOperation(STENCIL_REPLACE)
    render.SetStencilCompareFunction(STENCIL_EQUAL)
    -- render.SetColorMaterial()
		DrawBokehDOF(3, 0.1, 0.4)
    	render.SetStencilEnable(false)

	end
end
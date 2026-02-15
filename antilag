--[[
	WARNING: Heads up! This script has not been verified by ScriptBlox. Use at your own risk!
]]
local l=game:GetService("Lighting")
local p=game:GetService("Players")
local t=workspace:FindFirstChildOfClass("Terrain")

if not game:IsLoaded() then repeat task.wait() until game:IsLoaded() end
pcall(function()
	for _,v in pairs(l:GetChildren())do
		if v:IsA("PostEffect")or v:IsA("Atmosphere")or v:IsA("Sky")
		or v:IsA("BloomEffect")or v:IsA("BlurEffect")
		or v:IsA("SunRaysEffect")or v:IsA("ColorCorrectionEffect")then
			v:Destroy()
		end
	end
	for k,v in pairs({
		GlobalShadows=false,EnvironmentSpecularScale=0,EnvironmentDiffuseScale=0,
		Brightness=1,FogEnd=1e9,ShadowSoftness=0,ClockTime=12,
		OutdoorAmbient=Color3.new(.5,.5,.5)
	})do l[k]=v end
end)

if t then
	pcall(function()
		for k,v in pairs({
			WaterWaveSize=0,WaterWaveSpeed=0,WaterReflectance=0,
			WaterTransparency=1,Decoration=false
		})do t[k]=v end
	end)
end

local function simp(v)
	pcall(function()
		if v:IsA("BasePart")or v:IsA("MeshPart")or v:IsA("UnionOperation")then
			v.Material=Enum.Material.SmoothPlastic v.Reflectance=0
			if v:IsA("BasePart")then v.CastShadow=false end
			if v:IsA("MeshPart")then v.TextureID="" v.RenderFidelity=Enum.RenderFidelity.Performance end
		elseif v:IsA("Decal")or v:IsA("Texture")or v:IsA("SurfaceAppearance")then
			v:Destroy()
		elseif v:IsA("ParticleEmitter")or v:IsA("Trail")or v:IsA("Beam")
		or v:IsA("Smoke")or v:IsA("Fire")or v:IsA("Sparkles")or v:IsA("Light")then
			v.Enabled=false
		end
	end)
end

for _,v in pairs(workspace:GetDescendants())do simp(v)end
workspace.DescendantAdded:Connect(function(v)task.defer(simp,v)end)

local function opt(c)
	for _,v in pairs(c:GetDescendants())do
		pcall(function()
			if v:IsA("Accessory")or v:IsA("Clothing")or v:IsA("ShirtGraphic")then
				v:Destroy()
			elseif v:IsA("BasePart")then
				v.Material=Enum.Material.SmoothPlastic v.Reflectance=0
			end
		end)
	end
end

for _,pl in pairs(p:GetPlayers())do
	if pl.Character then opt(pl.Character)end
	pl.CharacterAdded:Connect(opt)
end
p.PlayerAdded:Connect(function(pl)pl.CharacterAdded:Connect(opt)end)

pcall(function()
	settings().Rendering.QualityLevel=Enum.QualityLevel.Level01
	settings().Rendering.MeshPartDetailLevel=Enum.MeshPartDetailLevel.Low
	settings().Rendering.EagerBulkExecution=false
end)


local Players=game:GetService("Players")
local ReplicatedStorage=game:GetService("ReplicatedStorage")
local UserInputService=game:GetService("UserInputService")
local RunService=game:GetService("RunService")

local LocalPlayer=Players.LocalPlayer
local Remote=ReplicatedStorage.Systems.ActionsSystem.Network.Attack
local enabled=false
local attackIndex=1


local function valid(c)return c and c:FindFirstChild("Humanoid")and c:FindFirstChild("HumanoidRootPart")and c.Humanoid.Health>0 end
local function nearest()
    local my = LocalPlayer.Character
    if not valid(my) then return end
	local pos = my.HumanoidRootPart.Position
    local best, dist = nil, 32
	for _,p in Players:GetPlayers() do
        if p ~= LocalPlayer then
            local t = p.Character
            if valid(t) then
                local d = (t.HumanoidRootPart.Position - pos).Magnitude
                if d < dist then
                    best = t
                    dist = d
                end
            end
        end
    end
	local entitiesFolder = workspace:FindFirstChild("Entities")
    if entitiesFolder then
        for _,e in pairs(entitiesFolder:GetChildren()) do
            if valid(e) then
                local d = (e.HumanoidRootPart.Position - pos).Magnitude
                if d < dist then
                    best = e
                    dist = d
                end
            end
        end
    end

    return best
end

local function hit(t)
    pcall(function()Remote:InvokeServer(t,attackIndex)end)
    attackIndex=attackIndex==1 and 2 or 1
end


local sg=Instance.new("ScreenGui",game.CoreGui)
sg.Name="killaura"
local f=Instance.new("Frame")
f.Size=UDim2.new(0,80,0,80)
f.Position=UDim2.new(0.85,0,0.7,0)
f.BackgroundColor3=Color3.fromRGB(40,40,40)
f.BorderSizePixel=0
f.Active=true
f.Draggable=true
f.Parent=sg

Instance.new("UICorner",f).CornerRadius=UDim.new(0,12)

local b=Instance.new("TextButton",f)
b.Size=UDim2.new(0.8,0,0.8,0)
b.Position=UDim2.new(0.1,0,0.1,0)
b.BackgroundColor3=Color3.fromRGB(60,60,60)
b.BorderSizePixel=0
b.Font=Enum.Font.GothamBold
b.Text="K"
b.TextColor3=Color3.fromRGB(255,255,255)
b.TextSize=28

Instance.new("UICorner",b).CornerRadius=UDim.new(0,8)
b.Activated:Connect(function()
    enabled=not enabled
    if enabled then
        conn=RunService.Heartbeat:Connect(function()
            local t=nearest()if t then hit(t)task.wait(math.random(90,170)/1000)end
        end)
    else
        if conn then conn:Disconnect()conn=nil end
    end
    b.BackgroundColor3=enabled and Color3.fromRGB(100,200,100) or Color3.fromRGB(200,60,60)
end)

local conn
UserInputService.InputBegan:Connect(function(i)
    if i.KeyCode==Enum.KeyCode.K then
        enabled=not enabled
        if enabled then
            conn=RunService.Heartbeat:Connect(function()
                local t=nearest()if t then hit(t)task.wait(math.random(90,170)/1000)end
            end)
        else
            if conn then conn:Disconnect()conn=nil end
        end
        if b then
            b.BackgroundColor3=enabled and Color3.fromRGB(100,200,100) or Color3.fromRGB(200,60,60)
        end
    end
end)


b.BackgroundColor3=Color3.fromRGB(200,60,60)

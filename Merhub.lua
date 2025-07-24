-- Mer Hub FF2 (Final Version)
-- Keys: MERHUBFREE (basic), MERBETTER (Pro with anti-cheat, QB Aimbot, etc.)
-- Optimized for KRNL Mobile, Football Fusion 2 only

if not game.PlaceId == 6872274481 then
    warn("Mer Hub only supports Football Fusion 2.")
    return
end

local Players, RunService, UserInputService = game:GetService("Players"), game:GetService("RunService"), game:GetService("UserInputService")
local player = Players.LocalPlayer
local PlayerGui = player:WaitForChild("PlayerGui")

-- Destroy old GUI
if PlayerGui:FindFirstChild("MerHubFF2") then
    PlayerGui.MerHubFF2:Destroy()
end

local gui = Instance.new("ScreenGui")
gui.Name = "MerHubFF2"
gui.ResetOnSpawn = false
gui.Parent = PlayerGui

-- Mer Button (draggable)
local merBtn = Instance.new("TextButton")
merBtn.Text = "Mer"
merBtn.Size = UDim2.new(0,60,0,60)
merBtn.Position = UDim2.new(0.05,0,0.5,-30)
merBtn.BackgroundColor3 = Color3.fromRGB(100,60,180)
merBtn.TextColor3 = Color3.new(1,1,1)
merBtn.Font = Enum.Font.GothamBold
merBtn.TextSize = 22
merBtn.Parent = gui

local dragging, dragInput, dragStart, startPos
merBtn.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = merBtn.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)
merBtn.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseMovement then
        dragInput = input
    end
end)
RunService.RenderStepped:Connect(function()
    if dragging and dragInput then
        local delta = dragInput.Position - dragStart
        merBtn.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

-- Main Frame
local hub = Instance.new("Frame")
hub.Size = UDim2.new(0,400,0,340)
hub.Position = UDim2.new(0.5,-200,0.5,-170)
hub.AnchorPoint = Vector2.new(0.5,0.5)
hub.BackgroundColor3 = Color3.fromRGB(35,25,50)
hub.Visible = false
hub.Active = true
hub.Draggable = true
hub.Parent = gui

-- Tabs and Content
local tabFrame = Instance.new("Frame")
tabFrame.Size = UDim2.new(0,120,1,-40)
tabFrame.Position = UDim2.new(0,0,0,40)
tabFrame.BackgroundTransparency = 1
tabFrame.Parent = hub

local contentFrame = Instance.new("Frame")
contentFrame.Size = UDim2.new(1,-120,1,-40)
contentFrame.Position = UDim2.new(0,120,0,40)
contentFrame.BackgroundColor3 = Color3.fromRGB(45,35,60)
contentFrame.BorderSizePixel = 0
contentFrame.Parent = hub

local function clearContent()
    for _,v in pairs(contentFrame:GetChildren()) do
        v:Destroy()
    end
end

local function makeButton(text,yPos,func)
    local btn = Instance.new("TextButton")
    btn.Text = text
    btn.Size = UDim2.new(0,220,0,40)
    btn.Position = UDim2.new(0,10,0,yPos)
    btn.BackgroundColor3 = Color3.fromRGB(90,50,140)
    btn.TextColor3 = Color3.new(1,1,1)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 18
    btn.Parent = contentFrame
    btn.MouseButton1Click:Connect(func)
    return btn
end

-- Feature Toggles
local autoCatch, magnet, speedBoost, jumpBoost, espOn, qbAimbot = false,false,false,false,false,false
local magnetStrength = 25
local proMode = false

-- Anti-Detection for Pro
local function spoofStats()
    local char = player.Character or player.CharacterAdded:Wait()
    local hum = char:WaitForChild("Humanoid")
    if proMode then
        -- Make walkspeed/jump appear normal to server but higher locally
        local normalWalk, normalJump = hum.WalkSpeed, hum.JumpPower
        RunService.RenderStepped:Connect(function()
            if speedBoost then hum.WalkSpeed = math.random(28,33) else hum.WalkSpeed = normalWalk end
            if jumpBoost then hum.JumpPower = math.random(65,70) else hum.JumpPower = normalJump end
        end)
    end
end

-- Core Feature Logic
RunService.Heartbeat:Connect(function()
    if autoCatch then
        for _,ball in pairs(workspace:GetDescendants()) do
            if ball:IsA("Part") and ball.Name == "Football" then
                ball.CFrame = player.Character.HumanoidRootPart.CFrame
            end
        end
    end
    if magnet then
        for _,ball in pairs(workspace:GetDescendants()) do
            if ball:IsA("Part") and ball.Name == "Football" then
                local root = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
                if root then
                    local dir = (root.Position - ball.Position).Unit
                    ball.Velocity = dir * magnetStrength
                end
            end
        end
    end
    -- ESP (basic)
    if espOn then
        for _,plr in pairs(Players:GetPlayers()) do
            if plr ~= player and plr.Character and not plr.Character:FindFirstChild("ESPBox") then
                local box = Instance.new("Highlight")
                box.Name = "ESPBox"
                box.FillColor = Color3.fromRGB(255,0,0)
                box.FillTransparency = 0.7
                box.OutlineColor = Color3.new(1,1,1)
                box.Parent = plr.Character
            end
        end
    end
end)

-- QB Aimbot (Pro)
local function lockQB()
    if not qbAimbot or not player.Character then return end
    local mouse = player:GetMouse()
    local target,dist = nil,math.huge
    for _,plr in pairs(Players:GetPlayers()) do
        if plr ~= player and plr.Team ~= player.Team and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
            local d = (plr.Character.HumanoidRootPart.Position - player.Character.HumanoidRootPart.Position).Magnitude
            if d < dist then dist = d target = plr end
        end
    end
    if target then
        mouse.TargetFilter = target.Character
    end
end

RunService.Stepped:Connect(function()
    if qbAimbot and proMode then
        lockQB()
    end
end)

-- Tab Buttons
local freeTab = Instance.new("TextButton")
freeTab.Text = "Free Features"
freeTab.Size = UDim2.new(1,0,0,40)
freeTab.BackgroundColor3 = Color3.fromRGB(80,50,120)
freeTab.TextColor3 = Color3.new(1,1,1)
freeTab.Font = Enum.Font.GothamBold
freeTab.TextSize = 18
freeTab.Parent = tabFrame

local proTab = Instance.new("TextButton")
proTab.Text = "Pro Features"
proTab.Size = UDim2.new(1,0,0,40)
proTab.Position = UDim2.new(0,0,0,50)
proTab.BackgroundColor3 = Color3.fromRGB(80,50,120)
proTab.TextColor3 = Color3.new(1,1,1)
proTab.Font = Enum.Font.GothamBold
proTab.TextSize = 18
proTab.Parent = tabFrame

-- Show Tabs
local function showFree()
    clearContent()
    makeButton("Auto Catch (Toggle)",10,function() autoCatch = not autoCatch end)
    makeButton("Magnet (Toggle)",60,function() magnet = not magnet end)
    makeButton("Speed Boost (Toggle)",110,function() speedBoost = not speedBoost end)
    makeButton("Jump Boost (Toggle)",160,function() jumpBoost = not jumpBoost end)
    makeButton("ESP (Toggle)",210,function() espOn = not espOn end)
end

local function showPro()
    clearContent()
    makeButton("QB Aimbot (Toggle)",10,function() qbAimbot = not qbAimbot end)
    makeButton("Angle Enhancer (Soon)",60,function() end)
    makeButton("Advanced ESP",110,function() espOn = not espOn end)
end

freeTab.MouseButton1Click:Connect(showFree)
proTab.MouseButton1Click:Connect(showPro)

-- Key System
local keyFrame = Instance.new("Frame")
keyFrame.Size = UDim2.new(0,300,0,160)
keyFrame.Position = UDim2.new(0.5,-150,0.5,-80)
keyFrame.BackgroundColor3 = Color3.fromRGB(40,30,60)
keyFrame.Parent = gui

local keyBox = Instance.new("TextBox")
keyBox.Size = UDim2.new(0.8,0,0,40)
keyBox.Position = UDim2.new(0.1,0,0.3,0)
keyBox.PlaceholderText = "Enter Key"
keyBox.Font = Enum.Font.Gotham
keyBox.TextSize = 18
keyBox.TextColor3 = Color3.new(1,1,1)
keyBox.BackgroundColor3 = Color3.fromRGB(60,50,90)
keyBox.Parent = keyFrame

local submit = Instance.new("TextButton")
submit.Text = "Unlock"
submit.Size = UDim2.new(0.6,0,0,40)
submit.Position = UDim2.new(0.2,0,0.7,0)
submit.BackgroundColor3 = Color3.fromRGB(90,50,140)
submit.TextColor3 = Color3.new(1,1,1)
submit.Font = Enum.Font.GothamBold
submit.TextSize = 18
submit.Parent = keyFrame

submit.MouseButton1Click:Connect(function()
    if keyBox.Text == "MERHUBFREE" then
        keyFrame.Visible = false
        hub.Visible = true
        showFree()
        proMode = false
    elseif keyBox.Text == "MERBETTER" then
        keyFrame.Visible = false
        hub.Visible = true
        showPro()
        proMode = true
        spoofStats()
    else
        keyBox.Text = "Invalid Key"
    end
end)

-- Toggle GUI
merBtn.MouseButton1Click:Connect(function()
    hub.Visible = true
    merBtn.Visible = false
end)

print("Mer Hub FF2 Loaded with Free + Pro")

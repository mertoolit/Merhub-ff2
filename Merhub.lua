-- Mer Hub FF2 Free Version by Mer Beauvoir
-- Key: MERHUBFREE
-- Auto-updater included

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local HttpService = game:GetService("HttpService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local repoRaw = "https://raw.githubusercontent.com/mertoolit/Merhub-ff2/main/MerhubFF2-Free.lua"

-- Auto update function
local function autoUpdate()
    local success, newCode = pcall(function()
        return game:HttpGet(repoRaw)
    end)
    if success and newCode and newCode ~= script.Source then
        loadstring(newCode)()
        return true
    end
    return false
end

if autoUpdate() then return end

-- Key system
local KEY = "MERHUBFREE"

-- Clear old gui
local oldGui = playerGui:FindFirstChild("MerHub")
if oldGui then oldGui:Destroy() end

-- Create ScreenGui
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "MerHub"
ScreenGui.Parent = playerGui
ScreenGui.ResetOnSpawn = false

-- Floating draggable Mer button
local MerButton = Instance.new("TextButton")
MerButton.Size = UDim2.new(0, 60, 0, 60)
MerButton.Position = UDim2.new(0.05, 0, 0.5, -30)
MerButton.BackgroundColor3 = Color3.fromRGB(100, 40, 160)
MerButton.TextColor3 = Color3.new(1, 1, 1)
MerButton.Font = Enum.Font.GothamBold
MerButton.TextSize = 20
MerButton.Text = "Mer"
MerButton.BorderSizePixel = 0
MerButton.Parent = ScreenGui
MerButton.ZIndex = 50
MerButton.Visible = false

-- Draggable code
local dragging, dragInput, dragStart, startPos
MerButton.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
		dragging = true
		dragStart = input.Position
		startPos = MerButton.Position
		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then
				dragging = false
			end
		end)
	end
end)
MerButton.InputChanged:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseMovement then
		dragInput = input
	end
end)
RunService.RenderStepped:Connect(function()
	if dragging and dragInput then
		local delta = dragInput.Position - dragStart
		MerButton.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X,
			startPos.Y.Scale, startPos.Y.Offset + delta.Y)
	end
end)

-- Main Hub frame
local HubFrame = Instance.new("Frame")
HubFrame.Size = UDim2.new(0, 300, 0, 350)
HubFrame.Position = UDim2.new(0.5, -150, 0.5, -175)
HubFrame.BackgroundColor3 = Color3.fromRGB(30, 20, 40)
HubFrame.AnchorPoint = Vector2.new(0.5, 0.5)
HubFrame.BorderSizePixel = 0
HubFrame.Visible = false
HubFrame.Parent = ScreenGui
HubFrame.Active = true
HubFrame.Draggable = true

-- Title bar
local TitleBar = Instance.new("Frame", HubFrame)
TitleBar.Size = UDim2.new(1, 0, 0, 40)
TitleBar.BackgroundColor3 = Color3.fromRGB(50, 30, 70)

local Title = Instance.new("TextLabel", TitleBar)
Title.Text = "Mer Hub - FF2 (Free)"
Title.Size = UDim2.new(1, -40, 1, 0)
Title.Position = UDim2.new(0, 10, 0, 0)
Title.BackgroundTransparency = 1
Title.TextColor3 = Color3.fromRGB(220, 220, 255)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 18
Title.TextXAlignment = Enum.TextXAlignment.Left

local Close = Instance.new("TextButton", TitleBar)
Close.Text = "X"
Close.Size = UDim2.new(0, 40, 1, 0)
Close.Position = UDim2.new(1, -40, 0, 0)
Close.BackgroundColor3 = Color3.fromRGB(120, 40, 70)
Close.TextColor3 = Color3.new(1, 1, 1)
Close.Font = Enum.Font.GothamBold
Close.TextSize = 18
Close.MouseButton1Click:Connect(function()
    HubFrame.Visible = false
    MerButton.Visible = true
end)

-- Tabs container
local TabsFrame = Instance.new("Frame", HubFrame)
TabsFrame.Size = UDim2.new(1, 0, 1, -40)
TabsFrame.Position = UDim2.new(0, 0, 0, 40)
TabsFrame.BackgroundColor3 = Color3.fromRGB(25, 15, 40)

-- Tab buttons container
local TabButtonsFrame = Instance.new("Frame", TabsFrame)
TabButtonsFrame.Size = UDim2.new(1, 0, 0, 40)
TabButtonsFrame.BackgroundTransparency = 1
TabButtonsFrame.Position = UDim2.new(0, 0, 0, 0)

-- Helper function to create tab button
local function createTabButton(name, posX)
	local btn = Instance.new("TextButton", TabButtonsFrame)
	btn.Size = UDim2.new(0, 100, 1, 0)
	btn.Position = UDim2.new(0, posX, 0, 0)
	btn.BackgroundColor3 = Color3.fromRGB(80, 50, 110)
	btn.Text = name
	btn.TextColor3 = Color3.new(1, 1, 1)
	btn.Font = Enum.Font.GothamBold
	btn.TextSize = 18
	return btn
end

-- Create tabs
local tabs = {}
local currentTab

-- Catching Tab
local CatchingTab = Instance.new("Frame", TabsFrame)
CatchingTab.Size = UDim2.new(1, 0, 1, -40)
CatchingTab.Position = UDim2.new(0, 0, 0, 40)
CatchingTab.BackgroundTransparency = 1
CatchingTab.Visible = false
tabs["Catching"] = CatchingTab

local autoCatch = false
local autoCatchConn

local autoCatchBtn = Instance.new("TextButton", CatchingTab)
autoCatchBtn.Size = UDim2.new(0, 260, 0, 40)
autoCatchBtn.Position = UDim2.new(0.5, -130, 0, 20)
autoCatchBtn.BackgroundColor3 = Color3.fromRGB(80, 50, 110)
autoCatchBtn.TextColor3 = Color3.new(1, 1, 1)
autoCatchBtn.Font = Enum.Font.GothamBold
autoCatchBtn.TextSize = 18
autoCatchBtn.Text = "Auto Catch (OFF)"

local function catchLoop()
    local ball = workspace:FindFirstChild("Ball") or workspace:FindFirstChild("ball")
    if ball and ball:IsA("BasePart") and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        ball.CFrame = player.Character.HumanoidRootPart.CFrame
    end
end

autoCatchBtn.MouseButton1Click:Connect(function()
    autoCatch = not autoCatch
    autoCatchBtn.Text = "Auto Catch (" .. (autoCatch and "ON" or "OFF") .. ")"
    if autoCatch then
        autoCatchConn = RunService.Heartbeat:Connect(catchLoop)
    else
        if autoCatchConn then
            autoCatchConn:Disconnect()
            autoCatchConn = nil
        end
    end
end)

-- Visuals Tab
local VisualsTab = Instance.new("Frame", TabsFrame)
VisualsTab.Size = UDim2.new(1, 0, 1, -40)
VisualsTab.Position = UDim2.new(0, 0, 0, 40)
VisualsTab.BackgroundTransparency = 1
VisualsTab.Visible = false
tabs["Visuals"] = VisualsTab

local esp = false
local espBoxes = {}
local espConn

local function clearEsp()
    for _, box in pairs(espBoxes) do
        if box and box.Parent then
            box:Destroy()
        end
    end
    espBoxes = {}
end

local function espLoop()
    clearEsp()
    for _, plr in ipairs(Players:GetPlayers()) do
        if plr ~= player and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
            local box = Instance.new("BoxHandleAdornment")
            box.Adornee = plr.Character.HumanoidRootPart
            box.Size = plr.Character.HumanoidRootPart.Size + Vector3.new(0.5, 0.5, 0.5)
            box.Color3 = Color3.fromRGB(255, 0, 0)
            box.Transparency = 0.5
            box.AlwaysOnTop = true
            box.ZIndex = 10
            box.Parent = plr.Character.HumanoidRootPart
            table.insert(espBoxes, box)
        end
    end
    local ball = workspace:FindFirstChild("Ball") or workspace:FindFirstChild("ball")
    if ball and ball:IsA("BasePart") then
        local box = Instance.new("BoxHandleAdornment")
        box.Adornee = ball
        box.Size = ball.Size + Vector3.new(0.5, 0.5, 0.5)
        box.Color3 = Color3.fromRGB(0, 255, 255)
        box.Transparency = 0.5
        box.AlwaysOnTop = true
        box.ZIndex = 10
        box.Parent = ball
        table.insert(espBoxes, box)
    end
end

local espBtn = Instance.new("TextButton", VisualsTab)
espBtn.Size = UDim2.new(0, 260, 0, 40)
espBtn.Position = UDim2.new(0.5, -130, 0, 20)
espBtn.BackgroundColor3 = Color3.fromRGB(80, 50, 110)
espBtn.TextColor3 = Color3.new(1, 1, 1)
espBtn.Font = Enum.Font.GothamBold
espBtn.TextSize = 18
espBtn.Text = "ESP (OFF)"

espBtn.MouseButton1Click:Connect(function()
    esp = not esp
    espBtn.Text = "ESP (" .. (esp and "ON" or "OFF") .. ")"
    if esp then
        espConn = RunService.RenderStepped:Connect(espLoop)
    else
        if espConn then
            espConn:Disconnect()
            espConn = nil
        end
        clearEsp()
    end
end)

-- Settings Tab
local SettingsTab = Instance.new("Frame", TabsFrame)
SettingsTab.Size = UDim2.new(1, 0, 1, -40)
SettingsTab.Position = UDim2.new(0, 0, 0, 40)
SettingsTab.BackgroundTransparency = 1
SettingsTab.Visible = false
tabs["Settings"] = SettingsTab

local noJump = false
local jumpConn

local noJumpBtn = Instance.new("TextButton", SettingsTab)
noJumpBtn.Size = UDim2.new(0, 260, 0, 40)
noJumpBtn.Position = UDim2.new(0.5, -130, 0, 20)
noJumpBtn.BackgroundColor3 = Color3.fromRGB(80, 50, 110)
noJumpBtn.TextColor3 = Color3.new(1, 1, 1)
noJumpBtn.Font = Enum.Font.GothamBold
noJumpBtn.TextSize = 18
noJumpBtn.Text = "No High Jump (OFF)"

local function jumpLoop()
    if player.Character then
        local h = player.Character:FindFirstChild("Humanoid")
        if h then
            h.JumpPower = 50
        end
    end
end

noJumpBtn.MouseButton1Click:Connect(function()
    noJump = not noJump
    noJumpBtn.Text = "No High Jump (" .. (noJump and "ON" or "OFF") .. ")"
    if noJump then
        jumpConn = RunService.Heartbeat:Connect(jumpLoop)
    else
        if jumpConn then
            jumpConn:Disconnect()
            jumpConn = nil
        end
        if player.Character then
            local h = player.Character:FindFirstChild("Humanoid")
            if h then
                h.JumpPower = 100
            end
        end
    end
end)

-- Tab buttons setup
local tabNames = {"Catching", "Visuals", "Settings"}
for i, name in ipairs(tabNames) do
    local btn = createTabButton(name, (i - 1) * 100)
    btn.MouseButton1Click:Connect(function()
        for _, tab in pairs(tabs) do tab.Visible = false end
        tabs[name].Visible = true
        for _, b in pairs(TabButtonsFrame:GetChildren()) do
            if b:IsA("TextButton") then
                b.BackgroundColor3 = Color3.fromRGB(80, 50, 110)
            end
        end
        btn.BackgroundColor3 = Color3.fromRGB(120, 60, 160)
    end)
    if i == 1 then
        btn.BackgroundColor3 = Color3.fromRGB(120, 60, 160)
        tabs[name].Visible = true
        currentTab = tabs[name]
    end
end

-- Key Frame
local KeyFrame = Instance.new("Frame", ScreenGui)
KeyFrame.Size = UDim2.new(0, 300, 0, 150)
KeyFrame.Position = UDim2.new(0.5, -150, 0.5, -75)
KeyFrame.BackgroundColor3 = Color3.fromRGB(30, 20, 40)
KeyFrame.AnchorPoint = Vector2.new(0.5, 0.5)
KeyFrame.BorderSizePixel = 0
KeyFrame.Visible = true

local KeyLabel = Instance.new("TextLabel", KeyFrame)
KeyLabel.Text = "Enter Key:"
KeyLabel.Size = UDim2.new(1, 0, 0, 30)
KeyLabel.Position = UDim2.new(0, 0, 0, 10)
KeyLabel.BackgroundTransparency = 1
KeyLabel.TextColor3 = Color3.fromRGB(200, 200, 255)
KeyLabel.Font = Enum.Font.GothamBold
KeyLabel.TextSize = 20

local KeyBox = Instance.new("TextBox", KeyFrame)
KeyBox.Size = UDim2.new(0.8, 0, 0, 35)
KeyBox.Position = UDim2.new(0.1, 0, 0, 50)
KeyBox.PlaceholderText = "Enter Key"
KeyBox.Text = ""
KeyBox.ClearTextOnFocus = false

local Submit = Instance.new("TextButton", KeyFrame)
Submit.Text = "Submit"
Submit.Size = UDim2.new(0.4, 0, 0, 35)
Submit.Position = UDim2.new(0.3, 0, 0, 95)
Submit.BackgroundColor3 = Color3.fromRGB(0, 120, 255)
Submit.TextColor3 = Color3.new(1, 1, 1)
Submit.Font = Enum.Font.GothamBold
Submit.TextSize = 18

local Info = Instance.new("TextLabel", KeyFrame)
Info.Size = UDim2.new(1, 0, 0, 20)
Info.Position = UDim2.new(0, 0, 0, 135)
Info.BackgroundTransparency = 1
Info.TextColor3 = Color3.fromRGB(255, 100, 100)
Info.Font = Enum.Font.Gotham
Info.TextSize = 14
Info.Text = ""

Submit.MouseButton1Click:Connect(function()
	if KeyBox.Text == KEY then
		Info.TextColor3 = Color3.fromRGB(0, 255, 0)
		Info.Text = "Key Accepted!"
		task.delay(1, function()
			KeyFrame.Visible = false
			MerButton.Visible = true
		end)
	else
		Info.TextColor3 = Color3.fromRGB(255, 100, 100)
		Info.Text = "Hint: Starts with 'MER' ends with 'FREE'"
	end
end)

-- Show Mer button when key is accepted or after first use
MerButton.Visible = false
MerButton.MouseButton1Click:Connect(function()
    HubFrame.Visible = true
    MerButton.Visible = false
end)

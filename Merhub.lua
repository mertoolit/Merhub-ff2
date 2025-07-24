-- Mer Hub Football Fusion 2 GUI Script
-- Features: Auto Catch, Speed Boost, Magnet Adjust, ESP, Color Customization, Key System
-- Designed for KRNL and mobile executors

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

local plr = Players.LocalPlayer
local mouse = plr:GetMouse()

-- Key system (example)
local KEY = "merhub2025" -- simple key for demonstration
local enteredKey = nil
local keyValid = false

-- GUI setup
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "MerHubGUI"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = plr:WaitForChild("PlayerGui")

-- Main frame
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 420, 0, 320)
MainFrame.Position = UDim2.new(0.5, -210, 0.5, -160)
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
MainFrame.BorderSizePixel = 0
MainFrame.Parent = ScreenGui

-- Title
local Title = Instance.new("TextLabel")
Title.Text = "Mer Hub - Football Fusion 2"
Title.Size = UDim2.new(1, 0, 0, 30)
Title.BackgroundTransparency = 1
Title.TextColor3 = Color3.new(1, 1, 1)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 22
Title.Parent = MainFrame

-- Close button
local CloseBtn = Instance.new("TextButton")
CloseBtn.Text = "X"
CloseBtn.Size = UDim2.new(0, 30, 0, 30)
CloseBtn.Position = UDim2.new(1, -30, 0, 0)
CloseBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
CloseBtn.TextColor3 = Color3.new(1, 1, 1)
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.TextSize = 20
CloseBtn.Parent = MainFrame

CloseBtn.MouseButton1Click:Connect(function()
    ScreenGui.Enabled = false
end)

-- Tabs container
local TabsFrame = Instance.new("Frame")
TabsFrame.Size = UDim2.new(1, 0, 1, -30)
TabsFrame.Position = UDim2.new(0, 0, 0, 30)
TabsFrame.BackgroundTransparency = 1
TabsFrame.Parent = MainFrame

-- Create tab buttons (Auto, ESP, Settings)
local TabButtons = Instance.new("Frame")
TabButtons.Size = UDim2.new(1, 0, 0, 30)
TabButtons.BackgroundTransparency = 1
TabButtons.Parent = MainFrame
TabButtons.Position = UDim2.new(0, 0, 0, 30)

local tabs = {"Auto", "ESP", "Settings"}
local tabButtonsList = {}
local tabFrames = {}

for i, tabName in ipairs(tabs) do
    local btn = Instance.new("TextButton")
    btn.Text = tabName
    btn.Size = UDim2.new(1 / #tabs, 0, 1, 0)
    btn.Position = UDim2.new((i - 1) / #tabs, 0, 0, 0)
    btn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    btn.TextColor3 = Color3.new(1, 1, 1)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 18
    btn.Parent = TabButtons
    table.insert(tabButtonsList, btn)

    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, 0, 1, -30)
    frame.Position = UDim2.new(0, 0, 0, 30)
    frame.BackgroundTransparency = 1
    frame.Visible = false
    frame.Parent = MainFrame
    tabFrames[tabName] = frame

    btn.MouseButton1Click:Connect(function()
        for _, f in pairs(tabFrames) do
            f.Visible = false
        end
        for _, b in pairs(tabButtonsList) do
            b.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
        end
        frame.Visible = true
        btn.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
    end)
end

-- Activate first tab by default
tabButtonsList[1].BackgroundColor3 = Color3.fromRGB(100, 100, 100)
tabFrames["Auto"].Visible = true

-- Utility function to create toggle buttons
local function createToggle(parent, text, default, callback)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, -10, 0, 30)
    frame.BackgroundTransparency = 1
    frame.Parent = parent

    local label = Instance.new("TextLabel")
    label.Text = text
    label.Size = UDim2.new(0.7, 0, 1, 0)
    label.BackgroundTransparency = 1
    label.TextColor3 = Color3.new(1, 1, 1)
    label.Font = Enum.Font.Gotham
    label.TextSize = 18
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = frame

    local toggle = Instance.new("TextButton")
    toggle.Text = default and "ON" or "OFF"
    toggle.Size = UDim2.new(0.3, -5, 1, 0)
    toggle.Position = UDim2.new(0.7, 5, 0, 0)
    toggle.BackgroundColor3 = default and Color3.fromRGB(50, 200, 50) or Color3.fromRGB(200, 50, 50)
    toggle.TextColor3 = Color3.new(1, 1, 1)
    toggle.Font = Enum.Font.GothamBold
    toggle.TextSize = 16
    toggle.Parent = frame

    toggle.MouseButton1Click:Connect(function()
        default = not default
        toggle.Text = default and "ON" or "OFF"
        toggle.BackgroundColor3 = default and Color3.fromRGB(50, 200, 50) or Color3.fromRGB(200, 50, 50)
        callback(default)
    end)

    return frame
end

-- Auto Tab Features

local autoTab = tabFrames["Auto"]

local autoCatchEnabled = false
local speedBoostEnabled = false
local speedBoostValue = 25
local magnetStrengthValue = 100

local function autoCatch()
    if not autoCatchEnabled then return end
    local ball = workspace:FindFirstChild("Football") or workspace:FindFirstChild("Ball")
    if ball and ball:IsA("BasePart") then
        ball.CFrame = plr.Character.HumanoidRootPart.CFrame * CFrame.new(0, 2, 0)
    end
end

-- Auto Catch Toggle
createToggle(autoTab, "Auto Catch", false, function(state)
    autoCatchEnabled = state
end)

-- Speed Boost Toggle
createToggle(autoTab, "Speed Boost", false, function(state)
    speedBoostEnabled = state
    if speedBoostEnabled then
        plr.Character.Humanoid.WalkSpeed = speedBoostValue
    else
        plr.Character.Humanoid.WalkSpeed = 16 -- default speed
    end
end)

-- Speed Slider
local speedSliderLabel = Instance.new("TextLabel")
speedSliderLabel.Text = "Speed Value"
speedSliderLabel.Size = UDim2.new(1, 0, 0, 20)
speedSliderLabel.Position = UDim2.new(0, 0, 0, 70)
speedSliderLabel.BackgroundTransparency = 1
speedSliderLabel.TextColor3 = Color3.new(1, 1, 1)
speedSliderLabel.Font = Enum.Font.Gotham
speedSliderLabel.TextSize = 16
speedSliderLabel.Parent = autoTab

local speedSlider = Instance.new("TextBox")
speedSlider.Text = tostring(speedBoostValue)
speedSlider.Size = UDim2.new(1, 0, 0, 30)
speedSlider.Position = UDim2.new(0, 0, 0, 90)
speedSlider.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
speedSlider.TextColor3 = Color3.new(1, 1, 1)
speedSlider.Font = Enum.Font.Gotham
speedSlider.TextSize = 18
speedSlider.ClearTextOnFocus = false
speedSlider.Parent = autoTab

speedSlider.FocusLost:Connect(function(enterPressed)
    local val = tonumber(speedSlider.Text)
    if val and val >= 16 and val <= 150 then
        speedBoostValue = val
        if speedBoostEnabled then
            plr.Character.Humanoid.WalkSpeed = speedBoostValue
        end
    else
        speedSlider.Text = tostring(speedBoostValue)
    end
end)

-- Magnet Strength Slider
local magnetSliderLabel = Instance.new("TextLabel")
magnetSliderLabel.Text = "Magnet Strength"
magnetSliderLabel.Size = UDim2.new(1, 0, 0, 20)
magnetSliderLabel.Position = UDim2.new(0, 0, 0, 130)
magnetSliderLabel.BackgroundTransparency = 1
magnetSliderLabel.TextColor3 = Color3.new(1, 1, 1)
magnetSliderLabel.Font = Enum.Font.Gotham
magnetSliderLabel.TextSize = 16
magnetSliderLabel.Parent = autoTab

local magnetSlider = Instance.new("TextBox")
magnetSlider.Text = tostring(magnetStrengthValue)
magnetSlider.Size = UDim2.new(1, 0, 0, 30)
magnetSlider.Position = UDim2.new(0, 0, 0, 150)
magnetSlider.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
magnetSlider.TextColor3 = Color3.new(1, 1, 1)
magnetSlider.Font = Enum.Font.Gotham
magnetSlider.TextSize = 18
magnetSlider.ClearTextOnFocus = false
magnetSlider.Parent = autoTab

magnetSlider.FocusLost:Connect(function(enterPressed)
    local val = tonumber(magnetSlider.Text)
    if val and val >= 50 and val <= 1000 then
        magnetStrengthValue = val
    else
        magnetSlider.Text = tostring(magnetStrengthValue)
    end
end)

-- Run auto catch loop
RunService.Heartbeat:Connect(function()
    if autoCatchEnabled and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
        autoCatch()
    end
end)

-- ESP Tab Features

local espTab = tabFrames["ESP"]

local espEnabled = false
local espObjects = {}

local function createESP(part)
    local box = Instance.new("BoxHandleAdornment")
    box.Adornee = part
    box.Size = part.Size + Vector3.new(0.1, 0.1, 0.1)
    box.Color3 = Color3.fromRGB(255, 0, 0)
    box.AlwaysOnTop = true
    box.ZIndex = 10
    box.Transparency = 0.5
    box.Parent = part
    return box
end

local function removeESP()
    for _, box in pairs(espObjects) do
        if box and box.Parent then
            box:Destroy()
        end
    end
    espObjects = {}
end

createToggle(espTab, "ESP Enable", false, function(state)
    espEnabled = state
    if espEnabled then
        for _, p in pairs(workspace:GetChildren()) do
            if p:IsA("BasePart") and p.Name == "Football" then
                local espBox = createESP(p)
                table.insert(espObjects, espBox)
            end
        end
    else
        removeESP()
    end
end)

-- Settings Tab (Color theme example)
local settingsTab = tabFrames["Settings"]

local function createColorPicker(parent, labelText, defaultColor, callback)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, -10, 0, 40)
    frame.BackgroundTransparency = 1
    frame.Parent = parent

    local label = Instance.new("TextLabel")
    label.Text = labelText
    label.Size = UDim2.new(0.4, 0, 1, 0)
    label.BackgroundTransparency = 1
    label.TextColor3 = Color3.new(1, 1, 1)
    label.Font = Enum.Font.Gotham
    label.TextSize = 16
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = frame

    local colorBox = Instance.new("Frame")
    colorBox.Size = UDim2.new(0.4, 0, 1, 0)
    colorBox.Position = UDim2.new(0.5, 0, 0, 0)
    colorBox.BackgroundColor3 = defaultColor
    colorBox.BorderSizePixel = 1
    colorBox.Parent = frame

    colorBox.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            -- For simplicity, cycle colors on click
            local newColor = Color3.new(math.random(), math.random(), math.random())
            colorBox.BackgroundColor3 = newColor
            callback(newColor)
        end
    end)

    return frame
end

createColorPicker(settingsTab, "Theme Color", Color3.fromRGB(100, 100, 100), function(newColor)
    MainFrame.BackgroundColor3 = newColor
end)

-- Simple Key Entry Prompt
local keyFrame = Instance.new("Frame")
keyFrame.Size = UDim2.new(0, 300, 0, 120)
keyFrame.Position = UDim2.new(0.5, -150, 0.5, -60)
keyFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
keyFrame.BorderSizePixel = 0
keyFrame.Parent = ScreenGui

local keyLabel = Instance.new("TextLabel")
keyLabel.Text = "Enter Mer Hub Key:"
keyLabel.Size = UDim2.new(1, 0, 0, 30)
keyLabel.BackgroundTransparency = 1
keyLabel.TextColor3 = Color3.new(1, 1, 1)
keyLabel.Font = Enum.Font.GothamBold
keyLabel.TextSize = 20
keyLabel.Parent = keyFrame

local keyBox = Instance.new("TextBox")
keyBox.PlaceholderText = "Type your key here"
keyBox.Size = UDim2.new(1, -20, 0, 40)
keyBox.Position = UDim2.new(0, 10, 0, 40)
keyBox.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
keyBox.TextColor3 = Color3.new(1, 1, 1)
keyBox.Font = Enum.Font.Gotham
keyBox.TextSize = 20
keyBox.ClearTextOnFocus = false
keyBox.Parent = keyFrame

local submitBtn = Instance.new("TextButton")
submitBtn.Text = "Submit"
submitBtn.Size = UDim2.new(0, 100, 0, 30)
submitBtn.Position = UDim2.new(0.5, -50, 1, -40)
submitBtn.BackgroundColor3 = Color3.fromRGB(50, 150, 50)
submitBtn.TextColor3 = Color3.new(1, 1, 1)
submitBtn.Font = Enum.Font.GothamBold
submitBtn.TextSize = 18
submitBtn.Parent = keyFrame

submitBtn.MouseButton1Click:Connect(function()
    if keyBox.Text == KEY then
        keyValid = true
        keyFrame:Destroy()
        ScreenGui.Enabled = true
    else
        keyLabel.Text = "Invalid Key! Try Again."
        keyBox.Text = ""
    end
end)

-- Hide main GUI until key is entered
ScreenGui.Enabled = false

-- Safety for WalkSpeed reset when speed boost off or player dies
plr.CharacterAdded:Connect(function(char)
    local humanoid = char:WaitForChild("Humanoid")
    humanoid.WalkSpeed = 16
end)

-- Run speed boost update on Heartbeat
RunService.Heartbeat:Connect(function()
    if speedBoostEnabled and plr.Character and plr.Character:FindFirstChild("Humanoid") then
        plr.Character.Humanoid.WalkSpeed = speedBoostValue
    end
end)

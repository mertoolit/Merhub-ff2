-- Mer Hub Free Version (FF2 only) by Mer Beauvoir

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Clean old GUI
local oldGui = playerGui:FindFirstChild("MerHub")
if oldGui then oldGui:Destroy() end

-- Key system
local KEY = "MERHUBFREE"

-- Create GUI container
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "MerHub"
ScreenGui.Parent = playerGui
ScreenGui.ResetOnSpawn = false

-- Welcome Screen
local WelcomeFrame = Instance.new("Frame", ScreenGui)
WelcomeFrame.Size = UDim2.new(0, 400, 0, 200)
WelcomeFrame.Position = UDim2.new(0.5, -200, 0.5, -100)
WelcomeFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
WelcomeFrame.BorderSizePixel = 0
WelcomeFrame.AnchorPoint = Vector2.new(0.5, 0.5)

local WelcomeText = Instance.new("TextLabel", WelcomeFrame)
WelcomeText.Text = "Welcome to Mer Hub!"
WelcomeText.Size = UDim2.new(1, 0, 1, 0)
WelcomeText.TextColor3 = Color3.fromRGB(180, 180, 255)
WelcomeText.Font = Enum.Font.GothamBold
WelcomeText.TextSize = 36
WelcomeText.BackgroundTransparency = 1

-- Function to fade out welcome and show main GUI
local function hideWelcome()
    local tweenInfo = TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    local tween = TweenService:Create(WelcomeFrame, tweenInfo, {BackgroundTransparency = 1, TextTransparency = 1})
    tween:Play()
    tween.Completed:Connect(function()
        WelcomeFrame:Destroy()
        mainGui.Enabled = true
    end)
end

delay(2, hideWelcome) -- Show welcome for 2 seconds

-- Main GUI (hidden initially)
local mainGui = Instance.new("ScreenGui")
mainGui.Name = "MerHubMain"
mainGui.Parent = playerGui
mainGui.Enabled = false
mainGui.ResetOnSpawn = false

-- Main Frame
local MainFrame = Instance.new("Frame", mainGui)
MainFrame.Size = UDim2.new(0, 450, 0, 320)
MainFrame.Position = UDim2.new(0.5, -225, 0.5, -160)
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 20, 40)
MainFrame.BorderSizePixel = 0
MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)

-- Make draggable
local dragging, dragInput, dragStart, startPos
MainFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = MainFrame.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)
MainFrame.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)
RunService.RenderStepped:Connect(function()
    if dragging and dragInput then
        local delta = dragInput.Position - dragStart
        MainFrame.Position = UDim2.new(
            startPos.X.Scale,
            startPos.X.Offset + delta.X,
            startPos.Y.Scale,
            startPos.Y.Offset + delta.Y
        )
    end
end)

-- Title bar
local TitleBar = Instance.new("Frame", MainFrame)
TitleBar.Size = UDim2.new(1, 0, 0, 40)
TitleBar.BackgroundColor3 = Color3.fromRGB(50, 30, 70)

local TitleLabel = Instance.new("TextLabel", TitleBar)
TitleLabel.Text = "Mer Hub Free Version - Football Fusion 2"
TitleLabel.Size = UDim2.new(1, -40, 1, 0)
TitleLabel.BackgroundTransparency = 1
TitleLabel.TextColor3 = Color3.fromRGB(220, 220, 255)
TitleLabel.Font = Enum.Font.GothamBold
TitleLabel.TextSize = 20
TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
TitleLabel.Position = UDim2.new(0, 10, 0, 0)

local CloseButton = Instance.new("TextButton", TitleBar)
CloseButton.Text = "X"
CloseButton.Size = UDim2.new(0, 40, 1, 0)
CloseButton.Position = UDim2.new(1, -40, 0, 0)
CloseButton.BackgroundColor3 = Color3.fromRGB(120, 40, 70)
CloseButton.TextColor3 = Color3.new(1, 1, 1)
CloseButton.Font = Enum.Font.GothamBold
CloseButton.TextSize = 20
CloseButton.MouseButton1Click:Connect(function()
    mainGui.Enabled = false
end)

-- Content frame
local ContentFrame = Instance.new("Frame", MainFrame)
ContentFrame.Size = UDim2.new(1, 0, 1, -40)
ContentFrame.Position = UDim2.new(0, 0, 0, 40)
ContentFrame.BackgroundColor3 = Color3.fromRGB(25, 15, 40)

-- Key Entry GUI (modal)
local KeyFrame = Instance.new("Frame", mainGui)
KeyFrame.Size = UDim2.new(0, 350, 0, 180)
KeyFrame.Position = UDim2.new(0.5, -175, 0.5, -90)
KeyFrame.BackgroundColor3 = Color3.fromRGB(30, 20, 40)
KeyFrame.BorderSizePixel = 0

local KeyLabel = Instance.new("TextLabel", KeyFrame)
KeyLabel.Text = "Enter Key to Access Mer Hub:"
KeyLabel.Size = UDim2.new(1, 0, 0, 40)
KeyLabel.Position = UDim2.new(0, 0, 0, 10)
KeyLabel.BackgroundTransparency = 1
KeyLabel.TextColor3 = Color3.fromRGB(220, 220, 255)
KeyLabel.Font = Enum.Font.GothamBold
KeyLabel.TextSize = 20

local KeyBox = Instance.new("TextBox", KeyFrame)
KeyBox.PlaceholderText = "Enter Key"
KeyBox.Size = UDim2.new(0.8, 0, 0, 40)
KeyBox.Position = UDim2.new(0.1, 0, 0, 60)
KeyBox.ClearTextOnFocus = false
KeyBox.Text = ""

local SubmitButton = Instance.new("TextButton", KeyFrame)
SubmitButton.Text = "Submit"
SubmitButton.Size = UDim2.new(0.3, 0, 0, 40)
SubmitButton.Position = UDim2.new(0.35, 0, 0, 110)
SubmitButton.BackgroundColor3 = Color3.fromRGB(0, 120, 255)
SubmitButton.TextColor3 = Color3.new(1, 1, 1)
SubmitButton.Font = Enum.Font.GothamBold
SubmitButton.TextSize = 20

local InfoLabel = Instance.new("TextLabel", KeyFrame)
InfoLabel.Size = UDim2.new(1, 0, 0, 40)
InfoLabel.Position = UDim2.new(0, 0, 0, 150)
InfoLabel.BackgroundTransparency = 1
InfoLabel.TextColor3 = Color3.fromRGB(255, 100, 100)
InfoLabel.Font = Enum.Font.Gotham
InfoLabel.TextSize = 16
InfoLabel.Text = ""

-- Auto Catch, ESP, No High Jump feature variables
local autoCatchEnabled = false
local espEnabled = false
local noJumpEnabled = false

local autoCatchConnection
local espConnection
local noJumpConnection

-- Auto Catch logic
local function autoCatchLoop()
    local ball = workspace:FindFirstChild("Ball") or workspace:FindFirstChild("ball")
    if ball and ball:IsA("BasePart") and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        ball.CFrame = player.Character.HumanoidRootPart.CFrame
    end
end

-- ESP logic
local espBoxes = {}

local function createEsp(part, color)
    local box = Instance.new("BoxHandleAdornment")
    box.Adornee = part
    box.AlwaysOnTop = true
    box.ZIndex = 10
    box.Size = part.Size + Vector3.new(0.2, 0.2, 0.2)
    box.Color3 = color
    box.Transparency = 0.5
    box.Parent = part
    return box
end

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
    for _, plr in pairs(Players:GetPlayers()) do
        if plr ~= player and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
            local box = createEsp(plr.Character.HumanoidRootPart, Color3.fromRGB(255, 0, 0))
            table.insert(espBoxes, box)
        end
    end
    local ball = workspace:FindFirstChild("Ball") or workspace:FindFirstChild("ball")
    if ball and ball:IsA("BasePart") then
        local box = createEsp(ball, Color3.fromRGB(0, 255, 255))
        table.insert(espBoxes, box)
    end
end

-- No High Jump logic
local function noJumpLoop()
    if player.Character then
        local humanoid = player.Character:FindFirstChild("Humanoid")
        if humanoid then
            humanoid.JumpPower = 50 -- Lower jump power to avoid high jump
        end
    end
end

-- Add feature buttons

local yStart = 20
local function createFeatureButton(text, posY, callback)
    local btn = Instance.new("TextButton", ContentFrame)
    btn.Text = text
    btn.Size = UDim2.new(0, 220, 0, 40)
    btn.Position = UDim2.new(0, 15, 0, posY)
    btn.BackgroundColor3 = Color3.fromRGB(80, 50, 110)
    btn.TextColor3 = Color3.new(1, 1, 1)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 18
    btn.AutoButtonColor = true
    btn.MouseButton1Click:Connect(callback)
    return btn
end

local autoCatchBtn = createFeatureButton("Toggle Auto Catch (OFF)", yStart, function()
    autoCatchEnabled = not autoCatchEnabled
    autoCatchBtn.Text = "Toggle Auto Catch (" .. (autoCatchEnabled and "ON" or "OFF") .. ")"
    if autoCatchEnabled then
        autoCatchConnection = RunService.Heartbeat:Connect(autoCatchLoop)
    else
        if autoCatchConnection then
            autoCatchConnection:Disconnect()
            autoCatchConnection = nil
        end
    end
end)

local espBtn = createFeatureButton("Toggle ESP (OFF)", yStart + 60, function()
    espEnabled = not espEnabled
    espBtn.Text = "Toggle ESP (" .. (espEnabled and "ON" or "OFF") .. ")"
    if espEnabled then
        espConnection = RunService.RenderStepped:Connect(espLoop)
    else
        if espConnection then
            espConnection:Disconnect()
            espConnection = nil
        end
        clearEsp()
    end
end)

local noJumpBtn = createFeatureButton("Toggle No High Jump (OFF)", yStart + 120, function()
    noJumpEnabled = not noJumpEnabled
    noJumpBtn.Text = "Toggle No High Jump (" .. (noJumpEnabled and "ON" or "OFF") .. ")"
    if noJumpEnabled then
        noJumpConnection = RunService.Heartbeat:Connect(noJumpLoop)
    else
        if noJumpConnection then
            noJumpConnection:Disconnect()
            noJumpConnection = nil
        end
        -- Reset jump power to default
        if player.Character then
            local humanoid = player.Character:FindFirstChild("Humanoid")
            if humanoid then
                humanoid.JumpPower = 100
            end
        end
    end
end)

-- Key submit logic
SubmitButton.MouseButton1Click:Connect(function()
    if KeyBox.Text == KEY then
        InfoLabel.TextColor3 = Color3.fromRGB(0, 255, 0)
        InfoLabel.Text = "Key accepted! Loading Mer Hub..."
        wait(1)
        KeyFrame:Destroy()
        mainGui.Enabled = true
    else
        InfoLabel.TextColor3 = Color3.fromRGB(255, 100, 100)
        InfoLabel.Text = "Wrong key! Hint: Starts with 'MER', ends with 'FREE'"
    end
end)

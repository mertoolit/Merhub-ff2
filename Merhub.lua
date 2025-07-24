-- Mer Hub Free Version
-- Author: Mer Beauvoir (sole creator)

local Players = game:GetService("Players")
local PlayerGui = Players.LocalPlayer:WaitForChild("PlayerGui")

-- Clean old GUI if exists
local oldGui = PlayerGui:FindFirstChild("MerHub")
if oldGui then oldGui:Destroy() end

-- GUI setup
local ScreenGui = Instance.new("ScreenGui", PlayerGui)
ScreenGui.Name = "MerHub"

local Frame = Instance.new("Frame", ScreenGui)
Frame.Size = UDim2.new(0, 400, 0, 250)
Frame.Position = UDim2.new(0.5, -200, 0.5, -125)
Frame.BackgroundColor3 = Color3.fromRGB(20,20,20)

local Title = Instance.new("TextLabel", Frame)
Title.Text = "Mer Hub Free Version"
Title.Size = UDim2.new(1, 0, 0, 40)
Title.BackgroundTransparency = 1
Title.TextColor3 = Color3.new(1,1,1)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 24

local KeyBox = Instance.new("TextBox", Frame)
KeyBox.PlaceholderText = "Enter Key"
KeyBox.Size = UDim2.new(0.8, 0, 0, 40)
KeyBox.Position = UDim2.new(0.1, 0, 0, 60)
KeyBox.ClearTextOnFocus = false

local SubmitButton = Instance.new("TextButton", Frame)
SubmitButton.Text = "Submit"
SubmitButton.Size = UDim2.new(0.3, 0, 0, 40)
SubmitButton.Position = UDim2.new(0.35, 0, 0, 110)
SubmitButton.BackgroundColor3 = Color3.fromRGB(0, 120, 255)
SubmitButton.TextColor3 = Color3.new(1,1,1)
SubmitButton.Font = Enum.Font.GothamBold
SubmitButton.TextSize = 20

local Info = Instance.new("TextLabel", Frame)
Info.Size = UDim2.new(1,0,0,40)
Info.Position = UDim2.new(0,0,0,170)
Info.BackgroundTransparency = 1
Info.TextColor3 = Color3.fromRGB(255,100,100)
Info.Font = Enum.Font.Gotham
Info.TextSize = 16

local KEY = "MERHUBFREE"

SubmitButton.MouseButton1Click:Connect(function()
    if KeyBox.Text == KEY then
        Info.TextColor3 = Color3.fromRGB(0,255,0)
        Info.Text = "Key Accepted! Loading Hub..."
        wait(1)
        Frame:Destroy()

        -- Placeholder: Hub content loads here
        local Loaded = Instance.new("TextLabel", ScreenGui)
        Loaded.Text = "Mer Hub Loaded! (Free Version)"
        Loaded.Size = UDim2.new(0,300,0,50)
        Loaded.Position = UDim2.new(0.5,-150,0.5,-25)
        Loaded.BackgroundColor3 = Color3.fromRGB(30,30,30)
        Loaded.TextColor3 = Color3.new(1,1,1)
        Loaded.Font = Enum.Font.GothamBold
        Loaded.TextSize = 22
    else
        Info.TextColor3 = Color3.fromRGB(255,100,100)
        Info.Text = "Wrong key! Hint: Starts with 'MER', ends with 'FREE'"
    end
end)

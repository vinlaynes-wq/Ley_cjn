-- KAZ Mobile GUI Demo
-- For a Roblox experience you own.
-- Place this LocalScript in StarterPlayerScripts.

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local gui = Instance.new("ScreenGui")
gui.Name = "KAZ_GUI"
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

local main = Instance.new("Frame")
main.Size = UDim2.fromOffset(240, 190)
main.Position = UDim2.new(0.5, -120, 0.5, -95)
main.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
main.Parent = gui

Instance.new("UICorner", main).CornerRadius = UDim.new(0, 12)

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 40)
title.BackgroundColor3 = Color3.fromRGB(90, 65, 180)
title.Text = "KAZ MOBILE MENU"
title.TextColor3 = Color3.new(1, 1, 1)
title.TextSize = 17
title.Font = Enum.Font.GothamBold
title.Parent = main

Instance.new("UICorner", title).CornerRadius = UDim.new(0, 12)

-- Mobile-friendly dragging
local dragging = false
local dragStart, startPosition

title.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch
    or input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPosition = main.Position
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if dragging and (
        input.UserInputType == Enum.UserInputType.Touch
        or input.UserInputType == Enum.UserInputType.MouseMovement
    ) then
        local delta = input.Position - dragStart
        main.Position = UDim2.new(
            startPosition.X.Scale,
            startPosition.X.Offset + delta.X,
            startPosition.Y.Scale,
            startPosition.Y.Offset + delta.Y
        )
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch
    or input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)

local function makeToggle(label, y)
    local enabled = false

    local button = Instance.new("TextButton")
    button.Size = UDim2.new(1, -24, 0, 42)
    button.Position = UDim2.fromOffset(12, y)
    button.BackgroundColor3 = Color3.fromRGB(55, 55, 70)
    button.TextColor3 = Color3.new(1, 1, 1)
    button.TextSize = 14
    button.Font = Enum.Font.Gotham
    button.Parent = main

    Instance.new("UICorner", button).CornerRadius = UDim.new(0, 8)

    local function update()
        button.Text = label .. ": " .. (enabled and "ON" or "OFF")
        button.BackgroundColor3 = enabled
            and Color3.fromRGB(70, 145, 100)
            or Color3.fromRGB(55, 55, 70)
    end

    button.Activated:Connect(function()
        enabled = not enabled
        update()
    end)

    update()
end

makeToggle("Option 1", 55)
makeToggle("Option 2", 105)

local close = Instance.new("TextButton")
close.Size = UDim2.fromOffset(32, 30)
close.Position = UDim2.new(1, -36, 0, 5)
close.Text = "X"
close.TextSize = 16
close.Parent = main

close.Activated:Connect(function()
    main.Visible = false
end)

local open = Instance.new("TextButton")
open.Size = UDim2.fromOffset(100, 42)
open.Position = UDim2.new(0, 15, 0.5, 100)
open.Text = "OPEN KAZ"
open.TextSize = 14
open.Parent = gui

open.Activated:Connect(function()
    main.Visible = true
end)

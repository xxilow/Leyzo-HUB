-- === SCRIPT COMPLET LEYZO UI AVEC ESP BOX + ESP SKELETON ROUGE + AIMBOT ===

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Workspace = game:GetService("Workspace")

local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")
local Camera = Workspace.CurrentCamera

-- GUI Setup
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "LeyzoUI"
ScreenGui.Parent = PlayerGui
ScreenGui.ResetOnSpawn = false

local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 650, 0, 400)
MainFrame.Position = UDim2.new(0.5, -325, 0.5, -200)
MainFrame.BackgroundColor3 = Color3.fromRGB(18, 18, 18)
MainFrame.BackgroundTransparency = 0.15
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Visible = true
MainFrame.Parent = ScreenGui

Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 12)

-- Sidebar
local SideBar = Instance.new("Frame")
SideBar.Name = "SideBar"
SideBar.Size = UDim2.new(0, 160, 1, 0)
SideBar.Position = UDim2.new(0, 0, 0, 0)
SideBar.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
SideBar.BackgroundTransparency = 0.2
SideBar.BorderSizePixel = 0
SideBar.Parent = MainFrame
Instance.new("UICorner", SideBar).CornerRadius = UDim.new(0, 12)

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 40)
Title.Text = "Leyzo HUB"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 20
Title.BackgroundTransparency = 1
Title.Parent = SideBar

local Categories = {"Aimbot", "ESP", "Misc", "Settings", "Credit"}
local Buttons = {}
local Pages = {}

for i, name in ipairs(Categories) do
    local Button = Instance.new("TextButton")
    Button.Name = name .. "Button"
    Button.Size = UDim2.new(1, -20, 0, 35)
    Button.Position = UDim2.new(0, 10, 0, 40 + (i - 1) * 40)
    Button.Text = name
    Button.TextColor3 = Color3.fromRGB(220, 220, 220)
    Button.Font = Enum.Font.Gotham
    Button.TextSize = 16
    Button.AutoLocalize = false
    Button.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    Button.BackgroundTransparency = 0.1
    Button.BorderSizePixel = 0
    Button.Parent = SideBar
    Instance.new("UICorner", Button).CornerRadius = UDim.new(0, 8)

    Buttons[name] = Button

    local Page = Instance.new("Frame")
    Page.Name = name .. "Page"
    Page.Position = UDim2.new(0, 170, 0, 10)
    Page.Size = UDim2.new(1, -180, 1, -20)
    Page.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    Page.BackgroundTransparency = 0.15
    Page.Visible = false
    Page.Parent = MainFrame
    Instance.new("UICorner", Page).CornerRadius = UDim.new(0, 12)

    Pages[name] = Page

    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(1, -20, 0, 30)
    Label.Position = UDim2.new(0, 10, 0, 10)
    Label.Text = "-> " .. name
    Label.TextColor3 = Color3.fromRGB(200, 200, 200)
    Label.Font = Enum.Font.Gotham
    Label.TextSize = 18
    Label.BackgroundTransparency = 1
    Label.Parent = Page

    Button.MouseButton1Click:Connect(function()
        for _, p in pairs(Pages) do p.Visible = false end
        Page.Visible = true
    end)
end

Pages["Aimbot"].Visible = true

-- Page Credit
local CreditPage = Pages["Credit"]
local CopyrightLabel = Instance.new("TextLabel")
CopyrightLabel.Size = UDim2.new(1, -20, 0, 30)
CopyrightLabel.Position = UDim2.new(0, 10, 0, 50)
CopyrightLabel.Text = "© 2025 Leyzo HUB. Tous droits réservés."
CopyrightLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
CopyrightLabel.Font = Enum.Font.Gotham
CopyrightLabel.TextSize = 16
CopyrightLabel.BackgroundTransparency = 1
CopyrightLabel.TextXAlignment = Enum.TextXAlignment.Left
CopyrightLabel.Parent = CreditPage

-- Page Settings
local SettingsPage = Pages["Settings"]
local InstructionLabel = Instance.new("TextLabel")
InstructionLabel.Size = UDim2.new(1, -20, 0, 40)
InstructionLabel.Position = UDim2.new(0, 10, 0, 10)
InstructionLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
InstructionLabel.Font = Enum.Font.Gotham
InstructionLabel.TextSize = 18
InstructionLabel.BackgroundTransparency = 1
InstructionLabel.TextXAlignment = Enum.TextXAlignment.Left
InstructionLabel.Parent = SettingsPage

local CaptureButton = Instance.new("TextButton")
CaptureButton.Size = UDim2.new(0, 320, 0, 40)
CaptureButton.Position = UDim2.new(0, 10, 0, 60)
CaptureButton.TextColor3 = Color3.fromRGB(220, 220, 220)
CaptureButton.Font = Enum.Font.Gotham
CaptureButton.TextSize = 18
CaptureButton.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
CaptureButton.BackgroundTransparency = 0.1
CaptureButton.BorderSizePixel = 0
CaptureButton.Parent = SettingsPage
Instance.new("UICorner", CaptureButton).CornerRadius = UDim.new(0, 6)

local currentToggleKey = Enum.KeyCode.RightShift
local capturing = false

local function setToggleKey(keyEnum)
    currentToggleKey = keyEnum
    CaptureButton.Text = "Choisir une touche (actuelle: " .. tostring(keyEnum.Name) .. ")"
end
setToggleKey(currentToggleKey)

CaptureButton.MouseButton1Click:Connect(function()
    if capturing then return end
    capturing = true
    CaptureButton.Text = "Appuyez sur une touche..."
end)

UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if capturing and input.UserInputType == Enum.UserInputType.Keyboard then
        setToggleKey(input.KeyCode)
        capturing = false
        return
    end
    if input.KeyCode == currentToggleKey and not capturing then
        MainFrame.Visible = not MainFrame.Visible
    end
end)

-- Fonctions Utiles
local function isCharacterValid(character)
    return character and character:FindFirstChild("Humanoid") and character.Humanoid.Health > 0 and character:FindFirstChild("HumanoidRootPart")
end

-- ESP BOX

local espBoxEnabled = false
local drawingBoxes = {}

local function createBox()
    local box = Drawing.new("Square")
    box.Visible = false
    box.Color = Color3.fromRGB(255, 255, 255)
    box.Thickness = 1
    box.Transparency = 0.4 -- plus transparent
    return box
end

local function createOrGetBox(player)
    if not drawingBoxes[player] then
        drawingBoxes[player] = createBox()
    end
    return drawingBoxes[player]
end

local function removeBox(player)
    if drawingBoxes[player] then
        drawingBoxes[player]:Remove()
        drawingBoxes[player] = nil
    end
end

local function updateBoxes()
    for _, player in pairs(Players:GetPlayers()) do
        local box = drawingBoxes[player]
        if not espBoxEnabled then
            if box then
                box.Visible = false
            end
        else
            if player ~= Player and isCharacterValid(player.Character) then
                local hrp = player.Character.HumanoidRootPart
                local size = Vector3.new(2, 5, 1)
                local topPos, topOnScreen = Camera:WorldToViewportPoint(hrp.Position + Vector3.new(0, size.Y / 2, 0))
                local bottomPos, bottomOnScreen = Camera:WorldToViewportPoint(hrp.Position - Vector3.new(0, size.Y / 2, 0))

                if topOnScreen and bottomOnScreen then
                    box = createOrGetBox(player)
                    local height = math.abs(topPos.Y - bottomPos.Y)
                    local width = height / 2
                    local boxPosX = topPos.X - width / 2
                    local boxPosY = topPos.Y

                    box.Size = Vector2.new(width, height)
                    box.Position = Vector2.new(boxPosX, boxPosY)
                    box.Visible = true
                elseif box then
                    box.Visible = false
                end
            elseif box then
                box.Visible = false
            end
        end
    end
end

-- ESP SKELETON ROUGE (via Drawing API)
local espSkeletonEnabled = false
local skeletonBones = {
    {"Head", "UpperTorso"},
    {"UpperTorso", "LowerTorso"},
    {"UpperTorso", "LeftUpperArm"},
    {"LeftUpperArm", "LeftLowerArm"},
    {"LeftLowerArm", "LeftHand"},
    {"UpperTorso", "RightUpperArm"},
    {"RightUpperArm", "RightLowerArm"},
    {"RightLowerArm", "RightHand"},
    {"LowerTorso", "LeftUpperLeg"},
    {"LeftUpperLeg", "LeftLowerLeg"},
    {"LeftLowerLeg", "LeftFoot"},
    {"LowerTorso", "RightUpperLeg"},
    {"RightUpperLeg", "RightLowerLeg"},
    {"RightLowerLeg", "RightFoot"},
}

local drawingSkeletons = {}

local function createSkeletonLines(player)
    if drawingSkeletons[player] then return end
    local lines = {}
    for _, bone in pairs(skeletonBones) do
        local line = Drawing.new("Line")
        line.Color = Color3.fromRGB(255, 0, 0)
        line.Thickness = 2
        line.Transparency = 0.8
        line.Visible = false
        table.insert(lines, line)
    end
    drawingSkeletons[player] = lines
end

local function removeSkeletonLines(player)
    if drawingSkeletons[player] then
        for _, line in pairs(drawingSkeletons[player]) do
            line.Visible = false
            line:Remove()
        end
        drawingSkeletons[player] = nil
    end
end

local function updateDrawingSkeleton()
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= Player and espSkeletonEnabled and isCharacterValid(player.Character) then
            if not drawingSkeletons[player] then
                createSkeletonLines(player)
            end

            local char = player.Character
            local lines = drawingSkeletons[player]

            for i, bone in ipairs(skeletonBones) do
                local part0 = char:FindFirstChild(bone[1])
                local part1 = char:FindFirstChild(bone[2])
                if part0 and part1 then
                    local pos0, onScreen0 = Camera:WorldToViewportPoint(part0.Position)
                    local pos1, onScreen1 = Camera:WorldToViewportPoint(part1.Position)
                    if onScreen0 and onScreen1 then
                        lines[i].From = Vector2.new(pos0.X, pos0.Y)
                        lines[i].To = Vector2.new(pos1.X, pos1.Y)
                        lines[i].Visible = true
                    else
                        lines[i].Visible = false
                    end
                else
                    lines[i].Visible = false
                end
            end
        else
            removeSkeletonLines(player)
        end
    end
end

-- AIMBOT

local aimbotEnabled = false
local aimbotFOV = 120
local aimbotSmoothness = 0.15

-- Boutons Aimbot

local AimbotPage = Pages["Aimbot"]

local function createToggleButton(name, positionY)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 140, 0, 40)
    btn.Position = UDim2.new(0, 10, 0, positionY)
    btn.Text = name .. " : OFF"
    btn.TextColor3 = Color3.fromRGB(220, 220, 220)
    btn.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    btn.BorderSizePixel = 0
    btn.Font = Enum.Font.Gotham
    btn.TextSize = 18
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
    btn.Parent = AimbotPage
    return btn
end

-- Toggle Aimbot
local AimbotToggle = createToggleButton("Aimbot", 50)
AimbotToggle.MouseButton1Click:Connect(function()
    aimbotEnabled = not aimbotEnabled
    AimbotToggle.Text = "Aimbot : " .. (aimbotEnabled and "ON" or "OFF")
end)

-- Slider Aimbot FOV
local FOVLabel = Instance.new("TextLabel")
FOVLabel.Size = UDim2.new(0, 140, 0, 25)
FOVLabel.Position = UDim2.new(0, 10, 0, 105)
FOVLabel.Text = "Aimbot FOV: " .. tostring(aimbotFOV)
FOVLabel.TextColor3 = Color3.fromRGB(220, 220, 220)
FOVLabel.Font = Enum.Font.Gotham
FOVLabel.TextSize = 14
FOVLabel.BackgroundTransparency = 1
FOVLabel.Parent = AimbotPage

local FOVSlider = Instance.new("TextBox")
FOVSlider.Size = UDim2.new(0, 140, 0, 30)
FOVSlider.Position = UDim2.new(0, 10, 0, 130)
FOVSlider.Text = tostring(aimbotFOV)
FOVSlider.TextColor3 = Color3.fromRGB(220, 220, 220)
FOVSlider.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
FOVSlider.BorderSizePixel = 0
FOVSlider.Font = Enum.Font.Gotham
FOVSlider.TextSize = 16
FOVSlider.ClearTextOnFocus = false
FOVSlider.Parent = AimbotPage
Instance.new("UICorner", FOVSlider).CornerRadius = UDim.new(0, 6)

FOVSlider.FocusLost:Connect(function(enterPressed)
    local val = tonumber(FOVSlider.Text)
    if val and val > 0 and val <= 360 then
        aimbotFOV = val
        FOVLabel.Text = "Aimbot FOV: " .. tostring(aimbotFOV)
        -- Update radius cercle si Drawn FOV activé
        fovCircle.Radius = aimbotFOV
    else
        FOVSlider.Text = tostring(aimbotFOV)
    end
end)

-- Slider Aimbot Smoothness
local SmoothLabel = Instance.new("TextLabel")
SmoothLabel.Size = UDim2.new(0, 140, 0, 25)
SmoothLabel.Position = UDim2.new(0, 10, 0, 175)
SmoothLabel.Text = "Aimbot Smoothness: " .. tostring(aimbotSmoothness)
SmoothLabel.TextColor3 = Color3.fromRGB(220, 220, 220)
SmoothLabel.Font = Enum.Font.Gotham
SmoothLabel.TextSize = 14
SmoothLabel.BackgroundTransparency = 1
SmoothLabel.Parent = AimbotPage

local SmoothSlider = Instance.new("TextBox")
SmoothSlider.Size = UDim2.new(0, 140, 0, 30)
SmoothSlider.Position = UDim2.new(0, 10, 0, 200)
SmoothSlider.Text = tostring(aimbotSmoothness)
SmoothSlider.TextColor3 = Color3.fromRGB(220, 220, 220)
SmoothSlider.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
SmoothSlider.BorderSizePixel = 0
SmoothSlider.Font = Enum.Font.Gotham
SmoothSlider.TextSize = 16
SmoothSlider.ClearTextOnFocus = false
SmoothSlider.Parent = AimbotPage
Instance.new("UICorner", SmoothSlider).CornerRadius = UDim.new(0, 6)

SmoothSlider.FocusLost:Connect(function(enterPressed)
    local val = tonumber(SmoothSlider.Text)
    if val and val > 0 and val <= 1 then
        aimbotSmoothness = val
        SmoothLabel.Text = "Aimbot Smoothness: " .. tostring(aimbotSmoothness)
    else
        SmoothSlider.Text = tostring(aimbotSmoothness)
    end
end)

-- === NOUVEAU : Drawn FOV Toggle ===
local drawnFOVEnabled = false

local DrawnFOVToggle = Instance.new("TextButton")
DrawnFOVToggle.Size = UDim2.new(0, 140, 0, 40)
DrawnFOVToggle.Position = UDim2.new(0, 10, 0, 240)
DrawnFOVToggle.Text = "Drawn FOV : OFF"
DrawnFOVToggle.TextColor3 = Color3.fromRGB(220, 220, 220)
DrawnFOVToggle.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
DrawnFOVToggle.BorderSizePixel = 0
DrawnFOVToggle.Font = Enum.Font.Gotham
DrawnFOVToggle.TextSize = 18
DrawnFOVToggle.Parent = AimbotPage
Instance.new("UICorner", DrawnFOVToggle).CornerRadius = UDim.new(0, 6)

local fovCircle = Drawing.new("Circle")
fovCircle.Visible = false
fovCircle.Color = Color3.fromRGB(0, 255, 255)
fovCircle.Thickness = 2
fovCircle.NumSides = 64
fovCircle.Filled = false
fovCircle.Transparency = 0.8
fovCircle.Radius = aimbotFOV

DrawnFOVToggle.MouseButton1Click:Connect(function()
    drawnFOVEnabled = not drawnFOVEnabled
    DrawnFOVToggle.Text = "Drawn FOV : " .. (drawnFOVEnabled and "ON" or "OFF")
    fovCircle.Visible = drawnFOVEnabled
end)

-- Fonction pour obtenir le joueur le plus proche dans le FOV
local function getClosestTarget()
    local closestPlayer = nil
    local shortestDistance = aimbotFOV

    local mousePos = UserInputService:GetMouseLocation()

    for _, player in pairs(Players:GetPlayers()) do
        if player ~= Player and isCharacterValid(player.Character) then
            local head = player.Character:FindFirstChild("Head")
            if head then
                local screenPos, onScreen = Camera:WorldToViewportPoint(head.Position)
                if onScreen then
                    local dist = (Vector2.new(screenPos.X, screenPos.Y) - Vector2.new(mousePos.X, mousePos.Y)).Magnitude
                    if dist < shortestDistance then
                        shortestDistance = dist
                        closestPlayer = player
                    end
                end
            end
        end
    end
    return closestPlayer
end

-- RenderStepped Loop
RunService.RenderStepped:Connect(function()
    -- Mise à jour cercle FOV
    if drawnFOVEnabled then
        local mousePos = UserInputService:GetMouseLocation()
        fovCircle.Position = Vector2.new(mousePos.X, mousePos.Y)
        fovCircle.Visible = true
    else
        fovCircle.Visible = false
    end

    if espBoxEnabled then
        updateBoxes()
    end

    if espSkeletonEnabled then
        updateDrawingSkeleton()
    end

    if aimbotEnabled then
        local target = getClosestTarget()
        if target and target.Character and isCharacterValid(target.Character) then
            local head = target.Character:FindFirstChild("Head")
            if head then
                local mouseLocation = UserInputService:GetMouseLocation()
                local headScreenPos, onScreen = Camera:WorldToViewportPoint(head.Position)
                if onScreen then
                    local targetPos = Vector2.new(headScreenPos.X, headScreenPos.Y)
                    local mousePos = Vector2.new(mouseLocation.X, mouseLocation.Y)
                    local delta = (targetPos - mousePos) * aimbotSmoothness

                    local dx = delta.X
                    local dy = delta.Y
                    pcall(function()
                        mousemoverel(dx, dy)
                    end)
                end
            end
        end
    end
end)

-- ESP Toggle buttons (pour activer/désactiver les ESP)

-- ESP Box Toggle Button (dans ESP Page)
local ESPPage = Pages["ESP"]

local ESPBoxToggle = Instance.new("TextButton")
ESPBoxToggle.Size = UDim2.new(0, 140, 0, 40)
ESPBoxToggle.Position = UDim2.new(0, 10, 0, 50)
ESPBoxToggle.Text = "ESP Box : OFF"
ESPBoxToggle.TextColor3 = Color3.fromRGB(220, 220, 220)
ESPBoxToggle.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
ESPBoxToggle.BorderSizePixel = 0
ESPBoxToggle.Font = Enum.Font.Gotham
ESPBoxToggle.TextSize = 18
Instance.new("UICorner", ESPBoxToggle).CornerRadius = UDim.new(0, 6)
ESPBoxToggle.Parent = ESPPage

ESPBoxToggle.MouseButton1Click:Connect(function()
    espBoxEnabled = not espBoxEnabled
    ESPBoxToggle.Text = "ESP Box : " .. (espBoxEnabled and "ON" or "OFF")
end)

-- ESP Skeleton Toggle Button
local ESPSkeletonToggle = Instance.new("TextButton")
ESPSkeletonToggle.Size = UDim2.new(0, 140, 0, 40)
ESPSkeletonToggle.Position = UDim2.new(0, 10, 0, 105)
ESPSkeletonToggle.Text = "ESP Skeleton : OFF"
ESPSkeletonToggle.TextColor3 = Color3.fromRGB(220, 220, 220)
ESPSkeletonToggle.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
ESPSkeletonToggle.BorderSizePixel = 0
ESPSkeletonToggle.Font = Enum.Font.Gotham
ESPSkeletonToggle.TextSize = 18
Instance.new("UICorner", ESPSkeletonToggle).CornerRadius = UDim.new(0, 6)
ESPSkeletonToggle.Parent = ESPPage

ESPSkeletonToggle.MouseButton1Click:Connect(function()
    espSkeletonEnabled = not espSkeletonEnabled
    ESPSkeletonToggle.Text = "ESP Skeleton : " .. (espSkeletonEnabled and "ON" or "OFF")
end)

-- === FIN DU SCRIPT ===

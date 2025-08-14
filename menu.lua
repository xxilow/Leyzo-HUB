-- === SCRIPT COMPLET LEYZO UI AVEC ESP BOX + ESP SKELETON ROUGE + AIMBOT + FLY + NOCLIP ===

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
InstructionLabel.Text = "Appuie sur le bouton ci-dessous pour choisir la touche d'affichage du GUI."
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
    box.Transparency = 0.4
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
    for _, plr in pairs(Players:GetPlayers()) do
        local box = drawingBoxes[plr]
        if not espBoxEnabled then
            if box then
                box.Visible = false
            end
        else
            if plr ~= Player and isCharacterValid(plr.Character) then
                local hrp = plr.Character.HumanoidRootPart
                local size = Vector3.new(2, 5, 1)
                local topPos, topOnScreen = Camera:WorldToViewportPoint(hrp.Position + Vector3.new(0, size.Y / 2, 0))
                local bottomPos, bottomOnScreen = Camera:WorldToViewportPoint(hrp.Position - Vector3.new(0, size.Y / 2, 0))

                if topOnScreen and bottomOnScreen then
                    box = createOrGetBox(plr)
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

local function createSkeletonLines(plr)
    if drawingSkeletons[plr] then return end
    local lines = {}
    for _, bone in pairs(skeletonBones) do
        local line = Drawing.new("Line")
        line.Color = Color3.fromRGB(255, 0, 0)
        line.Thickness = 2
        line.Transparency = 0.8
        line.Visible = false
        table.insert(lines, line)
    end
    drawingSkeletons[plr] = lines
end

local function removeSkeletonLines(plr)
    if drawingSkeletons[plr] then
        for _, line in pairs(drawingSkeletons[plr]) do
            line.Visible = false
            line:Remove()
        end
        drawingSkeletons[plr] = nil
    end
end

local function updateDrawingSkeleton()
    for _, plr in pairs(Players:GetPlayers()) do
        if plr ~= Player and espSkeletonEnabled and isCharacterValid(plr.Character) then
            if not drawingSkeletons[plr] then
                createSkeletonLines(plr)
            end

            local char = plr.Character
            local lines = drawingSkeletons[plr]

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
            removeSkeletonLines(plr)
        end
    end
end

-- AIMBOT
local aimbotEnabled = false
local aimbotFOV = 120
local aimbotSmoothness = 0.15

-- Aimbot Page + contrôles
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

local AimbotToggle = createToggleButton("Aimbot", 50)
AimbotToggle.MouseButton1Click:Connect(function()
    aimbotEnabled = not aimbotEnabled
    AimbotToggle.Text = "Aimbot : " .. (aimbotEnabled and "ON" or "OFF")
end)

-- FOV Label + input
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

-- Cercle FOV (visible si option activée)
local drawnFOVEnabled = false
local fovCircle = Drawing.new("Circle")
fovCircle.Visible = false
fovCircle.Color = Color3.fromRGB(0, 255, 255)
fovCircle.Thickness = 2
fovCircle.NumSides = 64
fovCircle.Filled = false
fovCircle.Transparency = 0.8
fovCircle.Radius = aimbotFOV

FOVSlider.FocusLost:Connect(function()
    local val = tonumber(FOVSlider.Text)
    if val and val > 0 and val <= 360 then
        aimbotFOV = val
        FOVLabel.Text = "Aimbot FOV: " .. tostring(aimbotFOV)
        fovCircle.Radius = aimbotFOV
    else
        FOVSlider.Text = tostring(aimbotFOV)
    end
end)

-- Smoothness Label + input
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

SmoothSlider.FocusLost:Connect(function()
    local val = tonumber(SmoothSlider.Text)
    if val and val > 0 and val <= 1 then
        aimbotSmoothness = val
        SmoothLabel.Text = "Aimbot Smoothness: " .. tostring(aimbotSmoothness)
    else
        SmoothSlider.Text = tostring(aimbotSmoothness)
    end
end)

-- Drawn FOV Toggle
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

DrawnFOVToggle.MouseButton1Click:Connect(function()
    drawnFOVEnabled = not drawnFOVEnabled
    DrawnFOVToggle.Text = "Drawn FOV : " .. (drawnFOVEnabled and "ON" or "OFF")
    fovCircle.Visible = drawnFOVEnabled
end)

-- Ciblage aimbot (plus proche dans le FOV)
local function getClosestTarget()
    local closestPlayer = nil
    local shortestDistance = aimbotFOV
    local mousePos = UserInputService:GetMouseLocation()

    for _, plr in pairs(Players:GetPlayers()) do
        if plr ~= Player and isCharacterValid(plr.Character) then
            local head = plr.Character:FindFirstChild("Head")
            if head then
                local screenPos, onScreen = Camera:WorldToViewportPoint(head.Position)
                if onScreen then
                    local dist = (Vector2.new(screenPos.X, screenPos.Y) - Vector2.new(mousePos.X, mousePos.Y)).Magnitude
                    if dist < shortestDistance then
                        shortestDistance = dist
                        closestPlayer = plr
                    end
                end
            end
        end
    end
    return closestPlayer
end

-- ESP Page + toggles
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

-- === MISC : FLY + NOCLIP ===
local MiscPage = Pages["Misc"]

-- Fly
local flyEnabled = false
local flySpeed = 5
local bodyGyro, bodyVelocity
local flyConn

local function startFly()
    local character = Player.Character
    if not character or not character:FindFirstChild("HumanoidRootPart") then return end

    if bodyGyro then bodyGyro:Destroy() bodyGyro = nil end
    if bodyVelocity then bodyVelocity:Destroy() bodyVelocity = nil end

    bodyGyro = Instance.new("BodyGyro")
    bodyGyro.P = 9e4
    bodyGyro.MaxTorque = Vector3.new(9e9, 9e9, 9e9)
    bodyGyro.CFrame = character.HumanoidRootPart.CFrame
    bodyGyro.Parent = character.HumanoidRootPart

    bodyVelocity = Instance.new("BodyVelocity")
    bodyVelocity.Velocity = Vector3.new(0,0,0)
    bodyVelocity.MaxForce = Vector3.new(9e9, 9e9, 9e9)
    bodyVelocity.Parent = character.HumanoidRootPart

    flyConn = RunService.RenderStepped:Connect(function()
        if not flyEnabled then return end
        local char = Player.Character
        if not char or not char:FindFirstChild("HumanoidRootPart") then return end

        local moveDirection = Vector3.new(0,0,0)
        if UserInputService:IsKeyDown(Enum.KeyCode.W) then moveDirection = moveDirection + Camera.CFrame.LookVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.S) then moveDirection = moveDirection - Camera.CFrame.LookVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.A) then moveDirection = moveDirection - Camera.CFrame.RightVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.D) then moveDirection = moveDirection + Camera.CFrame.RightVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.Space) then moveDirection = moveDirection + Vector3.new(0, 1, 0) end
        if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then moveDirection = moveDirection - Vector3.new(0, 1, 0) end

        if moveDirection.Magnitude > 0 then
            moveDirection = moveDirection.Unit
        end

        bodyVelocity.Velocity = moveDirection * flySpeed
        bodyGyro.CFrame = Camera.CFrame
    end)
end

local function stopFly()
    if flyConn and flyConn.Connected then flyConn:Disconnect() flyConn = nil end
    if bodyGyro then bodyGyro:Destroy() bodyGyro = nil end
    if bodyVelocity then bodyVelocity:Destroy() bodyVelocity = nil end
end

local FlyToggle = Instance.new("TextButton")
FlyToggle.Size = UDim2.new(0, 140, 0, 40)
FlyToggle.Position = UDim2.new(0, 10, 0, 50)
FlyToggle.Text = "Fly : OFF"
FlyToggle.TextColor3 = Color3.fromRGB(220, 220, 220)
FlyToggle.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
FlyToggle.BorderSizePixel = 0
FlyToggle.Font = Enum.Font.Gotham
FlyToggle.TextSize = 18
Instance.new("UICorner", FlyToggle).CornerRadius = UDim.new(0, 6)
FlyToggle.Parent = MiscPage

FlyToggle.MouseButton1Click:Connect(function()
    flyEnabled = not flyEnabled
    FlyToggle.Text = "Fly : " .. (flyEnabled and "ON" or "OFF")
    if flyEnabled then startFly() else stopFly() end
end)

-- Fly speed control
local FlySpeedLabel = Instance.new("TextLabel")
FlySpeedLabel.Size = UDim2.new(0, 140, 0, 25)
FlySpeedLabel.Position = UDim2.new(0, 10, 0, 100)
FlySpeedLabel.Text = "Fly Speed: " .. tostring(flySpeed)
FlySpeedLabel.TextColor3 = Color3.fromRGB(220, 220, 220)
FlySpeedLabel.Font = Enum.Font.Gotham
FlySpeedLabel.TextSize = 14
FlySpeedLabel.BackgroundTransparency = 1
FlySpeedLabel.Parent = MiscPage

local FlySpeedBox = Instance.new("TextBox")
FlySpeedBox.Size = UDim2.new(0, 140, 0, 30)
FlySpeedBox.Position = UDim2.new(0, 10, 0, 125)
FlySpeedBox.Text = tostring(flySpeed)
FlySpeedBox.TextColor3 = Color3.fromRGB(220, 220, 220)
FlySpeedBox.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
FlySpeedBox.BorderSizePixel = 0
FlySpeedBox.Font = Enum.Font.Gotham
FlySpeedBox.TextSize = 16
FlySpeedBox.ClearTextOnFocus = false
FlySpeedBox.Parent = MiscPage
Instance.new("UICorner", FlySpeedBox).CornerRadius = UDim.new(0, 6)

FlySpeedBox.FocusLost:Connect(function()
    local val = tonumber(FlySpeedBox.Text)
    if val and val > 0 and val <= 100 then
        flySpeed = val
        FlySpeedLabel.Text = "Fly Speed: " .. tostring(flySpeed)
    else
        FlySpeedBox.Text = tostring(flySpeed)
    end
end)

-- NoClip
local noclipEnabled = false
local noclipConn

local function setCharacterCollisions(char, canCollide)
    if not char then return end
    for _, d in ipairs(char:GetDescendants()) do
        if d:IsA("BasePart") then
            d.CanCollide = canCollide
        end
    end
end

local function startNoClip()
    -- Désactive les collisions en continu pour éviter que Roblox les réactive
    if noclipConn and noclipConn.Connected then noclipConn:Disconnect() end
    noclipConn = RunService.Stepped:Connect(function()
        if not noclipEnabled then return end
        local char = Player.Character
        if char then
            setCharacterCollisions(char, false)
            local hum = char:FindFirstChildOfClass("Humanoid")
            if hum then
                -- Empêche certains états d'accroche/physique gênants
                pcall(function()
                    hum:SetStateEnabled(Enum.HumanoidStateType.Climbing, false)
                    hum:SetStateEnabled(Enum.HumanoidStateType.Ragdoll, false)
                    hum:ChangeState(Enum.HumanoidStateType.Physics)
                end)
            end
        end
    end)
    -- Au démarrage, désactiver immédiatement
    setCharacterCollisions(Player.Character, false)
end

local function stopNoClip()
    if noclipConn and noclipConn.Connected then
        noclipConn:Disconnect()
        noclipConn = nil
    end
    -- Rétablir collisions
    setCharacterCollisions(Player.Character, true)
end

-- Maintenir NoClip après respawn
Player.CharacterAdded:Connect(function(char)
    char:WaitForChild("HumanoidRootPart", 10)
    if noclipEnabled then
        -- Laisse le temps aux parties d'exister
        task.wait(0.25)
        setCharacterCollisions(char, false)
    end
end)

local NoClipToggle = Instance.new("TextButton")
NoClipToggle.Size = UDim2.new(0, 140, 0, 40)
NoClipToggle.Position = UDim2.new(0, 10, 0, 170)
NoClipToggle.Text = "NoClip : OFF"
NoClipToggle.TextColor3 = Color3.fromRGB(220, 220, 220)
NoClipToggle.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
NoClipToggle.BorderSizePixel = 0
NoClipToggle.Font = Enum.Font.Gotham
NoClipToggle.TextSize = 18
Instance.new("UICorner", NoClipToggle).CornerRadius = UDim.new(0, 6)
NoClipToggle.Parent = MiscPage

NoClipToggle.MouseButton1Click:Connect(function()
    noclipEnabled = not noclipEnabled
    NoClipToggle.Text = "NoClip : " .. (noclipEnabled and "ON" or "OFF")
    if noclipEnabled then
        startNoClip()
    else
        stopNoClip()
    end
end)

-- === BOUCLE PRINCIPALE RENDER ===
RunService.RenderStepped:Connect(function()
    -- CERCLE FOV
    if drawnFOVEnabled then
        local mousePos = UserInputService:GetMouseLocation()
        fovCircle.Position = Vector2.new(mousePos.X, mousePos.Y)
        fovCircle.Visible = true
    else
        fovCircle.Visible = false
    end

    -- ESP
    if espBoxEnabled then
        updateBoxes()
    end

    if espSkeletonEnabled then
        updateDrawingSkeleton()
    end

    -- AIMBOT
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

-- === FIN DU SCRIPT ===

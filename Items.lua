-- Items --
if not _G.LazyLoadInitialized then
    _G.LazyLoadInitialized = true
    _G.ESPEnabled = false
    _G.AimbotEnabled = false
    _G.PlayerCache = {}
    _G.ESPObjects = {}
end


local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local LocalPlayer = Players.LocalPlayer


local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "EnhancedGui"
ScreenGui.Parent = game.CoreGui
ScreenGui.ResetOnSpawn = false

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 140, 0, 160)
MainFrame.Position = UDim2.new(0.5, -70, 0.5, -80)
MainFrame.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
MainFrame.BorderSizePixel = 2
MainFrame.BorderColor3 = Color3.fromRGB(80, 80, 80)
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui


local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 8)
UICorner.Parent = MainFrame


local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 30)
Title.Position = UDim2.new(0, 0, 0, 0)
Title.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Text = "SaygexHub"
Title.Font = Enum.Font.GothamBold
Title.TextSize = 16
Title.Parent = MainFrame


local TitleCorner = Instance.new("UICorner")
TitleCorner.CornerRadius = UDim.new(0, 8)
TitleCorner.Parent = Title


local ESPToggle = Instance.new("TextButton")
ESPToggle.Size = UDim2.new(0.85, 0, 0, 28)
ESPToggle.Position = UDim2.new(0.075, 0, 0, 35)
ESPToggle.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
ESPToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
ESPToggle.Text = "ESP: OFF"
ESPToggle.Font = Enum.Font.Gotham
ESPToggle.TextSize = 14
ESPToggle.Parent = MainFrame


local ESPCorner = Instance.new("UICorner")
ESPCorner.CornerRadius = UDim.new(0, 6)
ESPCorner.Parent = ESPToggle


local AimbotToggle = Instance.new("TextButton")
AimbotToggle.Size = UDim2.new(0.85, 0, 0, 28)
AimbotToggle.Position = UDim2.new(0.075, 0, 0, 70)
AimbotToggle.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
AimbotToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
AimbotToggle.Text = "AIMBOT: OFF"
AimbotToggle.Font = Enum.Font.Gotham
AimbotToggle.TextSize = 14
AimbotToggle.Parent = MainFrame


local AimbotCorner = Instance.new("UICorner")
AimbotCorner.CornerRadius = UDim.new(0, 6)
AimbotCorner.Parent = AimbotToggle


local StatusLabel = Instance.new("TextLabel")
StatusLabel.Size = UDim2.new(0.85, 0, 0, 20)
StatusLabel.Position = UDim2.new(0.075, 0, 0, 105)
StatusLabel.BackgroundTransparency = 1
StatusLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
StatusLabel.Text = "Press F1 to hide"
StatusLabel.Font = Enum.Font.Gotham
StatusLabel.TextSize = 12
StatusLabel.Parent = MainFrame


local CloseButton = Instance.new("TextButton")
CloseButton.Size = UDim2.new(0.85, 0, 0, 28)
CloseButton.Position = UDim2.new(0.075, 0, 0, 125)
CloseButton.BackgroundColor3 = Color3.fromRGB(180, 50, 50)
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.Text = "CLOSE"
CloseButton.Font = Enum.Font.GothamBold
CloseButton.TextSize = 14
CloseButton.Parent = MainFrame


local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(0, 6)
CloseCorner.Parent = CloseButton


UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if input.KeyCode == Enum.KeyCode.F1 and not gameProcessed then
        MainFrame.Visible = not MainFrame.Visible
        StatusLabel.Text = MainFrame.Visible and "Press F1 to hide" or "Press F1 to show"
    end
end)


ESPToggle.MouseButton1Click:Connect(function()
    _G.ESPEnabled = not _G.ESPEnabled
    ESPToggle.Text = "ESP: " .. (_G.ESPEnabled and "ON" or "OFF")
    
    
    local tweenInfo = TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    local tween = TweenService:Create(
        ESPToggle, 
        tweenInfo, 
        {BackgroundColor3 = _G.ESPEnabled and Color3.fromRGB(50, 180, 50) or Color3.fromRGB(60, 60, 60)}
    )
    tween:Play()
    
    if not _G.ESPEnabled then
        ClearESP()
    else
        UpdateESP()
    end
end)


AimbotToggle.MouseButton1Click:Connect(function()
    _G.AimbotEnabled = not _G.AimbotEnabled
    AimbotToggle.Text = "AIMBOT: " .. (_G.AimbotEnabled and "ON" or "OFF")
    
   
    local tweenInfo = TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    local tween = TweenService:Create(
        AimbotToggle, 
        tweenInfo, 
        {BackgroundColor3 = _G.AimbotEnabled and Color3.fromRGB(50, 180, 50) or Color3.fromRGB(60, 60, 60)}
    )
    tween:Play()
end)


CloseButton.MouseButton1Click:Connect(function()
  
    local tweenInfo = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    local tween = TweenService:Create(
        MainFrame, 
        tweenInfo, 
        {Size = UDim2.new(0, 0, 0, 0), Position = UDim2.new(0.5, 0, 0.5, 0)}
    )
    tween:Play()
    
    tween.Completed:Connect(function()
        ScreenGui:Destroy()
        script:Destroy()
    end)
end)


function ClearESP()
    for _, obj in pairs(_G.ESPObjects) do
        if obj then
            obj:Destroy()
        end
    end
    _G.ESPObjects = {}
end

function CreateESP(player)
    if not player.Character or not player.Character:FindFirstChild("Head") then
        return
    end

    local highlight = Instance.new("Highlight")
    highlight.Name = player.Name .. "_ESP"
    highlight.Adornee = player.Character
    highlight.FillColor = player.Team ~= LocalPlayer.Team and Color3.fromRGB(255, 50, 50) or Color3.fromRGB(50, 255, 50)
    highlight.FillTransparency = 0.4
    highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
    highlight.OutlineTransparency = 0
    highlight.Parent = player.Character
    
    local billboard = Instance.new("BillboardGui")
    billboard.Name = player.Name .. "_NameTag"
    billboard.Adornee = player.Character.Head
    billboard.Size = UDim2.new(0, 200, 0, 60)
    billboard.StudsOffset = Vector3.new(0, 2.5, 0)
    billboard.AlwaysOnTop = true
    billboard.Parent = player.Character.Head
    
    local nameLabel = Instance.new("TextLabel")
    nameLabel.Size = UDim2.new(1, 0, 0.5, 0)
    nameLabel.Position = UDim2.new(0, 0, 0, 0)
    nameLabel.BackgroundTransparency = 1
    nameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    nameLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
    nameLabel.TextStrokeTransparency = 0
    nameLabel.Text = player.Name
    nameLabel.Font = Enum.Font.GothamBold
    nameLabel.TextSize = 16
    nameLabel.Parent = billboard
    
    local distanceLabel = Instance.new("TextLabel")
    distanceLabel.Size = UDim2.new(1, 0, 0.5, 0)
    distanceLabel.Position = UDim2.new(0, 0, 0.5, 0)
    distanceLabel.BackgroundTransparency = 1
    distanceLabel.TextColor3 = Color3.fromRGB(220, 220, 220)
    distanceLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
    distanceLabel.TextStrokeTransparency = 0
    distanceLabel.Font = Enum.Font.Gotham
    distanceLabel.TextSize = 14
    distanceLabel.Parent = billboard
    
    table.insert(_G.ESPObjects, highlight)
    table.insert(_G.ESPObjects, billboard)
    
    return {Highlight = highlight, Billboard = billboard, DistanceLabel = distanceLabel}
end

function UpdateESP()
    if not _G.ESPEnabled then return end
    
    ClearESP()
    
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character then
            local esp = CreateESP(player)
            if esp then
            
                local distance = (LocalPlayer.Character.Head.Position - player.Character.Head.Position).Magnitude
                esp.DistanceLabel.Text = tostring(math.floor(distance)) .. " studs"
            end
        end
    end
end


function FindNearestPlayer()
    local nearestPlayer = nil
    local nearestDistance = math.huge
    
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("Head") and player.Character:FindFirstChild("Humanoid") and player.Character.Humanoid.Health > 0 then
            local distance = (LocalPlayer.Character.Head.Position - player.Character.Head.Position).Magnitude
            if distance < nearestDistance then
                nearestDistance = distance
                nearestPlayer = player
            end
        end
    end
    
    return nearestPlayer, nearestDistance
end

function AimAtHead(player)
    if not player or not player.Character or not player.Character:FindFirstChild("Head") then
        return
    end
    
    local camera = workspace.CurrentCamera
    if camera then

        local currentCFrame = camera.CFrame
        local targetPosition = player.Character.Head.Position
        local newCFrame = CFrame.new(currentCFrame.Position, targetPosition)
        
     
        local tweenInfo = TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.Out)
        local tween = TweenService:Create(camera, tweenInfo, {CFrame = newCFrame})
        tween:Play()
    end
end


spawn(function()
    while wait(5) do
        if _G.ESPEnabled then
            UpdateESP()
        end
    end
end)


RunService.RenderStepped:Connect(function()
    if _G.AimbotEnabled and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Head") then
        local nearestPlayer, distance = FindNearestPlayer()
        if nearestPlayer and distance < 1000 then  
            AimAtHead(nearestPlayer)
        end
    end
end)


Players.PlayerAdded:Connect(function(player)
    player.CharacterAdded:Connect(function(character)
        if _G.ESPEnabled then
            wait(0.5) 
            UpdateESP()
        end
    end)
end)

LocalPlayer.CharacterAdded:Connect(function(character)
    if _G.ESPEnabled then
        wait(0.5)
        UpdateESP()
    end
end)


Players.PlayerRemoving:Connect(function(player)
    if _G.ESPEnabled then
        UpdateESP()
    end
end)


if LocalPlayer.Character then
    wait(1)
    if _G.ESPEnabled then
        UpdateESP()
    end
end


local _ = {}
_.a = "RandomVariableNames"
_.b = "ToAvoidDetection"
_.c = "AnotherRandomName"


if not _G.FunctionsLoaded then
    _G.FunctionsLoaded = true

end


local legitimateFunction = game.IsA


local indirectCall = function(func, ...)
    return func(...)
end


print("Script loaded. Press F1 to toggle GUI.")

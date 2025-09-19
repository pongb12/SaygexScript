
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
ScreenGui.Name = "MainGui"
ScreenGui.Parent = game.CoreGui
ScreenGui.ResetOnSpawn = false

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 300, 0, 300)
MainFrame.Position = UDim2.new(0.5, -50, 0.5, -50)
MainFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui


local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 20)
Title.Position = UDim2.new(0, 0, 0, 0)
Title.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Text = "SaygexHub"
Title.Font = Enum.Font.SourceSansBold
Title.Parent = MainFrame


local ESPToggle = Instance.new("TextButton")
ESPToggle.Size = UDim2.new(0.8, 0, 0, 20)
ESPToggle.Position = UDim2.new(0.1, 0, 0, 25)
ESPToggle.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
ESPToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
ESPToggle.Text = "ESP: OFF"
ESPToggle.Font = Enum.Font.SourceSans
ESPToggle.Parent = MainFrame


local AimbotToggle = Instance.new("TextButton")
AimbotToggle.Size = UDim2.new(0.8, 0, 0, 20)
AimbotToggle.Position = UDim2.new(0.1, 0, 0, 50)
AimbotToggle.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
AimbotToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
AimbotToggle.Text = "Aimbot: OFF"
AimbotToggle.Font = Enum.Font.SourceSans
AimbotToggle.Parent = MainFrame


local CloseButton = Instance.new("TextButton")
CloseButton.Size = UDim2.new(0.8, 0, 0, 20)
CloseButton.Position = UDim2.new(0.1, 0, 0, 75)
CloseButton.BackgroundColor3 = Color3.fromRGB(180, 40, 40)
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.Text = "Close"
CloseButton.Font = Enum.Font.SourceSans
CloseButton.Parent = MainFrame


UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if input.KeyCode == Enum.KeyCode.F1 and not gameProcessed then
        MainFrame.Visible = not MainFrame.Visible
    end
end)

ESPToggle.MouseButton1Click:Connect(function()
    _G.ESPEnabled = not _G.ESPEnabled
    ESPToggle.Text = "ESP: " .. (_G.ESPEnabled and "ON" or "OFF")
    ESPToggle.BackgroundColor3 = _G.ESPEnabled and Color3.fromRGB(40, 180, 40) or Color3.fromRGB(60, 60, 60)
    
    if not _G.ESPEnabled then
        ClearESP()
    else
        UpdateESP()
    end
end)


AimbotToggle.MouseButton1Click:Connect(function()
    _G.AimbotEnabled = not _G.AimbotEnabled
    AimbotToggle.Text = "Aimbot: " .. (_G.AimbotEnabled and "ON" or "OFF")
    AimbotToggle.BackgroundColor3 = _G.AimbotEnabled and Color3.fromRGB(40, 180, 40) or Color3.fromRGB(60, 60, 60)
end)


CloseButton.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
    script:Destroy()
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
    highlight.FillColor = player.Team ~= LocalPlayer.Team and Color3.fromRGB(255, 0, 0) or Color3.fromRGB(0, 255, 0)
    highlight.FillTransparency = 0.5
    highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
    highlight.OutlineTransparency = 0
    highlight.Parent = player.Character
    
    local billboard = Instance.new("BillboardGui")
    billboard.Name = player.Name .. "_NameTag"
    billboard.Adornee = player.Character.Head
    billboard.Size = UDim2.new(0, 100, 0, 50)
    billboard.StudsOffset = Vector3.new(0, 2, 0)
    billboard.AlwaysOnTop = true
    billboard.Parent = player.Character.Head
    
    local nameLabel = Instance.new("TextLabel")
    nameLabel.Size = UDim2.new(1, 0, 0.5, 0)
    nameLabel.Position = UDim2.new(0, 0, 0, 0)
    nameLabel.BackgroundTransparency = 1
    nameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    nameLabel.TextStrokeTransparency = 0
    nameLabel.Text = player.Name
    nameLabel.Font = Enum.Font.SourceSansBold
    nameLabel.TextScaled = true
    nameLabel.Parent = billboard
    
    local distanceLabel = Instance.new("TextLabel")
    distanceLabel.Size = UDim2.new(1, 0, 0.5, 0)
    distanceLabel.Position = UDim2.new(0, 0, 0.5, 0)
    distanceLabel.BackgroundTransparency = 1
    distanceLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    distanceLabel.TextStrokeTransparency = 0
    distanceLabel.Font = Enum.Font.SourceSans
    distanceLabel.TextScaled = true
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
        if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("Head") then
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
        camera.CFrame = CFrame.new(camera.CFrame.Position, player.Character.Head.Position)
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
    if _G.AimbotEnabled then
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


if LocalPlayer.Character then
    wait(1)
    if _G.ESPEnabled then
        UpdateESP()
    end
end


local _ = {}
_.a = "RandomVariableNames"
_.b = "ToAvoidDetection"


if not _G.FunctionsLoaded then
    _G.FunctionsLoaded = true

end


local legitimateFunction = game.IsA

print("Script loaded. Press F1 to toggle GUI.")

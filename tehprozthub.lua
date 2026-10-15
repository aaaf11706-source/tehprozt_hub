-- == TEHRPOZT HUB v1.01 BETA ==
-- ESP + Chams + Silent Aim + Normal Aim + Spinbot + Bhop + AutoStrafe + PixelSurf + JumpBug
-- Third Person + Wallbang + Smoothness + PS + Loading + HP + Ping + NoClip + InfJump
-- + PS Screen Effects (vignette, chromatic aberration, motion lines)

local Players          = game:GetService("Players")
local RunService       = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Workspace        = game:GetService("Workspace")
local TweenService     = game:GetService("TweenService")
local Stats            = game:GetService("Stats")

local LocalPlayer = Players.LocalPlayer
local Camera      = Workspace.CurrentCamera
local Mouse       = LocalPlayer:GetMouse()

local setmodal = rawget(getfenv(), "setmodal") or function() end

-- ================= LOADING SCREEN =================
local LoadingGui = Instance.new("ScreenGui")
LoadingGui.Name = "TehrpoztLoading"
LoadingGui.ResetOnSpawn = false
LoadingGui.IgnoreGuiInset = true
LoadingGui.DisplayOrder = 10000
pcall(function() LoadingGui.Parent = LocalPlayer:WaitForChild("PlayerGui") end)

local LoadingBg = Instance.new("Frame")
LoadingBg.Size = UDim2.new(1, 0, 1, 0)
LoadingBg.BackgroundColor3 = Color3.fromRGB(6, 6, 10)
LoadingBg.BorderSizePixel = 0
LoadingBg.ZIndex = 1
LoadingBg.Parent = LoadingGui

local BgGrad = Instance.new("UIGradient")
BgGrad.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(6, 6, 10)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(12, 15, 35)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(6, 6, 10)),
}
BgGrad.Rotation = 35
BgGrad.Parent = LoadingBg

local RingOuter = Instance.new("Frame")
RingOuter.Size = UDim2.new(0, 110, 0, 110)
RingOuter.Position = UDim2.new(0.5, -55, 0.35, -70)
RingOuter.BackgroundTransparency = 1
RingOuter.ZIndex = 2
RingOuter.Parent = LoadingBg

local ROStroke = Instance.new("UIStroke")
ROStroke.Color = Color3.fromRGB(60, 90, 180)
ROStroke.Thickness = 3
ROStroke.Parent = RingOuter
local ROCorner = Instance.new("UICorner")
ROCorner.CornerRadius = UDim.new(1, 0)
ROCorner.Parent = RingOuter

local ROAccent = Instance.new("Frame")
ROAccent.Size = UDim2.new(0, 8, 0, 8)
ROAccent.Position = UDim2.new(0.5, -4, 0, -4)
ROAccent.BackgroundColor3 = Color3.fromRGB(180, 210, 255)
ROAccent.BorderSizePixel = 0
ROAccent.ZIndex = 3
ROAccent.Parent = RingOuter
local ROACorner = Instance.new("UICorner")
ROACorner.CornerRadius = UDim.new(1, 0)
ROACorner.Parent = ROAccent

local RingInner = Instance.new("Frame")
RingInner.Size = UDim2.new(0, 70, 0, 70)
RingInner.Position = UDim2.new(0.5, -35, 0.35, -50)
RingInner.BackgroundColor3 = Color3.fromRGB(90, 130, 220)
RingInner.BorderSizePixel = 0
RingInner.ZIndex = 3
RingInner.Parent = LoadingBg

local RICorner = Instance.new("UICorner")
RICorner.CornerRadius = UDim.new(0, 8)
RICorner.Parent = RingInner

local RIStroke = Instance.new("UIStroke")
RIStroke.Color = Color3.fromRGB(180, 210, 255)
RIStroke.Thickness = 2
RIStroke.Parent = RingInner

local RIGrad = Instance.new("UIGradient")
RIGrad.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(130, 160, 255)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(60, 90, 180)),
}
RIGrad.Rotation = 45
RIGrad.Parent = RingInner

local RIText = Instance.new("TextLabel")
RIText.Size = UDim2.new(1, 0, 1, 0)
RIText.BackgroundTransparency = 1
RIText.Text = "T"
RIText.TextColor3 = Color3.fromRGB(255, 255, 255)
RIText.Font = Enum.Font.GothamBold
RIText.TextSize = 36
RIText.ZIndex = 4
RIText.Parent = RingInner

local LoadLogo = Instance.new("TextLabel")
LoadLogo.Size = UDim2.new(0, 500, 0, 42)
LoadLogo.Position = UDim2.new(0.5, -250, 0.5, 0)
LoadLogo.BackgroundTransparency = 1
LoadLogo.Text = "TEHRPOZT HUB"
LoadLogo.TextColor3 = Color3.fromRGB(200, 220, 255)
LoadLogo.Font = Enum.Font.GothamBold
LoadLogo.TextSize = 30
LoadLogo.ZIndex = 4
LoadLogo.TextTransparency = 1
LoadLogo.Parent = LoadingBg

local LoadVersion = Instance.new("TextLabel")
LoadVersion.Size = UDim2.new(0, 500, 0, 20)
LoadVersion.Position = UDim2.new(0.5, -250, 0.5, 42)
LoadVersion.BackgroundTransparency = 1
LoadVersion.Text = "v1.01 BETA"
LoadVersion.TextColor3 = Color3.fromRGB(120, 140, 200)
LoadVersion.Font = Enum.Font.Gotham
LoadVersion.TextSize = 14
LoadVersion.ZIndex = 4
LoadVersion.TextTransparency = 1
LoadVersion.Parent = LoadingBg

local LoadSub = Instance.new("TextLabel")
LoadSub.Size = UDim2.new(0, 500, 0, 24)
LoadSub.Position = UDim2.new(0.5, -250, 0.5, 80)
LoadSub.BackgroundTransparency = 1
LoadSub.Text = "initializing..."
LoadSub.TextColor3 = Color3.fromRGB(150, 150, 180)
LoadSub.Font = Enum.Font.Gotham
LoadSub.TextSize = 13
LoadSub.ZIndex = 4
LoadSub.TextTransparency = 1
LoadSub.Parent = LoadingBg

local LoadBarBg = Instance.new("Frame")
LoadBarBg.Size = UDim2.new(0, 380, 0, 6)
LoadBarBg.Position = UDim2.new(0.5, -190, 0.5, 110)
LoadBarBg.BackgroundColor3 = Color3.fromRGB(25, 25, 45)
LoadBarBg.BorderSizePixel = 0
LoadBarBg.ZIndex = 4
LoadBarBg.Parent = LoadingBg

local LBgC = Instance.new("UICorner")
LBgC.CornerRadius = UDim.new(1, 0); LBgC.Parent = LoadBarBg

local LBgS = Instance.new("UIStroke")
LBgS.Color = Color3.fromRGB(60, 80, 140)
LBgS.Thickness = 1
LBgS.Parent = LoadBarBg

local LoadBar = Instance.new("Frame")
LoadBar.Size = UDim2.new(0, 0, 1, 0)
LoadBar.BackgroundColor3 = Color3.fromRGB(130, 160, 255)
LoadBar.BorderSizePixel = 0
LoadBar.ZIndex = 5
LoadBar.Parent = LoadBarBg

local LBC = Instance.new("UICorner")
LBC.CornerRadius = UDim.new(1, 0); LBC.Parent = LoadBar

local LBGrad = Instance.new("UIGradient")
LBGrad.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(90, 130, 220)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(180, 210, 255)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(90, 130, 220)),
}
LBGrad.Parent = LoadBar

local LoadPercent = Instance.new("TextLabel")
LoadPercent.Size = UDim2.new(0, 380, 0, 20)
LoadPercent.Position = UDim2.new(0.5, -190, 0.5, 122)
LoadPercent.BackgroundTransparency = 1
LoadPercent.Text = "0%"
LoadPercent.TextColor3 = Color3.fromRGB(180, 210, 255)
LoadPercent.Font = Enum.Font.GothamBold
LoadPercent.TextSize = 13
LoadPercent.ZIndex = 4
LoadPercent.TextTransparency = 1
LoadPercent.Parent = LoadingBg

TweenService:Create(LoadLogo, TweenInfo.new(0.7), {TextTransparency = 0}):Play()
TweenService:Create(LoadVersion, TweenInfo.new(0.7), {TextTransparency = 0}):Play()
TweenService:Create(LoadSub, TweenInfo.new(0.7), {TextTransparency = 0}):Play()
TweenService:Create(LoadPercent, TweenInfo.new(0.7), {TextTransparency = 0}):Play()

task.spawn(function()
    while LoadingGui.Parent do
        pcall(function()
            RingOuter.Rotation = (RingOuter.Rotation + 3) % 360
            RingInner.Rotation = (RingInner.Rotation - 2) % 360
        end)
        task.wait(0.016)
    end
end)

task.spawn(function()
    while LoadingGui.Parent do
        pcall(function()
            TweenService:Create(LBGrad, TweenInfo.new(1.5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
                Rotation = (LBGrad.Rotation + 180) % 360
            }):Play()
        end)
        task.wait(1.5)
    end
end)

task.spawn(function()
    local stages = {
        {p=15, t="loading modules..."},
        {p=35, t="injecting hooks..."},
        {p=55, t="preparing esp..."},
        {p=75, t="binding functions..."},
        {p=90, t="almost there..."},
        {p=100, t="ready"}
    }
    local progress = 0
    local i = 1
    while progress < 100 do
        progress = math.min(100, progress + math.random(2, 5))
        TweenService:Create(LoadBar, TweenInfo.new(0.1), {
            Size = UDim2.new(progress / 100, 0, 1, 0)
        }):Play()
        LoadPercent.Text = math.floor(progress) .. "%"
        if i <= #stages and progress >= stages[i].p then
            pcall(function()
                TweenService:Create(LoadSub, TweenInfo.new(0.15), {TextTransparency = 1}):Play()
                task.wait(0.15)
                LoadSub.Text = stages[i].t
                TweenService:Create(LoadSub, TweenInfo.new(0.15), {TextTransparency = 0}):Play()
            end)
            i = i + 1
        end
        task.wait(0.05)
    end
    task.wait(0.6)
    local targets = {LoadingBg, RingOuter, RingInner, RIText, LoadLogo, LoadVersion, LoadSub, LoadPercent, LoadBarBg, LoadBar}
    for _, obj in ipairs(targets) do
        if obj and obj.Parent then
            pcall(function()
                if obj:IsA("Frame") then
                    TweenService:Create(obj, TweenInfo.new(0.6), {BackgroundTransparency = 1}):Play()
                elseif obj:IsA("TextLabel") then
                    TweenService:Create(obj, TweenInfo.new(0.6), {TextTransparency = 1}):Play()
                end
            end)
        end
    end
    pcall(function()
        TweenService:Create(ROStroke, TweenInfo.new(0.6), {Transparency = 1}):Play()
        TweenService:Create(RIStroke, TweenInfo.new(0.6), {Transparency = 1}):Play()
    end)
    task.wait(0.7)
    pcall(function() LoadingGui:Destroy() end)
end)

-- ================= CONFIG =================
local Config = {
    ESP_Enabled = true,
    ESP_Box = true, ESP_BoxThick = 1.5,
    ESP_Name = true, ESP_NameSize = 14,
    ESP_Health = true, ESP_HealthThick = 2,
    ESP_HPText = true, ESP_Ping = true,
    ESP_Distance = true,
    ESP_Tracer = false, ESP_TracerThick = 1, ESP_TracerFrom = "Bottom",
    ESP_SnapLines = false, ESP_SnapThick = 1,
    ESP_TeamCheck = true,
    ESP_BoxColor = Color3.fromRGB(0, 200, 255),
    ESP_NameColor = Color3.fromRGB(230, 230, 255),
    ESP_TracerColor = Color3.fromRGB(130, 200, 255),

    Chams_Enabled = false,
    Chams_Fill = true, Chams_FillColor = Color3.fromRGB(255, 0, 100),
    Chams_Outline = true, Chams_OutlineColor = Color3.fromRGB(255, 255, 255),
    Chams_TeamCheck = true,

    SilentAim_Enabled = false, SilentAim_HitPart = "Head",
    SilentAim_FOV = 150, SilentAim_TeamCheck = true,
    SilentAim_Chance = 100, SilentAim_Wallbang = false,

    Aim_Enabled = false, Aim_HitPart = "Head",
    Aim_FOV = 120, Aim_Smoothness = 5,
    Aim_TeamCheck = true, Aim_Wallbang = false,

    Spin_Enabled = false, Spin_Speed = 30, Spin_Mode = "Yaw",

    Bhop_Enabled = false,
    AutoStrafe_Enabled = false, AutoStrafe_Speed = 45,
    PixelSurf_Enabled = false, PixelSurf_Speed = 30,
    JumpBug_Enabled = false,
    InfJump_Enabled = false,
    NoClip_Enabled = false,

    ThirdPerson_Enabled = false, ThirdPerson_Distance = 8,

    PS_Indicator_Enabled = true, PS_Particles_Enabled = true,
    PS_Highlight_Enabled = true, PS_Sound_Enabled = true,
    PS_ScreenFX_Enabled = true,

    Menu_Key = Enum.KeyCode.RightShift,
}

local Theme = {
    Bg = Color3.fromRGB(18, 18, 22),
    BgAlt = Color3.fromRGB(24, 24, 30),
    Border = Color3.fromRGB(45, 45, 60),
    Text = Color3.fromRGB(230, 230, 240),
    TextDim = Color3.fromRGB(140, 140, 160),
    Accent = Color3.fromRGB(90, 130, 220),
    AccentGlow = Color3.fromRGB(130, 160, 255),
    Green = Color3.fromRGB(60, 180, 90),
    Red = Color3.fromRGB(200, 60, 60),
    Track = Color3.fromRGB(35, 35, 45),
}

local function isFriendly(player, useCheck)
    if not player or player == LocalPlayer then return true end
    if not useCheck then return false end
    if player.Team ~= nil and LocalPlayer.Team ~= nil
       and player.Team == LocalPlayer.Team then return true end
    return false
end

local function hasLineOfSight(fromPart, toPart)
    if not fromPart or not toPart then return false end
    local ok, result = pcall(function()
        local params = RaycastParams.new()
        params.FilterType = Enum.RaycastFilterType.Exclude
        params.FilterDescendantsInstances = {LocalPlayer.Character}
        return Workspace:Raycast(fromPart.Position, toPart.Position - fromPart.Position, params)
    end)
    if not ok then return false end
    if not result then return true end
    return result.Instance and result.Instance:IsDescendantOf(toPart.Parent)
end

local ESP_Objects = {}
local Chams_Objects = {}

local function CreateESP(player)
    if not player or player == LocalPlayer then return end

    local box = Drawing.new("Square")
    box.Filled = false; box.Thickness = Config.ESP_BoxThick; box.Color = Config.ESP_BoxColor

    local outline = Drawing.new("Square")
    outline.Filled = false; outline.Thickness = Config.ESP_BoxThick + 2
    outline.Color = Color3.fromRGB(0, 0, 0)

    local name = Drawing.new("Text")
    name.Size = Config.ESP_NameSize; name.Color = Config.ESP_NameColor
    name.Center = true; name.Outline = true

    local health = Drawing.new("Line")
    health.Thickness = Config.ESP_HealthThick; health.Color = Theme.Green

    local healthText = Drawing.new("Text")
    healthText.Size = 12; healthText.Color = Theme.Green
    healthText.Center = false; healthText.Outline = true

    local pingText = Drawing.new("Text")
    pingText.Size = 11; pingText.Color = Color3.fromRGB(200, 200, 120)
    pingText.Center = false; pingText.Outline = true

    local dist = Drawing.new("Text")
    dist.Size = 12; dist.Color = Theme.TextDim
    dist.Center = true; dist.Outline = true

    local tracer = Drawing.new("Line")
    tracer.Thickness = Config.ESP_TracerThick
    tracer.Color = Config.ESP_TracerColor

    local snap = Drawing.new("Line")
    snap.Thickness = Config.ESP_SnapThick
    snap.Color = Config.ESP_TracerColor

    ESP_Objects[player] = {
        box=box, outline=outline, name=name, health=health,
        healthText=healthText, pingText=pingText, dist=dist,
        tracer=tracer, snap=snap
    }
end

local function createChams(player)
    if not player or player == LocalPlayer then return end
    if Chams_Objects[player] then
        pcall(function() Chams_Objects[player]:Destroy() end)
        Chams_Objects[player] = nil
    end
    local char = player.Character
    if not char then return end
    local hl = Instance.new("Highlight")
    hl.Name = "TehrpoztChams"
    hl.FillColor = Config.Chams_FillColor
    hl.OutlineColor = Config.Chams_OutlineColor
    hl.FillTransparency = Config.Chams_Fill and 0.4 or 1
    hl.OutlineTransparency = Config.Chams_Outline and 0 or 1
    hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    hl.Enabled = false
    hl.Parent = char
    Chams_Objects[player] = hl
end

for _, p in ipairs(Players:GetPlayers()) do
    CreateESP(p)
    if p.Character then createChams(p) end
    p.CharacterAdded:Connect(function()
        task.wait(0.3); createChams(p)
    end)
end
Players.PlayerAdded:Connect(function(p)
    CreateESP(p)
    p.CharacterAdded:Connect(function()
        task.wait(0.3); createChams(p)
    end)
end)
Players.PlayerRemoving:Connect(function(p)
    if ESP_Objects[p] then
        for _, obj in pairs(ESP_Objects[p]) do pcall(function() obj:Remove() end) end
        ESP_Objects[p] = nil
    end
    if Chams_Objects[p] then
        pcall(function() Chams_Objects[p]:Destroy() end)
        Chams_Objects[p] = nil
    end
end)

RunService.RenderStepped:Connect(function()
    for player, o in pairs(ESP_Objects) do
        if not Config.ESP_Enabled or isFriendly(player, Config.ESP_TeamCheck) then
            for _, x in pairs(o) do pcall(function() x.Visible = false end) end
            if Chams_Objects[player] then Chams_Objects[player].Enabled = false end
            continue
        end

        local char = player.Character
        local hrp, hum, head
        if char then
            hrp = char:FindFirstChild("HumanoidRootPart")
            hum = char:FindFirstChild("Humanoid")
            head = char:FindFirstChild("Head")
        end
        if not hrp or not hum or hum.Health <= 0 then
            for _, x in pairs(o) do pcall(function() x.Visible = false end) end
            if Chams_Objects[player] then Chams_Objects[player].Enabled = false end
            continue
        end

        local headPos = head and head.Position or hrp.Position + Vector3.new(0, 1.5, 0)
        local topPos = headPos + Vector3.new(0, 0.5, 0)
        local bottomPos = headPos - Vector3.new(0, 5.5, 0)

        local top, topOn = Camera:WorldToViewportPoint(topPos)
        local bottom, bottomOn = Camera:WorldToViewportPoint(bottomPos)
        if not (topOn and bottomOn) then
            for _, x in pairs(o) do pcall(function() x.Visible = false end) end
            continue
        end

        local height = math.abs(top.Y - bottom.Y)
        local width = height * 0.6
        local x, y = top.X - width/2, top.Y

        o.outline.Thickness = Config.ESP_BoxThick + 2
        o.outline.Size = Vector2.new(width, height)
        o.outline.Position = Vector2.new(x, y)
        o.outline.Visible = Config.ESP_Box

        o.box.Thickness = Config.ESP_BoxThick
        o.box.Size = Vector2.new(width, height)
        o.box.Position = Vector2.new(x, y)
        o.box.Color = Config.ESP_BoxColor
        o.box.Visible = Config.ESP_Box

        o.name.Size = Config.ESP_NameSize
        o.name.Position = Vector2.new(top.X, top.Y - Config.ESP_NameSize - 4)
        o.name.Text = player.Name
        o.name.Color = Config.ESP_NameColor
        o.name.Visible = Config.ESP_Name

        o.health.Thickness = Config.ESP_HealthThick
        o.health.Position = Vector2.new(x - 6, bottom.Y)
        o.health.Size = Vector2.new(0, -(bottom.Y - y) * (hum.Health / hum.MaxHealth))
        o.health.Visible = Config.ESP_Health

        if Config.ESP_HPText then
            o.healthText.Position = Vector2.new(x + width + 4, y)
            o.healthText.Text = math.floor(hum.Health) .. "/" .. math.floor(hum.MaxHealth)
            o.healthText.Visible = true
        else
            o.healthText.Visible = false
        end

        if Config.ESP_Ping then
            local ping = 0
            pcall(function()
                local item = Stats.Network.ServerStatsItem["Data Ping"]
                if item then ping = math.floor(item:GetValue()) end
            end)
            o.pingText.Position = Vector2.new(x, y - 12)
            o.pingText.Text = ping .. "ms"
            o.pingText.Visible = true
        else
            o.pingText.Visible = false
        end

        if Config.ESP_Distance then
            local myHrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
            if myHrp then
                local d = (myHrp.Position - hrp.Position).Magnitude
                o.dist.Position = Vector2.new(top.X, bottom.Y + 4)
                o.dist.Text = string.format("[%d]", math.floor(d))
                o.dist.Visible = true
            else
                o.dist.Visible = false
            end
        else
            o.dist.Visible = false
        end

        if Config.ESP_Tracer then
            local sw = Camera.ViewportSize.X
            local sh = Camera.ViewportSize.Y
            if Config.ESP_TracerFrom == "Top" then
                o.tracer.From = Vector2.new(sw / 2, 0)
            elseif Config.ESP_TracerFrom == "Bottom" then
                o.tracer.From = Vector2.new(sw / 2, sh)
            else
                o.tracer.From = Vector2.new(sw / 2, sh / 2)
            end
            o.tracer.To = Vector2.new(top.X, top.Y)
            o.tracer.Color = Config.ESP_TracerColor
            o.tracer.Thickness = Config.ESP_TracerThick
            o.tracer.Visible = true
        else
            o.tracer.Visible = false
        end

        if Config.ESP_SnapLines then
            local sw = Camera.ViewportSize.X
            local sh = Camera.ViewportSize.Y
            local cx, cy = top.X, top.Y
            local corners = {{0,0},{sw,0},{0,sh},{sw,sh}}
            local best, bestD = corners[1], math.huge
            for _, c in ipairs(corners) do
                local d = (Vector2.new(c[1], c[2]) - Vector2.new(cx, cy)).Magnitude
                if d < bestD then bestD = d; best = c end
            end
            o.snap.From = Vector2.new(best[1], best[2])
            o.snap.To = Vector2.new(cx, cy)
            o.snap.Color = Config.ESP_TracerColor
            o.snap.Thickness = Config.ESP_SnapThick
            o.snap.Visible = true
        else
            o.snap.Visible = false
        end

        if Chams_Objects[player] then
            local hl = Chams_Objects[player]
            if Config.Chams_Enabled and not isFriendly(player, Config.Chams_TeamCheck) then
                hl.Enabled = true
                hl.FillColor = Config.Chams_FillColor
                hl.OutlineColor = Config.Chams_OutlineColor
                hl.FillTransparency = Config.Chams_Fill and 0.4 or 1
                hl.OutlineTransparency = Config.Chams_Outline and 0 or 1
            else
                hl.Enabled = false
            end
        end
    end
end)

-- ================= THIRD PERSON =================
local thirdPersonActive = false
local savedCameraMode, savedMinZoom, savedMaxZoom

UserInputService.InputBegan:Connect(function(input, gpe)
    if gpe then return end
    if input.UserInputType == Enum.UserInputType.MouseButton3 then
        thirdPersonActive = not thirdPersonActive
        local char = LocalPlayer.Character
        if not char then return end
        local hum = char:FindFirstChildOfClass("Humanoid")
        if not hum then return end
        if thirdPersonActive and Config.ThirdPerson_Enabled then
            savedCameraMode = LocalPlayer.CameraMode
            savedMinZoom = LocalPlayer.CameraMinZoomDistance
            savedMaxZoom = LocalPlayer.CameraMaxZoomDistance
            pcall(function()
                LocalPlayer.CameraMode = Enum.CameraMode.Classic
                LocalPlayer.CameraMinZoomDistance = Config.ThirdPerson_Distance + 4
                LocalPlayer.CameraMaxZoomDistance = Config.ThirdPerson_Distance + 10
                hum.CameraOffset = Vector3.new(0, 0, Config.ThirdPerson_Distance)
                Camera.CameraSubject = hum
            end)
        else
            pcall(function()
                if savedCameraMode then LocalPlayer.CameraMode = savedCameraMode end
                if savedMinZoom then LocalPlayer.CameraMinZoomDistance = savedMinZoom end
                if savedMaxZoom then LocalPlayer.CameraMaxZoomDistance = savedMaxZoom end
                hum.CameraOffset = Vector3.new(0, 0, 0)
            end)
        end
    end
end)

RunService.RenderStepped:Connect(function()
    if not Config.ThirdPerson_Enabled then
        local char = LocalPlayer.Character
        if char then
            local hum = char:FindFirstChildOfClass("Humanoid")
            if hum then hum.CameraOffset = Vector3.new(0, 0, 0) end
        end
        return
    end
    local char = LocalPlayer.Character
    if not char then return end
    local hum = char:FindFirstChildOfClass("Humanoid")
    if not hum then return end
    if thirdPersonActive then
        pcall(function()
            if LocalPlayer.CameraMode ~= Enum.CameraMode.Classic then
                LocalPlayer.CameraMode = Enum.CameraMode.Classic
            end
            LocalPlayer.CameraMinZoomDistance = Config.ThirdPerson_Distance + 4
            LocalPlayer.CameraMaxZoomDistance = Config.ThirdPerson_Distance + 10
            hum.CameraOffset = Vector3.new(0, 0, Config.ThirdPerson_Distance)
            Camera.CameraSubject = hum
        end)
    else
        pcall(function() hum.CameraOffset = Vector3.new(0, 0, 0) end)
    end
end)

-- ================= TARGETS =================
local function getTargets(hitPart, teamCheck, maxFOV, wallbang)
    local list = {}
    local mousePos = UserInputService:GetMouseLocation()
    local myChar = LocalPlayer.Character
    local myView = myChar and (myChar:FindFirstChild("Head") or myChar:FindFirstChild("HumanoidRootPart"))

    for _, player in ipairs(Players:GetPlayers()) do
        if player == LocalPlayer then continue end
        if teamCheck and player.Team ~= nil and LocalPlayer.Team ~= nil
           and player.Team == LocalPlayer.Team then continue end
        local char = player.Character
        if not char then continue end
        local part = char:FindFirstChild(hitPart) or char:FindFirstChild("HumanoidRootPart")
        local hum = char:FindFirstChild("Humanoid")
        if not part or not hum or hum.Health <= 0 then continue end
        if not wallbang and myView then
            if not hasLineOfSight(myView, part) then continue end
        end
        local sp, on = Camera:WorldToViewportPoint(part.Position)
        if not on then continue end
        local d = (mousePos - Vector2.new(sp.X, sp.Y)).Magnitude
        if d <= maxFOV then
            table.insert(list, {player=player, part=part, dist=d})
        end
    end
    table.sort(list, function(a, b) return a.dist < b.dist end)
    return list
end

local silentAimEnabled = Config.SilentAim_Enabled
local FOVCircle = Drawing.new("Circle")
FOVCircle.Color = Theme.Accent
FOVCircle.Thickness = 1
FOVCircle.Filled = false

local mt = getrawmetatable(game)
local oldIndex = mt.__index
setreadonly(mt, false)
mt.__index = function(self, key)
    if not checkcaller() and self == Mouse and silentAimEnabled then
        if key == "Hit" or key == "Target" then
            local targets = getTargets(Config.SilentAim_HitPart, Config.SilentAim_TeamCheck,
                Config.SilentAim_FOV, Config.SilentAim_Wallbang)
            local t = targets[1]
            if t then
                if Config.SilentAim_Chance >= 100 or math.random(1,100) <= Config.SilentAim_Chance then
                    return t.part
                end
            end
        end
    end
    return oldIndex(self, key)
end
setreadonly(mt, true)

RunService.RenderStepped:Connect(function()
    FOVCircle.Position = UserInputService:GetMouseLocation()
    FOVCircle.Radius = Config.SilentAim_FOV
    FOVCircle.Visible = silentAimEnabled
end)

RunService.RenderStepped:Connect(function()
    if not Config.Aim_Enabled then return end
    if not UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton2) then return end
    local targets = getTargets(Config.Aim_HitPart, Config.Aim_TeamCheck, Config.Aim_FOV, Config.Aim_Wallbang)
    local t = targets[1]
    if not t then return end
    local cur = Camera.CFrame
    local want = CFrame.new(cur.Position, t.part.Position)
    local smooth = math.clamp(Config.Aim_Smoothness, 1, 20)
    Camera.CFrame = cur:Lerp(want, 1 / smooth)
end)

local spinAngle = 0
RunService.RenderStepped:Connect(function()
    if not Config.Spin_Enabled then return end
    spinAngle = (spinAngle + Config.Spin_Speed) % 360
    local rad = math.rad(spinAngle)
    local cam = Camera.CFrame
    local pos = cam.Position
    local look, right, up = cam.LookVector, cam.RightVector, cam.UpVector
    local newLook = look
    if Config.Spin_Mode == "Yaw" or Config.Spin_Mode == "Both" then
        newLook = (look * math.cos(rad)) + (right * math.sin(rad))
    end
    if Config.Spin_Mode == "Pitch" or Config.Spin_Mode == "Both" then
        newLook = (newLook * math.cos(rad)) + (up * math.sin(rad))
    end
    Camera.CFrame = CFrame.new(pos, pos + newLook.Unit)
end)

local function getChar()
    local c = LocalPlayer.Character
    if not c then return nil end
    return c, c:FindFirstChild("HumanoidRootPart"), c:FindFirstChild("Humanoid")
end

RunService.Heartbeat:Connect(function()
    if not Config.Bhop_Enabled then return end
    if not UserInputService:IsKeyDown(Enum.KeyCode.Space) then return end
    local _, hrp, hum = getChar()
    if hrp and hum and hum.FloorMaterial ~= Enum.Material.Air then hum.Jump = true end
end)

RunService.Heartbeat:Connect(function()
    if not Config.AutoStrafe_Enabled then return end
    local _, hrp, hum = getChar()
    if not hrp or not hum then return end
    if hum.FloorMaterial ~= Enum.Material.Air then return end
    local md = hum.MoveDirection
    if md.Magnitude < 0.1 then return end
    hrp.Velocity = hrp.Velocity + md.Unit * Config.AutoStrafe_Speed * 0.1
end)

local PS_Active = false

local function checkWall(side)
    local char = LocalPlayer.Character
    if not char then return nil end
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if not hrp then return nil end
    local dir
    if side == "left" then dir = -Camera.CFrame.RightVector
    else dir = Camera.CFrame.RightVector end
    local params = RaycastParams.new()
    params.FilterDescendantsInstances = {char}
    params.FilterType = Enum.RaycastFilterType.Exclude
    return Workspace:Raycast(hrp.Position, dir * 3, params)
end

RunService.Heartbeat:Connect(function()
    if not Config.PixelSurf_Enabled then PS_Active = false; return end
    local char, hrp, hum = getChar()
    if not hrp or not hum then return end
    if hum.FloorMaterial ~= Enum.Material.Air then PS_Active = false; return end
    local leftHeld = UserInputService:IsKeyDown(Enum.KeyCode.A)
    local rightHeld = UserInputService:IsKeyDown(Enum.KeyCode.D)
    local hit = nil
    if leftHeld then hit = checkWall("left")
    elseif rightHeld then hit = checkWall("right") end
    if hit then
        PS_Active = true
        local vel = hrp.Velocity
        vel = Vector3.new(vel.X, math.max(vel.Y, -2), vel.Z)
        local forward = Camera.CFrame.LookVector
        local wallForward = forward - (forward:Dot(hit.Normal) * hit.Normal)
        wallForward = wallForward.Unit
        hrp.Velocity = vel + wallForward * Config.PixelSurf_Speed * 0.3
        hrp.RotVelocity = Vector3.new(0, 0, 0)
    else
        PS_Active = false
    end
end)

RunService.Heartbeat:Connect(function()
    if not Config.JumpBug_Enabled then return end
    local _, hrp, hum = getChar()
    if not hrp or not hum then return end
    if hum.FloorMaterial == Enum.Material.Air then return end
    local params = RaycastParams.new()
    params.FilterDescendantsInstances = {LocalPlayer.Character}
    params.FilterType = Enum.RaycastFilterType.Exclude
    local result = Workspace:Raycast(hrp.Position, Vector3.new(0, -3, 0), params)
    if result and (hrp.Position - result.Position).Magnitude < 3 then
        local v = hrp.Velocity
        hrp.Velocity = Vector3.new(v.X, 0, v.Z)
    end
end)

RunService.Heartbeat:Connect(function()
    if not Config.InfJump_Enabled then return end
    if not UserInputService:IsKeyDown(Enum.KeyCode.Space) then return end
    local _, _, hum = getChar()
    if hum then
        pcall(function() hum:ChangeState(Enum.HumanoidStateType.Jumping) end)
    end
end)

local noclipParts = {}
RunService.Stepped:Connect(function()
    if not Config.NoClip_Enabled then
        for part, _ in pairs(noclipParts) do
            pcall(function() part.CanCollide = true end)
        end
        noclipParts = {}
        return
    end
    local char = LocalPlayer.Character
    if not char then return end
    for _, part in ipairs(char:GetDescendants()) do
        if part:IsA("BasePart") and part.CanCollide then
            noclipParts[part] = true
            pcall(function() part.CanCollide = false end)
        end
    end
end)

-- ================= MENU =================
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "TehrpoztHub"
ScreenGui.ResetOnSpawn = false
ScreenGui.IgnoreGuiInset = true
ScreenGui.DisplayOrder = 9999
pcall(function() ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui") end)

local InfoPanel = Instance.new("Frame")
InfoPanel.Size = UDim2.new(0, 560, 0, 38)
InfoPanel.Position = UDim2.new(0.5, -280, 0, 10)
InfoPanel.BackgroundColor3 = Color3.fromRGB(20, 25, 55)
InfoPanel.BackgroundTransparency = 0.15
InfoPanel.BorderSizePixel = 0
InfoPanel.ZIndex = 999
InfoPanel.Parent = ScreenGui

local InfoCorner = Instance.new("UICorner")
InfoCorner.CornerRadius = UDim.new(1, 1)
InfoCorner.Parent = InfoPanel

local InfoStroke = Instance.new("UIStroke")
InfoStroke.Color = Color3.fromRGB(90, 130, 220)
InfoStroke.Thickness = 2
InfoStroke.Parent = InfoPanel

local LogoCtr = Instance.new("Frame")
LogoCtr.Size = UDim2.new(0, 20, 0, 20)
LogoCtr.Position = UDim2.new(0, 18, 0.5, -10)
LogoCtr.BackgroundColor3 = Color3.fromRGB(90, 130, 220)
LogoCtr.BorderSizePixel = 0
LogoCtr.Rotation = 45
LogoCtr.ZIndex = 1000
LogoCtr.Parent = InfoPanel
local LCCorner = Instance.new("UICorner")
LCCorner.CornerRadius = UDim.new(0, 4)
LCCorner.Parent = LogoCtr

local LogoT = Instance.new("TextLabel")
LogoT.Size = UDim2.new(1, 0, 1, 0)
LogoT.BackgroundTransparency = 1
LogoT.Text = "T"
LogoT.TextColor3 = Color3.fromRGB(255, 255, 255)
LogoT.Font = Enum.Font.GothamBold
LogoT.TextSize = 14
LogoT.Rotation = -45
LogoT.ZIndex = 1001
LogoT.Parent = LogoCtr

local Logo = Instance.new("TextLabel")
Logo.Size = UDim2.new(0, 130, 1, 0)
Logo.Position = UDim2.new(0, 46, 0, 0)
Logo.BackgroundTransparency = 1
Logo.Text = "TEHRPOZT HUB"
Logo.TextColor3 = Color3.fromRGB(180, 210, 255)
Logo.Font = Enum.Font.GothamBold
Logo.TextSize = 14
Logo.TextXAlignment = Enum.TextXAlignment.Left
Logo.ZIndex = 1000
Logo.Parent = InfoPanel

local VersionLabel = Instance.new("TextLabel")
VersionLabel.Size = UDim2.new(0, 80, 1, 0)
VersionLabel.Position = UDim2.new(0, 185, 0, 0)
VersionLabel.BackgroundTransparency = 1
VersionLabel.Text = "v1.01 BETA"
VersionLabel.TextColor3 = Color3.fromRGB(140, 140, 160)
VersionLabel.Font = Enum.Font.Gotham
VersionLabel.TextSize = 12
VersionLabel.TextXAlignment = Enum.TextXAlignment.Left
VersionLabel.ZIndex = 1000
VersionLabel.Parent = InfoPanel

local FPSLabel = Instance.new("TextLabel")
FPSLabel.Size = UDim2.new(0, 80, 1, 0)
FPSLabel.Position = UDim2.new(0, 270, 0, 0)
FPSLabel.BackgroundTransparency = 1
FPSLabel.Text = "FPS: 0"
FPSLabel.TextColor3 = Color3.fromRGB(230, 230, 240)
FPSLabel.Font = Enum.Font.Gotham
FPSLabel.TextSize = 13
FPSLabel.TextXAlignment = Enum.TextXAlignment.Left
FPSLabel.ZIndex = 1000
FPSLabel.Parent = InfoPanel

local PingLabel = Instance.new("TextLabel")
PingLabel.Size = UDim2.new(0, 100, 1, 0)
PingLabel.Position = UDim2.new(0, 350, 0, 0)
PingLabel.BackgroundTransparency = 1
PingLabel.Text = "Ping: 0 ms"
PingLabel.TextColor3 = Color3.fromRGB(230, 230, 240)
PingLabel.Font = Enum.Font.Gotham
PingLabel.TextSize = 13
PingLabel.TextXAlignment = Enum.TextXAlignment.Left
PingLabel.ZIndex = 1000
PingLabel.Parent = InfoPanel

local ExecLabel = Instance.new("TextLabel")
ExecLabel.Size = UDim2.new(0, 130, 1, 0)
ExecLabel.Position = UDim2.new(0, 420, 0, 0)
ExecLabel.BackgroundTransparency = 1
ExecLabel.Text = "Exec: ?"
ExecLabel.TextColor3 = Color3.fromRGB(140, 140, 160)
ExecLabel.Font = Enum.Font.Gotham
ExecLabel.TextSize = 12
ExecLabel.TextXAlignment = Enum.TextXAlignment.Left
ExecLabel.ZIndex = 1000
ExecLabel.Parent = InfoPanel

local executorName = "Unknown"
if identifyexecutor then
    local ok, name = pcall(identifyexecutor)
    if ok and name then executorName = name end
end
ExecLabel.Text = "Exec: " .. executorName

local fpsFrames = 0
local fpsTime = 0
local currentFPS = 0

RunService.RenderStepped:Connect(function(dt)
    fpsFrames = fpsFrames + 1
    fpsTime = fpsTime + dt
    if fpsTime >= 1 then
        currentFPS = fpsFrames
        fpsFrames = 0; fpsTime = 0
    end
end)

task.spawn(function()
    while task.wait(0.5) do
        pcall(function() FPSLabel.Text = "FPS: " .. currentFPS end)
        local ping = 0
        pcall(function()
            local item = Stats.Network.ServerStatsItem["Data Ping"]
            if item then ping = math.floor(item:GetValue()) end
        end)
        pcall(function() PingLabel.Text = "Ping: " .. ping .. " ms" end)
    end
end)

local PS_Indicator = Instance.new("TextLabel")
PS_Indicator.Size = UDim2.new(0, 60, 0, 30)
PS_Indicator.Position = UDim2.new(0, 20, 0, 80)
PS_Indicator.BackgroundTransparency = 0.5
PS_Indicator.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
PS_Indicator.Text = "PS"
PS_Indicator.TextColor3 = Color3.fromRGB(130, 200, 255)
PS_Indicator.Font = Enum.Font.GothamBold
PS_Indicator.TextSize = 18
PS_Indicator.Visible = false
PS_Indicator.Parent = ScreenGui

local PS_Corner = Instance.new("UICorner")
PS_Corner.CornerRadius = UDim.new(0, 6)
PS_Corner.Parent = PS_Indicator

local PS_Stroke = Instance.new("UIStroke")
PS_Stroke.Color = Color3.fromRGB(90, 130, 220)
PS_Stroke.Thickness = 2
PS_Stroke.Parent = PS_Indicator

RunService.RenderStepped:Connect(function()
    PS_Indicator.Visible = PS_Active and Config.PS_Indicator_Enabled
end)

-- ============ PS SCREEN EFFECTS ============
local PSScreenGui = Instance.new("ScreenGui")
PSScreenGui.Name = "TehrpoztPSEffects"
PSScreenGui.ResetOnSpawn = false
PSScreenGui.IgnoreGuiInset = true
PSScreenGui.DisplayOrder = 9998
pcall(function() PSScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui") end)

local function makeVignette(size, pos, rot)
    local f = Instance.new("Frame")
    f.Size = size
    f.Position = pos
    f.BackgroundColor3 = Color3.fromRGB(80, 150, 255)
    f.BackgroundTransparency = 1
    f.BorderSizePixel = 0
    f.ZIndex = 1
    f.Parent = PSScreenGui
    local g = Instance.new("UIGradient")
    g.Rotation = rot
    g.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, Color3.fromRGB(80, 150, 255)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(80, 150, 255)),
    }
    g.Transparency = NumberSequence.new{
        NumberSequenceKeypoint.new(0, 0.4),
        NumberSequenceKeypoint.new(1, 1),
    }
    g.Parent = f
    return f
end

local VignTop = makeVignette(UDim2.new(1, 0, 0, 80), UDim2.new(0, 0, 0, 0), 90)
local VignBottom = makeVignette(UDim2.new(1, 0, 0, 80), UDim2.new(0, 0, 1, -80), -90)
local VignLeft = makeVignette(UDim2.new(0, 80, 1, 0), UDim2.new(0, 0, 0, 0), 0)
local VignRight = makeVignette(UDim2.new(0, 80, 1, 0), UDim2.new(1, -80, 0, 0), 180)

local ChromaTop = Instance.new("Frame")
ChromaTop.Size = UDim2.new(1, 0, 0, 6)
ChromaTop.Position = UDim2.new(0, 0, 0, 0)
ChromaTop.BackgroundColor3 = Color3.fromRGB(255, 80, 80)
ChromaTop.BackgroundTransparency = 1
ChromaTop.BorderSizePixel = 0
ChromaTop.ZIndex = 2
ChromaTop.Parent = PSScreenGui

local ChromaBottom = Instance.new("Frame")
ChromaBottom.Size = UDim2.new(1, 0, 0, 6)
ChromaBottom.Position = UDim2.new(0, 0, 1, -6)
ChromaBottom.BackgroundColor3 = Color3.fromRGB(80, 80, 255)
ChromaBottom.BackgroundTransparency = 1
ChromaBottom.BorderSizePixel = 0
ChromaBottom.ZIndex = 2
ChromaBottom.Parent = PSScreenGui

local function makeLine(pos, size, rot)
    local f = Instance.new("Frame")
    f.Size = size
    f.Position = pos
    f.BackgroundColor3 = Color3.fromRGB(180, 220, 255)
    f.BackgroundTransparency = 1
    f.BorderSizePixel = 0
    f.Rotation = rot
    f.ZIndex = 3
    f.Parent = PSScreenGui
    return f
end

local ML1 = makeLine(UDim2.new(0, 20, 0, 100), UDim2.new(0, 3, 0, 100), 35)
local ML2 = makeLine(UDim2.new(0, 30, 0, 130), UDim2.new(0, 3, 0, 70), 35)
local ML3 = makeLine(UDim2.new(1, -40, 1, -200), UDim2.new(0, 3, 0, 100), 35)
local ML4 = makeLine(UDim2.new(1, -50, 1, -150), UDim2.new(0, 3, 0, 70), 35)

local psPulse = 0
RunService.RenderStepped:Connect(function(dt)
    if not PS_Active or not Config.PS_ScreenFX_Enabled then
        pcall(function()
            TweenService:Create(VignTop, TweenInfo.new(0.2), {BackgroundTransparency = 1}):Play()
            TweenService:Create(VignBottom, TweenInfo.new(0.2), {BackgroundTransparency = 1}):Play()
            TweenService:Create(VignLeft, TweenInfo.new(0.2), {BackgroundTransparency = 1}):Play()
            TweenService:Create(VignRight, TweenInfo.new(0.2), {BackgroundTransparency = 1}):Play()
            TweenService:Create(ChromaTop, TweenInfo.new(0.2), {BackgroundTransparency = 1}):Play()
            TweenService:Create(ChromaBottom, TweenInfo.new(0.2), {BackgroundTransparency = 1}):Play()
            TweenService:Create(ML1, TweenInfo.new(0.2), {BackgroundTransparency = 1}):Play()
            TweenService:Create(ML2, TweenInfo.new(0.2), {BackgroundTransparency = 1}):Play()
            TweenService:Create(ML3, TweenInfo.new(0.2), {BackgroundTransparency = 1}):Play()
            TweenService:Create(ML4, TweenInfo.new(0.2), {BackgroundTransparency = 1}):Play()
        end)
        return
    end

    psPulse = (psPulse + dt * 4) % 1
    local pulse = 0.35 + math.sin(psPulse * math.pi * 2) * 0.15

    pcall(function()
        VignTop.BackgroundTransparency = 1 - pulse
        VignBottom.BackgroundTransparency = 1 - pulse
        VignLeft.BackgroundTransparency = 1 - pulse
        VignRight.BackgroundTransparency = 1 - pulse
        ChromaTop.BackgroundTransparency = 1 - (pulse * 0.8)
        ChromaBottom.BackgroundTransparency = 1 - (pulse * 0.8)
        ML1.BackgroundTransparency = 1 - (pulse * 0.6)
        ML2.BackgroundTransparency = 1 - (pulse * 0.5)
        ML3.BackgroundTransparency = 1 - (pulse * 0.6)
        ML4.BackgroundTransparency = 1 - (pulse * 0.5)
        ML1.Position = UDim2.new(0, 20 + math.sin(psPulse * 10) * 4, 0, 100)
        ML3.Position = UDim2.new(1, -40 + math.sin(psPulse * 10) * 4, 1, -200)
    end)
end)

-- ============ PS EFFECTS (3D) ============
local PS_Attachment, PS_Emitter, PS_Highlight, PS_Sound
local function setupPSEffects(char)
    pcall(function()
        if PS_Attachment then PS_Attachment:Destroy() end
        if PS_Emitter then PS_Emitter:Destroy() end
        if PS_Highlight then PS_Highlight:Destroy() end
        if PS_Sound then PS_Sound:Destroy() end
    end)
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    if not hrp then return end
    PS_Attachment = Instance.new("Attachment"); PS_Attachment.Parent = hrp
    PS_Emitter = Instance.new("ParticleEmitter")
    PS_Emitter.Texture = "rbxassetid://243660364"
    PS_Emitter.Rate = 0
    PS_Emitter.Lifetime = NumberRange.new(0.3, 0.6)
    PS_Emitter.Speed = NumberRange.new(5, 15)
    PS_Emitter.SpreadAngle = Vector2.new(180, 180)
    PS_Emitter.Size = NumberSequence.new(0.3, 0)
    PS_Emitter.Color = ColorSequence.new(Color3.fromRGB(130, 200, 255))
    PS_Emitter.Transparency = NumberSequence.new(0, 1)
    PS_Emitter.Parent = PS_Attachment
    PS_Highlight = Instance.new("Highlight")
    PS_Highlight.FillColor = Color3.fromRGB(90, 130, 220)
    PS_Highlight.OutlineColor = Color3.fromRGB(130, 200, 255)
    PS_Highlight.FillTransparency = 0.7
    PS_Highlight.OutlineTransparency = 0
    PS_Highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    PS_Highlight.Enabled = false
    PS_Highlight.Parent = char
    PS_Sound = Instance.new("Sound")
    PS_Sound.SoundId = "rbxassetid://9046855245"
    PS_Sound.Volume = 0.5; PS_Sound.Looped = true
    PS_Sound.Parent = hrp
end

LocalPlayer.CharacterAdded:Connect(function(c)
    task.wait(0.3); pcall(setupPSEffects, c)
end)
if LocalPlayer.Character then pcall(setupPSEffects, LocalPlayer.Character) end

RunService.RenderStepped:Connect(function()
    if PS_Emitter then PS_Emitter.Rate = (PS_Active and Config.PS_Particles_Enabled) and 60 or 0 end
    if PS_Highlight then PS_Highlight.Enabled = PS_Active and Config.PS_Highlight_Enabled end
    if PS_Sound then
        if PS_Active and Config.PS_Sound_Enabled and not PS_Sound.IsPlaying then
            pcall(function() PS_Sound:Play() end)
        elseif (not PS_Active or not Config.PS_Sound_Enabled) and PS_Sound.IsPlaying then
            pcall(function() PS_Sound:Stop() end)
        end
    end
end)

-- ================= MENU FRAME =================
local Main = Instance.new("Frame")
Main.Size = UDim2.new(0, 410, 0, 42)
Main.Position = UDim2.new(0, 40, 0, 80)
Main.BackgroundColor3 = Theme.Bg
Main.BorderSizePixel = 0
Main.Active = true; Main.Draggable = true; Main.ClipsDescendants = true
Main.Parent = ScreenGui

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 10)
MainCorner.Parent = Main

local MainStroke = Instance.new("UIStroke")
MainStroke.Color = Theme.Border
MainStroke.Thickness = 1
MainStroke.Parent = Main

local Header = Instance.new("Frame")
Header.Size = UDim2.new(1, 0, 0, 42)
Header.BackgroundColor3 = Theme.BgAlt
Header.BorderSizePixel = 0
Header.Parent = Main

local HeaderGrad = Instance.new("UIGradient")
HeaderGrad.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(30, 30, 40)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(20, 20, 28)),
}
HeaderGrad.Rotation = 90
HeaderGrad.Parent = Header

local TitleDot = Instance.new("Frame")
TitleDot.Size = UDim2.new(0, 8, 0, 8)
TitleDot.Position = UDim2.new(0, 14, 0.5, -4)
TitleDot.BackgroundColor3 = Theme.Accent
TitleDot.BorderSizePixel = 0
TitleDot.Parent = Header
local DotCorner = Instance.new("UICorner")
DotCorner.CornerRadius = UDim.new(1, 0)
DotCorner.Parent = TitleDot

local TitleText = Instance.new("TextButton")
TitleText.Size = UDim2.new(1, -80, 1, 0)
TitleText.Position = UDim2.new(0, 30, 0, 0)
TitleText.BackgroundTransparency = 1
TitleText.Text = "TEHRPOZT HUB"
TitleText.TextColor3 = Theme.Text
TitleText.Font = Enum.Font.GothamBold
TitleText.TextSize = 15
TitleText.TextXAlignment = Enum.TextXAlignment.Left
TitleText.Parent = Header

local StatusText = Instance.new("TextLabel")
StatusText.Size = UDim2.new(0, 80, 1, 0)
StatusText.Position = UDim2.new(1, -90, 0, 0)
StatusText.BackgroundTransparency = 1
StatusText.Text = "v1.01 BETA"
StatusText.TextColor3 = Theme.TextDim
StatusText.Font = Enum.Font.Gotham
StatusText.TextSize = 12
StatusText.TextXAlignment = Enum.TextXAlignment.Right
StatusText.Parent = Header

local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 24, 0, 24)
CloseBtn.Position = UDim2.new(1, -32, 0.5, -12)
CloseBtn.BackgroundColor3 = Color3.fromRGB(50, 30, 30)
CloseBtn.BorderSizePixel = 0
CloseBtn.Text = "×"
CloseBtn.TextColor3 = Color3.fromRGB(255, 120, 120)
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.TextSize = 18
CloseBtn.Parent = Header

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(1, 0)
CloseCorner.Parent = CloseBtn

local Body = Instance.new("Frame")
Body.Size = UDim2.new(1, -16, 1, -58)
Body.Position = UDim2.new(0, 8, 0, 50)
Body.BackgroundTransparency = 1
Body.Parent = Main

local Scroll = Instance.new("ScrollingFrame")
Scroll.Size = UDim2.new(0, 255, 1, 0)
Scroll.BackgroundTransparency = 1
Scroll.BorderSizePixel = 0
Scroll.ScrollBarThickness = 3
Scroll.ScrollBarImageColor3 = Theme.Accent
Scroll.CanvasSize = UDim2.new(0, 0, 0, 2800)
Scroll.Parent = Body

local Layout = Instance.new("UIListLayout")
Layout.Padding = UDim.new(0, 6)
Layout.SortOrder = Enum.SortOrder.LayoutOrder
Layout.Parent = Scroll

local Preview = Instance.new("Frame")
Preview.Size = UDim2.new(0, 135, 1, 0)
Preview.Position = UDim2.new(1, -135, 0, 0)
Preview.BackgroundColor3 = Color3.fromRGB(12, 12, 18)
Preview.BorderSizePixel = 0
Preview.Parent = Body
local PreviewCorner = Instance.new("UICorner")
PreviewCorner.CornerRadius = UDim.new(0, 8)
PreviewCorner.Parent = Preview
local PreviewStroke = Instance.new("UIStroke")
PreviewStroke.Color = Theme.Border
PreviewStroke.Thickness = 1
PreviewStroke.Parent = Preview

local PreviewTitle = Instance.new("TextLabel")
PreviewTitle.Size = UDim2.new(1, 0, 0, 22)
PreviewTitle.Position = UDim2.new(0, 0, 0, 4)
PreviewTitle.BackgroundTransparency = 1
PreviewTitle.Text = "PREVIEW"
PreviewTitle.TextColor3 = Theme.AccentGlow
PreviewTitle.Font = Enum.Font.GothamBold
PreviewTitle.TextSize = 11
PreviewTitle.Parent = Preview

local ViewportFrame = Instance.new("ViewportFrame")
ViewportFrame.Size = UDim2.new(1, -16, 1, -34)
ViewportFrame.Position = UDim2.new(0, 8, 0, 28)
ViewportFrame.BackgroundColor3 = Color3.fromRGB(8, 8, 12)
ViewportFrame.BorderSizePixel = 0
ViewportFrame.Ambient = Color3.fromRGB(200, 200, 220)
ViewportFrame.LightColor = Color3.fromRGB(255, 255, 255)
ViewportFrame.Parent = Preview
local VPCorner = Instance.new("UICorner")
VPCorner.CornerRadius = UDim.new(0, 6)
VPCorner.Parent = ViewportFrame

local WorldModel = Instance.new("WorldModel")
WorldModel.Parent = ViewportFrame

local VPCam = Instance.new("Camera")
VPCam.Parent = ViewportFrame
ViewportFrame.CurrentCamera = VPCam

local function UpdatePreviewModel()
    pcall(function()
        for _, c in ipairs(WorldModel:GetChildren()) do c:Destroy() end
    end)
    local char = LocalPlayer.Character
    if not char then return end
    local ok, cloned = pcall(function() return char:Clone() end)
    if not ok or not cloned then return end
    pcall(function()
        for _, c in ipairs(cloned:GetChildren()) do
            if c:IsA("Script") or c:IsA("LocalScript") or c:IsA("Sound") then c:Destroy() end
        end
        cloned.Parent = WorldModel
        local hrp = cloned:FindFirstChild("HumanoidRootPart")
            or cloned:FindFirstChild("Torso")
            or cloned:FindFirstChild("UpperTorso")
        if hrp then
            local pos = hrp.Position
            VPCam.CFrame = CFrame.new(pos + Vector3.new(0, 0, 9), pos)
            VPCam.FieldOfView = 40
        end
    end)
end

UpdatePreviewModel()
LocalPlayer.CharacterAdded:Connect(function()
    task.wait(0.6); UpdatePreviewModel()
end)
task.spawn(function()
    while task.wait(5) do pcall(UpdatePreviewModel) end
end)

local function section(text)
    local f = Instance.new("Frame")
    f.Size = UDim2.new(1, -6, 0, 26)
    f.BackgroundColor3 = Theme.BgAlt
    f.BorderSizePixel = 0
    f.Parent = Scroll
    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, 6); c.Parent = f
    local s = Instance.new("UIStroke")
    s.Color = Theme.Border; s.Thickness = 1; s.Parent = f
    local t = Instance.new("TextLabel")
    t.Size = UDim2.new(1, -12, 1, 0)
    t.Position = UDim2.new(0, 12, 0, 0)
    t.BackgroundTransparency = 1
    t.Text = text
    t.TextColor3 = Theme.AccentGlow
    t.Font = Enum.Font.GothamBold
    t.TextSize = 12
    t.TextXAlignment = Enum.TextXAlignment.Left
    t.Parent = f
end

local function toggle(text, default, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, -6, 0, 30)
    btn.BackgroundColor3 = Theme.BgAlt
    btn.BorderSizePixel = 0
    btn.Text = ""; btn.AutoButtonColor = false
    btn.Parent = Scroll
    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, 6); c.Parent = btn
    local s = Instance.new("UIStroke")
    s.Color = Theme.Border; s.Thickness = 1; s.Parent = btn
    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(1, -60, 1, 0)
    lbl.Position = UDim2.new(0, 12, 0, 0)
    lbl.BackgroundTransparency = 1
    lbl.Text = text
    lbl.TextColor3 = Theme.Text
    lbl.Font = Enum.Font.Gotham
    lbl.TextSize = 12
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.Parent = btn
    local ind = Instance.new("Frame")
    ind.Size = UDim2.new(0, 34, 0, 18)
    ind.Position = UDim2.new(1, -46, 0.5, -9)
    ind.BackgroundColor3 = default and Theme.Green or Theme.Red
    ind.BorderSizePixel = 0
    ind.Parent = btn
    local ic = Instance.new("UICorner")
    ic.CornerRadius = UDim.new(1, 0); ic.Parent = ind
    local knob = Instance.new("Frame")
    knob.Size = UDim2.new(0, 14, 0, 14)
    knob.Position = default and UDim2.new(1, -16, 0.5, -7) or UDim2.new(0, 2, 0.5, -7)
    knob.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    knob.BorderSizePixel = 0
    knob.Parent = ind
    local kc = Instance.new("UICorner")
    kc.CornerRadius = UDim.new(1, 0); kc.Parent = knob
    local state = default
    btn.MouseButton1Click:Connect(function()
        state = not state
        TweenService:Create(ind, TweenInfo.new(0.15), {BackgroundColor3 = state and Theme.Green or Theme.Red}):Play()
        TweenService:Create(knob, TweenInfo.new(0.15), {
            Position = state and UDim2.new(1, -16, 0.5, -7) or UDim2.new(0, 2, 0.5, -7)
        }):Play()
        callback(state)
    end)
end

local function slider(text, min, max, default, callback, step)
    step = step or 1
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, -6, 0, 44)
    frame.BackgroundColor3 = Theme.BgAlt
    frame.BorderSizePixel = 0
    frame.Parent = Scroll
    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, 6); c.Parent = frame
    local s = Instance.new("UIStroke")
    s.Color = Theme.Border; s.Thickness = 1; s.Parent = frame
    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(1, -20, 0, 18)
    lbl.Position = UDim2.new(0, 10, 0, 4)
    lbl.BackgroundTransparency = 1
    lbl.Text = text .. "  " .. default
    lbl.TextColor3 = Theme.Text
    lbl.Font = Enum.Font.Gotham
    lbl.TextSize = 11
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.Parent = frame
    local bar = Instance.new("TextButton")
    bar.Size = UDim2.new(1, -20, 0, 8)
    bar.Position = UDim2.new(0, 10, 0, 30)
    bar.BackgroundColor3 = Theme.Track
    bar.BorderSizePixel = 0
    bar.Text = ""; bar.AutoButtonColor = false
    bar.Parent = frame
    local bc = Instance.new("UICorner")
    bc.CornerRadius = UDim.new(1, 0); bc.Parent = bar
    local fill = Instance.new("Frame")
    fill.Size = UDim2.new((default - min) / (max - min), 0, 1, 0)
    fill.BackgroundColor3 = Theme.Accent
    fill.BorderSizePixel = 0
    fill.Parent = bar
    local fc = Instance.new("UICorner")
    fc.CornerRadius = UDim.new(1, 0); fc.Parent = fill
    local drag = false
    bar.MouseButton1Down:Connect(function() drag = true end)
    UserInputService.InputEnded:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1 then drag = false end
    end)
    UserInputService.InputChanged:Connect(function(i)
        if drag and i.UserInputType == Enum.UserInputType.MouseMovement then
            local rel = math.clamp((i.Position.X - bar.AbsolutePosition.X) / bar.AbsoluteSize.X, 0, 1)
            local raw = min + (max - min) * rel
            local val = math.floor(raw / step + 0.5) * step
            fill.Size = UDim2.new((val - min) / (max - min), 0, 1, 0)
            if step < 1 then
                lbl.Text = text .. "  " .. string.format("%.1f", val)
            else
                lbl.Text = text .. "  " .. val
            end
            callback(val)
        end
    end)
end

local function dropdown(text, options, default, callback)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, -6, 0, 32)
    frame.BackgroundColor3 = Theme.BgAlt
    frame.BorderSizePixel = 0
    frame.ClipsDescendants = true
    frame.Parent = Scroll
    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, 6); c.Parent = frame
    local s = Instance.new("UIStroke")
    s.Color = Theme.Border; s.Thickness = 1; s.Parent = frame
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, 0, 0, 32)
    btn.BackgroundTransparency = 1
    btn.Text = ""; btn.AutoButtonColor = false
    btn.Parent = frame
    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(1, -20, 1, 0)
    lbl.Position = UDim2.new(0, 12, 0, 0)
    lbl.BackgroundTransparency = 1
    lbl.Text = text .. ": " .. default
    lbl.TextColor3 = Theme.Text
    lbl.Font = Enum.Font.Gotham
    lbl.TextSize = 12
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.Parent = frame
    local list = Instance.new("Frame")
    list.Size = UDim2.new(1, 0, 0, #options * 22)
    list.Position = UDim2.new(0, 0, 0, 32)
    list.BackgroundColor3 = Theme.Bg
    list.BorderSizePixel = 0
    list.Visible = false
    list.Parent = frame
    for i, opt in ipairs(options) do
        local o = Instance.new("TextButton")
        o.Size = UDim2.new(1, 0, 0, 22)
        o.Position = UDim2.new(0, 0, 0, (i-1) * 22)
        o.BackgroundColor3 = Theme.BgAlt
        o.BorderSizePixel = 0
        o.Text = opt
        o.TextColor3 = Theme.Text
        o.Font = Enum.Font.Gotham
        o.TextSize = 12
        o.AutoButtonColor = false
        o.Parent = list
        o.MouseButton1Click:Connect(function()
            lbl.Text = text .. ": " .. opt
            list.Visible = false
            frame.Size = UDim2.new(1, -6, 0, 32)
            callback(opt)
        end)
    end
    btn.MouseButton1Click:Connect(function()
        list.Visible = not list.Visible
        frame.Size = list.Visible and UDim2.new(1, -6, 0, 32 + #options * 22) or UDim2.new(1, -6, 0, 32)
    end)
end

section("ESP")
toggle("ESP Enabled", Config.ESP_Enabled, function(v) Config.ESP_Enabled = v end)
toggle("Boxes", Config.ESP_Box, function(v) Config.ESP_Box = v end)
slider("Box Thickness", 0.5, 6, Config.ESP_BoxThick, function(v) Config.ESP_BoxThick = v end, 0.5)
toggle("Names", Config.ESP_Name, function(v) Config.ESP_Name = v end)
slider("Name Size", 10, 22, Config.ESP_NameSize, function(v) Config.ESP_NameSize = v end, 1)
toggle("Health Bar", Config.ESP_Health, function(v) Config.ESP_Health = v end)
slider("Health Thickness", 0.5, 6, Config.ESP_HealthThick, function(v) Config.ESP_HealthThick = v end, 0.5)
toggle("HP Text", Config.ESP_HPText, function(v) Config.ESP_HPText = v end)
toggle("Ping on ESP", Config.ESP_Ping, function(v) Config.ESP_Ping = v end)
toggle("Distance", Config.ESP_Distance, function(v) Config.ESP_Distance = v end)
toggle("Tracers", Config.ESP_Tracer, function(v) Config.ESP_Tracer = v end)
slider("Tracer Thickness", 0.5, 6, Config.ESP_TracerThick, function(v) Config.ESP_TracerThick = v end, 0.5)
dropdown("Tracer From", {"Top", "Bottom", "Center"}, "Bottom", function(v) Config.ESP_TracerFrom = v end)
toggle("Snaplines", Config.ESP_SnapLines, function(v) Config.ESP_SnapLines = v end)
slider("Snap Thickness", 0.5, 6, Config.ESP_SnapThick, function(v) Config.ESP_SnapThick = v end, 0.5)
toggle("Enemies Only (ESP)", Config.ESP_TeamCheck, function(v) Config.ESP_TeamCheck = v end)

section("Chams")
toggle("Chams Enabled", Config.Chams_Enabled, function(v) Config.Chams_Enabled = v end)
toggle("Fill", Config.Chams_Fill, function(v) Config.Chams_Fill = v end)
toggle("Outline", Config.Chams_Outline, function(v) Config.Chams_Outline = v end)
toggle("Enemies Only (Chams)", Config.Chams_TeamCheck, function(v) Config.Chams_TeamCheck = v end)

section("Silent Aim")
toggle("Silent Aim Enabled", Config.SilentAim_Enabled, function(v)
    Config.SilentAim_Enabled = v; silentAimEnabled = v
end)
toggle("Enemies Only (Silent)", Config.SilentAim_TeamCheck, function(v) Config.SilentAim_TeamCheck = v end)
toggle("Through Walls (Silent)", Config.SilentAim_Wallbang, function(v) Config.SilentAim_Wallbang = v end)
slider("Silent FOV", 10, 500, Config.SilentAim_FOV, function(v) Config.SilentAim_FOV = v end, 1)
slider("Hit Chance %", 1, 100, Config.SilentAim_Chance, function(v) Config.SilentAim_Chance = v end, 1)

section("Normal Aim")
toggle("Aim Enabled (RMB)", Config.Aim_Enabled, function(v) Config.Aim_Enabled = v end)
toggle("Enemies Only (Aim)", Config.Aim_TeamCheck, function(v) Config.Aim_TeamCheck = v end)
toggle("Through Walls (Aim)", Config.Aim_Wallbang, function(v) Config.Aim_Wallbang = v end)
slider("Aim FOV", 10, 500, Config.Aim_FOV, function(v) Config.Aim_FOV = v end, 1)
slider("Smoothness", 1, 20, Config.Aim_Smoothness, function(v) Config.Aim_Smoothness = v end, 1)
dropdown("Hit Part", {"Head", "HumanoidRootPart", "UpperTorso", "LowerTorso"}, "Head", function(v)
    Config.Aim_HitPart = v
end)

section("Third Person")
toggle("Enabled (Mouse Wheel)", Config.ThirdPerson_Enabled, function(v) Config.ThirdPerson_Enabled = v end)
slider("Distance", 4, 20, Config.ThirdPerson_Distance, function(v) Config.ThirdPerson_Distance = v end, 1)

section("Spinbot")
toggle("Spinbot Enabled", Config.Spin_Enabled, function(v) Config.Spin_Enabled = v end)
slider("Speed", 5, 180, Config.Spin_Speed, function(v) Config.Spin_Speed = v end, 1)
dropdown("Mode", {"Yaw", "Pitch", "Both"}, "Yaw", function(v) Config.Spin_Mode = v end)

section("Movement")
toggle("Bhop", Config.Bhop_Enabled, function(v) Config.Bhop_Enabled = v end)
toggle("AutoStrafe", Config.AutoStrafe_Enabled, function(v) Config.AutoStrafe_Enabled = v end)
slider("AutoStrafe Power", 1, 100, Config.AutoStrafe_Speed, function(v) Config.AutoStrafe_Speed = v end, 1)
toggle("JumpBug", Config.JumpBug_Enabled, function(v) Config.JumpBug_Enabled = v end)
toggle("Inf Jump", Config.InfJump_Enabled, function(v) Config.InfJump_Enabled = v end)
toggle("NoClip", Config.NoClip_Enabled, function(v) Config.NoClip_Enabled = v end)

section("PixelSurf")
toggle("PixelSurf Enabled", Config.PixelSurf_Enabled, function(v) Config.PixelSurf_Enabled = v end)
slider("Surf Power", 1, 100, Config.PixelSurf_Speed, function(v) Config.PixelSurf_Speed = v end, 1)
toggle("PS Indicator", Config.PS_Indicator_Enabled, function(v) Config.PS_Indicator_Enabled = v end)
toggle("PS Particles", Config.PS_Particles_Enabled, function(v) Config.PS_Particles_Enabled = v end)
toggle("PS Highlight", Config.PS_Highlight_Enabled, function(v) Config.PS_Highlight_Enabled = v end)
toggle("PS Sound", Config.PS_Sound_Enabled, function(v) Config.PS_Sound_Enabled = v end)
toggle("PS Screen FX", Config.PS_ScreenFX_Enabled, function(v) Config.PS_ScreenFX_Enabled = v end)

-- ANIMATION + MOUSE
local openSize = UDim2.new(0, 410, 0, 640)
local closeSize = UDim2.new(0, 410, 0, 42)
local opened = false
local savedMouseBehavior = nil

local function setOpen(state)
    opened = state
    TweenService:Create(Main, TweenInfo.new(0.28, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
        {Size = state and openSize or closeSize}):Play()
    if state then
        Body.Visible = true
        pcall(function()
            savedMouseBehavior = UserInputService.MouseBehavior
            UserInputService.MouseBehavior = Enum.MouseBehavior.Default
            UserInputService.MouseIconEnabled = true
            setmodal(true)
        end)
    else
        task.delay(0.2, function()
            if not opened then Body.Visible = false end
        end)
        pcall(function()
            UserInputService.MouseBehavior = savedMouseBehavior or Enum.MouseBehavior.Default
            setmodal(false)
        end)
    end
end

RunService.RenderStepped:Connect(function()
    if opened then
        pcall(function()
            if UserInputService.MouseBehavior ~= Enum.MouseBehavior.Default then
                UserInputService.MouseBehavior = Enum.MouseBehavior.Default
            end
            if not UserInputService.MouseIconEnabled then
                UserInputService.MouseIconEnabled = true
            end
        end)
    end
end)

CloseBtn.MouseButton1Click:Connect(function() setOpen(false) end)
CloseBtn.MouseEnter:Connect(function()
    TweenService:Create(CloseBtn, TweenInfo.new(0.15), {BackgroundColor3 = Color3.fromRGB(80, 30, 30)}):Play()
end)
CloseBtn.MouseLeave:Connect(function()
    TweenService:Create(CloseBtn, TweenInfo.new(0.15), {BackgroundColor3 = Color3.fromRGB(50, 30, 30)}):Play()
end)

TitleText.MouseButton1Click:Connect(function() setOpen(not opened) end)

UserInputService.InputBegan:Connect(function(input, gpe)
    if gpe then return end
    if input.KeyCode == Config.Menu_Key then setOpen(not opened) end
end)

setOpen(false)

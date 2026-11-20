--[[
    NEMESIS PRIVET v1.0
    Liquid Glass UI starter for Roblox Studio (your own experience).
    Place this LocalScript in StarterPlayer > StarterPlayerScripts.

    This is a UI/customization starter only. It does not include exploit loaders,
    Silent Aim, aimbots, or modifications to the public Rivals game.
]]

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local Lighting = game:GetService("Lighting")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Remove an older copy if the LocalScript is run again.
local oldGui = playerGui:FindFirstChild("NemesisPrivet")
if oldGui then
    oldGui:Destroy()
end

local COLORS = {
    background = Color3.fromRGB(17, 18, 29),
    panel = Color3.fromRGB(27, 28, 43),
    panelLight = Color3.fromRGB(38, 39, 58),
    accent = Color3.fromRGB(153, 112, 255),
    accent2 = Color3.fromRGB(91, 174, 255),
    text = Color3.fromRGB(245, 244, 255),
    muted = Color3.fromRGB(160, 160, 184),
    stroke = Color3.fromRGB(105, 91, 151),
}

local gui = Instance.new("ScreenGui")
gui.Name = "NemesisPrivet"
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
gui.Parent = playerGui

local function addCorner(instance, radius)
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, radius or 12)
    corner.Parent = instance
    return corner
end

local function addStroke(instance, color, transparency)
    local stroke = Instance.new("UIStroke")
    stroke.Color = color or COLORS.stroke
    stroke.Transparency = transparency or 0.35
    stroke.Thickness = 1
    stroke.Parent = instance
    return stroke
end

local function makeText(parent, text, size, color, font)
    local label = Instance.new("TextLabel")
    label.BackgroundTransparency = 1
    label.Text = text
    label.TextColor3 = color or COLORS.text
    label.TextSize = size or 14
    label.Font = font or Enum.Font.Gotham
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.TextYAlignment = Enum.TextYAlignment.Center
    label.Parent = parent
    return label
end

local main = Instance.new("Frame")
main.Name = "Main"
main.Size = UDim2.fromOffset(720, 460)
main.Position = UDim2.new(0.5, -360, 0.5, -230)
main.BackgroundColor3 = COLORS.background
main.BackgroundTransparency = 0.12
main.Parent = gui
addCorner(main, 18)
addStroke(main, COLORS.stroke, 0.18)

local gradient = Instance.new("UIGradient")
gradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(31, 27, 48)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(16, 21, 35)),
})
gradient.Rotation = 25
gradient.Parent = main

-- Dragging from the header.
local header = Instance.new("Frame")
header.Name = "Header"
header.Size = UDim2.new(1, 0, 0, 66)
header.BackgroundTransparency = 1
header.Parent = main

local dragging = false
local dragStart
local startPosition

header.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPosition = main.Position
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement
        or input.UserInputType == Enum.UserInputType.Touch) then
        local delta = input.Position - dragStart
        main.Position = UDim2.new(
            startPosition.X.Scale, startPosition.X.Offset + delta.X,
            startPosition.Y.Scale, startPosition.Y.Offset + delta.Y
        )
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch then
        dragging = false
    end
end)

local logo = makeText(header, "N", 30, COLORS.accent, Enum.Font.GothamBlack)
logo.Position = UDim2.fromOffset(20, 12)
logo.Size = UDim2.fromOffset(38, 40)
logo.TextXAlignment = Enum.TextXAlignment.Center

local title = makeText(header, "NEMESIS PRIVET", 19, COLORS.text, Enum.Font.GothamBold)
title.Position = UDim2.fromOffset(66, 10)
title.Size = UDim2.fromOffset(250, 25)

local subtitle = makeText(header, "LIQUID GLASS  •  V1.0", 10, COLORS.muted, Enum.Font.GothamMedium)
subtitle.Position = UDim2.fromOffset(67, 35)
subtitle.Size = UDim2.fromOffset(220, 17)

local hideButton = Instance.new("TextButton")
hideButton.Name = "HideButton"
hideButton.Size = UDim2.fromOffset(34, 30)
hideButton.Position = UDim2.new(1, -50, 0, 17)
hideButton.BackgroundColor3 = COLORS.panelLight
hideButton.Text = "—"
hideButton.TextColor3 = COLORS.text
hideButton.TextSize = 18
hideButton.Font = Enum.Font.GothamBold
hideButton.AutoButtonColor = false
hideButton.Parent = header
addCorner(hideButton, 9)

local divider = Instance.new("Frame")
divider.Size = UDim2.new(1, -28, 0, 1)
divider.Position = UDim2.fromOffset(14, 65)
divider.BackgroundColor3 = COLORS.stroke
divider.BackgroundTransparency = 0.55
divider.BorderSizePixel = 0
divider.Parent = main

local sidebar = Instance.new("Frame")
sidebar.Name = "Sidebar"
sidebar.Size = UDim2.new(0, 160, 1, -82)
sidebar.Position = UDim2.fromOffset(14, 76)
sidebar.BackgroundColor3 = COLORS.panel
sidebar.BackgroundTransparency = 0.18
sidebar.Parent = main
addCorner(sidebar, 14)
addStroke(sidebar, COLORS.stroke, 0.55)

local sidePadding = Instance.new("UIPadding")
sidePadding.PaddingTop = UDim.new(0, 12)
sidePadding.PaddingLeft = UDim.new(0, 10)
sidePadding.PaddingRight = UDim.new(0, 10)
sidePadding.Parent = sidebar

local sideLayout = Instance.new("UIListLayout")
sideLayout.Padding = UDim.new(0, 7)
sideLayout.SortOrder = Enum.SortOrder.LayoutOrder
sideLayout.Parent = sidebar

local content = Instance.new("Frame")
content.Name = "Content"
content.Size = UDim2.new(1, -190, 1, -82)
content.Position = UDim2.fromOffset(190, 76)
content.BackgroundColor3 = COLORS.panel
content.BackgroundTransparency = 0.22
content.Parent = main
addCorner(content, 14)
addStroke(content, COLORS.stroke, 0.55)

local pages = {}
local tabButtons = {}
local currentTab = nil

local function createPage(name)
    local page = Instance.new("ScrollingFrame")
    page.Name = name .. "Page"
    page.Size = UDim2.new(1, -24, 1, -24)
    page.Position = UDim2.fromOffset(12, 12)
    page.BackgroundTransparency = 1
    page.BorderSizePixel = 0
    page.ScrollBarThickness = 3
    page.ScrollBarImageColor3 = COLORS.accent
    page.CanvasSize = UDim2.new(0, 0, 0, 0)
    page.Visible = false
    page.Parent = content

    local layout = Instance.new("UIListLayout")
    layout.Padding = UDim.new(0, 10)
    layout.SortOrder = Enum.SortOrder.LayoutOrder
    layout.Parent = page

    layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        page.CanvasSize = UDim2.new(0, 0, 0, layout.AbsoluteContentSize.Y + 8)
    end)

    pages[name] = page
    return page
end

local function showTab(name)
    currentTab = name
    for pageName, page in pairs(pages) do
        page.Visible = pageName == name
    end
    for tabName, button in pairs(tabButtons) do
        local selected = tabName == name
        button.BackgroundColor3 = selected and COLORS.accent or COLORS.panelLight
        button.BackgroundTransparency = selected and 0.12 or 0.35
        button.TextColor3 = selected and Color3.new(1, 1, 1) or COLORS.muted
    end
end

local function addSection(page, text)
    local label = makeText(page, text, 12, COLORS.accent2, Enum.Font.GothamBold)
    label.Size = UDim2.new(1, -4, 0, 22)
    return label
end

local function addInfo(page, text)
    local card = Instance.new("Frame")
    card.Size = UDim2.new(1, -4, 0, 54)
    card.BackgroundColor3 = COLORS.panelLight
    card.BackgroundTransparency = 0.22
    card.Parent = page
    addCorner(card, 10)

    local label = makeText(card, text, 12, COLORS.muted, Enum.Font.Gotham)
    label.Position = UDim2.fromOffset(12, 5)
    label.Size = UDim2.new(1, -24, 1, -10)
    label.TextWrapped = true
    return card
end

local function addButton(page, text, callback)
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(1, -4, 0, 38)
    button.BackgroundColor3 = COLORS.panelLight
    button.BackgroundTransparency = 0.12
    button.Text = text
    button.TextColor3 = COLORS.text
    button.TextSize = 12
    button.Font = Enum.Font.GothamSemibold
    button.AutoButtonColor = false
    button.Parent = page
    addCorner(button, 10)
    addStroke(button, COLORS.stroke, 0.72)
    button.MouseButton1Click:Connect(callback or function() end)
    return button
end

local function addSlider(page, titleText, initialValue, callback)
    local card = Instance.new("Frame")
    card.Size = UDim2.new(1, -4, 0, 66)
    card.BackgroundColor3 = COLORS.panelLight
    card.BackgroundTransparency = 0.2
    card.Parent = page
    addCorner(card, 10)

    local titleLabel = makeText(card, titleText, 12, COLORS.text, Enum.Font.GothamSemibold)
    titleLabel.Position = UDim2.fromOffset(12, 7)
    titleLabel.Size = UDim2.new(1, -75, 0, 20)

    local valueLabel = makeText(card, tostring(initialValue) .. "%", 12, COLORS.accent2, Enum.Font.GothamBold)
    valueLabel.Position = UDim2.new(1, -58, 0, 7)
    valueLabel.Size = UDim2.fromOffset(46, 20)
    valueLabel.TextXAlignment = Enum.TextXAlignment.Right

    local bar = Instance.new("Frame")
    bar.Size = UDim2.new(1, -24, 0, 7)
    bar.Position = UDim2.fromOffset(12, 42)
    bar.BackgroundColor3 = Color3.fromRGB(61, 60, 82)
    bar.BorderSizePixel = 0
    bar.Parent = card
    addCorner(bar, 6)

    local fill = Instance.new("Frame")
    fill.Size = UDim2.new(math.clamp(initialValue / 100, 0, 1), 0, 1, 0)
    fill.BackgroundColor3 = COLORS.accent
    fill.BorderSizePixel = 0
    fill.Parent = bar
    addCorner(fill, 6)

    local knob = Instance.new("TextButton")
    knob.Size = UDim2.fromOffset(18, 18)
    knob.AnchorPoint = Vector2.new(0.5, 0.5)
    knob.Position = UDim2.new(math.clamp(initialValue / 100, 0, 1), 0, 0.5, 0)
    knob.BackgroundColor3 = Color3.fromRGB(245, 242, 255)
    knob.Text = ""
    knob.Parent = bar
    addCorner(knob, 20)

    local active = false
    local value = initialValue

    local function updateFromX(x)
        local width = math.max(bar.AbsoluteSize.X, 1)
        local alpha = math.clamp((x - bar.AbsolutePosition.X) / width, 0, 1)
        value = math.floor(alpha * 100 + 0.5)
        fill.Size = UDim2.new(alpha, 0, 1, 0)
        knob.Position = UDim2.new(alpha, 0, 0.5, 0)
        valueLabel.Text = tostring(value) .. "%"
        if callback then callback(value) end
    end

    knob.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1
            or input.UserInputType == Enum.UserInputType.Touch then
            active = true
            updateFromX(input.Position.X)
        end
    end)

    bar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1
            or input.UserInputType == Enum.UserInputType.Touch then
            active = true
            updateFromX(input.Position.X)
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if active and (input.UserInputType == Enum.UserInputType.MouseMovement
            or input.UserInputType == Enum.UserInputType.Touch) then
            updateFromX(input.Position.X)
        end
    end)

    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1
            or input.UserInputType == Enum.UserInputType.Touch then
            active = false
        end
    end)

    return function() return value end
end

local tabNames = {"Combat", "Visuals", "Skins", "Sounds", "Configs", "Misc", "Settings"}
for index, name in ipairs(tabNames) do
    local button = Instance.new("TextButton")
    button.Name = name .. "Tab"
    button.Size = UDim2.new(1, 0, 0, 36)
    button.LayoutOrder = index
    button.BackgroundColor3 = COLORS.panelLight
    button.BackgroundTransparency = 0.35
    button.Text = name
    button.TextColor3 = COLORS.muted
    button.TextSize = 12
    button.Font = Enum.Font.GothamSemibold
    button.AutoButtonColor = false
    button.Parent = sidebar
    addCorner(button, 9)
    tabButtons[name] = button
    createPage(name)
    button.MouseButton1Click:Connect(function()
        showTab(name)
    end)
end

-- Combat: fair-play training controls only.
local combat = pages.Combat
addSection(combat, "AIM TRAINING")
addInfo(combat, "Training controls for your own experience. This slider does not control or automate aiming.")
local trainingValue = 50
addSlider(combat, "Training intensity", 50, function(value)
    trainingValue = value
end)
addButton(combat, "Print training intensity", function()
    print("[Nemesis Privet] Training intensity:", trainingValue .. "%")
end)

-- Visuals
local visuals = pages.Visuals
addSection(visuals, "VISUAL CUSTOMIZATION")
addInfo(visuals, "Preview-only options. Connect these to visual effects in your own Roblox experience.")
addButton(visuals, "Sky preview: default", function()
    print("[Nemesis Privet] Add your own sky preview here.")
end)

-- Gray Sky is a local lighting preset for your own Roblox experience.
-- It adjusts the scene's ambient lighting; it does not replace the skybox texture.
local graySkyEnabled = false
local originalLighting = {
    Ambient = Lighting.Ambient,
    OutdoorAmbient = Lighting.OutdoorAmbient,
    ColorShift_Top = Lighting.ColorShift_Top,
    ColorShift_Bottom = Lighting.ColorShift_Bottom,
    Brightness = Lighting.Brightness,
}
local graySkyButton
graySkyButton = addButton(visuals, "Gray Sky: OFF", function()
    graySkyEnabled = not graySkyEnabled

    if graySkyEnabled then
        Lighting.Ambient = Color3.fromRGB(115, 115, 120)
        Lighting.OutdoorAmbient = Color3.fromRGB(135, 135, 140)
        Lighting.ColorShift_Top = Color3.fromRGB(185, 185, 190)
        Lighting.ColorShift_Bottom = Color3.fromRGB(105, 105, 110)
        Lighting.Brightness = 2
        graySkyButton.Text = "Gray Sky: ON"
        print("[Nemesis Privet] Gray lighting preset enabled.")
    else
        Lighting.Ambient = originalLighting.Ambient
        Lighting.OutdoorAmbient = originalLighting.OutdoorAmbient
        Lighting.ColorShift_Top = originalLighting.ColorShift_Top
        Lighting.ColorShift_Bottom = originalLighting.ColorShift_Bottom
        Lighting.Brightness = originalLighting.Brightness
        graySkyButton.Text = "Gray Sky: OFF"
        print("[Nemesis Privet] Original lighting restored.")
    end
end)

addButton(visuals, "Crosshair preview", function()
    print("[Nemesis Privet] Add a custom crosshair preview here.")
end)

-- Skins
local skins = pages.Skins
addSection(skins, "LOADOUT PREVIEW")
addInfo(skins, "Skin, wrap and charm preview slots. Connect these to items you own in your own experience.")
addButton(skins, "Open skin preview", function()
    print("[Nemesis Privet] Skin preview slot selected.")
end)
addButton(skins, "Open wrap preview", function()
    print("[Nemesis Privet] Wrap preview slot selected.")
end)
addButton(skins, "Open charm preview", function()
    print("[Nemesis Privet] Charm preview slot selected.")
end)

-- Sounds
local sounds = pages.Sounds
addSection(sounds, "SOUND MANAGER")
addInfo(sounds, "Add sound assets that you own or are permitted to use in your own experience.")
addButton(sounds, "Preview selected sound", function()
    print("[Nemesis Privet] Add your permitted sound preview here.")
end)

-- Configs
local configs = pages.Configs
addSection(configs, "CONFIG MANAGER")
addInfo(configs, "Config slots are UI placeholders. Roblox LocalScripts cannot write arbitrary files to your device.")
addButton(configs, "Print current UI config", function()
    print("[Nemesis Privet] Theme:", "Purple / Blue", "Training:", trainingValue .. "%")
end)
addButton(configs, "Reset UI layout", function()
    main.Position = UDim2.new(0.5, -360, 0.5, -230)
end)

-- Misc
local misc = pages.Misc
addSection(misc, "MISCELLANEOUS")
addInfo(misc, "Hide the menu with the button above or press RightShift to show/hide it.")
addButton(misc, "Hide menu now", function()
    main.Visible = false
end)
addButton(misc, "Reset menu position", function()
    main.Position = UDim2.new(0.5, -360, 0.5, -230)
end)

-- Settings
local settings = pages.Settings
addSection(settings, "INTERFACE SETTINGS")
addInfo(settings, "Purple / blue liquid-glass theme. You can edit the COLORS table near the top of this script.")
addButton(settings, "Accent: purple", function()
    COLORS.accent = Color3.fromRGB(153, 112, 255)
    for _, page in pairs(pages) do
        for _, child in ipairs(page:GetChildren()) do
            if child:IsA("Frame") and child:FindFirstChildWhichIsA("Frame") then
                -- Existing controls retain their current colors; new controls use this accent.
            end
        end
    end
    print("[Nemesis Privet] Purple accent selected.")
end)
addButton(settings, "Accent: blue", function()
    COLORS.accent = Color3.fromRGB(91, 174, 255)
    print("[Nemesis Privet] Blue accent selected for future controls.")
end)

hideButton.MouseButton1Click:Connect(function()
    main.Visible = false
end)

-- RightShift toggles the menu, including when it is hidden.
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.KeyCode == Enum.KeyCode.RightShift then
        main.Visible = not main.Visible
    end
end)

showTab("Combat")

-- Small entrance animation.
main.Size = UDim2.fromOffset(690, 440)
main.BackgroundTransparency = 0.35
TweenService:Create(main, TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
    Size = UDim2.fromOffset(720, 460),
    BackgroundTransparency = 0.12,
}):Play()

print("[Nemesis Privet] UI loaded. Press RightShift to hide/show.")

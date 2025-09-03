-- Lua (LocalScript) - Place this in StarterGui
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local mouse = player:GetMouse()

-- Theme
local THEME = {
    Background = Color3.fromRGB(18, 18, 20),
    Panel = Color3.fromRGB(24, 26, 30),
    Accent = Color3.fromRGB(67, 160, 255), -- azure-like
    AccentDark = Color3.fromRGB(46, 115, 184),
    Text = Color3.fromRGB(230, 230, 230),
    SubText = Color3.fromRGB(170, 170, 170),
}

-- Configuration
local TOGGLE_KEY = Enum.KeyCode.RightControl
local UI_ZINDEX = 50

-- Create ScreenGui
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "AzureMenu"
screenGui.ResetOnSpawn = false
screenGui.Parent = player:WaitForChild("PlayerGui")

-- Main container
local main = Instance.new("Frame")
main.Name = "Main"
main.Size = UDim2.new(0, 920, 0, 560)
main.Position = UDim2.new(0.5, -460, 0.5, -280)
main.AnchorPoint = Vector2.new(0.5, 0.5)
main.BackgroundColor3 = THEME.Panel
main.BorderSizePixel = 0
main.ClipsDescendants = true
main.ZIndex = UI_ZINDEX
main.Parent = screenGui

-- Round corners
local uicorner_main = Instance.new("UICorner")
uicorner_main.CornerRadius = UDim.new(0, 8)
uicorner_main.Parent = main

-- Shadow (simple)
local shadow = Instance.new("ImageLabel")
shadow.Name = "Shadow"
shadow.BackgroundTransparency = 1
shadow.Image = "rbxassetid://5919989911" -- soft shadow asset
shadow.ImageColor3 = Color3.new(0,0,0)
shadow.Size = UDim2.new(1, 60, 1, 60)
shadow.Position = UDim2.new(0, -30, 0, -30)
shadow.ScaleType = Enum.ScaleType.Slice
shadow.SliceCenter = Rect.new(20, 20, 280, 280)
shadow.ZIndex = UI_ZINDEX - 1
shadow.Parent = main

-- Header
local header = Instance.new("Frame")
header.Name = "Header"
header.Size = UDim2.new(1, 0, 0, 48)
header.BackgroundColor3 = THEME.Background
header.BorderSizePixel = 0
header.Parent = main

local headerCorner = Instance.new("UICorner")
headerCorner.CornerRadius = UDim.new(0, 8)
headerCorner.Parent = header

local title = Instance.new("TextLabel")
title.Name = "Title"
title.Text = "Azure Menu"
title.TextColor3 = THEME.Text
title.Font = Enum.Font.GothamBold
title.TextSize = 20
title.BackgroundTransparency = 1
title.Position = UDim2.new(0, 16, 0, 10)
title.Size = UDim2.new(0, 200, 0, 28)
title.Parent = header

local subtitle = Instance.new("TextLabel")
subtitle.Name = "Subtitle"
subtitle.Text = "v1.0"
subtitle.TextColor3 = THEME.SubText
subtitle.Font = Enum.Font.Gotham
subtitle.TextSize = 12
subtitle.BackgroundTransparency = 1
subtitle.Position = UDim2.new(0, 16, 0, 28)
subtitle.Size = UDim2.new(0, 120, 0, 18)
subtitle.Parent = header

-- Close button
local closeBtn = Instance.new("TextButton")
closeBtn.Name = "Close"
closeBtn.Text = "X"
closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextSize = 18
closeBtn.TextColor3 = THEME.Text
closeBtn.BackgroundColor3 = Color3.fromRGB(0,0,0)
closeBtn.BackgroundTransparency = 1
closeBtn.Size = UDim2.new(0, 36, 0, 36)
closeBtn.Position = UDim2.new(1, -44, 0, 6)
closeBtn.Parent = header
closeBtn.ZIndex = UI_ZINDEX + 5

-- Minimize button
local minBtn = Instance.new("TextButton")
minBtn.Name = "Minimize"
minBtn.Text = "—"
minBtn.Font = Enum.Font.GothamBold
minBtn.TextSize = 18
minBtn.TextColor3 = THEME.SubText
minBtn.BackgroundTransparency = 1
minBtn.Size = UDim2.new(0, 36, 0, 36)
minBtn.Position = UDim2.new(1, -88, 0, 6)
minBtn.Parent = header
minBtn.ZIndex = UI_ZINDEX + 5

-- Layout: sidebar + content
local layoutFrame = Instance.new("Frame")
layoutFrame.Name = "Layout"
layoutFrame.Position = UDim2.new(0, 16, 0, 64)
layoutFrame.Size = UDim2.new(1, -32, 1, -80)
layoutFrame.BackgroundTransparency = 1
layoutFrame.Parent = main

-- Sidebar
local sidebar = Instance.new("Frame")
sidebar.Name = "Sidebar"
sidebar.Size = UDim2.new(0, 200, 1, 0)
sidebar.BackgroundColor3 = THEME.Background
sidebar.BorderSizePixel = 0
sidebar.Parent = layoutFrame

local sidebarCorner = Instance.new("UICorner")
sidebarCorner.CornerRadius = UDim.new(0, 6)
sidebarCorner.Parent = sidebar

local sidebarList = Instance.new("UIListLayout")
sidebarList.Parent = sidebar
sidebarList.Padding = UDim.new(0, 6)
sidebarList.SortOrder = Enum.SortOrder.LayoutOrder
sidebarList.HorizontalAlignment = Enum.HorizontalAlignment.Center
sidebarList.Padding = UDim.new(0, 10)

local tabsFolder = Instance.new("Folder")
tabsFolder.Name = "Tabs"
tabsFolder.Parent = sidebar

-- Content area
local content = Instance.new("Frame")
content.Name = "Content"
content.Size = UDim2.new(1, -216, 1, 0)
content.Position = UDim2.new(0, 216, 0, 0)
content.BackgroundColor3 = THEME.Panel
content.BorderSizePixel = 0
content.Parent = layoutFrame

local contentCorner = Instance.new("UICorner")
contentCorner.CornerRadius = UDim.new(0, 6)
contentCorner.Parent = content

local contentPadding = Instance.new("UIPadding")
contentPadding.PaddingTop = UDim.new(0, 12)
contentPadding.PaddingLeft = UDim.new(0, 12)
contentPadding.PaddingRight = UDim.new(0, 12)
contentPadding.PaddingBottom = UDim.new(0, 12)
contentPadding.Parent = content

local contentScroller = Instance.new("ScrollingFrame")
contentScroller.Name = "Scroller"
contentScroller.Size = UDim2.new(1, 0, 1, 0)
contentScroller.BackgroundTransparency = 1
contentScroller.ScrollBarThickness = 6
contentScroller.Parent = content

local contentList = Instance.new("UIListLayout")
contentList.Parent = contentScroller
contentList.SortOrder = Enum.SortOrder.LayoutOrder
contentList.Padding = UDim.new(0, 8)

-- Utility: tween function
local function tweenObject(obj, props, info)
    info = info or TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    local t = TweenService:Create(obj, info, props)
    t:Play()
    return t
end

-- Dragging the window by header
do
    local dragging = false
    local dragStart = nil
    local startPos = nil

    header.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = main.Position

            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)

    header.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement and dragging and dragStart and startPos then
            local delta = input.Position - dragStart
            local newPos = startPos + UDim2.new(0, delta.X, 0, delta.Y)
            main.Position = newPos
        end
    end)
end

-- Open/Close logic
local isOpen = true
local minimized = false

local function openUI()
    if isOpen and not main.Visible then
        main.Visible = true
    end
    tweenObject(main, {Size = UDim2.new(0, 920, 0, 560)})
    main.Position = UDim2.new(0.5, -460, 0.5, -280)
    isOpen = true
end

local function closeUI()
    tweenObject(main, {Size = UDim2.new(0, 0, 0, 0)}, TweenInfo.new(0.2, Enum.EasingStyle.Quad))
    delay(0.21, function()
        main.Visible = false
    end)
    isOpen = false
end

local function minimizeUI()
    if minimized then
        -- restore
        tweenObject(main, {Size = UDim2.new(0, 920, 0, 560)})
        minimized = false
    else
        tweenObject(main, {Size = UDim2.new(0, 380, 0, 48)})
        minimized = true
    end
end

closeBtn.MouseButton1Click:Connect(function()
    closeUI()
end)
minBtn.MouseButton1Click:Connect(function()
    minimizeUI()
end)

-- Toggle with key
UserInputService.InputBegan:Connect(function(input, gp)
    if gp then return end
    if input.KeyCode == TOGGLE_KEY then
        if not isOpen then
            main.Visible = true
            openUI()
        else
            closeUI()
        end
    end
end)

-- Tab system
local currentTab = nil
local tabButtons = {}

local function switchToTab(tabName)
    if currentTab == tabName then return end
    -- hide all children in content scroller
    for _, child in ipairs(contentScroller:GetChildren()) do
        if child:IsA("Frame") or child:IsA("TextButton") or child:IsA("TextLabel") or child:IsA("ImageLabel") or child:IsA("ScrollingFrame") then
            child.Visible = false
        end
    end
    local t = tabsFolder:FindFirstChild(tabName .. "_Content")
    if t then
        t.Visible = true
        currentTab = tabName
    end

    -- update button highlights
    for name, btn in pairs(tabButtons) do
        if name == tabName then
            tweenObject(btn, {BackgroundColor3 = THEME.Accent})
            btn.TextColor3 = Color3.new(1,1,1)
        else
            tweenObject(btn, {BackgroundColor3 = THEME.Background})
            btn.TextColor3 = THEME.SubText
        end
    end
end

local function createTab(tabName)
    -- sidebar button
    local btn = Instance.new("TextButton")
    btn.Name = tabName .. "_Button"
    btn.AutoButtonColor = false
    btn.BackgroundColor3 = THEME.Background
    btn.Size = UDim2.new(1, -16, 0, 42)
    btn.Text = tabName
    btn.TextColor3 = THEME.SubText
    btn.Font = Enum.Font.Gotham
    btn.TextSize = 15
    btn.Parent = sidebar

    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 6)
    btnCorner.Parent = btn

    btn.MouseButton1Click:Connect(function()
        switchToTab(tabName)
    end)

    tabButtons[tabName] = btn

    -- content frame for this tab
    local contentFrame = Instance.new("Frame")
    contentFrame.Name = tabName .. "_Content"
    contentFrame.Size = UDim2.new(1, -12, 0, 200)
    contentFrame.BackgroundTransparency = 1
    contentFrame.Parent = contentScroller
    contentFrame.Visible = false

    local vLayout = Instance.new("UIListLayout")
    vLayout.Parent = contentFrame
    vLayout.Padding = UDim.new(0, 10)
    vLayout.SortOrder = Enum.SortOrder.LayoutOrder

    return {
        frame = contentFrame,
        addButton = function(text, callback)
            local b = Instance.new("TextButton")
            b.Text = text
            b.Font = Enum.Font.GothamBold
            b.TextSize = 15
            b.TextColor3 = Color3.new(1,1,1)
            b.Size = UDim2.new(1, 0, 0, 44)
            b.BackgroundColor3 = THEME.AccentDark
            b.AutoButtonColor = false
            b.Parent = contentFrame

            local bc = Instance.new("UICorner")
            bc.CornerRadius = UDim.new(0, 6)
            bc.Parent = b

            b.MouseButton1Click:Connect(function()
                if callback then
                    pcall(callback)
                end
                tweenObject(b, {BackgroundColor3 = THEME.Accent}, TweenInfo.new(0.08))
                wait(0.08)
                tweenObject(b, {BackgroundColor3 = THEME.AccentDark}, TweenInfo.new(0.12))
            end)

            return b
        end,
        addToggle = function(text, default, onChange)
            local holder = Instance.new("Frame")
            holder.Size = UDim2.new(1, 0, 0, 44)
            holder.BackgroundTransparency = 1
            holder.Parent = contentFrame

            local label = Instance.new("TextLabel")
            label.Text = text
            label.Font = Enum.Font.Gotham
            label.TextSize = 15
            label.TextColor3 = THEME.Text
            label.BackgroundTransparency = 1
            label.Position = UDim2.new(0, 8, 0, 8)
            label.Size = UDim2.new(1, -68, 1, -16)
            label.TextXAlignment = Enum.TextXAlignment.Left
            label.Parent = holder

            local toggle = Instance.new("TextButton")
            toggle.Size = UDim2.new(0, 44, 0, 24)
            toggle.Position = UDim2.new(1, -52, 0, 10)
            toggle.BackgroundColor3 = default and THEME.Accent or Color3.fromRGB(50,50,50)
            toggle.Text = ""
            toggle.Parent = holder
            toggle.AutoButtonColor = false

            local toggleCorner = Instance.new("UICorner")
            toggleCorner.CornerRadius = UDim.new(0, 12)
            toggleCorner.Parent = toggle

            local dot = Instance.new("Frame")
            dot.Size = UDim2.new(0, 18, 0, 18)
            dot.Position = default and UDim2.new(1, -38, 0, 3) or UDim2.new(0, 6, 0, 3)
            dot.BackgroundColor3 = Color3.new(1,1,1)
            dot.Parent = toggle

            local dotCorner = Instance.new("UICorner")
            dotCorner.CornerRadius = UDim.new(0, 9)
            dotCorner.Parent = dot

            local state = default or false

            local function update(newState)
                state = newState
                if state then
                    tweenObject(toggle, {BackgroundColor3 = THEME.Accent})
                    tweenObject(dot, {Position = UDim2.new(1, -38, 0, 3)})
                else
                    tweenObject(toggle, {BackgroundColor3 = Color3.fromRGB(50,50,50)})
                    tweenObject(dot, {Position = UDim2.new(0, 6, 0, 3)})
                end
                if onChange then
                    pcall(onChange, state)
                end
            end

            toggle.MouseButton1Click:Connect(function()
                update(not state)
            end)

            update(state)
            return holder
        end,
        addSlider = function(text, min, max, default, onChange)
            local holder = Instance.new("Frame")
            holder.Size = UDim2.new(1, 0, 0, 60)
            holder.BackgroundTransparency = 1
            holder.Parent = contentFrame

            local label = Instance.new("TextLabel")
            label.Text = text
            label.Font = Enum.Font.Gotham
            label.TextSize = 15
            label.TextColor3 = THEME.Text
            label.BackgroundTransparency = 1
            label.Position = UDim2.new(0, 8, 0, 2)
            label.Size = UDim2.new(1, -16, 0, 18)
            label.TextXAlignment = Enum.TextXAlignment.Left
            label.Parent = holder

            local valueLabel = Instance.new("TextLabel")
            valueLabel.Text = tostring(default)
            valueLabel.Font = Enum.Font.Gotham
            valueLabel.TextSize = 14
            valueLabel.TextColor3 = THEME.SubText
            valueLabel.BackgroundTransparency = 1
            valueLabel.Position = UDim2.new(1, -56, 0, 2)
            valueLabel.Size = UDim2.new(0, 48, 0, 18)
            valueLabel.Parent = holder

            local bar = Instance.new("Frame")
            bar.Size = UDim2.new(1, -16, 0, 12)
            bar.Position = UDim2.new(0, 8, 0, 32)
            bar.BackgroundColor3 = Color3.fromRGB(50,50,50)
            bar.Parent = holder

            local barCorner = Instance.new("UICorner")
            barCorner.CornerRadius = UDim.new(0, 6)
            barCorner.Parent = bar

            local fill = Instance.new("Frame")
            fill.Size = UDim2.new( (default - min) / (max - min), 0, 1, 0)
            fill.BackgroundColor3 = THEME.Accent
            fill.Parent = bar

            local fillCorner = Instance.new("UICorner")
            fillCorner.CornerRadius = UDim.new(0, 6)
            fillCorner.Parent = fill

            local dragging = false

            local function updateFillFromX(x)
                local abs = math.clamp(x - bar.AbsolutePosition.X, 0, bar.AbsoluteSize.X)
                local percent = abs / bar.AbsoluteSize.X
                local val = min + (max - min) * percent
                val = math.floor(val*100)/100
                fill.Size = UDim2.new(percent, 0, 1, 0)
                valueLabel.Text = tostring(val)
                if onChange then pcall(onChange, val) end
            end

            bar.InputBegan:Connect(function(inp)
                if inp.UserInputType == Enum.UserInputType.MouseButton1 then
                    dragging = true
                    updateFillFromX(inp.Position.X)
                end
            end)
            bar.InputEnded:Connect(function(inp)
                if inp.UserInputType == Enum.UserInputType.MouseButton1 then
                    dragging = false
                end
            end)
            UserInputService.InputChanged:Connect(function(inp)
                if dragging and inp.UserInputType == Enum.UserInputType.MouseMovement then
                    updateFillFromX(inp.Position.X)
                end
            end)

            return holder
        end
    }
end

-- Create sample tabs and controls
local mainTab = createTab("Main")
local settingsTab = createTab("Settings")

-- Populate Main tab
mainTab.addButton("Print Hello", function()
    print("Hello from Azure Menu!")
end)

mainTab.addToggle("Enable Feature", false, function(state)
    print("Feature state:", state)
end)

mainTab.addSlider("Speed", 0, 500, 16, function(val)
    -- example effect: print value
    print("Speed set to", val)
end)

-- Populate Settings
settingsTab.addToggle("Dark Mode (demo)", true, function(s)
    -- could switch theme here; for demo we just print
    print("Dark mode:", s)
end)
settingsTab.addButton("Reset Position", function()
    main.Position = UDim2.new(0.5, -460, 0.5, -280)
    tweenObject(main, {Size = UDim2.new(0, 920, 0, 560)})
    minimized = false
end)

-- Initialize first tab
switchToTab("Main")

-- Make UI visible initially
main.Visible = true

-- Optional: close UI when player dies or leaves (clean up)
player.CharacterRemoving:Connect(function()
    if screenGui then screenGui:Destroy() end
end)

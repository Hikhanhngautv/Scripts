-- Client: StarterPlayerScripts/NotifAndMenuClient.lua (LocalScript)
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Lấy Remote
local remoteCheck = ReplicatedStorage:WaitForChild("Notif_CheckSeen")
local remoteSet = ReplicatedStorage:WaitForChild("Notif_SetSeen")

-- Helper tạo UI cơ bản
local function createScreenGui(name)
    local sg = Instance.new("ScreenGui")
    sg.Name = name
    sg.ResetOnSpawn = false
    sg.Parent = playerGui
    return sg
end

-- Tạo notification frame (góc phải dưới)
local function createNotificationGui()
    local sg = createScreenGui("NotificationGui")

    local frame = Instance.new("Frame")
    frame.Name = "NotifFrame"
    frame.AnchorPoint = Vector2.new(1, 1) -- góc phải dưới
    frame.Size = UDim2.new(0, 320, 0, 80)
    frame.Position = UDim2.new(1, -16, 1, -16)
    frame.BackgroundTransparency = 0
    frame.BackgroundColor3 = Color3.fromRGB(20,20,20)
    frame.BorderSizePixel = 0
    frame.Parent = sg
    frame.ClipsDescendants = true
    frame.Rotation = 0
    frame.BackgroundTransparency = 0.1

    local txt = Instance.new("TextLabel")
    txt.Size = UDim2.new(1, -20, 1, -20)
    txt.Position = UDim2.new(0, 10, 0, 10)
    txt.BackgroundTransparency = 1
    txt.TextColor3 = Color3.new(1,1,1)
    txt.TextScaled = true
    txt.Text = "Bật thông báo để nhận thông tin\nNhấn 'Bật' để tiếp tục"
    txt.Font = Enum.Font.SourceSansBold
    txt.Parent = frame

    local btn = Instance.new("TextButton")
    btn.Name = "EnableBtn"
    btn.Size = UDim2.new(0, 80, 0, 28)
    btn.Position = UDim2.new(1, -90, 1, -38)
    btn.AnchorPoint = Vector2.new(1, 1)
    btn.Text = "Bật"
    btn.Font = Enum.Font.SourceSans
    btn.TextSize = 18
    btn.BackgroundColor3 = Color3.fromRGB(0,140,255)
    btn.TextColor3 = Color3.new(1,1,1)
    btn.Parent = frame

    -- Ẩn ban đầu (slide in)
    frame.Position = UDim2.new(1, 320, 1, -16)
    return sg, frame, btn
end

-- Tạo toggle button góc trái trên
local function createToggleButtonGui()
    local sg = createScreenGui("ToggleGui")

    local button = Instance.new("TextButton")
    button.Name = "MenuToggleBtn"
    button.Size = UDim2.new(0, 110, 0, 36)
    button.Position = UDim2.new(0, 16, 0, 16)
    button.AnchorPoint = Vector2.new(0,0)
    button.Text = "Menu"
    button.Font = Enum.Font.SourceSansBold
    button.TextSize = 20
    button.BackgroundColor3 = Color3.fromRGB(230, 200, 70)
    button.TextColor3 = Color3.new(0,0,0)
    button.Parent = sg
    button.Visible = false -- hiện sau

    return sg, button
end

-- Tạo menu trung tâm
local function createMenuGui()
    local sg = createScreenGui("MainMenuGui")

    local blur = Instance.new("Frame")
    blur.Name = "BgBlur"
    blur.Size = UDim2.new(1,0,1,0)
    blur.Position = UDim2.new(0,0,0,0)
    blur.BackgroundTransparency = 0.7
    blur.BackgroundColor3 = Color3.fromRGB(0,0,0)
    blur.Parent = sg
    blur.Visible = false

    local frame = Instance.new("Frame")
    frame.Name = "MenuFrame"
    frame.Size = UDim2.new(0, 560, 0, 340)
    frame.Position = UDim2.new(0.5, 0, 0.5, 0)
    frame.AnchorPoint = Vector2.new(0.5, 0.5)
    frame.BackgroundColor3 = Color3.fromRGB(35,35,35)
    frame.Parent = blur
    frame.Visible = true
    frame.AutomaticSize = Enum.AutomaticSize.None
    frame.BorderSizePixel = 0
    frame.BackgroundTransparency = 0

    local title = Instance.new("TextLabel")
    title.Name = "Title"
    title.Size = UDim2.new(1, -20, 0, 44)
    title.Position = UDim2.new(0, 10, 0, 10)
    title.BackgroundTransparency = 1
    title.Text = "Main Farm"
    title.Font = Enum.Font.GothamBold
    title.TextSize = 28
    title.TextColor3 = Color3.fromRGB(240,240,240)
    title.Parent = frame

    -- Add some example toggles/options inside menu (can be extended)
    local function addOption(yOffset, text, initial)
        local opt = Instance.new("Frame")
        opt.Size = UDim2.new(1, -20, 0, 44)
        opt.Position = UDim2.new(0, 10, 0, 10 + yOffset)
        opt.BackgroundTransparency = 1
        opt.Parent = frame

        local label = Instance.new("TextLabel")
        label.Size = UDim2.new(0.7, 0, 1, 0)
        label.Position = UDim2.new(0, 0, 0, 0)
        label.BackgroundTransparency = 1
        label.Text = text
        label.TextColor3 = Color3.fromRGB(220,220,220)
        label.TextSize = 20
        label.Font = Enum.Font.SourceSans
        label.Parent = opt

        local toggle = Instance.new("TextButton")
        toggle.Size = UDim2.new(0.28, 0, 0.8, 0)
        toggle.Position = UDim2.new(0.72, 0, 0.1, 0)
        toggle.AnchorPoint = Vector2.new(0,0)
        toggle.Text = initial and "ON" or "OFF"
        toggle.BackgroundColor3 = initial and Color3.fromRGB(50,200,50) or Color3.fromRGB(180,50,50)
        toggle.TextColor3 = Color3.new(1,1,1)
        toggle.Font = Enum.Font.SourceSansBold
        toggle.TextSize = 18
        toggle.Parent = opt

        toggle.MouseButton1Click:Connect(function()
            initial = not initial
            toggle.Text = initial and "ON" or "OFF"
            toggle.BackgroundColor3 = initial and Color3.fromRGB(50,200,50) or Color3.fromRGB(180,50,50)
            -- implement toggle functionality here
        end)
    end

    addOption(60, "Auto Farm Level", false)
    addOption(120, "Auto Katakuri", false)
    addOption(180, "Auto Bone", false)

    return sg, blur, frame
end

-- Tween helper
local function tweenObject(obj, props, time, style, direction)
    local info = TweenInfo.new(time or 0.35, style or Enum.EasingStyle.Quad, direction or Enum.EasingDirection.Out)
    local t = TweenService:Create(obj, info, props)
    t:Play()
    return t
end

-- Main flow
spawn(function()
    -- 1) Kiểm tra server xem đã bật thông báo chưa
    local seen = false
    local ok, res = pcall(function()
        return remoteCheck:InvokeServer()
    end)
    if ok and res == true then
        seen = true
    else
        seen = false
    end

    -- Tạo GUI
    local notifGui, notifFrame, enableBtn = createNotificationGui()
    local toggleGui, toggleBtn = createToggleButtonGui()
    local menuGui, menuBlur, menuFrame = createMenuGui()

    -- Hàm hiển thị toggle button (kèm animation)
    local function showToggle()
        toggleBtn.Visible = true
        toggleBtn.Position = UDim2.new(0, 16, 0, -60)
        tweenObject(toggleBtn, {Position = UDim2.new(0, 16, 0, 16)}, 0.35)
    end

    -- Hàm hiển thị menu (hiển thị blur và tween scale)
    local function openMenu()
        menuBlur.Visible = true
        menuFrame.Position = UDim2.new(0.5, 0, 0.5, -20)
        menuFrame.Size = UDim2.new(0, 560, 0, 300)
        menuFrame.AnchorPoint = Vector2.new(0.5,0.5)
        menuFrame.BackgroundTransparency = 1
        -- Fade in
        tweenObject(menuFrame, {BackgroundTransparency = 0, Position = UDim2.new(0.5, 0, 0.5, 0)}, 0.25)
        menuBlur.Visible = true
    end

    local function closeMenu()
        tweenObject(menuFrame, {BackgroundTransparency = 1, Position = UDim2.new(0.5, 0, 0.5, -20)}, 0.2)
        wait(0.2)
        menuBlur.Visible = false
    end

    -- Nếu chưa seen -> show notification first
    if not seen then
        -- slide in notification
        tweenObject(notifFrame, {Position = UDim2.new(1, -16, 1, -16)}, 0.35)
        -- xử lý nút bật
        enableBtn.MouseButton1Click:Connect(function()
            -- Gửi lên server lưu rằng đã bật
            spawn(function()
                local ok2, err = pcall(function()
                    remoteSet:FireServer(true)
                end)
                if not ok2 then
                    warn("Failed to set seen:", err)
                end
            end)
            -- ẩn notification bằng tween
            tweenObject(notifFrame, {Position = UDim2.new(1, 320, 1, -16)}, 0.35)
            wait(0.37)
            notifGui:Destroy()
            -- hiện toggle
            showToggle()
        end)
    else
        -- nếu đã seen trước đó thì hiện toggle luôn
        notifGui:Destroy()
        showToggle()
    end

    -- Toggle button click -> show/hide menu
    local menuOpen = false
    toggleBtn.MouseButton1Click:Connect(function()
        menuOpen = not menuOpen
        if menuOpen then
            openMenu()
            toggleBtn.Text = "Đóng"
        else
            closeMenu()
            toggleBtn.Text = "Menu"
        end
    end)

    -- Khi menu blur click bên ngoài, đóng menu
    menuBlur.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            if menuOpen then
                menuOpen = false
                closeMenu()
                toggleBtn.Text = "Menu"
            end
        end
    end)
end)

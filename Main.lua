-- Tải Rayfield UI Library
local Rayfield = loadstring(game:HttpGet("https://raw.githubusercontent.com/Hikhanhngautv/Scripts/refs/heads/main/Rayfield"))()

-- Tạo cửa sổ giao diện
local Window = Rayfield:CreateWindow({
    Name = "🍌 Banana Hamster Hub - Blox Fruits [ Premium ] by Hikhanhngautv",
    LoadingTitle = "Banana Hamster GUI",
    LoadingSubtitle = "by Hikhanhngautv",
    ConfigurationSaving = {
        Enabled = true,
        FolderName = "BananaHamsterHub",
        FileName = "BananaHamsterConfig"
    },
    Discord = {
        Enabled = false,
        Invite = "discord.gg/xxxx", -- để trống nếu không có
        RememberJoins = true
    },
    KeySystem = false, -- nếu bạn muốn có key thì bật true
})

-- Thêm tab
local Tab = Window:CreateTab("Main", 4483362458) -- icon id

-- Thêm button
local Button = Tab:CreateButton({
   Name = "Test Menu",
   Callback = function()
        print("Menu của bạn đã bật!")
   end,
})

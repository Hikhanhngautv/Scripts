4483362458-- Load thư viện Rayfield (bản của bạn)
local Rayfield = loadstring(game:HttpGet('https://raw.githubusercontent.com/Hikhanhngautv/Rayfield-backup/main/Rayfield'))()

-- Tạo cửa sổ chính
local Window = Rayfield:CreateWindow({
    Name = "🍌 Banana Hamster Hub - Blox Fruits [ Premium ] by Hikhanhngautv",
    LoadingTitle = "Banana Hamster GUI",
    LoadingSubtitle = "by Hikhanhngautv",
    ConfigurationSaving = {
        Enabled = true,
        FolderName = "BananaHamsterHub", -- thư mục lưu config
        FileName = "BananaHamsterConfig" -- tên file config
    },
    Discord = {
        Enabled = false,
        Invite = "discord.gg/xxxx", -- bỏ trống nếu không có
        RememberJoins = true
    },
    KeySystem = false -- đổi thành true nếu bạn muốn có hệ thống key
})

-- Tạo 1 tab
local Tab = Window:CreateTab("⚡ Main", 4483362458) -- số là ID icon Roblox

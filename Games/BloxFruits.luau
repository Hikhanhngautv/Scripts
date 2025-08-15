-- Blox Fruits Auto Farm Level Menu by Hikhanhngautv
-- GUI cơ bản + Auto Farm Level

local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = library.CreateLib("Blox Fruits - Auto Farm", "DarkTheme")

local FarmTab = Window:NewTab("Auto Farm")
local FarmSection = FarmTab:NewSection("Farm Level")

local AutoFarm = false

FarmSection:NewToggle("Auto Farm Level", "Tự động farm level từ current -> max", function(state)
    AutoFarm = state
    if state then
        AutoFarmFunc()
    end
end)

function AutoFarmFunc()
    spawn(function()
        while AutoFarm and wait() do
            pcall(function()
                local plr = game.Players.LocalPlayer
                local quest = GetQuestForLevel(plr.Data.Level.Value) -- Hàm lấy quest
                if quest then
                    if not plr.PlayerGui:FindFirstChild("Quest") then
                        game.ReplicatedStorage.Remotes.CommF_:InvokeServer("StartQuest", quest.name, quest.id)
                    else
                        local mob = FindMob(quest.mob)
                        if mob then
                            plr.Character.HumanoidRootPart.CFrame = mob.HumanoidRootPart.CFrame * CFrame.new(0, 5, 0)
                            game:GetService("VirtualUser"):CaptureController()
                            game:GetService("VirtualUser"):Button1Down(Vector2.new(0,0))
                        end
                    end
                end
            end)
        end
    end)
end

-- Bạn cần tự định nghĩa các hàm GetQuestForLevel & FindMob theo level và map hiện tại

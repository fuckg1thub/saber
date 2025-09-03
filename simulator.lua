_G.Y_TEST = 5
local cheatEngine = string.find(identifyexecutor():lower(), "xeno") or string.find(identifyexecutor():lower(), "solara") or string.find(identifyexecutor():lower(), "nezur") or string.find(identifyexecutor():lower(), "jj")
if cheatEngine then
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "executor",
        Text = "your executor is bad, dont expect many features to work",
        Duration = 9
    })
end

local lplr = game.Players.LocalPlayer
local mainClient = lplr.PlayerScripts:WaitForChild("MainClient")
local events = game:GetService("ReplicatedStorage"):WaitForChild("Events")
local crownsPath = game.workspace.Gameplay.CurrencyPickup.CurrencyHolder
local swingModule = (not cheatEngine) and require(mainClient:WaitForChild("ClientTool")) or {}
local swing = function()
    if cheatEngine then return end
    if lplr.Character and lplr.Character:FindFirstChild("Humanoid") and lplr.Character:FindFirstChildOfClass("Tool") == nil then
        local tool = lplr.Backpack:FindFirstChildOfClass("Tool")
        if tool then
            lplr.Character.Humanoid:EquipTool(tool)
        end
    end
    swingModule.Swing()
end
local dataModule = mainClient:WaitForChild("ClientDataManager")
local uiAction = events:WaitForChild("UIAction")
local fuckingJumpMagic = (not cheatEngine) and getsenv(lplr.PlayerScripts.MainClient.DoubleJump).UpdateGuiText or
function() end
local itemInfo = (not cheatEngine) and require(game:GetService("ReplicatedStorage").Modules.ItemInfo) or {}
local classes = (not cheatEngine) and itemInfo.Classes_Order or {}
local lava = {}

for i, v in pairs(workspace.Gameplay.Map.ElementZones.Fire:GetChildren()) do
    if v.Name == "Lava" then
        table.insert(lava, v)
    end
end

local getFireEnemies = function(name)
    local fire = {
        Golems = {},
        Boss = nil
    }
    local path = name == "Earth" and workspace.Gameplay.Map.ElementZones[name].Model[name] or workspace.Gameplay.Map.ElementZones[name][name]
    for i, v in pairs(path:GetChildren()) do
        if string.find(v.Name, "Golem") then
            table.insert(fire.Golems, v)
        elseif string.find(v.Name, "Boss") then
            fire.Boss = v
        end
    end
    return fire
end

if not cheatEngine then
    local popups = require(mainClient.Gui.Popups)
    if not popups:YesNoPopup("Thank you for using NXP Hub!") then
        return
    end
end
local setJumps = function(val)
    if cheatEngine then return end
    debug.setupvalue(fuckingJumpMagic, 1, val)
end
local getData = function()
    if cheatEngine then return end
    return require(dataModule).Data
end
local sell = function()
    events:WaitForChild("SellStrength"):FireServer()
end
local collectCrown = function(root, crown)
    firetouchinterest(root, crown, 0)
end
local claimDailyReward = function()
    uiAction:FireServer("ClaimDailyReward")
end
local collectCrowns = function()
    local character = lplr.Character
    if not character then return end
    local root = character:FindFirstChild("HumanoidRootPart")
    if not root then return end
    for i, crown in pairs(crownsPath:GetChildren()) do
        collectCrown(root, crown)
        if not _G.autoCrowns then return end
        task.wait(0.2)
    end
end
local buyBestSabers = function()
    uiAction:FireServer("BuyAllWeapons")
end
local buyBestDNA = function()
    uiAction:FireServer("BuyAllDNAs")
end
local buyBossHits = function()
    uiAction:FireServer("BuyAllBossBoosts")
end
local buyAuras = function()
    uiAction:FireServer("BuyAllAuras")
end
local buyPetAuras = function()
    uiAction:FireServer("BuyAllPetAuras")
end
local getNextBestClass = function()
    if cheatEngine then return end
    return classes[getData().Best_Class_Index + 1]
end
local buyBestClass = function()
    local bestClass = getNextBestClass()
    if bestClass then
        uiAction:FireServer("BuyClass", bestClass)
    end
end
local equipBestPets = function()
    uiAction:FireServer("EquipBestPets")
end

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
local Window = Rayfield:CreateWindow({
    Name = "NXP Hub",
    Icon = 0,
    LoadingTitle = "Saber Simulator",
    LoadingSubtitle = "NXP Hub",
    ShowText = "NXP Hub",
    Theme = "Default",
})


local AutoFarm = Window:CreateTab("Autofarm", "zap")
local Misc = Window:CreateTab("Miscallenous", "zap")
AutoFarm:CreateToggle({
    Name = "Auto Swing",
    CurrentValue = false,
    Flag = "Toggle1",
    Callback = function(Value)
        _G.autoSwing = Value
        task.spawn(function()
            while _G.autoSwing and task.wait() do
                swing()
            end
        end)
    end,
})
AutoFarm:CreateToggle({
    Name = "Auto Sell",
    CurrentValue = false,
    Flag = "Toggle1",
    Callback = function(Value)
        _G.autoSell = Value
        task.spawn(function()
            while _G.autoSell and task.wait() do
                sell()
            end
        end)
    end,
})
AutoFarm:CreateToggle({
    Name = "Auto Crowns",
    CurrentValue = false,
    Flag = "Toggle1",
    Callback = function(Value)
        _G.autoCrowns = Value
        task.spawn(function()
            while _G.autoCrowns and task.wait(2) do
                local _, res = pcall(collectCrowns)
                if res and res:find("new overlap in different world") then
                    print("fuck you")
                end
            end
        end)
    end,
})
AutoFarm:CreateToggle({
    Name = "Auto Daily Reward",
    CurrentValue = false,
    Flag = "Toggle1",
    Callback = function(Value)
        _G.autoDailyRewards = Value
        task.spawn(function()
            while _G.autoDailyRewards and task.wait(2) do
                claimDailyReward()
            end
        end)
    end,
})

AutoFarm:CreateToggle({
    Name = "Auto Buy Saber",
    CurrentValue = false,
    Flag = "Toggle1",
    Callback = function(Value)
        _G.autoBuySabers = Value
        task.spawn(function()
            while _G.autoBuySabers and task.wait(2) do
                buyBestSabers()
            end
        end)
    end,
})

AutoFarm:CreateToggle({
    Name = "Auto Buy DNA",
    CurrentValue = false,
    Flag = "Toggle1",
    Callback = function(Value)
        _G.autoBuyDna = Value
        task.spawn(function()
            while _G.autoBuyDna and task.wait(2) do
                buyBestDNA()
            end
        end)
    end,
})

AutoFarm:CreateToggle({
    Name = "Auto Buy Boss Hits",
    CurrentValue = false,
    Flag = "Toggle1",
    Callback = function(Value)
        _G.autoBuyHits = Value
        task.spawn(function()
            while _G.autoBuyHits and task.wait(2) do
                buyBossHits()
            end
        end)
    end,
})

AutoFarm:CreateToggle({
    Name = "Auto Buy Class", -- gonna be honest, this feature took way longer than it needed to
    CurrentValue = false,
    Flag = "Toggle1",
    Callback = function(Value)
        _G.autoBuyClasses = Value
        task.spawn(function()
            while _G.autoBuyClasses and task.wait(0.3) do
                buyBestClass()
            end
        end)
    end,
})

AutoFarm:CreateToggle({
    Name = "Auto Buy Aura",
    CurrentValue = false,
    Flag = "Toggle1",
    Callback = function(Value)
        _G.autoBuyAUra = Value
        task.spawn(function()
            while _G.autoBuyAUra and task.wait(2) do
                buyAuras()
            end
        end)
    end,
})

AutoFarm:CreateToggle({
    Name = "Auto Buy Pet Aura",
    CurrentValue = false,
    Flag = "Toggle1",
    Callback = function(Value)
        _G.autoBuyPetAura = Value
        task.spawn(function()
            while _G.autoBuyPetAura and task.wait(2) do
                buyPetAuras()
            end
        end)
    end,
})

AutoFarm:CreateToggle({
    Name = "Auto Equip Best Pets",
    CurrentValue = false,
    Flag = "Toggle1",
    Callback = function(Value)
        _G.autoEquipBest = Value
        task.spawn(function()
            while _G.autoEquipBest and task.wait(2) do
                equipBestPets()
            end
        end)
    end,
})

AutoFarm:CreateToggle({
    Name = "Auto Capture Flags",
    CurrentValue = false,
    Flag = "Toggle1",
    Callback = function(Value)
        _G.autoCapture = Value
    end,
})

AutoFarm:CreateToggle({
    Name = "Auto KOTH",
    CurrentValue = false,
    Flag = "Toggle1",
    Callback = function(Value)
        _G.autoKingOfTheHill = Value
    end,
})

AutoFarm:CreateToggle({
    Name = "Auto Kill Main Boss",
    CurrentValue = false,
    Flag = "Toggle1",
    Callback = function(Value)
        _G.autoKillBoss = Value
    end,
})

AutoFarm:CreateToggle({
    Name = "Auto Kill Element Golems",
    CurrentValue = false,
    Flag = "Toggle1",
    Callback = function(Value)
        _G.autoKillGolems = Value
    end,
})

AutoFarm:CreateToggle({
    Name = "Auto Kill Element Boss",
    CurrentValue = false,
    Flag = "Toggle1",
    Callback = function(Value)
        _G.autoKillFireBoss = Value
    end,
})

local killEnemiesTable = {}
AutoFarm:CreateDropdown({
    Name = "Elements",
    Options = {"Fire", "Earth", "Water"},
    CurrentOption = {},
    MultipleOptions = true,
    Flag = "Dropdown1",
    Callback = function(Options)
        killEnemiesTable = Options
    end,
})

Misc:CreateToggle({
    Name = "Infinite Jumps",
    Callback = function(Value)
        _G.infiniteJumps = Value
        task.spawn(function()
            while _G.infiniteJumps and task.wait() do
                setJumps(0) -- setting jumps to 0 sounds retarded but thats how this game checks if you can jump its fucking stupid and i dont get it
            end
        end)
    end
})

Misc:CreateToggle({
    Name = "Remove Lava Damage",
    Callback = function(Value)
        for i, v in pairs(lava) do
            v.CanTouch = not Value
        end
    end
})

local function getMainBoss()
    return workspace.Gameplay.Boss.BossHolder:FindFirstChild("Boss")
end

local capturingFlags = false
local killingFireEnemies = false
local killingMainBoss = false
local function captureFlags()
    if killingMainBoss then return end
    for i, v in pairs(workspace.Gameplay.Flags:GetChildren()) do
        if v:GetAttribute("OwnerName") ~= lplr.Name then
            local timeout = tick()
            capturingFlags = true
            local isPersonNearby
            repeat
                local character = lplr.Character
                local root = character and character:FindFirstChild("HumanoidRootPart")
                if not root then
                    capturingFlags = false
                    return
                end
                isPersonNearby = (function()
                    for i, p in pairs(lplr.Parent:GetPlayers()) do
                        if p ~= lplr and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                            if (p.Character.HumanoidRootPart.Position - v.Base.Position).magnitude <= 20 then
                                return true
                            end
                        end
                    end
                end)()
                if isPersonNearby then break end
                root.CFrame = v.Base.CFrame + Vector3.new(0, _G.Y_TEST, 0)
                root.Velocity = Vector3.zero
                task.wait()
            until isPersonNearby or (v:GetAttribute("OwnerName") == lplr.Name and tonumber(v:GetAttribute("CapValue")) == 10) or not _G.autoCapture or tick() - timeout >= 25 or killingMainBoss
            if tick() - timeout >= 25 then
                Rayfield:Notify({
                    Title = "Skipped flag",
                    Content = "skipped flag #" .. i .. " because it seemed to be stuck",
                    Duration = 7
                })
            end
        end
    end
    capturingFlags = false
end
local function doKOTH()
    local character = lplr.Character
    local root = character and character:FindFirstChild("HumanoidRootPart")
    if not root then return end
    if capturingFlags or killingFireEnemies or killingMainBoss then return end
    root.CFrame = workspace.Gameplay.KOTH.KOH_BOUNDARY.CFrame + Vector3.new(0, _G.Y_TEST, 0)
    root.Velocity = Vector3.zero
end
local function killEnemies(name)
    if not _G.autoKillGolems then return end
    if capturingFlags then return end
    local enemies = getFireEnemies(name).Golems
    if #enemies > 0 then
        killingFireEnemies = true
        for i, v in pairs(enemies) do
            repeat
                local character = lplr.Character
                local root = character and character:FindFirstChild("HumanoidRootPart")
                if not root then break end
                if v:GetAttribute("Health") <= 0 then break end
                root.CFrame = v.HumanoidRootPart.CFrame
                root.Velocity = Vector3.zero
                swing()
                task.wait()
            until not _G.autoKillGolems or not table.find(killEnemiesTable, name) or killingMainBoss
        end
        killingFireEnemies = false
    end
end
local function killBoss(name)
    if not _G.autoKillFireBoss then return end
    if capturingFlags then return end
    local Boss = getFireEnemies(name).Boss
    if Boss then
        killingFireEnemies = true
        repeat
            local character = lplr.Character
            local root = character and character:FindFirstChild("HumanoidRootPart")
            if not root then break end
            if Boss:GetAttribute("Health") <= 0 then break end
            root.CFrame = Boss.HumanoidRootPart.CFrame
            root.Velocity = Vector3.zero
            if not _G.autoSwing then
                swing()
            end
            task.wait()
        until not _G.autoKillFireBoss or not table.find(killEnemiesTable, name) or killingMainBoss
        killingFireEnemies = false
    end
end
local function killMainBoss()
    local boss = getMainBoss()
    if boss then
        killingMainBoss = true
        local character = lplr.Character
        local root = character and character:FindFirstChild("HumanoidRootPart")
        if root then
            repeat
                root.CFrame = boss.HumanoidRootPart.CFrame
                root.Velocity = Vector3.zero
                if not _G.autoSwing then
                    swing()
                end
                task.wait()
            until not getMainBoss() or not _G.autoKillBoss
            killingMainBoss = false
        end
    else
        killingMainBoss = false
    end
end
task.spawn(function()
    while true do
        local character = lplr.Character
        local root = character and character:FindFirstChild("HumanoidRootPart")
        if root then
            local autoCapture, autoKOTH, autoKill, autoBoss, autoMBoss = _G.autoCapture, _G.autoKingOfTheHill, _G.autoKillGolems, _G.autoKillFireBoss, _G.autoKillBoss
            if autoCapture then
                captureFlags()
            end
            if autoKOTH then
                doKOTH()
            end
            if autoKill then
                for i, v in pairs(killEnemiesTable) do
                    killEnemies(v)
                end
            end
            if autoBoss then
                for i, v in pairs(killEnemiesTable) do
                    killBoss(v)
                end
            end
            if autoMBoss then
                killMainBoss()
            end
        end
        task.wait()
    end
end)

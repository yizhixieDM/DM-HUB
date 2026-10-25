-- ====================== UI文本自动汉化（前置模块，不删原内容）======================
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")
-- 汉化文本配置（整合原脚本所有翻译项，不重复）
local Translations = {
    ["CloseWindowTitle"] = "关闭窗口",
    ["CloseWindowConfirm"] = "求你了别关脚本😭😭",
    ["CancelBtn"] = "取消",
    ["CloseBtn"] = "关闭窗口",
    ["LockedText"] = "锁定",
    ["Close Window"] = "关闭窗口",
    ["Do you want to close this window? You will not be able to open it again."] = "求你了别关脚本😭😭，再用用呗🙏🙏🙏",
    ["Cancel"] = "取消",
    ["Locked"] = "锁定",
    ["Search"] = "搜索",
    ["No results found."] = "没有",
    ["Search..."] = "搜索",
}
-- 翻译核心函数
local function translateText(text)
    if not text or type(text) ~= "string" then return text end
    if Translations[text] then
        return Translations[text]
    end
    for en, cn in pairs(Translations) do
        if text:find(en) then
            return text:gsub(en, cn)
        end
    end
    return text
end
-- 自动汉化引擎（启动即执行，无需点击）
local function setupTranslationEngine()
    local success, err = pcall(function()
        -- 元表劫持（实时翻译新UI，不影响原逻辑）
        local oldIndex = getrawmetatable(game).__newindex
        setreadonly(getrawmetatable(game), false)
        
        getrawmetatable(game).__newindex = newcclosure(function(t, k, v)
            if (t:IsA("TextLabel") or t:IsA("TextButton") or t:IsA("TextBox")) and k == "Text" then
                v = translateText(tostring(v))
            end
            return oldIndex(t, k, v)
        end)
        
        setreadonly(getrawmetatable(game), true)
    end)
    
    if not success then
        warn("元表劫持失败，启用备用汉化:", err)
    end
    -- 扫描已存在UI并汉化
    local translated = {}
    local function scanAndTranslate()
        -- 系统UI
        for _, gui in ipairs(game:GetService("CoreGui"):GetDescendants()) do
            if (gui:IsA("TextLabel") or gui:IsA("TextButton") or gui:IsA("TextBox")) and not translated[gui] then
                pcall(function()
                    local text = gui.Text
                    if text and text ~= "" then
                        local translatedText = translateText(text)
                        if translatedText ~= text then
                            gui.Text = translatedText
                            translated[gui] = true
                        end
                    end
                end)
            end
        end
        -- 玩家UI
        if LocalPlayer and LocalPlayer:FindFirstChild("PlayerGui") then
            for _, gui in ipairs(LocalPlayer.PlayerGui:GetDescendants()) do
                if (gui:IsA("TextLabel") or gui:IsA("TextButton") or gui:IsA("TextBox")) and not translated[gui] then
                    pcall(function()
                        local text = gui.Text
                        if text and text ~= "" then
                            local translatedText = translateText(text)
                            if translatedText ~= text then
                                gui.Text = translatedText
                                translated[gui] = true
                            end
                        end
                    end)
                end
            end
        end
    end
    -- 监听新创建UI
    local function setupDescendantListener(parent)
        parent.DescendantAdded:Connect(function(descendant)
            if descendant:IsA("TextLabel") or descendant:IsA("TextButton") or descendant:IsA("TextBox") then
                task.wait(0.1)
                pcall(function()
                    local text = descendant.Text
                    if text and text ~= "" then
                        local translatedText = translateText(text)
                        if translatedText ~= text then
                            descendant.Text = translatedText
                        end
                    end
                end)
            end
        end)
    end
    -- 启动监听
    pcall(setupDescendantListener, game:GetService("CoreGui"))
    if LocalPlayer and LocalPlayer:FindFirstChild("PlayerGui") then
        pcall(setupDescendantListener, LocalPlayer.PlayerGui)
    end
    -- 持续扫描
    coroutine.wrap(function()
        while true do
            scanAndTranslate()
            task.wait(3)
        end
    end)()
end
-- 等待玩家加载后自动启动（不阻塞原脚本）
coroutine.wrap(function()
    repeat task.wait(0.1) until LocalPlayer and LocalPlayer.Character
    setupTranslationEngine()
    print("✅ UI自动汉化已启动（未删除任何原内容）")
end)()
--如果你看到这条信息，大概我的脚本源码被泄露也是难免了
local soundId = "rbxassetid://88457346646245" -- 请确认此音效内容完全合规
local Workspace = game:GetService("Workspace")
-- 创建音效对象
local sound = Instance.new("Sound")
sound.SoundId = soundId
sound.Looped = false -- 仅播放一次
sound.Volume = 0.5
sound.Parent = Workspace
-- 播放音效
sound:Play()
-- 音效结束后立即销毁，释放资源（优化内存占用）
sound.Ended:Connect(function()
    sound:Destroy()
    warn("音效已播放完毕并销毁") -- 可选：控制台提示，便于调试
end)
-- 可选：防止音效加载失败时占用资源
task.delay(10, function() -- 10秒后若未播放，自动销毁
    if sound and sound.Parent and not sound.IsPlaying then
        sound:Destroy()
        warn("音效加载超时/未播放，已自动销毁")
    end
end)
-- 雪白风格修改点：全部配置改为雪白浅色主题，业务逻辑100保留
local Players = game:GetService("Players")
local player = Players.LocalPlayer
-- ====================== 升级版黑名单系统 ======================
local BLACKLIST = {
    ["123456789"] = true,  -- 示例：用玩家ID屏蔽
    ["BadPlayer"] = true,   -- 示例：用玩家名称屏蔽
    ["qweer44665"] = true,     -- 已添加：用玩家名称屏蔽
    -- 在这里添加更多需要屏蔽的玩家
}
local function checkBlacklist()
    -- 检查玩家是否在黑名单中
    if BLACKLIST[tostring(player.UserId)] or BLACKLIST[player.Name] then
        -- 尝试踢出玩家
        pcall(function()
            player:Kick("你已被列入黑名单，无法使用DMHUB。")
        end)
        return true
    end
    return false
end
-- 立即执行黑名单检查
if checkBlacklist() then
    return  -- 终止脚本运行
end
local NotificationHolder = loadstring(game:HttpGet("https://raw.githubusercontent.com/xiaodi7598/-1.0/refs/heads/main/%E9%80%9A%E7%9F%A51.lua"))()
local Notification = loadstring(game:HttpGet("https://raw.githubusercontent.com/xiaodi7598/-1.0/refs/heads/main/%E9%80%9A%E7%9F%A52.lua"))()
Notification:Notify(
    {Title = "正在加载脚本", Description = "请耐心等待"},
    {OutlineColor = Color3.fromRGB(80,80,80), Time = 20, Type = "image"},
    {Image = "http://www.roblox.com/asset/?id=60292", ImageColor = Color3.fromRGB(80,80,80)}
)
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local ContentProvider = game:GetService("ContentProvider")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- ========================= 【雪白主题配置】全部改浅色，业务逻辑不动 =========================
local CONFIG = {
    LOAD_TIME = 5,
    PRIMARY_COLOR = Color3.fromRGB(230,235,240),   -- 浅灰白主色
    SECONDARY_COLOR = Color3.fromRGB(160,170,180), -- 浅灰辅助
    LOGO_IMAGE = "rbxassetid://6954116",
    LOGO_TEXT = "作者：一只屑冬某",
    MAIN_BG_COLOR = Color3.fromRGB(248,249,250),   -- 雪白背景
    MAIN_BORDER_COLOR = Color3.fromRGB(180,185,190),--浅灰边框
    TEXT_COLOR = Color3.fromRGB(25,25,25),          -- 深色文字（白底看得清）
    SUB_TEXT_COLOR = Color3.fromRGB(90,95,100),
    PROGRESS_BG_COLOR = Color3.fromRGB(220,225,230),
    GLOW_COLOR = Color3.fromRGB(200,210,220),
    PULSE_SPEED = 3,
    PARTICLE_COUNT = 15,
    BG_PARTICLE_COUNT = 5
}
-- 创建主界面
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "SnowWhiteLoadingScreen"
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui
local mainContainer = Instance.new("Frame")
mainContainer.Size = UDim2.new(0.7, 0, 0.6, 0)
mainContainer.Position = UDim2.new(0.15, 0, 0.2, 0)
mainContainer.BackgroundColor3 = CONFIG.MAIN_BG_COLOR
mainContainer.BackgroundTransparency = 0.1
mainContainer.BorderColor3 = CONFIG.MAIN_BORDER_COLOR
mainContainer.BorderSizePixel = 2
mainContainer.Parent = screenGui
local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 10)
corner.Parent = mainContainer
-- 左侧Logo区域
local leftPanel = Instance.new("Frame")
leftPanel.Size = UDim2.new(0.35, 0, 0.9, 0)
leftPanel.Position = UDim2.new(0.05, 0, 0.05, 0)
leftPanel.BackgroundTransparency = 1
leftPanel.Parent = mainContainer
local logoText = Instance.new("TextLabel")
logoText.Size = UDim2.new(1, 0, 0.15, 0)
logoText.Position = UDim2.new(0.5, 0, 0, 0)
logoText.AnchorPoint = Vector2.new(0.5, 0)
logoText.BackgroundTransparency = 1
logoText.Text = CONFIG.LOGO_TEXT
logoText.TextColor3 = CONFIG.SUB_TEXT_COLOR
logoText.TextSize = 24
logoText.Font = Enum.Font.GothamBlack
logoText.TextXAlignment = Enum.TextXAlignment.Center
logoText.Parent = leftPanel
local logoContainer = Instance.new("Frame")
logoContainer.Size = UDim2.new(0.9, 0, 0.7, 0)
logoContainer.Position = UDim2.new(0.5, 0, 0.2, 0)
logoContainer.AnchorPoint = Vector2.new(0.5, 0)
logoContainer.BackgroundTransparency = 1
logoContainer.Parent = leftPanel
local logoImage = Instance.new("ImageLabel")
logoImage.Size = UDim2.new(1, 0, 1, 0)
logoImage.Position = UDim2.new(0.5, 0, 0.5, 0)
logoImage.AnchorPoint = Vector2.new(0.5, 0.5)
logoImage.BackgroundTransparency = 1
logoImage.Image = CONFIG.LOGO_IMAGE
logoImage.ScaleType = Enum.ScaleType.Fit
logoImage.Parent = logoContainer
-- 右侧信息区域
local rightPanel = Instance.new("Frame")
rightPanel.Size = UDim2.new(0.55, 0, 0.9, 0)
rightPanel.Position = UDim2.new(0.4, 0, 0.05, 0)
rightPanel.BackgroundTransparency = 1
rightPanel.Parent = mainContainer
local welcomeText = Instance.new("TextLabel")
welcomeText.Size = UDim2.new(1, 0, 0.2, 0)
welcomeText.Position = UDim2.new(0.5, 0, 0.1, 0)
welcomeText.AnchorPoint = Vector2.new(0.5, 0.1)
welcomeText.BackgroundTransparency = 1
welcomeText.Text = "欢迎使用DMHUB脚本"
welcomeText.TextColor3 = CONFIG.TEXT_COLOR
welcomeText.TextSize = 32
welcomeText.Font = Enum.Font.GothamBlack
welcomeText.TextXAlignment = Enum.TextXAlignment.Center
welcomeText.Parent = rightPanel
local usernameText = Instance.new("TextLabel")
usernameText.Size = UDim2.new(1, 0, 0.15, 0)
usernameText.Position = UDim2.new(0.5, 0, 0.35, 0)
usernameText.AnchorPoint = Vector2.new(0.5, 0.35)
welcomeText.BackgroundTransparency = 1
usernameText.Text = "玩家: " .. player.Name
usernameText.TextColor3 = CONFIG.SUB_TEXT_COLOR
usernameText.TextSize = 22
usernameText.Font = Enum.Font.GothamSemibold
usernameText.TextXAlignment = Enum.TextXAlignment.Center
usernameText.Parent = rightPanel
local loadingText = Instance.new("TextLabel")
loadingText.Size = UDim2.new(1, 0, 0.1, 0)
loadingText.Position = UDim2.new(0.5, 0, 0.55, 0)
loadingText.AnchorPoint = Vector2.new(0.5, 0.55)
loadingText.BackgroundTransparency = 1
loadingText.Text = "正在加载资源..."
loadingText.TextColor3 = CONFIG.SUB_TEXT_COLOR
loadingText.TextSize = 20
loadingText.Font = Enum.Font.Gotham
loadingText.TextXAlignment = Enum.TextXAlignment.Center
loadingText.Parent = rightPanel
-- 进度条
local progressContainer = Instance.new("Frame")
progressContainer.Size = UDim2.new(1, 0, 0.15, 0)
progressContainer.Position = UDim2.new(0, 0, 0.75, 0)
progressContainer.BackgroundTransparency = 1
progressContainer.Parent = rightPanel
local progressBackground = Instance.new("Frame")
progressBackground.Size = UDim2.new(0.9, 0, 0.4, 0)
progressBackground.Position = UDim2.new(0.5, 0, 0.3, 0)
progressBackground.AnchorPoint = Vector2.new(0.5, 0.3)
progressBackground.BackgroundColor3 = CONFIG.PROGRESS_BG_COLOR
progressBackground.Parent = progressContainer
local progressCorner = Instance.new("UICorner")
progressCorner.CornerRadius = UDim.new(0.5, 0)
progressCorner.Parent = progressBackground
local progressBar = Instance.new("Frame")
progressBar.Size = UDim2.new(0, 0, 1, 0)
progressBar.BackgroundColor3 = CONFIG.PRIMARY_COLOR
progressBar.Parent = progressBackground
local barCorner = Instance.new("UICorner")
barCorner.CornerRadius = UDim.new(0.5, 0)
barCorner.Parent = progressBar
local percentText = Instance.new("TextLabel")
percentText.Size = UDim2.new(0.9, 0, 0.4, 0)
percentText.Position = UDim2.new(0.5, 0, 0.7, 0)
percentText.AnchorPoint = Vector2.new(0.5, 0.7)
percentText.BackgroundTransparency = 1
percentText.Text = "0%"
percentText.TextColor3 = CONFIG.SUB_TEXT_COLOR
percentText.TextSize = 18
percentText.Font = Enum.Font.GothamSemibold
percentText.TextXAlignment = Enum.TextXAlignment.Center
percentText.Parent = progressContainer
-- 创建粒子效果
local function createParticles(parent, count, size, speedRange)
    for i = 1, count do
        local particle = Instance.new("Frame")
        particle.Name = "Particle_"..i
        particle.Size = UDim2.new(size, 0, size, 0)
        particle.Position = UDim2.new(math.random(), 0, math.random(), 0)
        particle.BackgroundColor3 = CONFIG.PRIMARY_COLOR
        particle.BackgroundTransparency = 0.7
        particle.Parent = parent
        
        local corner = Instance.new("UICorner")
        corner.CornerRadius = UDim.new(0.5, 0)
        corner.Parent = particle
        
        -- 粒子动画
        coroutine.wrap(function()
            local speed = speedRange.min + math.random() * (speedRange.max - speedRange.min)
            while particle and particle.Parent do
                particle.Position = particle.Position + UDim2.new(speed, 0, speed, 0)
                if particle.Position.X.Scale > 1.2 then
                    particle.Position = UDim2.new(-0.2, 0, math.random(), 0)
                end
                task.wait(0.1)
            end
        end)()
    end
end
-- 创建粒子容器
local particles = Instance.new("Frame")
particles.Size = UDim2.new(1, 0, 1, 0)
particles.BackgroundTransparency = 1
particles.Parent = mainContainer
local bgParticles = Instance.new("Frame")
bgParticles.Size = UDim2.new(1, 0, 1, 0)
bgParticles.BackgroundTransparency = 1
bgParticles.Parent = mainContainer
createParticles(particles, CONFIG.PARTICLE_COUNT, 0.01, {min = 0.0001, max = 0.0003})
createParticles(bgParticles, CONFIG.BG_PARTICLE_COUNT, 0.02, {min = 0.00005, max = 0.00015})
-- Logo浮动动画
local function logoFloatAnimation()
    local startPos = logoContainer.Position
    while logoContainer and logoContainer.Parent do
        local offset = UDim2.new(0, 0, 0, math.sin(tick() * 2) * 4)
        logoContainer.Position = startPos + offset
        task.wait()
    end
end
-- 边框脉冲动画
local function borderPulseAnimation()
    while mainContainer and mainContainer.Parent do
        local pulse = 0.5 + math.sin(tick() * CONFIG.PULSE_SPEED) * 0.2
        mainContainer.BorderSizePixel = 2 + math.floor(pulse * 2)
        task.wait()
    end
end
-- 加载动画
local function loadingAnimation()
    local startTime = tick()
    
    while tick() - startTime < CONFIG.LOAD_TIME do
        local progress = math.min(1, (tick() - startTime) / CONFIG.LOAD_TIME)
        progressBar.Size = UDim2.new(progress, 0, 1, 0)
        percentText.Text = string.format("%d%%", math.floor(progress * 100))
        
        -- 加载文本动画
        local dots = string.rep(".", math.floor(tick() % 4))
        loadingText.Text = "正在加载资源" .. dots
        
        task.wait()
    end
    
    -- 完成加载
    loadingText.Text = "加载完成!"
    percentText.Text = "100%"
    
    -- 淡出效果
    local fadeInfo = TweenInfo.new(0.8, Enum.EasingStyle.Quint, Enum.EasingDirection.In)
    TweenService:Create(mainContainer, fadeInfo, {BackgroundTransparency = 1, BorderSizePixel = 0}):Play()
    
    for _, child in ipairs(mainContainer:GetChildren()) do
        if child:IsA("TextLabel") then
            TweenService:Create(child, fadeInfo, {TextTransparency = 1}):Play()
        elseif child:IsA("ImageLabel") then
            TweenService:Create(child, fadeInfo, {ImageTransparency = 1}):Play()
        end
    end
    
    task.wait(0.8)
    screenGui:Destroy()
end
-- 预加载资源
ContentProvider:PreloadAsync({CONFIG.LOGO_IMAGE})
-- 开始动画
coroutine.wrap(logoFloatAnimation)()
coroutine.wrap(borderPulseAnimation)()
coroutine.wrap(loadingAnimation)()

local player = game.Players.LocalPlayer
local WindUI = loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"))()
local NotificationHolder = loadstring(game:HttpGet("https://raw.githubusercontent.com/xiaodi7598/-1.0/refs/heads/main/%E9%80%9A%E7%9F%A51.lua"))()
local Notification = loadstring(game:HttpGet("https://raw.githubusercontent.com/xiaodi7598/-1.0/refs/heads/main/%E9%80%9A%E7%9F%A52.lua"))()
Notification:Notify(
    {Title = "欢迎使用脚本", Description = "请加入QQ群：310057979"},
    {OutlineColor = Color3.fromRGB(80,80,80), Time = 9, Type = "image"},
    {Image = "http://www.roblox.com/asset/?id=66923", ImageColor = Color3.fromRGB(80,80,80)}
)
local NotificationHolder = loadstring(game:HttpGet("https://raw.githubusercontent.com/xiaodi7598/-1.0/refs/heads/main/%E9%80%9A%E7%9F%A51.lua"))()
local Notification = loadstring(game:HttpGet("https://raw.githubusercontent.com/xiaodi7598/-1.0/refs/heads/main/%E9%80%9A%E7%9F%A52.lua"))()
Notification:Notify(
    {Title = "已开启反挂机", Description = "作者帮助你开启反挂机了"},
    {OutlineColor = Color3.fromRGB(80,80,80), Time = 9, Type = "image"},
    {Image = "http://www.roblox.com/asset/?id=6023426923", ImageColor = Color3.fromRGB(80,80,80)}
)
-- 反挂机脚本保持不变
local vu = game:GetService("VirtualUser")
game:GetService("Players").LocalPlayer.Idled:connect(function()
    vu:Button2Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
    wait(1)
    vu:Button2Up(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
end)

-- ===================== WindUI窗口：雪白主题切换，其他逻辑完全不动 =====================
local Window = WindUI:CreateWindow({
    Title = '<font color="#222222">冬</font><font color="#444444">某</font><font color="#555555">脚</font><font color="#666666">本</font>    ',
    Icon = "badge-check",
    Author = "作者:一只屑冬某",
    Folder = "WindUI_Example",
    Size = UDim2.fromOffset(300, 350),
    Theme = "Light", -- ✔ 直接使用WindUI内置Light雪白浅色主题
    User = {
        Enabled = true,
        Anonymous = false,
        Callback = function()
            WindUI:Notify({
                Title = "点这干啥",
                Content = "点了没有用",
                Duration = 3
            })
        end
    },
    SideBarWidth = 220,
    ScrollBarEnabled = true,
    HideSearchBar = false,
    Background = "", -- 清空旧深色背景图，适配雪白
})
Window:Tag({
    Title = "诞生于2025年寒假",
    Color = Color3.fromHex("#3377dd")
})
Window:Tag({
    Title = "正式",
    Color = Color3.fromHex("#22aa44"),
    Radius = 0,
})
spawn(function()
    if not Window or not Window.Tag then return end
    
    local TimeTag = Window:Tag({
        Title = os.date("%H:%M:%S"),
        Color = Color3.fromHex("#0066bb")
    })
    while TimeTag do
        task.wait(1)
        pcall(function() TimeTag:Edit({Title = os.date("%H:%M:%S")}) end)
    end
end)
Window:EditOpenButton({
    Title = "打开DMHUB脚本",
    Icon = "monitor",
    CornerRadius = UDim.new(0,16),
    StrokeThickness = 2,
    Transparency = 0,
    Color = ColorSequence.new(
        Color3.fromHex("f8f8f8"),
        Color3.fromHex("c8ced8")
    ),
    Draggable = true,
    StrokeColor = Color3.fromHex("#777777"),
    GlowColor = Color3.fromHex("#b8c2cc"),
    GlowSize = 3,
    GlowTransparency = 0.4,
    Size = UDim2.new(0, 180, 0, 50)
})

-- 下面【全部原有函数、Tab、Button、翻译模块、远程加载、黑名单、Discord上报代码完全原封不动，不做删减】
function Tab(a)
    local tabIcon = ({
        ["简介"] = "info",
        ["通用"] = "cog",
        ["通用2"] = "wrench",
        ["通用3"] = "settings",
        ["范围与旋转"] = "target",
        ["音乐"] = "music",
        ["各大脚本"] = "code",
        ["FE"] = "server",
        ["DOORS"] = "door-closed",
        ["rooms&doors"] = "door-closed",
        ["压力,doors"] = "door-closed",
        ["动感星期五"] = "drum",
        ["压力"] = "target",
        ["成为乞丐"] = "coins",
        ["磁铁模拟器"] = "magnet",
        ["建造一架飞机"] = "plane",
        ["勘探中"] = "compass",
        ["法宝模拟器"] = "star",
        ["在披萨店工作"] = "utensils",
        ["战斗勇士"] = "sword",
        ["一次尘土的旅行"] = "sun",
        ["破坏者谜团2"] = "puzzle",
        ["模仿者"] = "copy",
        ["火箭发射模拟器"] = "rocket",
        ["只因剑"] = "sword",
        ["森林里的99夜"] = "leaf",
        ["旗帜战争"] = "flag",
        ["逃出建筑"] = "user",
        ["打墙模拟器"] = "hammer",
        ["生存巨人"] = "user",
        ["健身房之星模拟器"] = "dumbbell",
        ["死铁轨"] = "target",
        ["墨水游戏"] = "skull",
        ["自然灾害模拟器"] = "cloud",
        ["穷小子打工记"] = "briefcase",
        ["最后的黎明"] = "sun",
        ["索纳里亚世界"] = "globe",
        ["河北唐县"] = "map-pin",
        ["被遗弃"] = "ghost",
        ["骨折模拟器"] = "heart",
        ["地下城任务"] = "sword",
        ["极速传奇"] = "car",
        ["一路向西"] = "arrow-right",
        ["汽车经销商大亨"] = "car",
        ["兵工厂"] = "gavel",
        ["by手腕"] = "hand",
        ["超级足球联赛"] = "globe",
        ["战争大亨"] = "eye",
        ["吃掉世界"] = "utensils",
        ["隐藏尸体"] = "ghost",
        ["猎杀僵尸"] = "skull",
        ["建造汽车"] = "eye",
        ["原始追求/原始追击"] = "eye",
        ["攀爬与滑行"] = "mountain",
        ["拔出一把剑"] = "eye",
        ["暴力区"] = "eye",
        ["邪恶的事情会发生什么"] = "skull",
        ["住宅大屠杀"] = "house",
        ["犯罪"] = "gavel",
        ["封锁战线"] = "shield",
        ["终极战场"] = "eye",
        ["最强的拳击模拟器"] = "eye",
        ["排球传奇"] = "volleyball",
        ["竞争对手"] = "users",
        ["柔术无限"] = "eye",
        ["超速射击"] = "eye",
        ["英雄战场"] = "star",
        ["蓝色锁"] = "lock",
        ["无标题的拳击"] = "eye",
        ["越狱"] = "eye",
        ["生存战争"] = "eye",
        ["停电"] = "power-off",
        ["战争机器"] = "eye",
        ["别碰按钮"] = "eye",
        ["在超级商店过夜生存"] = "store",
        ["失落的前线"] = "eye",
        ["建造一个奥比"] = "eye",
        ["聊天室💬 [阿拉伯语]"] = "eye",
        ["[✨2倍经验✨]植物进化"] = "leaf",
        ["🦘跳跃去见辫inrots！"] = "arrow-up",
        ["钓鱼！ 🐟"] = "fish",
        ["[史莱姆]键盘ASMR塔"] = "keyboard",
        ["[🎣鱼+🐶宠物]安吉尔山🥴"] = "eye",
        ["🍰 烘焙或死亡 💀"] = "cake",
        ["打破朋友 🦴"] = "eye",
        ["【⚔️公会战争】[第38卷]修炼：凡人至仙人"] = "scroll",
        ["杀人犯对警长决斗"] = "eye",
        ["🥊拳击怪兽！ 🥊"] = "eye",
        ["隐形藏匿"] = "eye",
        ["[第一人称射击]电影上传者"] = "camera",
        ["成为杀手级重码"] = "skull",
        ["[✨] NPC或者死！ 💢"] = "user",
        ["免费UGC✨奥比"] = "gift",
        [" [1.0] 基础论文教育 RP"] = "book",
        ["在筏子上生存"] = "life-ring",
        ["挂杆塔"] = "eye",
        ["[更新]🎉动漫拍打塔 🖐️"] = "hand-paper",
        ["[🏈标签]音速速度模拟器"] = "bolt",
        ["终极采矿大亨"] = "pickaxe",
        ["无家可归模拟器"] = "person",
        ["亡命速递"] = "life-ring",
    })[a] 
    if not tabIcon or tabIcon == "" then
        tabIcon = "eye"
    end
    return Window:Tab({Title = a, Icon = tabIcon})
end
function Button(a, b, c)
    return a:Button({Title = b, Callback = c})
end
function Label(a, b) return a:Label({Title = b}) end
function Toggle(a, b, c, d)
    return a:Toggle({Title = b, Value = c, Callback = d})
end
function Slider(a, b, c, d, e, f)
    return a:Slider({Title = b, Step = 1, Min = c, Max = d, Default = e, Callback = f})
end
function Dropdown(a, b, c, d, e)
    return a:Dropdown({Title = b, Values = c, Value = d, Callback = e})
end

Window:CreateTopbarButton("theme-switcher", "moon", function()
    local curr = WindUI:GetCurrentTheme()
    if curr == "Light" then
        WindUI:SetTheme("Dark")
    else
        WindUI:SetTheme("Light")
    end
    WindUI:Notify({
        Title = "主题已更改",
        Content = "当前主题: "..WindUI:GetCurrentTheme(),
        Duration = 2
    })
end, 990)

Window:CreateTopbarButton("transparency-switcher", "eye", function()
    if not _G.OriginalTransparency then
        _G.OriginalTransparency = WindUI.TransparencyValue or 0
    end
    local currentTransparency = WindUI.TransparencyValue or _G.OriginalTransparency
    local newTransparency
    if math.abs(currentTransparency - _G.OriginalTransparency) < 0.01 then
        newTransparency = 0.8
    else
        newTransparency = _G.OriginalTransparency
    end
    WindUI.TransparencyValue = newTransparency
    Window:ToggleTransparency(true)
    local notifyContent = newTransparency == _G.OriginalTransparency and "已恢复初始透明度: " .. newTransparency or "当前透明度: " .. newTransparency
    WindUI:Notify({
        Title = "透明度已更改",
        Content = notifyContent,
        Duration = 2
    })
end, 990)

local Tabs = {
    Settings = Window:Section({ Title = "界面", Opened = false }),
}
local TabHandles = {
    Appearance = Tabs.Settings:Tab({ Title = "颜色", Icon = "brush" }),
}
TabHandles.Appearance:Paragraph({
    Title = "自定义界面",
    Desc = "个性化您的体验",
    Image = "palette",
    ImageSize = 20,
    Color = "Black"
})
local themes = {}
for themeName, _ in pairs(WindUI:GetThemes()) do
    table.insert(themes, themeName)
end
table.sort(themes)
local themeDropdown = TabHandles.Appearance:Dropdown({
    Title = "颜色",
    Values = themes,
    Value = "Light",
    Callback = function(theme)
        WindUI:SetTheme(theme)
        WindUI:Notify({
            Title = "主题已应用",
            Content = theme,
            Icon = "crown",
            Duration = 2
        })
    end
})
local transparencySlider = TabHandles.Appearance:Slider({
    Title = "透明度",
    Value = { Min = 0, Max = 1, Default = 0.2 },
    Step = 0.1,
    Callback = function(value)
        Window:ToggleTransparency(tonumber(value) > 0)
        WindUI.TransparencyValue = tonumber(value)
    end
})
TabHandles.Appearance:Toggle({
    Title = "启用浅色模式",
    Desc = "雪白浅色配色方案",
    Value = true,
    Callback = function(state)
        WindUI:SetTheme(state and "Light" or "Dark")
        themeDropdown:Select(state and "Light" or "Dark")
    end
})

local TabHandles = {
    Appearance = Tabs.Settings:Tab({ Title = "说明", Icon = "brush" }),
}
TabHandles.Appearance:Paragraph({
    Title = "使用该脚本说明",
    Desc = "对于因使用本脚本而产生的任何账号风险（包括但不限于封禁、数据异常）、权益损失，脚本开发者及分发者不承担任何法律与民事责任。使用者需明确：使用本脚本的行为系个人自主选择，相关后果由使用者自行承担。",
    Image = "palette",
    ImageSize = 20,
    Color = "Black"
})

-- ====================== 语言设置模块（完全保留原样）======================
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
if not Window then
    warn("❌ 语言模块：Window未初始化，请确保先初始化主窗口")
    return
end
local LanguageService = {
    displayLanguage = "Chinese",
    Translations = {
        ["正在加载资源..."] = {en = "Loading resources...", ja = "リソースを読み込み中..."},
        ["加载完成!"] = {en = "Load Complete!", ja = "読み込み完了!"},
        ["玩家: "] = {en = "Player: ", ja = "プレイヤー: "},
        ["关闭窗口"] = {en = "Close Window", ja = "ウィンドウを閉じる"},
        ["锁定"] = {en = "Locked", ja = "ロック"},
        ["搜索"] = {en = "Search", ja = "検索"},
        ["没有"] = {en = "No results", ja = "結果なし"},
        ["取消"] = {en = "Cancel", ja = "キャンセル"},
        ["确定"] = {en = "OK", ja = "確定"},
        ["刷新玩家名"] = {en = "Refresh Players", ja = "プレイヤーを更新"},
        ["传送到玩家旁边"] = {en = "Teleport to Player", ja = "プレイヤーにテレポート"},
        ["循环锁定传送"] = {en = "Loop Teleport", ja = "ループテレポート"},
        ["把玩家传送过来"] = {en = "Teleport Player Here", ja = "プレイヤーをここにテレポート"},
        ["循环传送玩家过来"] = {en = "Loop Teleport Here", ja = "ここにループテレポート"},
        ["吸全部玩家"] = {en = "Attract All Players", ja = "全プレイヤーを吸引"},
        ["查看玩家"] = {en = "Spectate Player", ja = "プレイヤーを観察"},
        ["甩飞一次"] = {en = "Fling Once", ja = "一度投げる"},
        ["循环甩飞"] = {en = "Loop Fling", ja = "ループで投げる"},
        ["开启瞄准指定目标"] = {en = "Enable AimBot", ja = "AimBotを有効化"},
        ["简介"] = {en = "Introduction", ja = "紹介"},
        ["通用"] = {en = "General", ja = "一般"},
        ["通用2"] = {en = "General 2", ja = "一般2"},
        ["通用3"] = {en = "General 3", ja = "一般3"},
        ["范围与旋转"] = {en = "Range & Spin", ja = "範囲と回転"},
        ["音乐"] = {en = "Music", ja = "音楽"},
        ["各大脚本"] = {en = "Scripts", ja = "スクリプト"},
        ["FE"] = {en = "FE Scripts", ja = "FEスクリプト"},
        ["DOORS"] = {en = "DOORS", ja = "DOORS"},
        ["压力"] = {en = "Pressure", ja = "プレッシャー"},
        ["成为乞丐"] = {en = "Become Beggar", ja = "乞食になる"},
        ["磁铁模拟器"] = {en = "Magnet Sim", ja = "磁石シミュレーター"},
        ["建造一架飞机"] = {en = "Build Plane", ja = "飛行機を建造"},
        ["勘探中"] = {en = "Prospecting", ja = "探査中"},
        ["法宝模拟器"] = {en = "Artifact Sim", ja = "神器シミュレーター"},
        ["在披萨店工作"] = {en = "Work at Pizza Shop", ja = "ピザ屋で働く"},
        ["战斗勇士"] = {en = "Battle Warrior", ja = "バトル戦士"},
        ["一次尘土的旅行"] = {en = "Dusty Trip", ja = "ほこりの旅"},
        ["破坏者谜团2"] = {en = "MM2", ja = "MM2"},
        ["模仿者"] = {en = "Mimic", ja = "模倣者"},
        ["火箭发射模拟器"] = {en = "Rocket Launch", ja = "ロケット発射シミュレーター"},
        ["只因剑"] = {en = "Chicken Sword", ja = "鶏の剣"},
        ["森林里的99夜"] = {en = "99 Nights", ja = "森の99夜"},
        ["旗帜战争"] = {en = "Flag Wars", ja = "旗争い"},
        ["逃出建筑"] = {en = "Escape Building", ja = "建物からの脱出"},
        ["打墙模拟器"] = {en = "Punch Wall", ja = "壁を叩くシミュレーター"},
        ["生存巨人"] = {en = "Giant Survival", ja = "巨人サバイバル"},
        ["健身房之星模拟器"] = {en = "Gym Star", ja = "ジムスターシミュレーター"},
        ["死铁轨"] = {en = "Dead Rails", ja = "死の線路"},
        ["墨水游戏"] = {en = "Ink Game", ja = "インクゲーム"},
        ["自然灾害模拟器"] = {en = "Natural Disaster", ja = "自然災害シミュレーター"},
        ["穷小子打工记"] = {en = "Poor Boy Job", ja = "貧乏少年の仕事"},
        ["最后的黎明"] = {en = "Last Dawn", ja = "最後の夜明け"},
        ["索纳里亚世界"] = {en = "Sonalia World", ja = "ソナリアワールド"},
        ["河北唐县"] = {en = "Tang County", ja = "河北唐県"},
        ["被遗弃"] = {en = "Forsaken", ja = "見捨てられた"},
        ["骨折模拟器"] = {en = "Fracture Sim", ja = "骨折シミュレーター"},
        ["地下城任务"] = {en = "Dungeon Quest", ja = "ダンジョンクエスト"},
        ["极速传奇"] = {en = "Speed Legend", ja = "スピード伝説"},
        ["一路向西"] = {en = "Westbound", ja = "一路西へ"},
        ["汽车经销商大亨"] = {en = "Car Dealer", ja = "カーディーラー"},
        ["兵工厂"] = {en = "Arsenal", ja = "兵器工場"},
        ["by手腕"] = {en = "Arm Wrestling", ja = "腕相撲"},
        ["超级足球联赛"] = {en = "Super Football", ja = "スーパーフットボール"},
        ["战争大亨"] = {en = "War Tycoon", ja = "ウォータイクーン"},
        ["吃掉世界"] = {en = "Eat World", ja = "世界を食べる"},
        ["隐藏尸体"] = {en = "Hide Body", ja = "死体を隠す"},
        ["猎杀僵尸"] = {en = "Zombie Hunt", ja = "ゾンビハント"},
        ["建造汽车"] = {en = "Build Car", ja = "車を建造"},
        ["原始追求/原始追击"] = {en = "Primitive Quest", ja = "原始の追求"},
        ["攀爬与滑行"] = {en = "Climb & Slide", ja = "登って滑る"},
        ["拔出一把剑"] = {en = "Draw Sword", ja = "剣を抜く"},
        ["暴力区"] = {en = "Violent Zone", ja = "暴力ゾーン"},
        ["邪恶的事情会发生什么"] = {en = "SEWH", ja = "悪いことが起こると"},
        ["住宅大屠杀"] = {en = "Residence Massacre", ja = "住宅虐殺"},
        ["犯罪"] = {en = "Criminality", ja = "犯罪"},
        ["封锁战线"] = {en = "Blockade", ja = "封鎖戦線"},
        ["终极战场"] = {en = "Ultimate Battle", ja = "究極の戦場"},
        ["最强的拳击模拟器"] = {en = "Boxing Sim", ja = "最強のボクシングシミュレーター"},
        ["排球传奇"] = {en = "Volleyball Legend", ja = "バレーボール伝説"},
        ["竞争对手"] = {en = "Rivals", ja = "ライバル"},
        ["柔术无限"] = {en = "Jujutsu Infinite", ja = "柔術無限"},
        ["超速射击"] = {en = "Hyper Shot", ja = "ハイパーショット"},
        ["英雄战场"] = {en = "Hero Battleground", ja = "ヒーローバトルフィールド"},
        ["蓝色锁"] = {en = "Blue Lock", ja = "ブルーロック"},
        ["无标题的拳击"] = {en = "Untitled Boxing", ja = "無題のボクシング"},
        ["越狱"] = {en = "Jailbreak", ja = "脱獄"},
        ["生存战争"] = {en = "Survival War", ja = "サバイバル戦争

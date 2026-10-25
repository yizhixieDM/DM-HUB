-- DMHUB 修复重制版 WindUI加载器
local WindUI = loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"))()

local Window = WindUI:CreateWindow({
    Title = "<font color='#FF66CC'>打开/点开DMHUB脚本</font>",
    Size = UDim2.fromOffset(620, 480),
    Transparent = true,
    Theme = "Dark",
    User = {
        Enabled = true,
        Callback = function() print("clicked") end,
        Anonymous = false
    },
    -- 完全移除KeySystem卡密系统，无需输入密码
})

-- 顶部标签
Window:Tag({ Title = "重制版", Color = Color3.fromHex("#30ff6a") })
Window:Tag({ Title = "回归之作", Color = Color3.fromHex("#30ff6a") })
Window:Tag({ Title = "此脚本永久免费", Color = Color3.fromHex("#315dff") })
Window:Tag({ Title = "持续更新", Color = Color3.fromHex("#000000") })

WindUI:Notify({
    Title = "DMHUB脚本通知",
    Content = "DMHUB脚本禁止倒卖",
    Duration = 10,
    Icon = "bird",
})
WindUI:Notify({
    Title = "DMHUB脚本通知",
    Content = "作者:一只屑冬某、HPttttt😏",
    Duration = 10,
    Icon = "bird",
})

-- ========== 正确层级：Window直接创建Tab侧边栏 ==========
local AnnounceTab = Window:Tab({
    Title = "DMHUB脚本公告",
    Icon = "layout-grid",
    Locked = false,
})

AnnounceTab:Paragraph({
    Title = "作者一只屑冬某、HPttttt😏",
    Desc = "QQ群主群310057979 ",
    Image = "rbxassetid://75198135626218",
    ImageSize = 42,
    Thumbnail = "rbxassetid://103506480252017",
    ThumbnailSize = 0,
})
AnnounceTab:Paragraph({
    Title = "欢迎使用DMHUB脚本",
    Desc = "QQ群主群310057979 ",
    Image = "rbxassetid://75198135626218",
    ImageSize = 42,
    Thumbnail = "rbxassetid://103506480252017",
    ThumbnailSize = 0,
})
AnnounceTab:Paragraph({
    Title = "三天一更",
    Desc = "QQ群主群310057979 ",
    Image = "rbxassetid://75198135626218",
    ImageSize = 42,
    Thumbnail = "rbxassetid://103506480252017",
    ThumbnailSize = 0,
})
AnnounceTab:Paragraph({
    Title = "祝大家新年快乐，身体健康，万事如意",
    Desc = "",
    Image = "rbxassetid://75198135626218",
    ImageSize = 42,
    Thumbnail = "rbxassetid://103506480252017",
    ThumbnailSize = 0,
})

-- 【通用功能Tab】
local MainTab = Window:Tab({
    Title = "通用",
    Icon = "layout-grid",
    Locked = false
})
local MainSection = MainTab:Section({ Title = "基础", Opened = true })

MainSection:Slider({
    Title = "跳跃",
    Value = { Min = 50, Max = 200, Default = 50 },
    Increment = 1,
    Callback = function(value)
        local plr = game.Players.LocalPlayer
        if plr.Character and plr.Character:FindFirstChildOfClass("Humanoid") then
            plr.Character.Humanoid.JumpPower = value
        end
    end
})

MainSection:Slider({
    Title = "移速",
    Value = { Min = 16, Max = 400, Default = 16 },
    Increment = 1,
    Callback = function(value)
        local plr = game.Players.LocalPlayer
        if plr.Character and plr.Character:FindFirstChildOfClass("Humanoid") then
            plr.Character.Humanoid.WalkSpeed = value
        end
    end
})

MainSection:Slider({
    Title = "重力",
    Value = { Min = 0.1, Max = 500.0, Default = 196.2 },
    Step = 0.1,
    Callback = function(value)
        game.Workspace.Gravity = value
    end
})

-- 工具按钮封装辅助函数，增加角色判断
local function RunRemoteScript(url)
    local plr = game.Players.LocalPlayer
    if not plr.Character then
        WindUI:Notify({Title="提示",Content="角色还未加载完成！",Duration=3})
        return
    end
    local success,err = pcall(function()
        loadstring(game:HttpGet(url))()
    end)
    if not success then
        WindUI:Notify({Title="脚本加载失败",Content=tostring(err),Duration=4})
    end
end

MainSection:Button({ Title = "shenmi飞行", Callback=function() RunRemoteScript("https://raw.githubusercontent.com/nknmk88l/-78-/refs/heads/main/飞行源码.lua") end })
MainSection:Button({ Title = "子弹追踪", Callback=function() RunRemoteScript("https://raw.githubusercontent.com/fcsdsss/games/refs/heads/main/Silent%20aim/1.1") end })
MainSection:Button({ Title = "隐身 [别人看得见]", Callback=function() RunRemoteScript("https://raw.githubusercontent.com/Yungengxin/roblox/main/yinshen") end })
MainSection:Button({ Title = "玩家进入提示", Callback=function() RunRemoteScript("https://raw.githubusercontent.com/boyscp/scriscriptsc/main/bbn.lua") end })
MainSection:Button({ Title = "反挂机", Callback=function() RunRemoteScript("https://pastebin.com/raw/9fFu43FF") end })
MainSection:Button({ Title = "悬空", Callback=function() RunRemoteScript('https://raw.githubusercontent.com/GhostPlayer352/Test4/main/Float') end })
MainSection:Button({ Title = "3000多个动作", Callback=function() RunRemoteScript("https://raw.githubusercontent.com/7yd7/Hub/refs/heads/Branch/GUIS/Emotes.lua") end })
MainSection:Button({ Title = "防止坠落伤害", Callback=function() RunRemoteScript('https://pastefy.app/4lzEtnLg/raw') end })
MainSection:Button({ Title = "成为无敌少侠", Callback=function() RunRemoteScript("https://raw.githubusercontent.com/396abc/Script/refs/heads/main/MobileFly.lua") end })

-- 【脚本中心Tab】
local HubListTab = Window:Tab({
    Title = "各大脚本中心",
    Icon = "layout-grid",
    Locked = false
})
local HubSec = HubListTab:Section({Title="外部脚本Hub",Opened=true})

HubSec:Button({ Title = "KG脚本", Callback=function()
    KG_SCRIPT = "张硕制作"
    RunRemoteScript("https://github.com/ZS-NB/KG/raw/main/Zhang-Shuo.lua")
end})
HubSec:Button({ Title = "某黄脚本", Callback=function() RunRemoteScript("https://raw.githubusercontent.com/xiaokong6/x1/refs/heads/main/黄某脚本加载器") end })
HubSec:Button({ Title = "安脚本中心", Callback=function() RunRemoteScript('https://raw.githubusercontent.com/wucan114514/gegeyxjb/main/oww') end })
HubSec:Button({ Title = "大司马脚本", Callback=function() RunRemoteScript("https://raw.githubusercontent.com/whenheer/dasimav6/refs/heads/main/dasimaV6.txt") end })
HubSec:Button({ Title = "叶脚本", Callback=function() RunRemoteScript("https://raw.githubusercontent.com/roblox-ye/QQ515966991/refs/heads/main/ROBLOX-CNVIP-XIAOYE.lua") end })
HubSec:Button({ Title = "光脚本", Callback=function() RunRemoteScript("https://raw.githubusercontent.com/qwrt5589/eododo/main/GuangJiaoBen.lua") end })
HubSec:Button({ Title = "TX脚本", Callback=function() RunRemoteScript("https://raw.githubusercontent.com/JsYb666/TX-Free-YYDS/refs/heads/main/FREE-TX-TEAM") end })
HubSec:Button({ Title = "rb脚本", Callback=function() RunRemoteScript("https://raw.githubusercontent.com/Yungengxin/roblox/refs/heads/main/Rb-Hub") end })

--【游戏专用Tab】
local GameTab = Window:Tab({
    Title = "游戏专用",
    Icon = "layout-grid",
    Locked = false
})
local GameSec = GameTab:Section({Title="游戏脚本",Opened=true})

GameSec:Button({ Title = "Doors圣诞Figure自动秒通关", Callback=function() RunRemoteScript("https://raw.githubusercontent.com/XOTRXONY/EasyScript/main/DoorsAutoWin") end })
GameSec:Button({ Title = "火车头(最强战场)", Callback=function()
    getgenv().settings = {
        ["morph"] = {["enabled"] = false,["dontchangeskincolor"] = false},
        ["ult_forcewalkspeed"] = true,
        ["ult_walkspeed"] = 64,
        ["tp_duration"] = 0.15
    }
    RunRemoteScript("https://raw.githubusercontent.com/skibiditoiletfan2007/ATrainSounds/refs/heads/main/ATrain.lua")
end})

-- 全部UI构建完毕，最后才切换标签
Window:SelectTab(1)

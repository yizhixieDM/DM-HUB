local ui = Instance.new("ScreenGui")
ui.Name = "DM_Premium"
ui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
ui.ResetOnSpawn = false

local background = Instance.new("Frame")
background.Name = "BackgroundOverlay"
background.Size = UDim2.new(1, 0, 1, 0)
background.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
background.BackgroundTransparency = 0.7
background.Parent = ui

local mainContainer = Instance.new("Frame")
mainContainer.Name = "MainContainer"
mainContainer.Size = UDim2.new(0, 0, 0, 380 * 0.7)
mainContainer.Position = UDim2.new(0.5, 0, 0.5, 0)
mainContainer.BackgroundTransparency = 1
mainContainer.AnchorPoint = Vector2.new(0.5, 0.5)
mainContainer.Parent = ui

local leftPanel = Instance.new("Frame")
leftPanel.Name = "TextPanel"
leftPanel.Size = UDim2.new(0.5, 0, 1, 0)
leftPanel.Position = UDim2.new(0, 0, 0, 0)
leftPanel.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
leftPanel.Parent = mainContainer

local leftCorner = Instance.new("UICorner")
leftCorner.CornerRadius = UDim.new(0, 12 * 0.7)
leftCorner.Parent = leftPanel

local leftStroke = Instance.new("UIStroke")
leftStroke.Color = Color3.fromRGB(60, 60, 60)
leftStroke.Thickness = 2 * 0.7
leftStroke.Parent = leftPanel

local rightPanel = Instance.new("Frame")
rightPanel.Name = "ImagePanel"
rightPanel.Size = UDim2.new(0.5, 0, 1, 0)
rightPanel.Position = UDim2.new(0.5, 0, 0, 0)
rightPanel.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
rightPanel.Parent = mainContainer

local rightCorner = Instance.new("UICorner")
rightCorner.CornerRadius = UDim.new(0, 12 * 0.7)
rightCorner.Parent = rightPanel

local rightStroke = Instance.new("UIStroke")
rightStroke.Color = Color3.fromRGB(80, 80, 80)
rightStroke.Thickness = 2 * 0.7
rightStroke.Parent = rightPanel

local leftContent = Instance.new("Frame")
leftContent.Size = UDim2.new(1, -40 * 0.7, 1, -40 * 0.7)
leftContent.Position = UDim2.new(0, 20 * 0.7, 0, 20 * 0.7)
leftContent.BackgroundTransparency = 1
leftContent.Parent = leftPanel

local decorLine = Instance.new("Frame")
decorLine.Size = UDim2.new(0, 3 * 0.7, 0.7, 0)
decorLine.Position = UDim2.new(0, 15 * 0.7, 0.15, 0)
decorLine.BackgroundColor3 = Color3.fromRGB(0, 180, 255)
decorLine.BorderSizePixel = 0
decorLine.Parent = leftContent

local decorCorner = Instance.new("UICorner")
decorCorner.CornerRadius = UDim.new(0, 1 * 0.7)
decorCorner.Parent = decorLine

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -30 * 0.7, 0, 70 * 0.7)
title.Position = UDim2.new(0, 25 * 0.7, 0, 10 * 0.7)
title.Text = "脚本能正常使用"
title.TextSize = 22 * 0.7
title.Font = Enum.Font.GothamSemibold
title.TextColor3 = Color3.fromRGB(220, 220, 220)
title.BackgroundTransparency = 1
title.TextWrapped = true
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = leftContent

local separator = Instance.new("Frame")
separator.Size = UDim2.new(1, -50 * 0.7, 0, 1 * 0.7)
separator.Position = UDim2.new(0, 25 * 0.7, 0, 85 * 0.7)
separator.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
separator.BorderSizePixel = 0
separator.Parent = leftContent

local thanks1 = Instance.new("TextLabel")
thanks1.Size = UDim2.new(1, -30 * 0.7, 0, 80 * 0.7)
thanks1.Position = UDim2.new(0, 25 * 0.7, 0, 95 * 0.7)
thanks1.Text = "感谢一路以来支持我的人。\n特别感谢：hptttt"
thanks1.TextSize = 16 * 0.7
thanks1.Font = Enum.Font.Gotham
thanks1.TextColor3 = Color3.fromRGB(180, 180, 180)
thanks1.BackgroundTransparency = 1
thanks1.TextWrapped = true
thanks1.TextXAlignment = Enum.TextXAlignment.Left
thanks1.Parent = leftContent

local thanks2 = Instance.new("TextLabel")
thanks2.Size = UDim2.new(1, -30 * 0.7, 0, 50 * 0.7)
thanks2.Position = UDim2.new(0, 25 * 0.7, 0, 185 * 0.7)
thanks2.Text = "冬某NB"
thanks2.TextSize = 17 * 0.7
thanks2.Font = Enum.Font.GothamMedium
thanks2.TextColor3 = Color3.fromRGB(200, 200, 200)
thanks2.BackgroundTransparency = 1
thanks2.TextXAlignment = Enum.TextXAlignment.Left
thanks2.Parent = leftContent

local imageContainer = Instance.new("Frame")
imageContainer.Size = UDim2.new(1, -20 * 0.7, 1, -20 * 0.7)
imageContainer.Position = UDim2.new(0, 10 * 0.7, 0, 10 * 0.7)
imageContainer.BackgroundColor3 = Color3.fromRGB(5, 5, 5)
imageContainer.Parent = rightPanel

local imageCorner = Instance.new("UICorner")
imageCorner.CornerRadius = UDim.new(0, 8 * 0.7)
imageCorner.Parent = imageContainer

local displayImage = Instance.new("ImageLabel")
displayImage.Size = UDim2.new(1, -20 * 0.7, 1, -20 * 0.7)
displayImage.Position = UDim2.new(0, 10 * 0.7, 0, 10 * 0.7)
displayImage.BackgroundTransparency = 1
displayImage.Image = "rbxasse6"
displayImage.ScaleType = Enum.ScaleType.Fit
displayImage.Parent = imageContainer

local imageStroke = Instance.new("UIStroke")
imageStroke.Color = Color3.fromRGB(40, 40, 40)
imageStroke.Thickness = 1 * 0.7
imageStroke.Parent = displayImage

local imageBorder = Instance.new("Frame")
imageBorder.Size = UDim2.new(1, 10 * 0.7, 1, 10 * 0.7)
imageBorder.Position = UDim2.new(0, -5 * 0.7, 0, -5 * 0.7)
imageBorder.BackgroundTransparency = 1
imageBorder.Parent = displayImage

local borderStroke = Instance.new("UIStroke")
borderStroke.Color = Color3.fromRGB(100, 100, 100)
borderStroke.Thickness = 2 * 0.7
borderStroke.Parent = imageBorder

local imageTitle = Instance.new("TextLabel")
imageTitle.Size = UDim2.new(1, 0, 0, 30 * 0.7)
imageTitle.Position = UDim2.new(0, 0, 1, -40 * 0.7)
imageTitle.Text = "神秘"
imageTitle.TextSize = 14 * 0.7
imageTitle.Font = Enum.Font.Gotham
imageTitle.TextColor3 = Color3.fromRGB(150, 150, 150)
imageTitle.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
imageTitle.BackgroundTransparency = 0.7
imageTitle.TextXAlignment = Enum.TextXAlignment.Center
imageTitle.Parent = imageContainer

local titleCorner = Instance.new("UICorner")
titleCorner.CornerRadius = UDim.new(0, 6 * 0.7)
titleCorner.Parent = imageTitle

local confirmBtn = Instance.new("TextButton")
confirmBtn.Name = "ConfirmButton"
confirmBtn.Size = UDim2.new(0.7, 0, 0, 45 * 0.7)
confirmBtn.Position = UDim2.new(0.15, 0, 0, 290 * 0.7)
confirmBtn.Text = "确认启动脚本"
confirmBtn.TextSize = 18 * 0.7
confirmBtn.Font = Enum.Font.GothamSemibold
confirmBtn.TextColor3 = Color3.fromRGB(230, 230, 230)
confirmBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
confirmBtn.AutoButtonColor = false
confirmBtn.Parent = leftContent

local btnCorner = Instance.new("UICorner")
btnCorner.CornerRadius = UDim.new(0, 8 * 0.7)
btnCorner.Parent = confirmBtn

local btnStroke = Instance.new("UIStroke")
btnStroke.Color = Color3.fromRGB(70, 70, 70)
btnStroke.Thickness = 1 * 0.7
btnStroke.Parent = confirmBtn

local btnIcon = Instance.new("ImageLabel")
btnIcon.Size = UDim2.new(0, 20 * 0.7, 0, 20 * 0.7)
btnIcon.Position = UDim2.new(0, 15 * 0.7, 0.5, -10 * 0.7)
btnIcon.BackgroundTransparency = 1
btnIcon.Image = "rbxasseti5"
btnIcon.ImageColor3 = Color3.fromRGB(200, 200, 200)
btnIcon.Parent = confirmBtn

local btnText = Instance.new("TextLabel")
btnText.Size = UDim2.new(1, -40 * 0.7, 1, 0)
btnText.Position = UDim2.new(0, 40 * 0.7, 0, 0)
btnText.Text = "确认启动"
btnText.TextSize = 18 * 0.7
btnText.Font = Enum.Font.GothamSemibold
btnText.TextColor3 = Color3.fromRGB(230, 230, 230)
btnText.BackgroundTransparency = 1
btnText.TextXAlignment = Enum.TextXAlignment.Left
btnText.Parent = confirmBtn

local colorOffset = 0
local activeGradient = true
local function updateGradients()
    while activeGradient do
        colorOffset = (colorOffset + 0.005) % 1
        local hue = colorOffset
        decorLine.BackgroundColor3 = Color3.fromHSV(hue, 0.8, 1)
        local btnHue = (colorOffset + 0.5) % 1
        btnStroke.Color = Color3.fromHSV(btnHue, 0.6, 0.8)
        rightStroke.Color = Color3.fromHSV((colorOffset + 0.3) % 1, 0.4, 0.7)
        task.wait(0.05)
    end
end

confirmBtn.MouseEnter:Connect(function()
    game.TweenService:Create(confirmBtn, TweenInfo.new(0.2), {
        BackgroundColor3 = Color3.fromRGB(40, 40, 40),
        Size = UDim2.new(0.72, 0, 0, 48 * 0.7)
    }):Play()
    game.TweenService:Create(btnIcon, TweenInfo.new(0.2), {
        ImageColor3 = Color3.fromRGB(0, 200, 255)
    }):Play()
    confirmBtn.Text = ""
    btnText.Text = "准备启动..."
end)

confirmBtn.MouseLeave:Connect(function()
    game.TweenService:Create(confirmBtn, TweenInfo.new(0.2), {
        BackgroundColor3 = Color3.fromRGB(30, 30, 30),
        Size = UDim2.new(0.7, 0, 0, 45 * 0.7)
    }):Play()
    game.TweenService:Create(btnIcon, TweenInfo.new(0.2), {
        ImageColor3 = Color3.fromRGB(200, 200, 200)
    }):Play()
    confirmBtn.Text = ""
    btnText.Text = "确认启动"
end)

local openingSequence = game.TweenService:Create(mainContainer, TweenInfo.new(0.8, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
    Size = UDim2.new(0, 900 * 0.7, 0, 380 * 0.7)
})

local leftFadeIn = game.TweenService:Create(leftPanel, TweenInfo.new(0.5), {
    BackgroundTransparency = 0
})

local rightFadeIn = game.TweenService:Create(rightPanel, TweenInfo.new(0.5), {
    BackgroundTransparency = 0
})

task.spawn(function()
    displayImage.ImageTransparency = 0
    openingSequence:Play()
    openingSequence.Completed:Wait()
    leftFadeIn:Play()
    rightFadeIn:Play()
    for _, element in pairs({title, separator, thanks1, thanks2, confirmBtn}) do
        if element:IsA("TextLabel") or element:IsA("TextButton") then
            element.TextTransparency = 1
            element.Visible = true
            game.TweenService:Create(element, TweenInfo.new(0.4), {
                TextTransparency = 0
            }):Play()
        else
            element.BackgroundTransparency = 1
            element.Visible = true
            game.TweenService:Create(element, TweenInfo.new(0.4), {
                BackgroundTransparency = 0
            }):Play()
        end
    end
    decorLine.Size = UDim2.new(0, 0, 0.7, 0)
    game.TweenService:Create(decorLine, TweenInfo.new(0.6), {
        Size = UDim2.new(0, 3 * 0.7, 0.7, 0)
    }):Play()
    activeGradient = true
    updateGradients()
end)

confirmBtn.MouseButton1Click:Connect(function()
    activeGradient = false
    ui:Destroy()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/yizhixieDM/DM-HUB/refs/heads/main/卡密系统(1).lua"))()
end)

local userInput = game:GetService("UserInputService")

local function closeInterface()
    activeGradient = false
    local fadeOut = game.TweenService:Create(mainContainer, TweenInfo.new(0.4), {
        BackgroundTransparency = 1
    })
    local bgFade = game.TweenService:Create(background, TweenInfo.new(0.4), {
        BackgroundTransparency = 1
    })
    for _, element in pairs(leftContent:GetChildren()) do
        if element:IsA("TextLabel") or element:IsA("TextButton") then
            game.TweenService:Create(element, TweenInfo.new(0.2), {
                TextTransparency = 1
            }):Play()
        end
    end
    fadeOut:Play()
    bgFade:Play()
    task.wait(0.4)
    ui:Destroy()
end

userInput.InputBegan:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.Escape then
        closeInterface()
    end
end)

background.MouseButton1Click:Connect(function()
    closeInterface()
end)

task.spawn(function()
    task.wait(10)
    if ui.Parent then
        closeInterface()
    end
end)

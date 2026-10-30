--源码由司空提供，盗卖4000+
--加入群聊获取更多源码
--神秘数字 1108203505
local CONFIG = {
	KEY         = "KEY_LK_YZXDM_JN_HKI",      
	KICKER      = "DMHUB",
	TITLE       = "身份验证",
	DESC        = "输入授权密钥以继续",
	PLACEHOLDER = "请输入密钥",
	BTN         = "验  证",
	REMEMBER    = true,
	BLUR        = true,
	DOTS        = 6,             
	SPIN        = 0.85,          
	RADIUS      = 27,            
	SPIN_TIME   = 1.15,          
}

local Players  = game:GetService("Players")
local Tween    = game:GetService("TweenService")
local Lighting = game:GetService("Lighting")
local LP       = Players.LocalPlayer
local Camera   = workspace.CurrentCamera

local C = {
	overlay = Color3.fromRGB(8, 8, 10),
	card    = Color3.fromRGB(19, 19, 22),
	field   = Color3.fromRGB(27, 27, 31),
	text    = Color3.fromRGB(236, 236, 240),
	dim     = Color3.fromRGB(118, 118, 126),
	faint   = Color3.fromRGB(58, 58, 64),
	accent  = Color3.fromRGB(236, 236, 240),
	ink     = Color3.fromRGB(18, 18, 21),
	bad     = Color3.fromRGB(198, 106, 106),
	good    = Color3.fromRGB(146, 200, 156),
}

local CACHE = "DMHUB卡.txt"

local function new(class, props, parent)
	local o = Instance.new(class)
	for k, v in pairs(props or {}) do o[k] = v end
	if parent then o.Parent = parent end
	return o
end

local function round(inst, r)
	if type(r) == "number" then r = UDim.new(0, r) end
	new("UICorner", { CornerRadius = r or UDim.new(0, 10) }, inst)
	return inst
end

local function tw(inst, time, props, style, delay)
	local info = TweenInfo.new(time, style or Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, false, delay or 0)
	local t = Tween:Create(inst, info, props)
	t:Play()
	return t
end

local function getParent()
	if gethui then
		local ok, h = pcall(gethui)
		if ok and h then return h end
	end
	local ok, cg = pcall(function() return game:GetService("CoreGui") end)
	if ok and cg then return cg end
	return LP:WaitForChild("PlayerGui")
end

local function hasFileAPI()
	return type(writefile) == "function" and type(readfile) == "function" and type(isfile) == "function"
end

local function norm(s)
	return tostring(s or ""):gsub("%s+", ""):lower()
end

local function onSuccess()
	print(" 卡密验证通过 ✔")
	-- ↓↓↓ 验证通过后加载你的脚本 ↓↓↓
	task.spawn(function()
		loadstring(game:HttpGet("https://raw.githubusercontent.com/yizhixieDM/DM-HUB/refs/heads/main/主脚本第二份.lua"))()end)
    end)
	-- ↑↑↑ 验证通过后加载你的脚本 ↑↑↑

	local g = new("ScreenGui", {
		Name = "case_unlocked", IgnoreGuiInset = true,
		ResetOnSpawn = false, DisplayOrder = 9999, Parent = getParent(),
	})
	local pill = new("Frame", {
		Position = UDim2.fromOffset(20, 20), Size = UDim2.fromOffset(198, 38),
		BackgroundColor3 = C.card, BackgroundTransparency = 1, BorderSizePixel = 0, Parent = g,
	})
	round(pill, 10)
	local st = new("UIStroke", {
		Color = Color3.fromRGB(255, 255, 255), Transparency = 1, Thickness = 1,
		ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Parent = pill,
	})
	local dot = new("Frame", {
		Position = UDim2.fromOffset(15, 15), Size = UDim2.fromOffset(8, 8),
		BackgroundColor3 = C.good, BackgroundTransparency = 1, BorderSizePixel = 0, Parent = pill,
	})
	round(dot, UDim.new(1, 0))
	local lbl = new("TextLabel", {
		Position = UDim2.fromOffset(32, 0), Size = UDim2.new(1, -44, 1, 0),
		BackgroundTransparency = 1, Font = Enum.Font.GothamBold, TextSize = 13,
		TextColor3 = C.text, TextXAlignment = Enum.TextXAlignment.Left,
		Text = "已解锁  ·  case", TextTransparency = 1, Parent = pill,
	})

	tw(pill, 0.3, { BackgroundTransparency = 0 })
	tw(st, 0.3, { Transparency = 0.86 })
	tw(dot, 0.3, { BackgroundTransparency = 0 })
	tw(lbl, 0.3, { TextTransparency = 0 })

	task.delay(2.6, function()
		tw(pill, 0.35, { BackgroundTransparency = 1 })
		tw(st, 0.35, { Transparency = 1 })
		tw(dot, 0.35, { BackgroundTransparency = 1 })
		tw(lbl, 0.35, { TextTransparency = 1 })
		task.wait(0.45)
		g:Destroy()
	end)
end

local function startKeyCheck(done)
	local gui = new("ScreenGui", {
		Name = "case_verify", IgnoreGuiInset = true, ResetOnSpawn = false,
		DisplayOrder = 9999, ZIndexBehavior = Enum.ZIndexBehavior.Sibling, Parent = getParent(),
	})

	local overlay = new("Frame", {
		Name = "Overlay", Size = UDim2.fromScale(1, 1),
		BackgroundColor3 = C.overlay, BackgroundTransparency = 1,
		BorderSizePixel = 0, ZIndex = 1, Parent = gui,
	})

	local scaleObj = new("UIScale", { Scale = 1, Parent = overlay })
	local function updateScale()
		scaleObj.Scale = math.clamp(Camera.ViewportSize.X / 440, 0.7, 1)
	end
	updateScale()
	Camera:GetPropertyChangedSignal("ViewportSize"):Connect(updateScale)

	local card = new("Frame", {
		Name = "Card", AnchorPoint = Vector2.new(0.5, 0.5),
		Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromOffset(380, 292),
		BackgroundColor3 = C.card, BackgroundTransparency = 1,
		BorderSizePixel = 0, ZIndex = 2, Parent = overlay,
	})
	round(card, 16)
	local cardStroke = new("UIStroke", {
		Color = Color3.fromRGB(255, 255, 255), Thickness = 1, Transparency = 1,
		ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Parent = card,
	})

	local pad = new("Frame", {
		Size = UDim2.new(1, -56, 1, -52), Position = UDim2.fromOffset(28, 26),
		BackgroundTransparency = 1, ZIndex = 3, Parent = card,
	})

	local mark = new("Frame", { Size = UDim2.fromOffset(18, 18), BackgroundTransparency = 1, ZIndex = 3, Parent = pad })
	local bars = {}
	for _, ang in ipairs({ 0, 60, 120 }) do
		local bar = new("Frame", {
			AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5),
			Size = UDim2.fromOffset(18, 2), BackgroundColor3 = C.dim, BackgroundTransparency = 1,
			BorderSizePixel = 0, Rotation = 0, ZIndex = 3, Parent = mark,
		})
		round(bar, UDim.new(1, 0))
		table.insert(bars, { bar = bar, ang = ang })
	end

	local kicker = new("TextLabel", {
		Position = UDim2.fromOffset(28, 0), Size = UDim2.new(1, -28, 0, 18),
		BackgroundTransparency = 1, Font = Enum.Font.GothamBold, TextSize = 11,
		TextColor3 = C.dim, TextXAlignment = Enum.TextXAlignment.Left,
		Text = CONFIG.KICKER, TextTransparency = 1, ZIndex = 3, Parent = pad,
	})

	local title = new("TextLabel", {
		Position = UDim2.fromOffset(0, 34), Size = UDim2.new(1, 0, 0, 30),
		BackgroundTransparency = 1, Font = Enum.Font.GothamBold, TextSize = 24,
		TextColor3 = C.text, TextXAlignment = Enum.TextXAlignment.Left,
		Text = CONFIG.TITLE, TextTransparency = 1, ZIndex = 3, Parent = pad,
	})

	local desc = new("TextLabel", {
		Position = UDim2.fromOffset(0, 66), Size = UDim2.new(1, 0, 0, 18),
		BackgroundTransparency = 1, Font = Enum.Font.Gotham, TextSize = 13,
		TextColor3 = C.dim, TextXAlignment = Enum.TextXAlignment.Left,
		Text = CONFIG.DESC, TextTransparency = 1, ZIndex = 3, Parent = pad,
	})

	local div = new("Frame", {
		Position = UDim2.fromOffset(0, 98), Size = UDim2.new(1, 0, 0, 1),
		BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1,
		BorderSizePixel = 0, ZIndex = 3, Parent = pad,
	})

	local field = new("Frame", {
		Position = UDim2.fromOffset(0, 114), Size = UDim2.new(1, 0, 0, 46),
		BackgroundColor3 = C.field, BackgroundTransparency = 1,
		BorderSizePixel = 0, ZIndex = 3, Parent = pad,
	})
	round(field, 10)
	local fieldStroke = new("UIStroke", {
		Color = Color3.fromRGB(255, 255, 255), Thickness = 1, Transparency = 1,
		ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Parent = field,
	})

	local box = new("TextBox", {
		Position = UDim2.fromOffset(15, 0), Size = UDim2.new(1, -30, 1, 0),
		BackgroundTransparency = 1, Font = Enum.Font.Gotham, TextSize = 15,
		TextColor3 = C.text, Text = "", PlaceholderText = CONFIG.PLACEHOLDER,
		PlaceholderColor3 = C.faint, ClearTextOnFocus = false,
		TextXAlignment = Enum.TextXAlignment.Left, TextTransparency = 1,
		ZIndex = 4, Parent = field,
	})

	local btnWrap = new("Frame", {
		Position = UDim2.fromOffset(0, 174), Size = UDim2.new(1, 0, 0, 44),
		BackgroundTransparency = 1, ZIndex = 3, Parent = pad,
	})
	local btn = new("TextButton", {
		AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5),
		Size = UDim2.new(1, 0, 0, 44), BackgroundColor3 = C.accent, BackgroundTransparency = 1,
		Text = CONFIG.BTN, Font = Enum.Font.GothamBold, TextSize = 14,
		TextColor3 = C.ink, TextTransparency = 1, AutoButtonColor = false,
		ZIndex = 4, Parent = btnWrap,
	})
	local btnCorner = new("UICorner", { CornerRadius = UDim.new(0, 10) }, btn)
	local btnScale = new("UIScale", { Scale = 1, Parent = btn })

	local check = new("TextLabel", {
		Size = UDim2.fromScale(1, 1), BackgroundTransparency = 1,
		Font = Enum.Font.GothamBold, TextSize = 24, Text = "✓",
		TextColor3 = C.ink, TextTransparency = 1, ZIndex = 7, Parent = btn,
	})
	local checkScale = new("UIScale", { Scale = 0.7, Parent = check })

	local spin = new("Frame", {
		AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5),
		Size = UDim2.fromOffset(0, 0), BackgroundTransparency = 1,
		ZIndex = 6, Parent = btnWrap,
	})

	local status = new("TextLabel", {
		Position = UDim2.fromOffset(0, 228), Size = UDim2.new(1, 0, 0, 16),
		BackgroundTransparency = 1, Font = Enum.Font.Gotham, TextSize = 12,
		TextColor3 = C.dim, TextXAlignment = Enum.TextXAlignment.Left,
		Text = "等待输入…", TextTransparency = 1, ZIndex = 3, Parent = pad,
	})

	local hint = new("TextLabel", {
		Position = UDim2.fromOffset(0, 228), Size = UDim2.new(1, 0, 0, 16),
		BackgroundTransparency = 1, Font = Enum.Font.GothamBold, TextSize = 11,
		TextColor3 = C.faint, TextXAlignment = Enum.TextXAlignment.Right,
		Text = "ENTER ", TextTransparency = 1, ZIndex = 3, Parent = pad,
	})

	local blur
	if CONFIG.BLUR then
		blur = new("BlurEffect", { Size = 0, Parent = Lighting })
		tw(blur, 0.5, { Size = 14 })
	end

	tw(overlay, 0.35, { BackgroundTransparency = 0.45 })
	tw(card, 0.5, { BackgroundTransparency = 0 }, Enum.EasingStyle.Quint)
	tw(cardStroke, 0.5, { Transparency = 0.86 })
	for i, b in ipairs(bars) do
		tw(b.bar, 0.5, { Rotation = b.ang, BackgroundTransparency = 0.45 }, Enum.EasingStyle.Quint, i * 0.06)
	end
	task.delay(0.12, function()
		tw(kicker, 0.4, { TextTransparency = 0.25 })
		tw(title, 0.45, { TextTransparency = 0 })
		tw(desc, 0.45, { TextTransparency = 0 }, nil, 0.06)
		tw(div, 0.45, { BackgroundTransparency = 0.9 }, nil, 0.1)
		tw(field, 0.45, { BackgroundTransparency = 0 })
		tw(fieldStroke, 0.45, { Transparency = 0.9 })
		tw(box, 0.45, { TextTransparency = 0 })
		tw(btn, 0.45, { BackgroundTransparency = 0 }, nil, 0.08)
		tw(btn, 0.45, { TextTransparency = 0 }, nil, 0.08)
		tw(status, 0.45, { TextTransparency = 0.1 }, nil, 0.14)
		tw(hint, 0.45, { TextTransparency = 0.5 }, nil, 0.14)
	end)

	local busy = false

	local function setStatus(text, color)
		status.Text = text
		status.TextColor3 = color or C.dim
	end

	local shaking = false
	local function shake()
		if shaking then return end
		shaking = true
		local seq = { 0.013, -0.013, 0.009, -0.009, 0.005, 0 }
		for i, dx in ipairs(seq) do
			task.delay(i * 0.045, function()
				tw(card, 0.06, { Position = UDim2.new(0.5 + dx, 0, 0.5, 0) }, Enum.EasingStyle.Linear)
			end)
		end
		task.delay(#seq * 0.045 + 0.12, function() shaking = false end)
	end

	local flashToken = 0
	local function flash(color)
		flashToken = flashToken + 1
		local mine = flashToken
		fieldStroke.Color = color
		fieldStroke.Transparency = 0.35
		task.delay(0.9, function()
			if mine ~= flashToken then return end
			fieldStroke.Color = Color3.fromRGB(255, 255, 255)
			tw(fieldStroke, 0.4, { Transparency = 0.9 })
		end)
	end

	local spinActive = false
	local spinTween = nil

	local function stopSpin()
		spinActive = false
		if spinTween then
			pcall(function() spinTween:Cancel() end)
			spinTween = nil
		end
	end

	local function startSpin()
		stopSpin()
		spinActive = true
		task.spawn(function()
			while spinActive do
				if not spin.Parent then break end

				local cur = spin.Rotation % 360
				spin.Rotation = cur - 360
				local okT, t = pcall(function()
					return tw(spin, CONFIG.SPIN, { Rotation = cur }, Enum.EasingStyle.Linear)
				end)
				if not okT or not t then break end
				spinTween = t
				local okW = pcall(function() t.Completed:Wait() end)
				spinTween = nil
				if not okW then break end
			end
			spinActive = false
		end)
	end

	local function clearDots()
		for _, d in ipairs(spin:GetChildren()) do
			if d:IsA("Frame") then d:Destroy() end
		end
	end

	local function fadeOut()
		stopSpin()
		for _, d in ipairs(pad:GetDescendants()) do
			if d:IsA("TextLabel") or d:IsA("TextBox") then
				tw(d, 0.3, { TextTransparency = 1 })
			elseif d:IsA("Frame") then
				tw(d, 0.3, { BackgroundTransparency = 1 })
			elseif d:IsA("UIStroke") then
				tw(d, 0.3, { Transparency = 1 })
			end
		end
		tw(card, 0.4, { BackgroundTransparency = 1 })
		tw(cardStroke, 0.4, { Transparency = 1 })
		tw(overlay, 0.4, { BackgroundTransparency = 1 })
		if blur then tw(blur, 0.4, { Size = 0 }) end
		task.wait(0.45)
		if blur then blur:Destroy() end
		gui:Destroy()
	end

	local function playMorph(success)
		busy = true
		box.TextEditable = false
		stopSpin()
		clearDots()
		spin.Rotation = 0
		check.Text = success and "✓" or "X"
		check.TextTransparency = 1
		checkScale.Scale = 0.7
		setStatus("验证中…", C.dim)

		tw(btn, 0.14, { TextTransparency = 1 }, Enum.EasingStyle.Sine)
		task.wait(0.16)

		tw(btn, 0.40, { Size = UDim2.new(0, 44, 0, 44) }, Enum.EasingStyle.Quint)
		tw(btnCorner, 0.40, { CornerRadius = UDim.new(1, 0) }, Enum.EasingStyle.Quint)
		task.wait(0.42)

		tw(btnScale, 0.15, { Scale = 1.14 }, Enum.EasingStyle.Sine)
		task.wait(0.15)
		tw(btnScale, 0.26, { Scale = 1 }, Enum.EasingStyle.Sine)

		local dots = {}
		for i = 1, CONFIG.DOTS do
			local rad = math.rad((i - 1) * (360 / CONFIG.DOTS))
			local dot = new("Frame", {
				AnchorPoint = Vector2.new(0.5, 0.5),
				Position = UDim2.fromOffset(math.cos(rad) * CONFIG.RADIUS, math.sin(rad) * CONFIG.RADIUS),
				Size = UDim2.fromOffset(8, 8), BackgroundColor3 = C.accent,
				BackgroundTransparency = 0, BorderSizePixel = 0,
				ZIndex = 6, Parent = spin,
			})
			round(dot, UDim.new(1, 0))
			local s = new("UIScale", { Scale = 0, Parent = dot })
			tw(s, 0.28, { Scale = 1 }, Enum.EasingStyle.Back, i * 0.05)
			table.insert(dots, dot)
		end
		startSpin()

		task.wait(CONFIG.SPIN_TIME)

		if success then
			stopSpin()
			for _, d in ipairs(dots) do
				tw(d, 0.32, {
					Position = UDim2.fromOffset(0, 0),
					Size = UDim2.fromOffset(0, 0),
					BackgroundColor3 = C.good,
				}, Enum.EasingStyle.Quint)
			end
			tw(btn, 0.32, { BackgroundColor3 = C.good })
			task.wait(0.18)
			tw(check, 0.26, { TextTransparency = 0 }, Enum.EasingStyle.Back)
			tw(checkScale, 0.32, { Scale = 1 }, Enum.EasingStyle.Back)
			setStatus("验证通过", C.good)
			if CONFIG.REMEMBER and hasFileAPI() then
				pcall(writefile, CACHE, CONFIG.KEY)
			end
			task.wait(0.75)
			fadeOut()
			if done then done() end
		else
			for _, d in ipairs(dots) do
				tw(d, 0.24, { BackgroundColor3 = C.bad, Size = UDim2.fromOffset(11, 11) })
			end
			tw(btn, 0.22, { BackgroundColor3 = C.bad })
			task.wait(0.2)
			tw(check, 0.22, { TextTransparency = 0 }, Enum.EasingStyle.Back)
			tw(checkScale, 0.26, { Scale = 1 }, Enum.EasingStyle.Back)
			setStatus("密钥无效", C.bad)
			task.wait(0.55)

			tw(check, 0.16, { TextTransparency = 1 })
			tw(checkScale, 0.16, { Scale = 0.6 })
			for _, d in ipairs(dots) do
				local p = d.Position
				tw(d, 0.32, {
					Position = UDim2.fromOffset(p.X.Offset * 1.9, p.Y.Offset * 1.9),
					Size = UDim2.fromOffset(0, 0),
					BackgroundTransparency = 1,
				}, Enum.EasingStyle.Quint)
			end
			task.wait(0.3)
			stopSpin()
			clearDots()
			spin.Rotation = 0

			tw(btn, 0.36, { BackgroundColor3 = C.accent, Size = UDim2.new(1, 0, 0, 44) }, Enum.EasingStyle.Quint)
			tw(btnCorner, 0.36, { CornerRadius = UDim.new(0, 10) }, Enum.EasingStyle.Quint)
			task.wait(0.38)
			tw(btn, 0.3, { TextTransparency = 0 }, Enum.EasingStyle.Sine)
			flash(C.bad)
			shake()
			setStatus("密钥无效 · 请重试", C.bad)
			box.TextEditable = true
			busy = false
		end
	end

	local verify

	box.Focused:Connect(function()
		tw(fieldStroke, 0.2, { Transparency = 0.7 })
	end)
	box.FocusLost:Connect(function(enter)
		tw(fieldStroke, 0.2, { Transparency = 0.9 })
		if enter and verify then verify() end
	end)

	btn.MouseEnter:Connect(function()
		if not busy then tw(btn, 0.16, { BackgroundColor3 = Color3.fromRGB(255, 255, 255) }) end
	end)
	btn.MouseLeave:Connect(function()
		if not busy then tw(btn, 0.16, { BackgroundColor3 = C.accent }) end
	end)
	btn.MouseButton1Down:Connect(function()
		if not busy then tw(btn, 0.08, { BackgroundColor3 = Color3.fromRGB(206, 206, 212) }) end
	end)
	btn.MouseButton1Up:Connect(function()
		if not busy then tw(btn, 0.12, { BackgroundColor3 = C.accent }) end
	end)
	btn.MouseButton1Click:Connect(function()
		if verify then verify() end
	end)

	verify = function()
		if busy then return end
		local v = norm(box.Text)
		if v == "" then
			setStatus("请先输入密钥", C.dim)
			shake()
			flash(C.bad)
			return
		end
		playMorph(v == norm(CONFIG.KEY))
	end

end

local function hasCachedKey()
	if not (CONFIG.REMEMBER and hasFileAPI()) then return false end
	local ok, saved = pcall(function()
		if isfile(CACHE) then return readfile(CACHE) end
	end)
	return ok and type(saved) == "string" and norm(saved) == norm(CONFIG.KEY)
end

if hasCachedKey() then
	print(" 已记住密钥, 跳过验证")
	onSuccess()
else
	startKeyCheck(onSuccess)
end

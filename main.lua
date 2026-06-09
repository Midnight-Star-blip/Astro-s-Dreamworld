
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local VirtualInputManager = game:GetService("VirtualInputManager")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local localPlayer = Players.LocalPlayer


_G.ESPTwisteds = false
_G.ESPResearch = false     
_G.ESPAllItems = false
_G.ESPGenerators = false
_G.ESPElevator = false
_G.AutoSkillcheck = false
_G.HideCircleMinigame = true   --change these ass names
_G.Fly = false
_G.Noclip = false


local AstroUI = {}

AstroUI.Theme = {
	Background = Color3.fromRGB(63, 51, 141),
	Header = Color3.fromRGB(232, 232, 232),
	Panel = Color3.fromRGB(78, 65, 156),
	PanelLight = Color3.fromRGB(91, 75, 188),
	Accent = Color3.fromRGB(100, 82, 202),
	AccentSoft = Color3.fromRGB(54, 78, 168),
	Hover = Color3.fromRGB(45, 72, 155),
	Shadow = Color3.fromRGB(15, 12, 38),
	PanelStroke = Color3.fromRGB(134, 116, 230),
	SoftStroke = Color3.fromRGB(184, 174, 255),
	WhiteStroke = Color3.fromRGB(255, 255, 255),
	ButtonTop = Color3.fromRGB(118, 99, 220),
	Text = Color3.fromRGB(255, 255, 255),
	HeaderText = Color3.fromRGB(17, 22, 92),
	Muted = Color3.fromRGB(208, 204, 235),
	Success = Color3.fromRGB(74, 222, 128),
	DisplayFont = Enum.Font.Fondamento,
}

local Window = {}
Window.__index = Window

local Tab = {}
Tab.__index = Tab

local function create(className, props, children)
	local instance = Instance.new(className)
	for key, value in pairs(props or {}) do instance[key] = value end
	for _, child in ipairs(children or {}) do child.Parent = instance end
	return instance
end

local function corner(radius) return create("UICorner", {CornerRadius = UDim.new(0, radius or 8)}) end
local function stroke(color, thickness, transparency) return create("UIStroke", {Color = color, Thickness = thickness or 1, Transparency = transparency or 0}) end
local function gradient(rotation, colors) return create("UIGradient", {Rotation = rotation or 90, Color = ColorSequence.new(colors)}) end

local function tween(object, goal, duration)
	local info = TweenInfo.new(duration or 0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
	local animation = TweenService:Create(object, info, goal)
	animation:Play()
	return animation
end

local function applyButtonHover(button, theme, isActive)
	local buttonGradient = button:FindFirstChildOfClass("UIGradient")
	local function setNormal()
		button.BackgroundColor3 = isActive and theme.Hover or theme.Accent
		if buttonGradient then
			buttonGradient.Color = isActive and ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.fromRGB(69, 102, 198)), ColorSequenceKeypoint.new(1, theme.Hover)}) or ColorSequence.new({ColorSequenceKeypoint.new(0, theme.ButtonTop), ColorSequenceKeypoint.new(1, theme.Accent)})
		end
	end
	button.MouseEnter:Connect(function()
		tween(button, {BackgroundColor3 = theme.Hover}, 0.12)
		if buttonGradient then buttonGradient.Color = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.fromRGB(69, 102, 198)), ColorSequenceKeypoint.new(1, theme.Hover)}) end
	end)
	button.MouseLeave:Connect(setNormal)
	setNormal()
	return setNormal
end

function AstroUI.CreateWindow(options)
	options = options or {}
	local theme = options.Theme or AstroUI.Theme
	local targetParent = game:GetService("CoreGui")
	
	
	local oldGui = targetParent:FindFirstChild(options.Name or "AstroUILibrary")
	if oldGui then oldGui:Destroy() end

	local screenGui = create("ScreenGui", {Name = options.Name or "AstroUILibrary", ResetOnSpawn = false, IgnoreGuiInset = true, Parent = targetParent})
	local self = setmetatable({Theme = theme, ScreenGui = screenGui, Pages = {}, TabButtons = {}, ActiveTab = nil}, Window)

	self.Main = create("Frame", {Name = "Main", AnchorPoint = Vector2.new(0.5, 0.5), Position = options.Position or UDim2.fromScale(0.5, 0.5), Size = options.Size or UDim2.fromOffset(824, 482), BackgroundTransparency = 1, BorderSizePixel = 0, Parent = screenGui})
	create("Frame", {Name = "HeaderShadow", Position = UDim2.fromOffset(32, 10), Size = UDim2.new(1, -2, 0, 345), BackgroundColor3 = theme.Shadow, BackgroundTransparency = 0.62, BorderSizePixel = 0, ZIndex = 0, Parent = self.Main}, {corner(14)})
	create("Frame", {Name = "HeaderBack", Position = UDim2.fromOffset(24, 0), Size = UDim2.new(1, 0, 0, 345), BackgroundColor3 = theme.Header, BorderSizePixel = 0, ZIndex = 1, Parent = self.Main}, {corner(14), stroke(theme.WhiteStroke, 1, 0.35), gradient(90, {ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(214, 214, 224))})})
	self.Header = create("Frame", {Name = "Header", Position = UDim2.fromOffset(24, 0), Size = UDim2.new(1, -24, 0, 54), BackgroundTransparency = 1, BorderSizePixel = 0, ZIndex = 4, Parent = self.Main})
	create("TextLabel", {Name = "Title", Position = UDim2.fromOffset(14, 0), Size = UDim2.new(0, 360, 1, 0), BackgroundTransparency = 1, Text = options.Title or "Astro's Dreamworld", TextColor3 = theme.HeaderText, Font = theme.DisplayFont, TextSize = 30, TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 5, Parent = self.Header})
	self.CloseButton = create("TextButton", {Name = "Close", AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, -18, 0.5, 0), Size = UDim2.fromOffset(30, 30), BackgroundTransparency = 1, BorderSizePixel = 0, Text = "x", TextColor3 = theme.HeaderText, Font = Enum.Font.GothamBold, TextSize = 16, ZIndex = 5, Parent = self.Header})
	create("Frame", {Name = "BodyShadow", Position = UDim2.fromOffset(10, 54), Size = UDim2.new(1, -24, 0, 439), BackgroundColor3 = theme.Shadow, BackgroundTransparency = 0.42, BorderSizePixel = 0, ZIndex = 1, Parent = self.Main}, {corner(16)})
	self.Body = create("Frame", {Name = "Body", Position = UDim2.fromOffset(0, 43), Size = UDim2.new(1, -24, 0, 439), BackgroundColor3 = theme.Background, BorderSizePixel = 0, ZIndex = 2, Parent = self.Main}, {corner(16), stroke(theme.PanelStroke, 2, 0.18), gradient(90, {ColorSequenceKeypoint.new(0, Color3.fromRGB(78, 63, 168)), ColorSequenceKeypoint.new(0.55, theme.Background), ColorSequenceKeypoint.new(1, Color3.fromRGB(50, 42, 125))})})
	self.Sidebar = create("ScrollingFrame", {Name = "Sidebar", Position = UDim2.fromOffset(18, 43), Size = UDim2.fromOffset(175, 362), BackgroundColor3 = theme.Panel, BorderSizePixel = 0, Active = true, CanvasSize = UDim2.fromOffset(0, 0), ScrollingDirection = Enum.ScrollingDirection.Y, ScrollingEnabled = true, ScrollBarThickness = 4, ScrollBarImageColor3 = theme.Accent, ZIndex = 3, Parent = self.Body}, {corner(16), stroke(theme.SoftStroke, 1, 0.62), gradient(90, {ColorSequenceKeypoint.new(0, Color3.fromRGB(93, 78, 185)), ColorSequenceKeypoint.new(1, Color3.fromRGB(67, 55, 145))})})

	local sidebarLayout = create("UIListLayout", {Padding = UDim.new(0, 14), SortOrder = Enum.SortOrder.LayoutOrder, Parent = self.Sidebar})
	create("UIPadding", {PaddingTop = UDim.new(0, 33), PaddingLeft = UDim.new(0, 17), PaddingRight = UDim.new(0, 17), Parent = self.Sidebar})
	sidebarLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function() self.Sidebar.CanvasSize = UDim2.fromOffset(0, sidebarLayout.AbsoluteContentSize.Y + 66) end)
	self.Content = create("Frame", {Name = "Content", Position = UDim2.fromOffset(224, 43), Size = UDim2.fromOffset(573, 362), BackgroundColor3 = theme.Panel, BorderSizePixel = 0, ZIndex = 3, Parent = self.Body}, {corner(14), stroke(theme.SoftStroke, 1, 0.7), gradient(90, {ColorSequenceKeypoint.new(0, Color3.fromRGB(89, 75, 175)), ColorSequenceKeypoint.new(1, Color3.fromRGB(69, 57, 150))})})
	
	self.CloseButton.MouseButton1Click:Connect(function() 
		self.ScreenGui.Enabled = false 
	end)
	
	local isMobile = UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled
	if isMobile then
		local mobileBtn = create("TextButton", {
			Name = "AstroMobileToggle",
			Size = UDim2.fromOffset(50, 50),
			Position = UDim2.new(0.05, 0, 0.2, 0),
			BackgroundColor3 = theme.Accent,
			BackgroundTransparency = 0.3,
			Text = "Astro",
			TextColor3 = theme.Text,
			Font = Enum.Font.GothamBold,
			TextSize = 14,
			ZIndex = 100,
			Parent = screenGui
		}, {
			corner(25),
			stroke(theme.SoftStroke, 2, 0.2)
		})
		
		mobileBtn.MouseButton1Click:Connect(function()
			self.ScreenGui.Enabled = not self.ScreenGui.Enabled
		end)
	else
		UserInputService.InputBegan:Connect(function(input, gameProcessed)
			if gameProcessed then return end
			if input.KeyCode == (options.ToggleKey or Enum.KeyCode.RightShift) then 
				self.ScreenGui.Enabled = not self.ScreenGui.Enabled 
			end
		end)
	end
	
	self:EnableDragging()
	return self
end

function Window:EnableDragging()
	local dragging, dragStart, startPosition = false, nil, nil
	self.Header.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			dragging = true dragStart = input.Position startPosition = self.Main.Position
		end
	end)
	UserInputService.InputChanged:Connect(function(input)
		if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
			local delta = input.Position - dragStart
			self.Main.Position = UDim2.new(startPosition.X.Scale, startPosition.X.Offset + delta.X, startPosition.Y.Scale, startPosition.Y.Offset + delta.Y)
		end
	end)
	UserInputService.InputEnded:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then dragging = false end
	end)
end

function Window:CreateTab(name)
	local theme = self.Theme
	local page = create("ScrollingFrame", {Name = name .. "Page", Size = UDim2.fromScale(1, 1), BackgroundTransparency = 1, BorderSizePixel = 0, Active = true, CanvasSize = UDim2.fromOffset(0, 0), ScrollingDirection = Enum.ScrollingDirection.Y, ScrollingEnabled = true, ScrollBarThickness = 4, ScrollBarImageColor3 = theme.Accent, Visible = false, ZIndex = 4, Parent = self.Content})
	local listLayout = create("UIListLayout", {Padding = UDim.new(0, 10), SortOrder = Enum.SortOrder.LayoutOrder, Parent = page})
	create("UIPadding", {PaddingTop = UDim.new(0, 14), PaddingLeft = UDim.new(0, 14), PaddingRight = UDim.new(0, 18), Parent = page})
	listLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function() page.CanvasSize = UDim2.fromOffset(0, listLayout.AbsoluteContentSize.Y + 34) end)
	
	local button = create("TextButton", {Name = name .. "Tab", Size = UDim2.new(1, 0, 0, 54), BackgroundColor3 = theme.Accent, BorderSizePixel = 0, Text = name, TextColor3 = theme.Text, Font = theme.DisplayFont, TextSize = 25, ZIndex = 4, Parent = self.Sidebar}, {corner(16), stroke(theme.SoftStroke, 1, 0.62), gradient(90, {ColorSequenceKeypoint.new(0, theme.ButtonTop), ColorSequenceKeypoint.new(1, theme.Accent)})})
	button.MouseButton1Click:Connect(function() 
		self:SetActiveTab(name)
	end)
	self.Pages[name], self.TabButtons[name] = page, button
	if not self.ActiveTab then self:SetActiveTab(name) end
	return setmetatable({Window = self, Page = page, Name = name}, Tab)
end

function Window:SetActiveTab(name)
	self.ActiveTab = name
	for tabName, page in pairs(self.Pages) do
		local isActive = tabName == name
		page.Visible = isActive
		if self.TabButtons[tabName] then applyButtonHover(self.TabButtons[tabName], self.Theme, isActive) end
	end
end


function Tab:CreateSection(text)
	local theme = self.Window.Theme
	return create("TextLabel", {Size = UDim2.new(1, 0, 0, 24), BackgroundTransparency = 1, Text = text, TextColor3 = theme.Text, Font = theme.DisplayFont, TextSize = 18, TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 4, Parent = self.Page})
end

function Tab:CreateButton(text, callback)
	local theme = self.Window.Theme
	local button = create("TextButton", {Size = UDim2.new(1, 0, 0, 40), BackgroundColor3 = theme.Accent, BorderSizePixel = 0, Text = text, TextColor3 = theme.Text, Font = theme.DisplayFont, TextSize = 18, ZIndex = 4, Parent = self.Page}, {corner(7), stroke(theme.SoftStroke, 1, 0.65), gradient(90, {ColorSequenceKeypoint.new(0, theme.ButtonTop), ColorSequenceKeypoint.new(1, theme.Accent)})})
	applyButtonHover(button, theme, false)
	button.MouseButton1Click:Connect(function() if callback then callback() end end)
	return button
end

function Tab:CreateToggle(text, defaultValue, callback)
	local theme = self.Window.Theme
	local value = defaultValue == true
	local row = create("Frame", {Size = UDim2.new(1, 0, 0, 42), BackgroundColor3 = theme.PanelLight, BorderSizePixel = 0, ZIndex = 4, Parent = self.Page}, {corner(7), stroke(theme.SoftStroke, 1, 0.76), gradient(90, {ColorSequenceKeypoint.new(0, Color3.fromRGB(102, 86, 198)), ColorSequenceKeypoint.new(1, Color3.fromRGB(76, 63, 165))})})
	create("TextLabel", {Position = UDim2.fromOffset(12, 0), Size = UDim2.new(1, -70, 1, 0), BackgroundTransparency = 1, Text = text, TextColor3 = theme.Text, Font = theme.DisplayFont, TextSize = 17, TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 5, Parent = row})
	local knob = create("Frame", {AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, -12, 0.5, 0), Size = UDim2.fromOffset(46, 24), BackgroundColor3 = value and theme.Success or Color3.fromRGB(88, 94, 108), BorderSizePixel = 0, ZIndex = 5, Parent = row}, {corner(12), stroke(Color3.fromRGB(255, 255, 255), 1, 0.75)})
	local dot = create("Frame", {Position = value and UDim2.fromOffset(24, 3) or UDim2.fromOffset(3, 3), Size = UDim2.fromOffset(18, 18), BackgroundColor3 = theme.Text, BorderSizePixel = 0, ZIndex = 6, Parent = knob}, {corner(9)})
	local function render()
		tween(knob, {BackgroundColor3 = value and theme.Success or Color3.fromRGB(88, 94, 108)})
		tween(dot, {Position = value and UDim2.fromOffset(24, 3) or UDim2.fromOffset(3, 3)})
	end
	local hitbox = create("TextButton", {Size = UDim2.fromScale(1, 1), BackgroundTransparency = 1, Text = "", ZIndex = 7, Parent = row})
	hitbox.MouseButton1Click:Connect(function()
		value = not value render() if callback then callback(value) end
	end)
	return {Get = function() return value end, Set = function(newValue) value = newValue == true render() if callback then callback(value) end end}
end

function Tab:CreateSlider(text, minValue, maxValue, defaultValue, callback)
	local theme = self.Window.Theme
	local value = math.clamp(defaultValue or minValue, minValue, maxValue)
	local frame = create("Frame", {Size = UDim2.new(1, 0, 0, 62), BackgroundColor3 = theme.PanelLight, BorderSizePixel = 0, ZIndex = 4, Parent = self.Page}, {corner(7), stroke(theme.SoftStroke, 1, 0.76), gradient(90, {ColorSequenceKeypoint.new(0, Color3.fromRGB(102, 86, 198)), ColorSequenceKeypoint.new(1, Color3.fromRGB(76, 63, 165))})})
	local label = create("TextLabel", {Position = UDim2.fromOffset(12, 0), Size = UDim2.new(1, -24, 0, 32), BackgroundTransparency = 1, Text = text .. ": " .. tostring(value), TextColor3 = theme.Text, Font = theme.DisplayFont, TextSize = 17, TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 5, Parent = frame})
	local bar = create("Frame", {Position = UDim2.fromOffset(12, 40), Size = UDim2.new(1, -24, 0, 8), BackgroundColor3 = Color3.fromRGB(72, 78, 92), BorderSizePixel = 0, ZIndex = 5, Parent = frame}, {corner(4), stroke(Color3.fromRGB(255, 255, 255), 1, 0.86)})
	local fill = create("Frame", {Size = UDim2.fromScale((value - minValue) / (maxValue - minValue), 1), BackgroundColor3 = theme.Accent, BorderSizePixel = 0, ZIndex = 6, Parent = bar}, {corner(4), gradient(0, {ColorSequenceKeypoint.new(0, Color3.fromRGB(82, 218, 255)), ColorSequenceKeypoint.new(1, theme.ButtonTop)})})
	local dragging = false
	local function setFromX(x)
		local alpha = math.clamp((x - bar.AbsolutePosition.X) / bar.AbsoluteSize.X, 0, 1)
		value = math.floor(minValue + ((maxValue - minValue) * alpha))
		label.Text = text .. ": " .. tostring(value) fill.Size = UDim2.fromScale(alpha, 1) if callback then callback(value) end
	end
	bar.InputBegan:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then dragging = true setFromX(input.Position.X) end end)
	UserInputService.InputChanged:Connect(function(input) if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then setFromX(input.Position.X) end end)
	UserInputService.InputEnded:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then dragging = false end end)
	return {Get = function() return value end}
end

function Tab:CreateKeybind(text, defaultKey, callback)
	local theme = self.Window.Theme
	local currentKey, listening = defaultKey, false
	callback = callback or function() end
	local isMobile = UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled
	
	local row = create("Frame", {Size = UDim2.new(1, 0, 0, 42), BackgroundColor3 = theme.PanelLight, BorderSizePixel = 0, ZIndex = 4, Parent = self.Page}, {corner(7), stroke(theme.SoftStroke, 1, 0.76), gradient(90, {ColorSequenceKeypoint.new(0, Color3.fromRGB(102, 86, 198)), ColorSequenceKeypoint.new(1, Color3.fromRGB(76, 63, 165))})})
	create("TextLabel", {Position = UDim2.fromOffset(12, 0), Size = UDim2.new(1, -120, 1, 0), BackgroundTransparency = 1, Text = text, TextColor3 = theme.Text, Font = theme.DisplayFont, TextSize = 17, TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 5, Parent = row})
	local bindButton = create("TextButton", {AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, -12, 0.5, 0), Size = UDim2.fromOffset(100, 26), BackgroundColor3 = theme.Accent, Text = isMobile and "Mobile" or (currentKey and currentKey.Name or "None"), TextColor3 = theme.Text, Font = Enum.Font.GothamMedium, TextSize = 13, ZIndex = 5, Parent = row}, {corner(6), stroke(theme.SoftStroke, 1, 0.5)})

	if isMobile then
		local btn = create("TextButton", {Size = UDim2.fromOffset(55, 55), Position = UDim2.new(0.8, 0, 0.3, 0), BackgroundColor3 = theme.Accent, Text = string.sub(text, 1, 3), TextColor3 = theme.Text, Font = Enum.Font.GothamBold, TextSize = 14, ZIndex = 10, Parent = self.Window.ScreenGui}, {corner(27), stroke(theme.SoftStroke, 2, 0.2)})
		local mD, mS, mP = false, nil, nil
		
		btn.InputBegan:Connect(function(i) 
			if i.UserInputType == Enum.UserInputType.Touch then 
				mD = true 
				mS = i.Position 
				mP = btn.Position 
			end 
		end)
		
		UserInputService.InputChanged:Connect(function(i) 
			if mD and i.UserInputType == Enum.UserInputType.Touch then 
				local d = i.Position - mS 
				btn.Position = UDim2.new(mP.X.Scale, mP.X.Offset + d.X, mP.Y.Scale, mP.Y.Offset + d.Y) 
			end 
		end)
		
		UserInputService.InputEnded:Connect(function(i) 
			if i.UserInputType == Enum.UserInputType.Touch then 
				mD = false 
			end 
		end)
		
		btn.MouseButton1Click:Connect(callback)
	end

	bindButton.MouseButton1Click:Connect(function() 
		if not isMobile then 
			listening = true 
			bindButton.Text = "..." 
			bindButton.BackgroundColor3 = theme.Hover 
		end 
	end)

	UserInputService.InputBegan:Connect(function(i, p)
		if p then return end
		if listening and i.UserInputType == Enum.UserInputType.Keyboard then
			currentKey = i.KeyCode ~= Enum.KeyCode.Escape and i.KeyCode or nil
			bindButton.Text = currentKey and currentKey.Name or "None" 
			listening = false 
			bindButton.BackgroundColor3 = theme.Accent
		elseif currentKey and i.KeyCode == currentKey then 
			callback() 
		end
	end)

	return {Get = function() return currentKey end}
end

local espTable = {}


local cooldownTimers = {}  

local function GetCooldown(monster)
	if cooldownTimers[monster] and cooldownTimers[monster] > 0 then
		return cooldownTimers[monster]
	end
	
	
	for _, v in ipairs(monster:GetDescendants()) do
		if (v:IsA("NumberValue") or v:IsA("IntValue")) then
			local valName = v.Name:lower()
			local val = v.Value
			
			
			if valName:find("patrol") or valName:find("speed") or valName:find("walk") then
				continue
			end
			
			if val >= 8 and val <= 18 then
				cooldownTimers[monster] = val
				return val
			end
		end
	end
	
	
	local chaser = monster:FindFirstChild("Chaser") or monster:FindFirstChild("AI")
	if chaser then
		for _, v in ipairs(chaser:GetDescendants()) do
			if (v:IsA("NumberValue") or v:IsA("IntValue")) then
				local val = v.Value
				if val >= 8 and val <= 18 then
					cooldownTimers[monster] = val
					return val
				end
			end
		end
	end
	
	return 0
end


task.spawn(function()
	while true do
		task.wait(0.1)
		for monster, timeLeft in pairs(cooldownTimers) do
			if monster and monster.Parent then
				cooldownTimers[monster] = math.max(0, timeLeft - 0.1)
			else
				cooldownTimers[monster] = nil
			end
		end
	end
end)

local function makeESP(obj, txt, col)
	if not obj then return end
	
	local p = obj:IsA("BasePart") and obj 
		or obj:FindFirstChildOfClass("MeshPart") 
		or obj:FindFirstChildOfClass("Part") 
		or obj:FindFirstChild("HumanoidRootPart")
	
	if not p then return end
	
	local targetModel = obj:IsA("Model") and obj 
		or obj:FindFirstAncestorOfClass("Model") 
		or p
	
	if targetModel:FindFirstChild("AstroHighlight") or p:FindFirstChild("AstroTag") then 
		return 
	end
	
	local hl = Instance.new("Highlight")
	hl.Name = "AstroHighlight"
	hl.FillColor = col
	hl.FillTransparency = 0.7
	hl.OutlineColor = col
	hl.OutlineTransparency = 0
	hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
	hl.Adornee = targetModel
	hl.Parent = targetModel
	
	local bb = Instance.new("BillboardGui")
	bb.Name = "AstroTag"
	bb.Size = UDim2.new(0, 200, 0, 50)
	bb.AlwaysOnTop = true
	bb.StudsOffset = Vector3.new(0, 4, 0)
	bb.Adornee = p
	bb.Parent = p
	
	local l = Instance.new("TextLabel")
	l.Size = UDim2.new(1, 0, 1, 0)
	l.BackgroundTransparency = 1
	l.Text = txt
	l.TextColor3 = col
	l.Font = Enum.Font.GothamBold
	l.TextSize = 14
	l.Parent = bb
	
	table.insert(espTable, hl)
	table.insert(espTable, bb)
end

local function clearESP()
	
	for _, v in ipairs(espTable) do
		pcall(function()
			if v and v.Parent then
				v:Destroy()
			end
		end)
	end
	table.clear(espTable)

 pcall(function()
		for _, obj in ipairs(workspace:GetDescendants()) do
			if obj.Name == "AstroHighlight" or obj.Name == "AstroTag" then
				obj:Destroy()
			end
		end
	end)
end



task.spawn(function()
	while task.wait(0.4) do
		clearESP()
		
		local room = workspace:FindFirstChild("CurrentRoom")
		if not room then continue end
		
		for _, sala in ipairs(room:GetChildren()) do
			if _G.ESPTwisteds then
				local monFolder = sala:FindFirstChild("Monsters")
				if monFolder then
					for _, monster in ipairs(monFolder:GetChildren()) do
						pcall(function()
							local root = monster:FindFirstChild("HumanoidRootPart") 
								or monster:FindFirstChildOfClass("MeshPart")
								or monster:FindFirstChildOfClass("Part")
							
							if not root then return end
							
							local nombreLimpio = string.gsub(monster.Name, "Monster", "")
							nombreLimpio = string.gsub(nombreLimpio, "Character", "")
							
							local cooldownText = ""
							
							local hasBigAbility = monster.Name:find("Goob") or monster.Name:find("Gigi") or 
												  monster.Name:find("Sprout") or monster.Name:find("Astro") or 
												  monster.Name:find("Scraps") or monster.Name:find("Vee")
							
							if hasBigAbility then
								local remaining = GetCooldown(monster)
								if remaining > 0.5 then
									cooldownText = " [" .. math.ceil(remaining) .. "s]"
								else
									cooldownText = " [READY]"
								end
							end
							
							makeESP(root, "[Twisted] " .. nombreLimpio .. cooldownText, Color3.fromRGB(255, 50, 50))
						end)
					end
				end
			end
			
			
			if _G.ESPResearch then
				local itemsFolder = sala:FindFirstChild("Items")
				if itemsFolder then
					for _, item in ipairs(itemsFolder:GetChildren()) do
						if item.Name == "ResearchCapsule" then 
							makeESP(item, "Capsule", Color3.fromRGB(82, 218, 255)) 
						end
					end
				end
			end
			
			
			if _G.ESPAllItems then
				local itemsFolder = sala:FindFirstChild("Items")
				if itemsFolder then
					for _, item in ipairs(itemsFolder:GetChildren()) do
						pcall(function()
							local nameLower = item.Name:lower()
							
							if nameLower:find("medkit") then
								makeESP(item, "🩹 Medkit", Color3.fromRGB(255, 215, 0))
							elseif nameLower:find("bandage") then
								makeESP(item, "🩹 Bandage", Color3.fromRGB(255, 215, 0))
							elseif nameLower:find("Chocolate Box") then
								makeESP(item, "🍫 Chocolate Box", Color3.fromRGB(139, 69, 19))
							elseif nameLower:find("pop") then
								if nameLower:find("bottle") or nameLower:find("bottleofpop") then
									makeESP(item, "🥤 Bottle of Pop", Color3.fromRGB(100, 200, 255))
								else
									makeESP(item, "🥤 Pop", Color3.fromRGB(100, 200, 255))
								end
							elseif nameLower:find("tape") then
								makeESP(item, "📼 Tape", Color3.fromRGB(180, 180, 180))
							else
								makeESP(item, " " .. item.Name, Color3.fromRGB(0, 255, 255))
							end
						end)
					end
				end
			end
			
			
			if _G.ESPGenerators then
				local gensFolder = sala:FindFirstChild("Generators")
				if gensFolder then
					for _, gen in ipairs(gensFolder:GetChildren()) do
						pcall(function()
							if gen.Name ~= "Generator" and not gen:FindFirstChild("BaseMachine") then 
								return 
							end
							
							local isCompleted = false
							local baseMachine = gen:FindFirstChild("BaseMachine") or gen
							
							for _, obj in ipairs(baseMachine:GetDescendants()) do
								if (obj:IsA("MeshPart") or obj:IsA("Part")) and obj.Material == Enum.Material.Neon then
									local c = obj.Color
									if c.G > 0.6 and c.R < 0.3 then
										isCompleted = true
										break
									end
								end
							end
							
							if not isCompleted then
								local lightRef = gen:FindFirstChild("LightReference") or baseMachine:FindFirstChild("LightReference")
								if lightRef then
									for _, obj in ipairs(lightRef:GetDescendants()) do
										if (obj:IsA("MeshPart") or obj:IsA("Part")) and obj.Material == Enum.Material.Neon then
											local c = obj.Color
											if c.G > 0.6 and c.R < 0.3 then
												isCompleted = true
												break
											end
										end
									end
								end
							end
							
							if not isCompleted then
								makeESP(gen, "Generator", Color3.fromRGB(74, 222, 128))
							end
						end)
					end
				end
			end
		end
		
		
		if _G.ESPElevator then
			local elevators = workspace:FindFirstChild("Elevators")
			if elevators then
				for _, elev in ipairs(elevators:GetChildren()) do
					if elev.Name == "Elevator" then 
						makeESP(elev, " Elevator", Color3.fromRGB(230, 100, 220)) 
					end
				end
			end
		end
	end
end)

	
	
			
			




local S = { skillcheckOrigCB = nil }

local function ApplyInstantSkillcheck(state)
    local ReplicatedStorage = game:GetService("ReplicatedStorage")
    local Remote = ReplicatedStorage:FindFirstChild("Events", true):FindFirstChild("SkillcheckUpdate")
    
   

    if state then
        
        if getcallbackvalue then
            pcall(function()
                S.skillcheckOrigCB = getcallbackvalue(Remote, "OnClientInvoke")
            end)
        end

        Remote.OnClientInvoke = function(...)
            task.spawn(function()
                pcall(function()
                    local pGui = localPlayer:WaitForChild("PlayerGui")
                    
                    
                    if _G.HideCircleMinigame then
                        
                        local circleGui = pGui:FindFirstChild("CircleSkillCheckGui")
                        if circleGui then
                            circleGui.Enabled = false
                            for _, obj in ipairs(circleGui:GetDescendants()) do
                                if obj:IsA("GuiObject") then
                                    pcall(function() obj.Visible = false end)
                                end
                            end
                        end
                        
                        
                        local skillFrame = pGui:FindFirstChild("SkillCheckFrame", true)
                        if skillFrame then skillFrame.Visible = false end
                    end

                    
                    local menu = pGui:FindFirstChild("Menu", true)
                    if menu then
                        local msg = menu:FindFirstChild("SkillCheckMessage")
                        if msg then
                            msg.Text = "Great Job!"
                            msg.Visible = true
                            msg.TextTransparency = 0
                            pcall(function()
                                if msg:FindFirstChild("UIGradient") then msg.UIGradient.Enabled = false end
                                if msg:FindFirstChild("UIGradientWin") then msg.UIGradientWin.Enabled = true end
                            end)
                        end
                    end

                    
                    pcall(function()
                        local correct = pGui:FindFirstChild("Correct", true) or pGui:FindFirstChildWhichIsA("Sound")
                        if correct and correct:IsA("Sound") then correct:Play() end
                        local goldHit = pGui:FindFirstChild("GoldAreaHit", true)
                        if goldHit and goldHit:IsA("Sound") then goldHit:Play() end
                    end)
                end)
            end)
            
            return "supercomplete"  
        end

        
    else
        
        if Remote then
            if S.skillcheckOrigCB then
                Remote.OnClientInvoke = S.skillcheckOrigCB
                S.skillcheckOrigCB = nil
            else
                Remote.OnClientInvoke = nil
            end
        end
        
    end
end



local RunService = game:GetService("RunService")

local FlyState = {
    flying = false,
    speed = 70,
    accel = 0.15,
    lv = nil,
    av = nil,
    attachment = nil,
}

local flyLoop = nil
local noclipLoop = nil

local function ToggleFly(state)
    _G.Fly = state
    
    local char = localPlayer.Character
    if not char then return end
    
    local root = char:FindFirstChild("HumanoidRootPart")
    local hum = char:FindFirstChildWhichIsA("Humanoid")
    if not root or not hum then return end

    
    if FlyState.lv then FlyState.lv:Destroy() end
    if FlyState.av then FlyState.av:Destroy() end
    if FlyState.attachment then FlyState.attachment:Destroy() end
    if flyLoop then flyLoop:Disconnect() flyLoop = nil end

    if state then
        FlyState.attachment = Instance.new("Attachment", root)
        
        FlyState.lv = Instance.new("LinearVelocity", root)
        FlyState.lv.MaxForce = 9e10
        FlyState.lv.VelocityConstraintMode = Enum.VelocityConstraintMode.Vector
        FlyState.lv.VectorVelocity = Vector3.zero
        FlyState.lv.Attachment0 = FlyState.attachment

        FlyState.av = Instance.new("AngularVelocity", root)
        FlyState.av.MaxTorque = 9e10
        FlyState.av.AngularVelocity = Vector3.zero
        FlyState.av.Attachment0 = FlyState.attachment

        hum.PlatformStand = true
        hum:ChangeState(Enum.HumanoidStateType.Physics)

        flyLoop = RunService.Heartbeat:Connect(function()
            pcall(function()
                if not root or not root.Parent then return end
                local camera = workspace.CurrentCamera
                local moveDir = Vector3.zero

                if UserInputService:IsKeyDown(Enum.KeyCode.W) then moveDir += camera.CFrame.LookVector end
                if UserInputService:IsKeyDown(Enum.KeyCode.S) then moveDir -= camera.CFrame.LookVector end
                if UserInputService:IsKeyDown(Enum.KeyCode.A) then moveDir -= camera.CFrame.RightVector end
                if UserInputService:IsKeyDown(Enum.KeyCode.D) then moveDir += camera.CFrame.RightVector end
                if UserInputService:IsKeyDown(Enum.KeyCode.Space) then moveDir += Vector3.new(0,1,0) end
                if UserInputService:IsKeyDown(Enum.KeyCode.Q) then moveDir -= Vector3.new(0,1,0) end

                local targetVel = moveDir.Magnitude > 0 and (moveDir.Unit * FlyState.speed) or Vector3.zero
                FlyState.lv.VectorVelocity = FlyState.lv.VectorVelocity:Lerp(targetVel, FlyState.accel)

                local camRot = camera.CFrame - camera.CFrame.Position
                root.CFrame = CFrame.new(root.Position) * camRot
            end)
        end)

    else
        hum.PlatformStand = false
        hum:ChangeState(Enum.HumanoidStateType.GettingUp)
    end
end

local noclipLoop = nil

local function ToggleNoclip(state)
    _G.Noclip = state
    
    if noclipLoop then 
        noclipLoop:Disconnect() 
        noclipLoop = nil 
    end

    local char = localPlayer.Character
    if not char then return end

    if state then
        
        noclipLoop = RunService.Heartbeat:Connect(function()
            pcall(function()
                if not char or not char.Parent then return end
                
                local root = char:FindFirstChild("HumanoidRootPart")
                if root then
                    root.CanCollide = false
                    root.Massless = true
                end

                for _, part in ipairs(char:GetDescendants()) do
                    if (part:IsA("BasePart") or part:IsA("MeshPart")) then
                        part.CanCollide = false
                        part.Massless = true
                    end
                end
            end)
        end)

        
    else
        
        pcall(function()
            local root = char:FindFirstChild("HumanoidRootPart")
            if root then
                root.CanCollide = true
                root.Massless = false
                root.Velocity = Vector3.new(0, -50, 0)   
                root.AssemblyLinearVelocity = Vector3.new(0, -50, 0)
            end

            for _, part in ipairs(char:GetDescendants()) do
                if part:IsA("BasePart") or part:IsA("MeshPart") then
                    part.CanCollide = true
                    part.Massless = false
                end
            end
        end)

        local hum = char:FindFirstChildWhichIsA("Humanoid")
        if hum then
            hum.PlatformStand = false
            task.wait(0.1)
            hum:ChangeState(Enum.HumanoidStateType.Running)
            task.wait(0.1)
            hum:ChangeState(Enum.HumanoidStateType.GettingUp)
            hum:ChangeState(Enum.HumanoidStateType.Landed)
        end

        
    end
end




local tpWalkLoop = nil
local tpWalkSpeed = 0.7   

local function ToggleTPWalk(state)
    _G.TPWalk = state

    if tpWalkLoop then
        tpWalkLoop:Disconnect()
        tpWalkLoop = nil
    end

    if not state then return end

    tpWalkLoop = RunService.Heartbeat:Connect(function()
        local char = localPlayer.Character
        if not char then return end
        local root = char:FindFirstChild("HumanoidRootPart")
        if not root then return end

        local camera = workspace.CurrentCamera
        local moveDir = Vector3.zero

        if UserInputService:IsKeyDown(Enum.KeyCode.W) then moveDir += camera.CFrame.LookVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.S) then moveDir -= camera.CFrame.LookVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.A) then moveDir -= camera.CFrame.RightVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.D) then moveDir += camera.CFrame.RightVector end

        if moveDir.Magnitude > 0 then
            moveDir = Vector3.new(moveDir.X, 0, moveDir.Z).Unit

            local targetPos = root.Position + moveDir * tpWalkSpeed
            local newPos = root.Position:Lerp(targetPos, 0.65)

            local currentLook = root.CFrame.LookVector
            local targetLook = moveDir
            local smoothedLook = currentLook:Lerp(targetLook, 0.25)

            root.CFrame = CFrame.new(newPos) * CFrame.lookAt(Vector3.new(0,0,0), smoothedLook)
        end
    end)
end


local fullbrightEnabled = false
local lightingConn = nil

local function ToggleFullbright(state)
    fullbrightEnabled = state
    
    local Lighting = game:GetService("Lighting")
    
    if state then
        
        Lighting.Ambient = Color3.fromRGB(110, 110, 120)
        Lighting.Brightness = 0.5
        Lighting.ClockTime = 14
        Lighting.FogEnd = 99999
        Lighting.GlobalShadows = false
        Lighting.OutdoorAmbient = Color3.fromRGB(100, 100, 120)
        
        if lightingConn then lightingConn:Disconnect() end
        
        lightingConn = Lighting.Changed:Connect(function()
            if fullbrightEnabled then
                Lighting.Ambient = Color3.fromRGB(110, 110, 120)
                Lighting.Brightness = 0.5
                Lighting.GlobalShadows = false
            end
        end)
        
    else
        if lightingConn then
            lightingConn:Disconnect()
            lightingConn = nil
        end
        
        
        Lighting.Ambient = Color3.fromRGB(70, 70, 70)
        Lighting.Brightness = 1
        Lighting.ClockTime = 14
        Lighting.GlobalShadows = true
        Lighting.FogEnd = 100000
    end
end





local Ventana = AstroUI.CreateWindow({
	Title = "Astro's Dreamworld 😴 | Dandy's World",
	ToggleKey = Enum.KeyCode.V
})

local PlayerTab = Ventana:CreateTab("Player")
PlayerTab:CreateSection("Movement")

PlayerTab:CreateToggle("Fly", false, function(state)
    ToggleFly(state)
end)

PlayerTab:CreateSlider("Fly Speed", 20, 150, 70, function(value)
    FlyState.speed  = value
end)

PlayerTab:CreateToggle("Noclip", false, function(state)
    ToggleNoclip(state)
end)

PlayerTab:CreateToggle("TP Walk", false, function(state)
    ToggleTPWalk(state)
end)


local speedRow = create("Frame", {
    Size = UDim2.new(1, 0, 0, 52),
    BackgroundColor3 = Ventana.Theme.PanelLight,
    BorderSizePixel = 0,
    Parent = PlayerTab.Page
}, {corner(8), stroke(Ventana.Theme.SoftStroke, 1, 0.7)})

create("TextLabel", {
    Position = UDim2.fromOffset(14, 10),
    Size = UDim2.new(1, -130, 0, 20),
    BackgroundTransparency = 1,
    Text = "TP Walk Speed",
    TextColor3 = Ventana.Theme.Text,
    Font = Ventana.Theme.DisplayFont,
    TextSize = 17,
    TextXAlignment = Enum.TextXAlignment.Left,
    Parent = speedRow
})

local inputBox = create("TextBox", {
    Position = UDim2.new(1, -110, 0.5, -13),
    Size = UDim2.fromOffset(95, 28),
    BackgroundColor3 = Color3.fromRGB(30, 30, 45),
    Text = tostring(tpWalkSpeed),
    TextColor3 = Color3.fromRGB(255, 255, 255),
    Font = Enum.Font.GothamSemibold,
    TextSize = 16,
    ClearTextOnFocus = false,
    Parent = speedRow
}, {corner(6), stroke(Ventana.Theme.Accent, 1, 0.5)})

inputBox.FocusLost:Connect(function()
    local num = tonumber(inputBox.Text)
    if num then
        tpWalkSpeed = math.clamp(num, 0.3, 5)
    end
    inputBox.Text = tostring(tpWalkSpeed)
end)


local VisualsTab = Ventana:CreateTab("Visuals")
VisualsTab:CreateSection("All ESPs")

VisualsTab:CreateToggle("ESP Twisteds", false, function(state)
	_G.ESPTwisteds = state
	if not state then clearESP() end
end)

VisualsTab:CreateToggle("ESP Research Capsules", false, function(state)
	_G.ESPResearch = state
	if not state then clearESP() end
end)

VisualsTab:CreateToggle("ESP All Items", false, function(state)
	_G.ESPAllItems = state
	if not state then clearESP() end
end)

VisualsTab:CreateToggle("ESP Generators", false, function(state)
	_G.ESPGenerators = state
	if not state then clearESP() end
end)

VisualsTab:CreateToggle("ESP Elevator", false, function(state)
	_G.ESPElevator = state
	if not state then clearESP() end
end)

local AutoTab = Ventana:CreateTab("Automation")
AutoTab:CreateSection("Generator")



local instantToggle = AutoTab:CreateToggle("Instant Skillcheck", false, function(state)
    ApplyInstantSkillcheck(state)
end)

local EnvironTab = Ventana:CreateTab("Environment ")
EnvironTab:CreateSection("Environment")

EnvironTab:CreateToggle("Fullbright", false, function(state)
    ToggleFullbright(state)
end)


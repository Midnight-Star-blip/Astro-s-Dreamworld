return(function(TXtnf, ...)
local vB145Y = {"YdguMWZajIndkTL";"R3zZliMelOR";"o6QzDn4wklib0r";"Jh9tRKdFN8udZf0JA";"EN1k2BbtBx9Ly";"gBL5d4f1";"ND7PtF";"KT5UbQM";"ba4Scjp8sbzRiL8bt";"nNX3e";"zw0f9thKNHoIvkni";"NiUqYy"}
local n3qXqe0X = function(...)
local Players = game:GetService(loadstring(base64decode("UGxheWVycw=="))())
local TweenService = game:GetService(loadstring(base64decode("VHdlZW5TZXJ2aWNl"))())
local UserInputService = game:GetService(loadstring(base64decode("VXNlcklucHV0U2VydmljZQ=="))())
local VirtualInputManager = game:GetService(loadstring(base64decode("VmlydHVhbElucHV0TWFuYWdlcg=="))())
local ReplicatedStorage = game:GetService(loadstring(base64decode("UmVwbGljYXRlZFN0b3JhZ2U="))())
local localPlayer = Players.LocalPlayer


_G.ESPTwisteds = false
_G.ESPItems = false
_G.ESPGenerators = false
_G.ESPElevator = false
_G.AutoSkillcheck = false
_G.HideCircleMinigame = true   
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

local function corner(radius) return create(loadstring(base64decode("VUlDb3JuZXI="))(), {CornerRadius = UDim.new(0, radius or 8)}) end
local function stroke(color, thickness, transparency) return create(loadstring(base64decode("VUlTdHJva2U="))(), {Color = color, Thickness = thickness or 1, Transparency = transparency or 0}) end
local function gradient(rotation, colors) return create(loadstring(base64decode("VUlHcmFkaWVudA=="))(), {Rotation = rotation or 90, Color = ColorSequence.new(colors)}) end

local function tween(object, goal, duration)
	local info = TweenInfo.new(duration or 0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
	local animation = TweenService:Create(object, info, goal)
	animation:Play()
	return animation
end

local function applyButtonHover(button, theme, isActive)
	local buttonGradient = button:FindFirstChildOfClass(loadstring(base64decode("VUlHcmFkaWVudA=="))())
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
	local targetParent = game:GetService(loadstring(base64decode("Q29yZUd1aQ=="))())
	
	
	local oldGui = targetParent:FindFirstChild(options.Name or loadstring(base64decode("QXN0cm9VSUxpYnJhcnk="))())
	if oldGui then oldGui:Destroy() end

	local screenGui = create(loadstring(base64decode("U2NyZWVuR3Vp"))(), {Name = options.Name or loadstring(base64decode("QXN0cm9VSUxpYnJhcnk="))(), ResetOnSpawn = false, IgnoreGuiInset = true, Parent = targetParent})
	local self = setmetatable({Theme = theme, ScreenGui = screenGui, Pages = {}, TabButtons = {}, ActiveTab = nil}, Window)

	self.Main = create(loadstring(base64decode("RnJhbWU="))(), {Name = loadstring(base64decode("TWFpbg=="))(), AnchorPoint = Vector2.new(0.5, 0.5), Position = options.Position or UDim2.fromScale(0.5, 0.5), Size = options.Size or UDim2.fromOffset(824, 482), BackgroundTransparency = 1, BorderSizePixel = 0, Parent = screenGui})
	create(loadstring(base64decode("RnJhbWU="))(), {Name = loadstring(base64decode("SGVhZGVyU2hhZG93"))(), Position = UDim2.fromOffset(32, 10), Size = UDim2.new(1, -2, 0, 345), BackgroundColor3 = theme.Shadow, BackgroundTransparency = 0.62, BorderSizePixel = 0, ZIndex = 0, Parent = self.Main}, {corner(14)})
	create(loadstring(base64decode("RnJhbWU="))(), {Name = loadstring(base64decode("SGVhZGVyQmFjaw=="))(), Position = UDim2.fromOffset(24, 0), Size = UDim2.new(1, 0, 0, 345), BackgroundColor3 = theme.Header, BorderSizePixel = 0, ZIndex = 1, Parent = self.Main}, {corner(14), stroke(theme.WhiteStroke, 1, 0.35), gradient(90, {ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(214, 214, 224))})})
	self.Header = create(loadstring(base64decode("RnJhbWU="))(), {Name = loadstring(base64decode("SGVhZGVy"))(), Position = UDim2.fromOffset(24, 0), Size = UDim2.new(1, -24, 0, 54), BackgroundTransparency = 1, BorderSizePixel = 0, ZIndex = 4, Parent = self.Main})
	create(loadstring(base64decode("VGV4dExhYmVs"))(), {Name = loadstring(base64decode("VGl0bGU="))(), Position = UDim2.fromOffset(14, 0), Size = UDim2.new(0, 360, 1, 0), BackgroundTransparency = 1, Text = options.Title or loadstring(base64decode("QXN0cm8ncyBEcmVhbXdvcmxk"))(), TextColor3 = theme.HeaderText, Font = theme.DisplayFont, TextSize = 30, TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 5, Parent = self.Header})
	self.CloseButton = create(loadstring(base64decode("VGV4dEJ1dHRvbg=="))(), {Name = loadstring(base64decode("Q2xvc2U="))(), AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, -18, 0.5, 0), Size = UDim2.fromOffset(30, 30), BackgroundTransparency = 1, BorderSizePixel = 0, Text = loadstring(base64decode("eA=="))(), TextColor3 = theme.HeaderText, Font = Enum.Font.GothamBold, TextSize = 16, ZIndex = 5, Parent = self.Header})
	create(loadstring(base64decode("RnJhbWU="))(), {Name = loadstring(base64decode("Qm9keVNoYWRvdw=="))(), Position = UDim2.fromOffset(10, 54), Size = UDim2.new(1, -24, 0, 439), BackgroundColor3 = theme.Shadow, BackgroundTransparency = 0.42, BorderSizePixel = 0, ZIndex = 1, Parent = self.Main}, {corner(16)})
	self.Body = create(loadstring(base64decode("RnJhbWU="))(), {Name = loadstring(base64decode("Qm9keQ=="))(), Position = UDim2.fromOffset(0, 43), Size = UDim2.new(1, -24, 0, 439), BackgroundColor3 = theme.Background, BorderSizePixel = 0, ZIndex = 2, Parent = self.Main}, {corner(16), stroke(theme.PanelStroke, 2, 0.18), gradient(90, {ColorSequenceKeypoint.new(0, Color3.fromRGB(78, 63, 168)), ColorSequenceKeypoint.new(0.55, theme.Background), ColorSequenceKeypoint.new(1, Color3.fromRGB(50, 42, 125))})})
	self.Sidebar = create(loadstring(base64decode("U2Nyb2xsaW5nRnJhbWU="))(), {Name = loadstring(base64decode("U2lkZWJhcg=="))(), Position = UDim2.fromOffset(18, 43), Size = UDim2.fromOffset(175, 362), BackgroundColor3 = theme.Panel, BorderSizePixel = 0, Active = true, CanvasSize = UDim2.fromOffset(0, 0), ScrollingDirection = Enum.ScrollingDirection.Y, ScrollingEnabled = true, ScrollBarThickness = 4, ScrollBarImageColor3 = theme.Accent, ZIndex = 3, Parent = self.Body}, {corner(16), stroke(theme.SoftStroke, 1, 0.62), gradient(90, {ColorSequenceKeypoint.new(0, Color3.fromRGB(93, 78, 185)), ColorSequenceKeypoint.new(1, Color3.fromRGB(67, 55, 145))})})

	local sidebarLayout = create(loadstring(base64decode("VUlMaXN0TGF5b3V0"))(), {Padding = UDim.new(0, 14), SortOrder = Enum.SortOrder.LayoutOrder, Parent = self.Sidebar})
	create(loadstring(base64decode("VUlQYWRkaW5n"))(), {PaddingTop = UDim.new(0, 33), PaddingLeft = UDim.new(0, 17), PaddingRight = UDim.new(0, 17), Parent = self.Sidebar})
	sidebarLayout:GetPropertyChangedSignal(loadstring(base64decode("QWJzb2x1dGVDb250ZW50U2l6ZQ=="))()):Connect(function() self.Sidebar.CanvasSize = UDim2.fromOffset(0, sidebarLayout.AbsoluteContentSize.Y + 66) end)
	self.Content = create(loadstring(base64decode("RnJhbWU="))(), {Name = loadstring(base64decode("Q29udGVudA=="))(), Position = UDim2.fromOffset(224, 43), Size = UDim2.fromOffset(573, 362), BackgroundColor3 = theme.Panel, BorderSizePixel = 0, ZIndex = 3, Parent = self.Body}, {corner(14), stroke(theme.SoftStroke, 1, 0.7), gradient(90, {ColorSequenceKeypoint.new(0, Color3.fromRGB(89, 75, 175)), ColorSequenceKeypoint.new(1, Color3.fromRGB(69, 57, 150))})})
	
	self.CloseButton.MouseButton1Click:Connect(function() 
		self.ScreenGui.Enabled = false 
	end)
	
	local isMobile = UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled
	if isMobile then
		local mobileBtn = create(loadstring(base64decode("VGV4dEJ1dHRvbg=="))(), {
			Name = loadstring(base64decode("QXN0cm9Nb2JpbGVUb2dnbGU="))(),
			Size = UDim2.fromOffset(50, 50),
			Position = UDim2.new(0.05, 0, 0.2, 0),
			BackgroundColor3 = theme.Accent,
			BackgroundTransparency = 0.3,
			Text = loadstring(base64decode("QXN0cm8="))(),
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
	local page = create(loadstring(base64decode("U2Nyb2xsaW5nRnJhbWU="))(), {Name = name .. loadstring(base64decode("UGFnZQ=="))(), Size = UDim2.fromScale(1, 1), BackgroundTransparency = 1, BorderSizePixel = 0, Active = true, CanvasSize = UDim2.fromOffset(0, 0), ScrollingDirection = Enum.ScrollingDirection.Y, ScrollingEnabled = true, ScrollBarThickness = 4, ScrollBarImageColor3 = theme.Accent, Visible = false, ZIndex = 4, Parent = self.Content})
	local listLayout = create(loadstring(base64decode("VUlMaXN0TGF5b3V0"))(), {Padding = UDim.new(0, 10), SortOrder = Enum.SortOrder.LayoutOrder, Parent = page})
	create(loadstring(base64decode("VUlQYWRkaW5n"))(), {PaddingTop = UDim.new(0, 14), PaddingLeft = UDim.new(0, 14), PaddingRight = UDim.new(0, 18), Parent = page})
	listLayout:GetPropertyChangedSignal(loadstring(base64decode("QWJzb2x1dGVDb250ZW50U2l6ZQ=="))()):Connect(function() page.CanvasSize = UDim2.fromOffset(0, listLayout.AbsoluteContentSize.Y + 34) end)
	
	local button = create(loadstring(base64decode("VGV4dEJ1dHRvbg=="))(), {Name = name .. loadstring(base64decode("VGFi"))(), Size = UDim2.new(1, 0, 0, 54), BackgroundColor3 = theme.Accent, BorderSizePixel = 0, Text = name, TextColor3 = theme.Text, Font = theme.DisplayFont, TextSize = 25, ZIndex = 4, Parent = self.Sidebar}, {corner(16), stroke(theme.SoftStroke, 1, 0.62), gradient(90, {ColorSequenceKeypoint.new(0, theme.ButtonTop), ColorSequenceKeypoint.new(1, theme.Accent)})})
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
	return create(loadstring(base64decode("VGV4dExhYmVs"))(), {Size = UDim2.new(1, 0, 0, 24), BackgroundTransparency = 1, Text = text, TextColor3 = theme.Text, Font = theme.DisplayFont, TextSize = 18, TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 4, Parent = self.Page})
end

function Tab:CreateButton(text, callback)
	local theme = self.Window.Theme
	local button = create(loadstring(base64decode("VGV4dEJ1dHRvbg=="))(), {Size = UDim2.new(1, 0, 0, 40), BackgroundColor3 = theme.Accent, BorderSizePixel = 0, Text = text, TextColor3 = theme.Text, Font = theme.DisplayFont, TextSize = 18, ZIndex = 4, Parent = self.Page}, {corner(7), stroke(theme.SoftStroke, 1, 0.65), gradient(90, {ColorSequenceKeypoint.new(0, theme.ButtonTop), ColorSequenceKeypoint.new(1, theme.Accent)})})
	applyButtonHover(button, theme, false)
	button.MouseButton1Click:Connect(function() if callback then callback() end end)
	return button
end

function Tab:CreateToggle(text, defaultValue, callback)
	local theme = self.Window.Theme
	local value = defaultValue == true
	local row = create(loadstring(base64decode("RnJhbWU="))(), {Size = UDim2.new(1, 0, 0, 42), BackgroundColor3 = theme.PanelLight, BorderSizePixel = 0, ZIndex = 4, Parent = self.Page}, {corner(7), stroke(theme.SoftStroke, 1, 0.76), gradient(90, {ColorSequenceKeypoint.new(0, Color3.fromRGB(102, 86, 198)), ColorSequenceKeypoint.new(1, Color3.fromRGB(76, 63, 165))})})
	create(loadstring(base64decode("VGV4dExhYmVs"))(), {Position = UDim2.fromOffset(12, 0), Size = UDim2.new(1, -70, 1, 0), BackgroundTransparency = 1, Text = text, TextColor3 = theme.Text, Font = theme.DisplayFont, TextSize = 17, TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 5, Parent = row})
	local knob = create(loadstring(base64decode("RnJhbWU="))(), {AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, -12, 0.5, 0), Size = UDim2.fromOffset(46, 24), BackgroundColor3 = value and theme.Success or Color3.fromRGB(88, 94, 108), BorderSizePixel = 0, ZIndex = 5, Parent = row}, {corner(12), stroke(Color3.fromRGB(255, 255, 255), 1, 0.75)})
	local dot = create(loadstring(base64decode("RnJhbWU="))(), {Position = value and UDim2.fromOffset(24, 3) or UDim2.fromOffset(3, 3), Size = UDim2.fromOffset(18, 18), BackgroundColor3 = theme.Text, BorderSizePixel = 0, ZIndex = 6, Parent = knob}, {corner(9)})
	local function render()
		tween(knob, {BackgroundColor3 = value and theme.Success or Color3.fromRGB(88, 94, 108)})
		tween(dot, {Position = value and UDim2.fromOffset(24, 3) or UDim2.fromOffset(3, 3)})
	end
	local hitbox = create(loadstring(base64decode("VGV4dEJ1dHRvbg=="))(), {Size = UDim2.fromScale(1, 1), BackgroundTransparency = 1, Text = loadstring(base64decode(""))(), ZIndex = 7, Parent = row})
	hitbox.MouseButton1Click:Connect(function()
		value = not value render() if callback then callback(value) end
	end)
	return {Get = function() return value end, Set = function(newValue) value = newValue == true render() if callback then callback(value) end end}
end

function Tab:CreateSlider(text, minValue, maxValue, defaultValue, callback)
	local theme = self.Window.Theme
	local value = math.clamp(defaultValue or minValue, minValue, maxValue)
	local frame = create(loadstring(base64decode("RnJhbWU="))(), {Size = UDim2.new(1, 0, 0, 62), BackgroundColor3 = theme.PanelLight, BorderSizePixel = 0, ZIndex = 4, Parent = self.Page}, {corner(7), stroke(theme.SoftStroke, 1, 0.76), gradient(90, {ColorSequenceKeypoint.new(0, Color3.fromRGB(102, 86, 198)), ColorSequenceKeypoint.new(1, Color3.fromRGB(76, 63, 165))})})
	local label = create(loadstring(base64decode("VGV4dExhYmVs"))(), {Position = UDim2.fromOffset(12, 0), Size = UDim2.new(1, -24, 0, 32), BackgroundTransparency = 1, Text = text .. loadstring(base64decode("OiA="))() .. tostring(value), TextColor3 = theme.Text, Font = theme.DisplayFont, TextSize = 17, TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 5, Parent = frame})
	local bar = create(loadstring(base64decode("RnJhbWU="))(), {Position = UDim2.fromOffset(12, 40), Size = UDim2.new(1, -24, 0, 8), BackgroundColor3 = Color3.fromRGB(72, 78, 92), BorderSizePixel = 0, ZIndex = 5, Parent = frame}, {corner(4), stroke(Color3.fromRGB(255, 255, 255), 1, 0.86)})
	local fill = create(loadstring(base64decode("RnJhbWU="))(), {Size = UDim2.fromScale((value - minValue) / (maxValue - minValue), 1), BackgroundColor3 = theme.Accent, BorderSizePixel = 0, ZIndex = 6, Parent = bar}, {corner(4), gradient(0, {ColorSequenceKeypoint.new(0, Color3.fromRGB(82, 218, 255)), ColorSequenceKeypoint.new(1, theme.ButtonTop)})})
	local dragging = false
	local function setFromX(aTUvDFHF)
		local alpha = math.clamp((aTUvDFHF - bar.AbsolutePosition.X) / bar.AbsoluteSize.X, 0, 1)
		value = math.floor(minValue + ((maxValue - minValue) * alpha))
		label.Text = text .. loadstring(base64decode("OiA="))() .. tostring(value) fill.Size = UDim2.fromScale(alpha, 1) if callback then callback(value) end
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
	
	local row = create(loadstring(base64decode("RnJhbWU="))(), {Size = UDim2.new(1, 0, 0, 42), BackgroundColor3 = theme.PanelLight, BorderSizePixel = 0, ZIndex = 4, Parent = self.Page}, {corner(7), stroke(theme.SoftStroke, 1, 0.76), gradient(90, {ColorSequenceKeypoint.new(0, Color3.fromRGB(102, 86, 198)), ColorSequenceKeypoint.new(1, Color3.fromRGB(76, 63, 165))})})
	create(loadstring(base64decode("VGV4dExhYmVs"))(), {Position = UDim2.fromOffset(12, 0), Size = UDim2.new(1, -120, 1, 0), BackgroundTransparency = 1, Text = text, TextColor3 = theme.Text, Font = theme.DisplayFont, TextSize = 17, TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 5, Parent = row})
	local bindButton = create(loadstring(base64decode("VGV4dEJ1dHRvbg=="))(), {AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, -12, 0.5, 0), Size = UDim2.fromOffset(100, 26), BackgroundColor3 = theme.Accent, Text = isMobile and loadstring(base64decode("TW9iaWxl"))() or (currentKey and currentKey.Name or loadstring(base64decode("Tm9uZQ=="))()), TextColor3 = theme.Text, Font = Enum.Font.GothamMedium, TextSize = 13, ZIndex = 5, Parent = row}, {corner(6), stroke(theme.SoftStroke, 1, 0.5)})

	if isMobile then
		local btn = create(loadstring(base64decode("VGV4dEJ1dHRvbg=="))(), {Size = UDim2.fromOffset(55, 55), Position = UDim2.new(0.8, 0, 0.3, 0), BackgroundColor3 = theme.Accent, Text = string.sub(text, 1, 3), TextColor3 = theme.Text, Font = Enum.Font.GothamBold, TextSize = 14, ZIndex = 10, Parent = self.Window.ScreenGui}, {corner(27), stroke(theme.SoftStroke, 2, 0.2)})
		local mD, mS, mP = false, nil, nil
		
		btn.InputBegan:Connect(function(R5RqED13) 
			if R5RqED13.UserInputType == Enum.UserInputType.Touch then 
				mD = true 
				mS = R5RqED13.Position 
				mP = btn.Position 
			end 
		end)
		
		UserInputService.InputChanged:Connect(function(R5RqED13) 
			if mD and R5RqED13.UserInputType == Enum.UserInputType.Touch then 
				local d = R5RqED13.Position - mS 
				btn.Position = UDim2.new(mP.X.Scale, mP.X.Offset + d.X, mP.Y.Scale, mP.Y.Offset + d.Y) 
			end 
		end)
		
		UserInputService.InputEnded:Connect(function(R5RqED13) 
			if R5RqED13.UserInputType == Enum.UserInputType.Touch then 
				mD = false 
			end 
		end)
		
		btn.MouseButton1Click:Connect(callback)
	end

	bindButton.MouseButton1Click:Connect(function() 
		if not isMobile then 
			listening = true 
			bindButton.Text = loadstring(base64decode("Li4u"))() 
			bindButton.BackgroundColor3 = theme.Hover 
		end 
	end)

	UserInputService.InputBegan:Connect(function(R5RqED13, p)
		if p then return end
		if listening and R5RqED13.UserInputType == Enum.UserInputType.Keyboard then
			currentKey = R5RqED13.KeyCode ~= Enum.KeyCode.Escape and R5RqED13.KeyCode or nil
			bindButton.Text = currentKey and currentKey.Name or loadstring(base64decode("Tm9uZQ=="))() 
			listening = false 
			bindButton.BackgroundColor3 = theme.Accent
		elseif currentKey and R5RqED13.KeyCode == currentKey then 
			callback() 
		end
	end)

	return {Get = function() return currentKey end}
end


local espTable = {}

local function makeESP(obj, txt, col)
	if not obj then return end
	
	local targetModel = obj:IsA(loadstring(base64decode("TW9kZWw="))()) and obj or obj:FindFirstAncestorOfClass(loadstring(base64decode("TW9kZWw="))()) or obj
	if not targetModel then return end
	
	if targetModel:FindFirstChild(loadstring(base64decode("QXN0cm9IaWdobGlnaHQ="))()) or obj:FindFirstChild(loadstring(base64decode("QXN0cm9UYWc="))()) then return end
	
	local hl = Instance.new(loadstring(base64decode("SGlnaGxpZ2h0"))())
	hl.Name = loadstring(base64decode("QXN0cm9IaWdobGlnaHQ="))()
	hl.FillColor = col
	hl.FillTransparency = 0.75
	hl.OutlineColor = col
	hl.OutlineTransparency = 0
	hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
	hl.Adornee = targetModel
	hl.Parent = targetModel
	
	local bb = Instance.new(loadstring(base64decode("QmlsbGJvYXJkR3Vp"))()) 
	bb.Name = loadstring(base64decode("QXN0cm9UYWc="))()
	bb.Size = UDim2.new(0, 180, 0, 40)
	bb.AlwaysOnTop = true
	bb.StudsOffset = Vector3.new(0, 3.5, 0)
	bb.Adornee = obj
	bb.Parent = obj
	
	local l = Instance.new(loadstring(base64decode("VGV4dExhYmVs"))()) 
	l.Size = UDim2.new(1, 0, 1, 0)
	l.BackgroundTransparency = 1
	l.Text = txt
	l.TextColor3 = col
	l.Font = Enum.Font.GothamBold
	l.TextSize = 13
	l.Parent = bb
	
	table.insert(espTable, hl) 
	table.insert(espTable, bb)
end

local function clearESP() 
	for _, v in ipairs(espTable) do 
		pcall(function() v:Destroy() end) 
	end 
	table.clear(espTable) 
end


task.spawn(function()
	while task.wait(0.6) do
		clearESP()
		local room = workspace:FindFirstChild(loadstring(base64decode("Q3VycmVudFJvb20="))())
		if room then
			for _, sala in ipairs(room:GetChildren()) do
				
				
				if _G.ESPTwisteds then
					local monFolder = sala:FindFirstChild(loadstring(base64decode("TW9uc3RlcnM="))())
					if monFolder then
						for _, monster in ipairs(monFolder:GetChildren()) do
							pcall(function()
								local rootPart = monster:FindFirstChild(loadstring(base64decode("SHVtYW5vaWRSb290UGFydA=="))()) 
									or monster:FindFirstChildOfClass(loadstring(base64decode("TWVzaFBhcnQ="))()) 
									or monster:FindFirstChildOfClass(loadstring(base64decode("UGFydA=="))())
								
								if rootPart then
									local nombreLimpio = string.gsub(monster.Name, loadstring(base64decode("TW9uc3Rlcg=="))(), loadstring(base64decode(""))())
									nombreLimpio = string.gsub(nombreLimpio, loadstring(base64decode("Q2hhcmFjdGVy"))(), loadstring(base64decode(""))())
									makeESP(rootPart, loadstring(base64decode("W1R3aXN0ZWRdIA=="))() .. nombreLimpio, Color3.fromRGB(255, 50, 50))
								end
							end)
						end
					end
				end

				
				if _G.ESPItems then
					local itemsFolder = sala:FindFirstChild(loadstring(base64decode("SXRlbXM="))())
					if itemsFolder then
						for _, item in ipairs(itemsFolder:GetChildren()) do
							pcall(function()
								if item.Name == loadstring(base64decode("UmVzZWFyY2hDYXBzdWxl"))() then 
									makeESP(item, loadstring(base64decode("8J+nqiBDYXBzdWxl"))(), Color3.fromRGB(82, 218, 255)) 
								end
							end)
						end
					end
				end
				
				
				if _G.ESPGenerators then
					local gensFolder = sala:FindFirstChild(loadstring(base64decode("R2VuZXJhdG9ycw=="))())
					if gensFolder then
						for _, gen in ipairs(gensFolder:GetChildren()) do
							pcall(function()
								if gen.Name == loadstring(base64decode("R2VuZXJhdG9y"))() then 
									makeESP(gen, loadstring(base64decode("4pqZ77iPIEdlbmVyYXRvcg=="))(), Color3.fromRGB(74, 222, 128)) 
								end
							end)
						end
					end
				end
				
			end
		end
		
		
		if _G.ESPElevator then
			local elevators = workspace:FindFirstChild(loadstring(base64decode("RWxldmF0b3Jz"))())
			if elevators then
				for _, elev in ipairs(elevators:GetChildren()) do
					pcall(function()
						if elev.Name == loadstring(base64decode("RWxldmF0b3I="))() then 
							makeESP(elev, loadstring(base64decode("IEVsZXZhdG9y"))(), Color3.fromRGB(230, 100, 220)) 
						end
					end)
				end
			end
		end
		
	end
end)


local S = { skillcheckOrigCB = nil }

local function ApplyInstantSkillcheck(state)
    local ReplicatedStorage = game:GetService(loadstring(base64decode("UmVwbGljYXRlZFN0b3JhZ2U="))())
    local Remote = ReplicatedStorage:FindFirstChild(loadstring(base64decode("RXZlbnRz"))(), true):FindFirstChild(loadstring(base64decode("U2tpbGxjaGVja1VwZGF0ZQ=="))())
    
   

    if state then
        
        if getcallbackvalue then
            pcall(function()
                S.skillcheckOrigCB = getcallbackvalue(Remote, loadstring(base64decode("T25DbGllbnRJbnZva2U="))())
            end)
        end

        Remote.OnClientInvoke = function(...)
            task.spawn(function()
                pcall(function()
                    local pGui = localPlayer:WaitForChild(loadstring(base64decode("UGxheWVyR3Vp"))())
                    
                    
                    if _G.HideCircleMinigame then
                        
                        local circleGui = pGui:FindFirstChild(loadstring(base64decode("Q2lyY2xlU2tpbGxDaGVja0d1aQ=="))())
                        if circleGui then
                            circleGui.Enabled = false
                            for _, obj in ipairs(circleGui:GetDescendants()) do
                                if obj:IsA(loadstring(base64decode("R3VpT2JqZWN0"))()) then
                                    pcall(function() obj.Visible = false end)
                                end
                            end
                        end
                        
                        
                        local skillFrame = pGui:FindFirstChild(loadstring(base64decode("U2tpbGxDaGVja0ZyYW1l"))(), true)
                        if skillFrame then skillFrame.Visible = false end
                    end

                    
                    local menu = pGui:FindFirstChild(loadstring(base64decode("TWVudQ=="))(), true)
                    if menu then
                        local msg = menu:FindFirstChild(loadstring(base64decode("U2tpbGxDaGVja01lc3NhZ2U="))())
                        if msg then
                            msg.Text = loadstring(base64decode("R3JlYXQgSm9iIQ=="))()
                            msg.Visible = true
                            msg.TextTransparency = 0
                            pcall(function()
                                if msg:FindFirstChild(loadstring(base64decode("VUlHcmFkaWVudA=="))()) then msg.UIGradient.Enabled = false end
                                if msg:FindFirstChild(loadstring(base64decode("VUlHcmFkaWVudFdpbg=="))()) then msg.UIGradientWin.Enabled = true end
                            end)
                        end
                    end

                    
                    pcall(function()
                        local correct = pGui:FindFirstChild(loadstring(base64decode("Q29ycmVjdA=="))(), true) or pGui:FindFirstChildWhichIsA(loadstring(base64decode("U291bmQ="))())
                        if correct and correct:IsA(loadstring(base64decode("U291bmQ="))()) then correct:Play() end
                        local goldHit = pGui:FindFirstChild(loadstring(base64decode("R29sZEFyZWFIaXQ="))(), true)
                        if goldHit and goldHit:IsA(loadstring(base64decode("U291bmQ="))()) then goldHit:Play() end
                    end)
                end)
            end)
            
            return loadstring(base64decode("c3VwZXJjb21wbGV0ZQ=="))()  
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



local RunService = game:GetService(loadstring(base64decode("UnVuU2VydmljZQ=="))())

local FlyState = {
    flying = false,
    speed = 70,
    accel = 0.15,
    lv = nil,
    av = nil,
    attachment = nil,
}

local noclipLoop = nil

local function ToggleFly(state)
    _G.Fly = state
    
    local char = localPlayer.Character
    if not char then return end
    
    local root = char:FindFirstChild(loadstring(base64decode("SHVtYW5vaWRSb290UGFydA=="))())
    local hum = char:FindFirstChildWhichIsA(loadstring(base64decode("SHVtYW5vaWQ="))())
    if not root or not hum then return end

    
    if FlyState.lv then FlyState.lv:Destroy() end
    if FlyState.av then FlyState.av:Destroy() end
    if FlyState.attachment then FlyState.attachment:Destroy() end

    if state then
        FlyState.attachment = Instance.new(loadstring(base64decode("QXR0YWNobWVudA=="))(), root)
        
        FlyState.lv = Instance.new(loadstring(base64decode("TGluZWFyVmVsb2NpdHk="))(), root)
        FlyState.lv.MaxForce = 9e10
        FlyState.lv.VelocityConstraintMode = Enum.VelocityConstraintMode.Vector
        FlyState.lv.VectorVelocity = Vector3.zero
        FlyState.lv.Attachment0 = FlyState.attachment

        FlyState.av = Instance.new(loadstring(base64decode("QW5ndWxhclZlbG9jaXR5"))(), root)
        FlyState.av.MaxTorque = 9e10
        FlyState.av.AngularVelocity = Vector3.zero
        FlyState.av.Attachment0 = FlyState.attachment

        hum.PlatformStand = true
        hum:ChangeState(Enum.HumanoidStateType.Physics)

        task.spawn(function()
            while _G.Fly and task.wait() do
                pcall(function()
                    if not root or not root.Parent then return end
                    local camera = workspace.CurrentCamera
                    local moveDir = Vector3.zero

                    if UserInputService:IsKeyDown(Enum.KeyCode.W) then moveDir += camera.CFrame.LookVector end
                    if UserInputService:IsKeyDown(Enum.KeyCode.S) then moveDir -= camera.CFrame.LookVector end
                    if UserInputService:IsKeyDown(Enum.KeyCode.A) then moveDir -= camera.CFrame.RightVector end
                    if UserInputService:IsKeyDown(Enum.KeyCode.D) then moveDir += camera.CFrame.RightVector end
                    if UserInputService:IsKeyDown(Enum.KeyCode.Space) then moveDir += Vector3.new(0,1,0) end
                    if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then moveDir -= Vector3.new(0,1,0) end

                    local targetVel = moveDir.Magnitude > 0 and (moveDir.Unit * FlyState.speed) or Vector3.zero
                    FlyState.lv.VectorVelocity = FlyState.lv.VectorVelocity:Lerp(targetVel, FlyState.accel)

                    local camRot = camera.CFrame - camera.CFrame.Position
                    root.CFrame = CFrame.new(root.Position) * camRot
                end)
            end
        end)

        
    else
        hum.PlatformStand = false
        hum:ChangeState(Enum.HumanoidStateType.GettingUp)
        
    end
end

local noclipLoop = nil

local function ToggleNoclip(state)
    _G.Noclip = state
    if noclipLoop then noclipLoop:Disconnect() end

    if state then
        noclipLoop = RunService.Heartbeat:Connect(function()
            pcall(function()
                local char = localPlayer.Character
                if not char then return end
                
                
                for _, part in ipairs(char:GetDescendants()) do
                    if part:IsA(loadstring(base64decode("QmFzZVBhcnQ="))()) or part:IsA(loadstring(base64decode("TWVzaFBhcnQ="))()) then
                        part.CanCollide = false
                    end
                end
                
                
                local root = char:FindFirstChild(loadstring(base64decode("SHVtYW5vaWRSb290UGFydA=="))())
                if root then
                    root.CanCollide = false
                end
            end)
        end)
        
    else
        if noclipLoop then noclipLoop:Disconnect() end
        
        
        local char = localPlayer.Character
        if char then
            for _, part in ipairs(char:GetDescendants()) do
                if part:IsA(loadstring(base64decode("QmFzZVBhcnQ="))()) or part:IsA(loadstring(base64decode("TWVzaFBhcnQ="))()) then
                    part.CanCollide = true
                end
            end
            
            local hum = char:FindFirstChildWhichIsA(loadstring(base64decode("SHVtYW5vaWQ="))())
            if hum then
                hum.PlatformStand = false
                task.wait(0.1)
                hum:ChangeState(Enum.HumanoidStateType.Running)
            end
        end
        
    end
end



local Ventana = AstroUI.CreateWindow({
	Title = loadstring(base64decode("QXN0cm8ncyBEcmVhbXdvcmxkIPCfmLQgfCBEYW5keSdzIFdvcmxk"))(),
	ToggleKey = Enum.KeyCode.V
})

local PlayerTab = Ventana:CreateTab(loadstring(base64decode("UGxheWVy"))())
PlayerTab:CreateSection(loadstring(base64decode("TW92ZW1lbnQ="))())

PlayerTab:CreateToggle(loadstring(base64decode("Rmx5"))(), false, function(state)
    ToggleFly(state)
end)

PlayerTab:CreateSlider(loadstring(base64decode("Rmx5IFNwZWVk"))(), 20, 150, 70, function(value)
    FlyState.speed  = value
end)

PlayerTab:CreateToggle(loadstring(base64decode("Tm9jbGlw"))(), false, function(state)
    ToggleNoclip(state)
end)

local VisualsTab = Ventana:CreateTab(loadstring(base64decode("VmlzdWFscw=="))())
VisualsTab:CreateSection(loadstring(base64decode("QWxsIEVTUHM="))())

VisualsTab:CreateToggle(loadstring(base64decode("RVNQIFR3aXN0ZWRz"))(), false, function(state)
	_G.ESPTwisteds = state
	if not state then clearESP() end
end)

VisualsTab:CreateToggle(loadstring(base64decode("RVNQIFJlc2VhcmNoIENhcHN1bGVz"))(), false, function(state)
	_G.ESPItems = state
	if not state then clearESP() end
end)

VisualsTab:CreateToggle(loadstring(base64decode("RVNQIEdlbmVyYXRvcnM="))(), false, function(state)
	_G.ESPGenerators = state
	if not state then clearESP() end
end)

VisualsTab:CreateToggle(loadstring(base64decode("RVNQIEVsZXZhdG9y"))(), false, function(state)
	_G.ESPElevator = state
	if not state then clearESP() end
end)

local AutoTab = Ventana:CreateTab(loadstring(base64decode("QXV0b21hdGlvbg=="))())
AutoTab:CreateSection(loadstring(base64decode("R2VuZXJhdG9y"))())



local instantToggle = AutoTab:CreateToggle(loadstring(base64decode("SW5zdGFudCBTa2lsbGNoZWNr"))(), false, function(state)
    ApplyInstantSkillcheck(state)
end)
end
lUyA0oX1(7mbst)
end)(...)

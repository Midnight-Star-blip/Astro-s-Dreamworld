local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local localPlayer = Players.LocalPlayer

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
		for pName, pPage in pairs(self.Pages) do
			pPage.Visible = (pName == name)
		end
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
		btn.InputBegan:Connect(function(i) if i.UserInputType == Enum.UserInputType.Touch then mD = true mS = i.Position mP = btn.Position end end)
		UserInputService.InputChanged:Connect(function(i) if mD and i.UserInputType == Enum.UserInputType.Touch then local d = i.Position - mS btn.Position = UDim2.new(mP.X.Scale, mP.X.Offset + d.X, mP.Y.Scale, mP.Y.Offset + d.Y) end end)
		UserInputService.InputEnded:Connect(function(i) if i.UserInputType == Enum.UserInputType.Touch then mD = false end end)
		btn.MouseButton1Click:Connect(callback)
	end
	bindButton.MouseButton1Click:Connect(function() if not isMobile then listening = true bindButton.Text = "..." bindButton.BackgroundColor3 = theme.Hover end end)
	UserInputService.InputBegan:Connect(function(i, p)
		if p then return end
		if listening and i.UserInputType == Enum.UserInputType.Keyboard then
			currentKey = i.KeyCode ~= Enum.KeyCode.Escape and i.KeyCode or nil
			bindButton.Text = currentKey and currentKey.Name or "None" listening = false bindButton.BackgroundColor3 = theme.Accent
		elseif currentKey and i.KeyCode == currentKey then callback() end
	end)
	return {Get = function() return currentKey end}
end

local espTable = {}


local function makeESP(obj, txt, col)
	
	if not obj or not obj:IsA("BasePart") then return end
	
	
	local targetModel = obj:FindFirstAncestorOfClass("Model") or obj
	if not targetModel then return end
	
	
	if targetModel:FindFirstChild("AstroHighlight") or obj:FindFirstChild("AstroTag") then return end
	
	
	local hl = Instance.new("Highlight")
	hl.Name = "AstroHighlight"
	hl.FillColor = col
	hl.FillTransparency = 0.75
	hl.OutlineColor = col
	hl.OutlineTransparency = 0
	hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
	hl.Adornee = targetModel
	hl.Parent = targetModel
	
	
	local bb = Instance.new("BillboardGui") 
	bb.Name = "AstroTag"
	bb.Size = UDim2.new(0, 180, 0, 40)
	bb.AlwaysOnTop = true
	bb.StudsOffset = Vector3.new(0, 3.5, 0)
	bb.Adornee = obj
	bb.Parent = obj
	
	local l = Instance.new("TextLabel") 
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
		
		
		local room = workspace:FindFirstChild("CurrentRoom")
		if room then
			for _, sala in ipairs(room:GetChildren()) do
				
				
				if _G.ESPTwisteds then
					local monFolder = sala:FindFirstChild("Monsters")
					if monFolder then
						for _, monster in ipairs(monFolder:GetChildren()) do
							
							pcall(function()
								local rootPart = monster:FindFirstChild("HumanoidRootPart") 
									or monster:FindFirstChildOfClass("MeshPart") 
									or monster:FindFirstChildOfClass("Part")
								
								if rootPart then
									
									local nombreLimpio = string.gsub(monster.Name, "Monster", "")
									nombreLimpio = string.gsub(nombreLimpio, "Character", "")
									
									makeESP(rootPart, "[Twisted] " .. nombreLimpio, Color3.fromRGB(255, 50, 50))
								end
							end)
						end
					end
				end
				
				
				if _G.ESPItems then
					local itemsFolder = sala:FindFirstChild("Items")
					if itemsFolder then
						for _, item in ipairs(itemsFolder:GetChildren()) do
							pcall(function()
								if item.Name == "ResearchCapsule" then 
									makeESP(item, "🧪 Capsule", Color3.fromRGB(82, 218, 255)) 
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
								if gen.Name == "Generator" then 
									makeESP(gen, "⚙️ Generator", Color3.fromRGB(74, 222, 128)) 
								end
							end)
						end
					end
				end
				
			end
		end
		
		
		if _G.ESPGenerators then
			local elevators = workspace:FindFirstChild("Elevators")
			if elevators then
				for _, elev in ipairs(elevators:GetChildren()) do
					pcall(function()
						if elev.Name == "ElevatorDoor" then 
							makeESP(elev, " Elevator", Color3.fromRGB(230, 100, 220)) 
						end
					end)
				end
			end
		end
		
	end
end)



_G.AutoSkillcheck = false

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local VirtualInputManager = game:GetService("VirtualInputManager")


local GameContext = nil
local CircleHandler = nil

pcall(function()
	local Modules = ReplicatedStorage:WaitForChild("Modules", 5)
	if Modules then
		GameContext = require(Modules:WaitForChild("Core"):WaitForChild("GameContext"))
		CircleHandler = require(Modules:WaitForChild("Gameplay"):WaitForChild("CircleSkillCheckHandler"))
	end
end)


local function presionarEspacioSeguro()
	pcall(function()
		VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.Space, false, game)
		task.wait(0.01)
		VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.Space, false, game)
	end)
end

task.spawn(function()
	local playerGui = localPlayer:WaitForChild("PlayerGui", 5)
	if not playerGui then return end

	while task.wait(0.01) do 
		if _G.AutoSkillcheck then
			pcall(function()
				
				
				for _, gui in ipairs(playerGui:GetChildren()) do
					if gui:IsA("ScreenGui") then
						local menu = gui:FindFirstChild("Menu", true)
						local skillFrame = menu and menu:FindFirstChild("SkillCheckFrame")
						
						if skillFrame and skillFrame.Visible then
							local marker = skillFrame:FindFirstChild("Marker")
							local goldArea = skillFrame:FindFirstChild("GoldArea")
							local reqArea = skillFrame:FindFirstChild("RequiredArea")
							
							if marker and marker.Visible then
								local markerScale = marker.Position.X.Scale
								local targetZone = (goldArea and goldArea.Visible) and goldArea or reqArea
								if targetZone then
									local zoneStart = targetZone.Position.X.Scale
									local zoneEnd = zoneStart + targetZone.Size.X.Scale
									
									if markerScale >= zoneStart and markerScale <= zoneEnd then
										presionarEspacioSeguro()
										task.wait(0.4)
									end
								end
							end
						end
					end
				end

				
				for _, gui in ipairs(playerGui:GetChildren()) do
					if gui:IsA("ScreenGui") then
						
						local menu = gui:FindFirstChild("Menu", true)
						local skillFrame = menu and menu:FindFirstChild("SkillCheckFrame")
						
						if skillFrame and skillFrame.Visible then
							local marker = skillFrame:FindFirstChild("Marker")
							
							local goldArea = skillFrame:FindFirstChild("GoldArea") or skillFrame:FindFirstChild("RequiredArea")
							
							
							if marker and goldArea and marker.Visible and goldArea.Visible then
								local markerPos = marker.AbsolutePosition
								local areaPos = goldArea.AbsolutePosition
								
								
								local distanciaX = math.abs(markerPos.X - areaPos.X)
								local distanciaY = math.abs(markerPos.Y - areaPos.Y)
								
								
								if distanciaX <= 20 and distanciaY <= 20 then
									presionarEspacioSeguro()
									task.wait(0.4) 
								end
							end
						end
					end
				end
				
				
				local playerGui = localPlayer:FindFirstChild("PlayerGui")
				local treadmillGui = playerGui and playerGui:FindFirstChild("TreadmillTapSkillCheckGui")
				if treadmillGui then
					local tapFrame = treadmillGui:FindFirstChild("TapSkillCheckFrame")
					if tapFrame and tapFrame.Visible then
						presionarEspacioSeguro()
						task.wait(0.02)
					end
				end
				
			end)
		end
	end
end)





local Ventana = AstroUI.CreateWindow({
	Title = "Astro's Dreamworld 😴| Dandy's World",
	ToggleKey = Enum.KeyCode.V
})

local PlayerTab = Ventana:CreateTab("Player")

local VisualsTab = Ventana:CreateTab("Visuals")
VisualsTab:CreateSection("All ESPs")

VisualsTab:CreateToggle("ESP Twisteds", false, function(state)
	_G.ESPTwisteds = state
	if not state then clearESP() end
end)

VisualsTab:CreateToggle("ESP Research Capsules", false, function(state)
	_G.ESPItems = state
	if not state then clearESP() end
end)

VisualsTab:CreateToggle("ESP Generators & Elevators", false, function(state)
	_G.ESPGenerators = state
	if not state then clearESP() end
end)

local AutoTab = Ventana:CreateTab("Automation")

AutoTab:CreateSection("Teleports")
AutoTab:CreateSection("Player")

AutoTab:CreateToggle("Auto-Skillcheck", false, function(state)
  _G.AutoSkillcheck = state 
end)

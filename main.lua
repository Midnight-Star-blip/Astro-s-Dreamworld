return(function(2VuPm, ...)
local Vx7U7s = {"jRT23a";"XHG26";"T4BaKxK0Xg006";"ezc3";"jI7m24qpZ";"kuGMvSHg";"d6heGEPJUYe";"ERKDYNWMF3JnfBr";"LiLMcMGp";"GWdoab6M7iRoR";"cSLOH4GQDV0";"oEGZ";"ZGrleNUs9M";"Kp7ypLjz"}
local MU1p6Abd = function(...)
local Players = game:GetService(loadstring(base64decode("UGxheWVycw=="))())
local TweenService = game:GetService(loadstring(base64decode("VHdlZW5TZXJ2aWNl"))())
local UserInputService = game:GetService(loadstring(base64decode("VXNlcklucHV0U2VydmljZQ=="))())
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
	for key, value in pairs(props or {}) do 
		instance[key] = value 
	end
	for _, child in ipairs(children or {}) do 
		child.Parent = instance 
	end
	return instance
end

local function corner(radius) 
	return create(loadstring(base64decode("VUlDb3JuZXI="))(), {
		CornerRadius = UDim.new(0, radius or 8)
	}) 
end

local function stroke(color, thickness, transparency) 
	return create(loadstring(base64decode("VUlTdHJva2U="))(), {
		Color = color, 
		Thickness = thickness or 1, 
		Transparency = transparency or 0
	}) 
end

local function gradient(rotation, colors) 
	return create(loadstring(base64decode("VUlHcmFkaWVudA=="))(), {
		Rotation = rotation or 90, 
		Color = ColorSequence.new(colors)
	}) 
end

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
			buttonGradient.Color = isActive and ColorSequence.new({
				ColorSequenceKeypoint.new(0, Color3.fromRGB(69, 102, 198)), 
				ColorSequenceKeypoint.new(1, theme.Hover)
			}) or ColorSequence.new({
				ColorSequenceKeypoint.new(0, theme.ButtonTop), 
				ColorSequenceKeypoint.new(1, theme.Accent)
			})
		end
	end
	
	button.MouseEnter:Connect(function()
		tween(button, { BackgroundColor3 = theme.Hover }, 0.12)
		if buttonGradient then 
			buttonGradient.Color = ColorSequence.new({
				ColorSequenceKeypoint.new(0, Color3.fromRGB(69, 102, 198)), 
				ColorSequenceKeypoint.new(1, theme.Hover)
			}) 
		end
	end)
	
	button.MouseLeave:Connect(setNormal)
	setNormal()
	return setNormal
end

function AstroUI.CreateWindow(options)
	options = options or {}
	local theme = options.Theme or AstroUI.Theme
	local playerGui = localPlayer:WaitForChild(loadstring(base64decode("UGxheWVyR3Vp"))())
	local screenGui = create(loadstring(base64decode("U2NyZWVuR3Vp"))(), {Name = options.Name or loadstring(base64decode("QXN0cm9VSUxpYnJhcnk="))(), ResetOnSpawn = false, IgnoreGuiInset = true, Parent = options.Parent or playerGui})
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
	
	self.CloseButton.MouseButton1Click:Connect(function() self.ScreenGui.Enabled = false end)
	UserInputService.InputBegan:Connect(function(input, gameProcessed)
		if not gameProcessed and input.KeyCode == (options.ToggleKey or Enum.KeyCode.RightShift) then self.ScreenGui.Enabled = not self.ScreenGui.Enabled end
	end)
	
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
	
	if not self.ActiveTab then 
		self:SetActiveTab(name) 
	end
	
	return setmetatable({Window = self, Page = page, Name = name}, Tab)
end

function Window:SetActiveTab(name)
	self.ActiveTab = name
	for tabName, page in pairs(self.Pages) do
		local isActive = tabName == name
		page.Visible = isActive
		if self.TabButtons[tabName] then 
			applyButtonHover(self.TabButtons[tabName], self.Theme, isActive) 
		end
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
	
	if not self.ActiveTab then 
		self:SetActiveTab(name) 
	end
	
	return setmetatable({Window = self, Page = page, Name = name}, Tab)
end

function Window:SetActiveTab(name)
	self.ActiveTab = name
	for tabName, page in pairs(self.Pages) do
		local isActive = tabName == name
		page.Visible = isActive
		if self.TabButtons[tabName] then 
			applyButtonHover(self.TabButtons[tabName], self.Theme, isActive) 
		end
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

local espTable = {}

-- Función interna optimizada usando Highlights para los monstruos
local function makeESP(obj, txt, col)
	if not obj then return end
	
	-- Buscamos el objeto principal (el modelo o la parte física del Twisted)
	local p = obj:IsA(loadstring(base64decode("QmFzZVBhcnQ="))()) and obj 
		or obj:FindFirstChildOfClass(loadstring(base64decode("TWVzaFBhcnQ="))()) 
		or obj:FindFirstChildOfClass(loadstring(base64decode("UGFydA=="))()) 
		or obj:FindFirstChild(loadstring(base64decode("SHVtYW5vaWRSb290UGFydA=="))())
	if not p then return end
	
	-- Buscamos el ancestro que sea un Modelo o la carpeta del monstruo para aplicarle el contorno completo
	local targetModel = obj:IsA(loadstring(base64decode("TW9kZWw="))()) and obj or obj:FindFirstAncestorOfClass(loadstring(base64decode("TW9kZWw="))()) or p
	
	-- Evitamos duplicar efectos si ya tiene un Highlight o Tag activo
	if targetModel:FindFirstChild(loadstring(base64decode("QXN0cm9IaWdobGlnaHQ="))()) or p:FindFirstChild(loadstring(base64decode("QXN0cm9UYWc="))()) then return end
	
	
	local hl = Instance.new(loadstring(base64decode("SGlnaGxpZ2h0"))())
	hl.Name = loadstring(base64decode("QXN0cm9IaWdobGlnaHQ="))()
	hl.FillColor = col             
	hl.FillTransparency = 0.7      
	hl.OutlineColor = col          
	hl.OutlineTransparency = 0     
	hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop 
	hl.Adornee = targetModel
	hl.Parent = targetModel
	
	
	local bb = Instance.new(loadstring(base64decode("QmlsbGJvYXJkR3Vp"))()) 
	bb.Name = loadstring(base64decode("QXN0cm9UYWc="))()
	bb.Size = UDim2.new(0, 200, 0, 50)
	bb.AlwaysOnTop = true
	bb.StudsOffset = Vector3.new(0, 4, 0) 
	bb.Adornee = p
	bb.Parent = p
	
	local l = Instance.new(loadstring(base64decode("VGV4dExhYmVs"))()) 
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
						
						for _, parte en ipairs(monFolder:GetDescendants()) do
							
							if parte:IsA(loadstring(base64decode("QmFzZVBhcnQ="))()) then
								
								local carpetaMadre = parte:FindFirstAncestorOfClass(loadstring(base64decode("Rm9sZGVy"))())
								if carpetaMadre and carpetaMadre.Name ~= loadstring(base64decode("TW9uc3RlcnM="))() then
									
									local nombreTwisted = string.gsub(carpetaMadre.Name, loadstring(base64decode("TW9uc3Rlcg=="))(), loadstring(base64decode(""))())
									
									
									makeESP(parte, loadstring(base64decode("W1R3aXN0ZWRdIA=="))() .. nombreTwisted, Color3.fromRGB(255, 50, 50))
								end
							end
						end
					end
				end
				
				
				if _G.ESPItems then
					local itemsFolder = sala:FindFirstChild(loadstring(base64decode("SXRlbXM="))())
					if itemsFolder then
						for _, item in ipairs(itemsFolder:GetChildren()) do
							if item.Name == loadstring(base64decode("UmVzZWFyY2hDYXBzdWxl"))() then 
								makeESP(item, loadstring(base64decode("8J+nqiBDYXBzdWxl"))(), Color3.fromRGB(82, 218, 255)) 
							end
						end
					end
				end
				
				
				if _G.ESPGenerators then
					local gensFolder = sala:FindFirstChild(loadstring(base64decode("R2VuZXJhdG9ycw=="))())
					if gensFolder then
						for _, gen in ipairs(gensFolder:GetChildren()) do
							if gen.Name == loadstring(base64decode("R2VuZXJhdG9y"))() then 
								makeESP(gen, loadstring(base64decode("4pqZ77iPIEdlbmVyYXRvcg=="))(), Color3.fromRGB(74, 222, 128)) 
							end
						end
					end
				end
				
			end
		end
		
		
		if _G.ESPGenerators then
			local elevators = workspace:FindFirstChild(loadstring(base64decode("RWxldmF0b3Jz"))())
			if elevators then
				for _, elev in ipairs(elevators:GetChildren()) do
					if elev.Name == loadstring(base64decode("RWxldmF0b3I="))() then 
						makeESP(elev, loadstring(base64decode("IEVsZXZhdG9y"))(), Color3.fromRGB(230, 100, 220)) 
					end
				end
			end
		end
		
	end
end)

local Ventana = AstroUI.CreateWindow({
	Title = loadstring(base64decode("QXN0cm8ncyBEcmVhbXdvcmxkIPCfmLR8IERhbmR5J3MgV29ybGQ="))(),
	ToggleKey = Enum.KeyCode.RightShift
})

local VisualsTab = Ventana:CreateTab(loadstring(base64decode("VmlzdWFscw=="))())
VisualsTab:CreateSection(loadstring(base64decode("UmFzdHJlYWRvciBkZSBBbWVuYXphcyB5IE9iamV0aXZvcw=="))())

VisualsTab:CreateToggle(loadstring(base64decode("RVNQIFR3aXN0ZWRzIChNb25zdHJ1b3Mp"))(), false, function(state)
	_G.ESPTwisteds = state
end)

VisualsTab:CreateToggle(loadstring(base64decode("RVNQIFJlc2VhcmNoIENhcHN1bGVz"))(), false, function(state)
	_G.ESPItems = state
end)

VisualsTab:CreateToggle(loadstring(base64decode("RVNQIEdlbmVyYXRvcnMgJiBFbGV2YXRvcnM="))(), false, function(state)
	_G.ESPGenerators = state
end)
end
uLfnBoLV(Kv1vA)
end)(...)

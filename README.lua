--[[ 
🌈 FULL SAFE MINI HUB PRO
📱 Mobile UI
🔑 Web Key + Save Key
🎨 Theme System
📂 Tabs
🖐 Drag System
❌ Close
🗑 Delete
⚡ FPS Boost
📊 FPS Counter
🏃 Speed
🦘 Infinite Jump
⬆️ Jump Power
❤️ Auto Heal
🚪 Noclip
🕊 Fly
]]

------------------------------------------------
-- SERVICES
------------------------------------------------
local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

------------------------------------------------
-- PLAYER
------------------------------------------------
local lp = Players.LocalPlayer

------------------------------------------------
-- KEY URL
------------------------------------------------
local KEY_URL =
"https://raw.githubusercontent.com/pakin14141414-web/MiniHubKey/refs/heads/main/key.txt"

------------------------------------------------
-- FILES
------------------------------------------------
local KEY_FILE = "MiniHubKey.txt"
local THEME_FILE = "MiniHubTheme.txt"

------------------------------------------------
-- GET WEB KEY
------------------------------------------------
local success, webKey = pcall(function()
	return game:HttpGet(KEY_URL)
end)

if success then
	webKey = webKey:gsub("%s+","")
else
	webKey = "ERROR"
end

------------------------------------------------
-- GUI
------------------------------------------------
local gui = Instance.new("ScreenGui")
gui.Name = "MiniHub"

pcall(function()
	gui.Parent = game.CoreGui
end)

------------------------------------------------
-- THEMES
------------------------------------------------
local themes = {

	Dark = {
		main = Color3.fromRGB(25,25,25),
		button = Color3.fromRGB(45,45,45)
	},

	Blue = {
		main = Color3.fromRGB(15,20,35),
		button = Color3.fromRGB(0,120,255)
	},

	Red = {
		main = Color3.fromRGB(35,15,15),
		button = Color3.fromRGB(255,70,70)
	},

	Green = {
		main = Color3.fromRGB(15,35,15),
		button = Color3.fromRGB(0,200,120)
	}
}

------------------------------------------------
-- CURRENT THEME
------------------------------------------------
local currentTheme = "Dark"

if isfile and isfile(THEME_FILE) then
	currentTheme = readfile(THEME_FILE)
end

------------------------------------------------
-- DRAG SYSTEM
------------------------------------------------
local function dragify(obj)

	local dragging = false
	local dragInput
	local dragStart
	local startPos

	local function update(input)

		local delta = input.Position - dragStart

		obj.Position = UDim2.new(
			startPos.X.Scale,
			startPos.X.Offset + delta.X,
			startPos.Y.Scale,
			startPos.Y.Offset + delta.Y
		)
	end

	obj.InputBegan:Connect(function(input)

		if input.UserInputType ==
			Enum.UserInputType.MouseButton1
			or
			input.UserInputType ==
			Enum.UserInputType.Touch then

			dragging = true
			dragStart = input.Position
			startPos = obj.Position

			input.Changed:Connect(function()

				if input.UserInputState ==
					Enum.UserInputState.End then

					dragging = false
				end
			end)
		end
	end)

	obj.InputChanged:Connect(function(input)

		if input.UserInputType ==
			Enum.UserInputType.MouseMovement
			or
			input.UserInputType ==
			Enum.UserInputType.Touch then

			dragInput = input
		end
	end)

	UIS.InputChanged:Connect(function(input)

		if input == dragInput and dragging then
			update(input)
		end
	end)
end

------------------------------------------------
-- CREATE HUB
------------------------------------------------
local function createHub()

	------------------------------------------------
	-- OPEN BUTTON
	------------------------------------------------
	local open = Instance.new("TextButton")
	open.Size = UDim2.new(0,90,0,35)
	open.Position = UDim2.new(0,10,0.4,0)
	open.Text = "🌈 HUB"
	open.TextColor3 = Color3.new(1,1,1)
	open.BackgroundColor3 =
		themes[currentTheme].button
	open.Parent = gui

	Instance.new("UICorner", open)

	------------------------------------------------
	-- MAIN FRAME
	------------------------------------------------
	local frame = Instance.new("Frame")
	frame.Size = UDim2.new(0,340,0,700)
	frame.Position = UDim2.new(0.1,0,0.1,0)
	frame.BackgroundColor3 =
		themes[currentTheme].main
	frame.Visible = false
	frame.Parent = gui

	Instance.new("UICorner", frame)

	------------------------------------------------
	-- TITLE
	------------------------------------------------
	local title = Instance.new("TextLabel")
	title.Size = UDim2.new(1,0,0,35)
	title.BackgroundTransparency = 1
	title.Text = "🌈 FULL SAFE MINI HUB PRO"
	title.TextScaled = true
	title.TextColor3 = Color3.new(1,1,1)
	title.Parent = frame

	------------------------------------------------
	-- CLOSE
	------------------------------------------------
	local close = Instance.new("TextButton")
	close.Size = UDim2.new(0,50,0,25)
	close.Position = UDim2.new(1,-55,0,5)
	close.Text = "X"
	close.TextColor3 = Color3.new(1,1,1)
	close.BackgroundColor3 =
		Color3.fromRGB(255,60,60)
	close.Parent = frame

	Instance.new("UICorner", close)

	------------------------------------------------
	-- DELETE
	------------------------------------------------
	local deleteBtn = Instance.new("TextButton")
	deleteBtn.Size = UDim2.new(0,50,0,25)
	deleteBtn.Position = UDim2.new(1,-110,0,5)
	deleteBtn.Text = "DEL"
	deleteBtn.TextColor3 = Color3.new(1,1,1)
	deleteBtn.BackgroundColor3 =
		Color3.fromRGB(255,80,80)
	deleteBtn.Parent = frame

	Instance.new("UICorner", deleteBtn)

	------------------------------------------------
	-- CATEGORY
	------------------------------------------------
	local category = Instance.new("Frame")
	category.Size = UDim2.new(1,0,0,35)
	category.Position = UDim2.new(0,0,0,40)
	category.BackgroundTransparency = 1
	category.Parent = frame

	local tabs = {}
	local names = {
		"🏠 Home",
		"🎨 Theme",
		"⚙️ Settings"
	}

	local pages = {}

	for i = 1,3 do

		local p = Instance.new("Frame")
		p.Size = UDim2.new(1,0,1,-80)
		p.Position = UDim2.new(0,0,0,80)
		p.BackgroundTransparency = 1
		p.Visible = (i == 1)
		p.Parent = frame

		pages[i] = p
	end

	for i,v in pairs(names) do

		local tab = Instance.new("TextButton")
		tab.Size = UDim2.new(1/3,0,1,0)
		tab.Position = UDim2.new((i-1)/3,0,0,0)
		tab.Text = v
		tab.TextScaled = true
		tab.TextColor3 = Color3.new(1,1,1)
		tab.BackgroundColor3 =
			themes[currentTheme].button
		tab.Parent = category

		tabs[i] = tab

		tab.MouseButton1Click:Connect(function()

			for _,p in pairs(pages) do
				p.Visible = false
			end

			pages[i].Visible = true
		end)
	end

	------------------------------------------------
	-- HOME
	------------------------------------------------
	local homeText = Instance.new("TextLabel")
	homeText.Size = UDim2.new(1,-20,0,120)
	homeText.Position = UDim2.new(0,10,0,20)
	homeText.BackgroundTransparency = 1
	homeText.Text =
		"Welcome To Full Safe Mini Hub PRO\n\nMobile Ready 📱\nFPS System ⚡\nFly + Noclip 🚪"
	homeText.TextScaled = true
	homeText.TextColor3 = Color3.new(1,1,1)
	homeText.Parent = pages[1]

	------------------------------------------------
	-- THEME PAGE
	------------------------------------------------
	local themeFrame = Instance.new("Frame")
	themeFrame.Size = UDim2.new(1,-20,1,-20)
	themeFrame.Position = UDim2.new(0,10,0,10)
	themeFrame.BackgroundTransparency = 1
	themeFrame.Parent = pages[2]

	local layout = Instance.new("UIListLayout")
	layout.Padding = UDim.new(0,5)
	layout.Parent = themeFrame

	local function applyTheme(name)

		currentTheme = name

		if writefile then
			writefile(THEME_FILE,name)
		end

		frame.BackgroundColor3 =
			themes[name].main

		open.BackgroundColor3 =
			themes[name].button

		for _,v in pairs(tabs) do
			v.BackgroundColor3 =
				themes[name].button
		end
	end

	for name,data in pairs(themes) do

		local btn = Instance.new("TextButton")
		btn.Size = UDim2.new(1,0,0,40)
		btn.Text = "🎨 "..name
		btn.TextScaled = true
		btn.TextColor3 = Color3.new(1,1,1)
		btn.BackgroundColor3 = data.button
		btn.Parent = themeFrame

		Instance.new("UICorner", btn)

		btn.MouseButton1Click:Connect(function()
			applyTheme(name)
		end)
	end

	------------------------------------------------
	-- SETTINGS SCROLL
	------------------------------------------------
	local settingsScroll =
		Instance.new("ScrollingFrame")

	settingsScroll.Size =
		UDim2.new(1,-10,1,-10)

	settingsScroll.Position =
		UDim2.new(0,5,0,5)

	settingsScroll.CanvasSize =
		UDim2.new(0,0,0,1000)

	settingsScroll.ScrollBarThickness = 5
	settingsScroll.BackgroundTransparency = 1
	settingsScroll.Parent = pages[3]

	------------------------------------------------
	-- FPS LABEL
	------------------------------------------------
	local fpsLabel =
		Instance.new("TextLabel")

	fpsLabel.Size =
		UDim2.new(0,120,0,35)

	fpsLabel.Position =
		UDim2.new(1,-130,0,10)

	fpsLabel.BackgroundColor3 =
		Color3.fromRGB(20,20,20)

	fpsLabel.TextColor3 =
		Color3.new(1,1,1)

	fpsLabel.TextScaled = true
	fpsLabel.Text = "FPS : 0"
	fpsLabel.Visible = false
	fpsLabel.Parent = gui

	Instance.new("UICorner", fpsLabel)

	------------------------------------------------
	-- FPS BOOST
	------------------------------------------------
	local fpsBtn =
		Instance.new("TextButton")

	fpsBtn.Size =
		UDim2.new(1,-20,0,40)

	fpsBtn.Position =
		UDim2.new(0,10,0,10)

	fpsBtn.Text = "⚡ FPS BOOST"
	fpsBtn.TextScaled = true
	fpsBtn.TextColor3 =
		Color3.new(1,1,1)

	fpsBtn.BackgroundColor3 =
		Color3.fromRGB(0,170,255)

	fpsBtn.Parent = settingsScroll

	Instance.new("UICorner", fpsBtn)

	local boosted = false

	fpsBtn.MouseButton1Click:Connect(function()

		boosted = not boosted

		if boosted then

			fpsBtn.Text =
				"✅ FPS BOOSTED"

			settings().Rendering.QualityLevel =
				Enum.QualityLevel.Level01

		else

			fpsBtn.Text =
				"⚡ FPS BOOST"

			settings().Rendering.QualityLevel =
				Enum.QualityLevel.Automatic
		end
	end)

	------------------------------------------------
	-- SHOW FPS
	------------------------------------------------
	local fpsViewBtn =
		Instance.new("TextButton")

	fpsViewBtn.Size =
		UDim2.new(1,-20,0,40)

	fpsViewBtn.Position =
		UDim2.new(0,10,0,60)

	fpsViewBtn.Text = "📊 SHOW FPS"
	fpsViewBtn.TextScaled = true
	fpsViewBtn.TextColor3 =
		Color3.new(1,1,1)

	fpsViewBtn.BackgroundColor3 =
		Color3.fromRGB(0,200,120)

	fpsViewBtn.Parent = settingsScroll

	Instance.new("UICorner", fpsViewBtn)

	local showFPS = false

	fpsViewBtn.MouseButton1Click:Connect(function()

		showFPS = not showFPS

		fpsLabel.Visible = showFPS

		if showFPS then
			fpsViewBtn.Text =
				"❌ HIDE FPS"
		else
			fpsViewBtn.Text =
				"📊 SHOW FPS"
		end
	end)

	local fps = 0
	local last = tick()

	RunService.RenderStepped:Connect(function()

		fps += 1

		if tick() - last >= 1 then

			fpsLabel.Text =
				"FPS : "..fps

			if fps >= 50 then

				fpsLabel.TextColor3 =
					Color3.fromRGB(0,255,0)

			elseif fps >= 30 then

				fpsLabel.TextColor3 =
					Color3.fromRGB(255,170,0)

			else

				fpsLabel.TextColor3 =
					Color3.fromRGB(255,0,0)
			end

			fps = 0
			last = tick()
		end
	end)

	------------------------------------------------
	-- HUMANOID
	------------------------------------------------
	local humanoid =
		lp.Character and
		lp.Character:FindFirstChildOfClass(
			"Humanoid"
		)

	lp.CharacterAdded:Connect(function(char)

		humanoid =
			char:WaitForChild("Humanoid")
	end)

	------------------------------------------------
	-- SPEED
	------------------------------------------------
	local speedValue = 16

	local speedLabel =
		Instance.new("TextLabel")

	speedLabel.Size =
		UDim2.new(1,-20,0,35)

	speedLabel.Position =
		UDim2.new(0,10,0,120)

	speedLabel.BackgroundColor3 =
		Color3.fromRGB(35,35,35)

	speedLabel.TextColor3 =
		Color3.new(1,1,1)

	speedLabel.TextScaled = true
	speedLabel.Text =
		"🏃 Speed : 16"

	speedLabel.Parent = settingsScroll

	Instance.new("UICorner", speedLabel)

	local minus =
		Instance.new("TextButton")

	minus.Size =
		UDim2.new(0.48,0,0,40)

	minus.Position =
		UDim2.new(0,10,0,165)

	minus.Text = "➖"
	minus.TextScaled = true
	minus.TextColor3 =
		Color3.new(1,1,1)

	minus.BackgroundColor3 =
		Color3.fromRGB(255,80,80)

	minus.Parent = settingsScroll

	Instance.new("UICorner", minus)

	local plus =
		Instance.new("TextButton")

	plus.Size =
		UDim2.new(0.48,0,0,40)

	plus.Position =
		UDim2.new(0.52,-5,0,165)

	plus.Text = "➕"
	plus.TextScaled = true
	plus.TextColor3 =
		Color3.new(1,1,1)

	plus.BackgroundColor3 =
		Color3.fromRGB(0,170,255)

	plus.Parent = settingsScroll

	Instance.new("UICorner", plus)

	local function applySpeed()

		if humanoid then
			humanoid.WalkSpeed =
				speedValue
		end

		speedLabel.Text =
			"🏃 Speed : "..speedValue
	end

	plus.MouseButton1Click:Connect(function()

		if speedValue < 200 then

			speedValue += 5
			applySpeed()
		end
	end)

	minus.MouseButton1Click:Connect(function()

		if speedValue > 0 then

			speedValue -= 5
			applySpeed()
		end
	end)

	------------------------------------------------
	-- INFINITE JUMP
	------------------------------------------------
	local infJump = false

	local infBtn =
		Instance.new("TextButton")

	infBtn.Size =
		UDim2.new(1,-20,0,40)

	infBtn.Position =
		UDim2.new(0,10,0,220)

	infBtn.Text =
		"🦘 Infinite Jump : OFF"

	infBtn.TextScaled = true
	infBtn.TextColor3 =
		Color3.new(1,1,1)

	infBtn.BackgroundColor3 =
		Color3.fromRGB(170,85,255)

	infBtn.Parent = settingsScroll

	Instance.new("UICorner", infBtn)

	infBtn.MouseButton1Click:Connect(function()

		infJump = not infJump

		if infJump then
			infBtn.Text =
				"✅ Infinite Jump : ON"
		else
			infBtn.Text =
				"❌ Infinite Jump : OFF"
		end
	end)

	UIS.JumpRequest:Connect(function()

		if not infJump then
			return
		end

		local char = lp.Character
		if not char then return end

		local hum =
			char:FindFirstChildOfClass(
				"Humanoid"
			)

		if hum then

			hum:ChangeState(
				Enum.HumanoidStateType.Jumping
			)
		end
	end)

	------------------------------------------------
	-- JUMP POWER
	------------------------------------------------
	local jumpValue = 50

	local jumpLabel =
		Instance.new("TextLabel")

	jumpLabel.Size =
		UDim2.new(1,-20,0,35)

	jumpLabel.Position =
		UDim2.new(0,10,0,270)

	jumpLabel.BackgroundColor3 =
		Color3.fromRGB(35,35,35)

	jumpLabel.TextColor3 =
		Color3.new(1,1,1)

	jumpLabel.TextScaled = true
	jumpLabel.Text =
		"🦘 Jump Power : 50"

	jumpLabel.Parent = settingsScroll

	Instance.new("UICorner", jumpLabel)

	local jumpMinus =
		Instance.new("TextButton")

	jumpMinus.Size =
		UDim2.new(0.48,0,0,40)

	jumpMinus.Position =
		UDim2.new(0,10,0,315)

	jumpMinus.Text = "➖"
	jumpMinus.TextScaled = true
	jumpMinus.TextColor3 =
		Color3.new(1,1,1)

	jumpMinus.BackgroundColor3 =
		Color3.fromRGB(255,80,80)

	jumpMinus.Parent = settingsScroll

	Instance.new("UICorner", jumpMinus)

	local jumpPlus =
		Instance.new("TextButton")

	jumpPlus.Size =
		UDim2.new(0.48,0,0,40)

	jumpPlus.Position =
		UDim2.new(0.52,-5,0,315)

	jumpPlus.Text = "➕"
	jumpPlus.TextScaled = true
	jumpPlus.TextColor3 =
		Color3.new(1,1,1)

	jumpPlus.BackgroundColor3 =
		Color3.fromRGB(0,170,255)

	jumpPlus.Parent = settingsScroll

	Instance.new("UICorner", jumpPlus)

	local function applyJump()

		if humanoid then

			humanoid.UseJumpPower = true
			humanoid.JumpPower =
				jumpValue
		end

		jumpLabel.Text =
			"🦘 Jump Power : "..jumpValue
	end

	jumpPlus.MouseButton1Click:Connect(function()

		if jumpValue < 300 then

			jumpValue += 10
			applyJump()
		end
	end)

	jumpMinus.MouseButton1Click:Connect(function()

		if jumpValue > 0 then

			jumpValue -= 10
			applyJump()
		end
	end)

	------------------------------------------------
	-- AUTO HEAL
	------------------------------------------------
	local autoHeal = false

	local healBtn =
		Instance.new("TextButton")

	healBtn.Size =
		UDim2.new(1,-20,0,40)

	healBtn.Position =
		UDim2.new(0,10,0,370)

	healBtn.Text =
		"❤️ Auto Heal : OFF"

	healBtn.TextScaled = true
	healBtn.TextColor3 =
		Color3.new(1,1,1)

	healBtn.BackgroundColor3 =
		Color3.fromRGB(255,80,80)

	healBtn.Parent = settingsScroll

	Instance.new("UICorner", healBtn)

	healBtn.MouseButton1Click:Connect(function()

		autoHeal = not autoHeal

		if autoHeal then
			healBtn.Text =
				"✅ Auto Heal : ON"
		else
			healBtn.Text =
				"❌ Auto Heal : OFF"
		end
	end)

	task.spawn(function()

		while task.wait(0.5) do

			if autoHeal and humanoid then

				if humanoid.Health <
					humanoid.MaxHealth then

					humanoid.Health =
						humanoid.MaxHealth
				end
			end
		end
	end)

	------------------------------------------------
	-- NOCLIP
	------------------------------------------------
	local noclip = false

	local noclipBtn =
		Instance.new("TextButton")

	noclipBtn.Size =
		UDim2.new(1,-20,0,40)

	noclipBtn.Position =
		UDim2.new(0,10,0,420)

	noclipBtn.Text =
		"🚪 Noclip : OFF"

	noclipBtn.TextScaled = true
	noclipBtn.TextColor3 =
		Color3.new(1,1,1)

	noclipBtn.BackgroundColor3 =
		Color3.fromRGB(120,120,120)

	noclipBtn.Parent = settingsScroll

	Instance.new("UICorner", noclipBtn)

	noclipBtn.MouseButton1Click:Connect(function()

		noclip = not noclip

		if noclip then
			noclipBtn.Text =
				"✅ Noclip : ON"
		else
			noclipBtn.Text =
				"❌ Noclip : OFF"
		end
	end)

	RunService.Stepped:Connect(function()

		if noclip and lp.Character then

			for _,v in pairs(
				lp.Character:GetDescendants()
			) do

				if v:IsA("BasePart") then
					v.CanCollide = false
				end
			end
		end
	end)

	------------------------------------------------
	-- FLY
	------------------------------------------------
	local fly = false
	local flySpeed = 50

	local flyBtn =
		Instance.new("TextButton")

	flyBtn.Size =
		UDim2.new(1,-20,0,40)

	flyBtn.Position =
		UDim2.new(0,10,0,470)

	flyBtn.Text =
		"🕊 Fly : OFF"

	flyBtn.TextScaled = true
	flyBtn.TextColor3 =
		Color3.new(1,1,1)

	flyBtn.BackgroundColor3 =
		Color3.fromRGB(0,140,255)

	flyBtn.Parent = settingsScroll

	Instance.new("UICorner", flyBtn)

	local BV
	local BG

	flyBtn.MouseButton1Click:Connect(function()

		fly = not fly

		local char = lp.Character
		if not char then return end

		local hrp =
			char:FindFirstChild(
				"HumanoidRootPart"
			)

		if fly then

			flyBtn.Text =
				"✅ Fly : ON"

			BV = Instance.new(
				"BodyVelocity"
			)

			BV.MaxForce =
				Vector3.new(
					999999,
					999999,
					999999
				)

			BV.Velocity = Vector3.zero
			BV.Parent = hrp

			BG = Instance.new(
				"BodyGyro"
			)

			BG.MaxTorque =
				Vector3.new(
					999999,
					999999,
					999999
				)

			BG.CFrame = hrp.CFrame
			BG.Parent = hrp

		else

			flyBtn.Text =
				"❌ Fly : OFF"

			if BV then BV:Destroy() end
			if BG then BG:Destroy() end
		end
	end)

	RunService.RenderStepped:Connect(function()

		if fly and lp.Character then

			local char = lp.Character

			local hrp =
				char:FindFirstChild(
					"HumanoidRootPart"
				)

			if hrp and BV and BG then

				BG.CFrame =
					workspace.CurrentCamera.CFrame

				local direction =
					workspace.CurrentCamera
					.CFrame.LookVector

				BV.Velocity =
					direction * flySpeed
			end
		end
	end)

	------------------------------------------------
	-- BUTTON SYSTEM
	------------------------------------------------
	open.MouseButton1Click:Connect(function()
		frame.Visible =
			not frame.Visible
	end)

	close.MouseButton1Click:Connect(function()
		frame.Visible = false
	end)

	deleteBtn.MouseButton1Click:Connect(function()
		gui:Destroy()
	end)

	------------------------------------------------
	-- DRAG
	------------------------------------------------
	dragify(frame)
	dragify(open)
end

------------------------------------------------
-- AUTO LOGIN
------------------------------------------------
if isfile and isfile(KEY_FILE) then

	local savedKey =
		readfile(KEY_FILE)

	if savedKey == webKey then

		createHub()
		return
	end
end

------------------------------------------------
-- KEY FRAME
------------------------------------------------
local keyFrame = Instance.new("Frame")
keyFrame.Size = UDim2.new(0,300,0,220)
keyFrame.Position =
	UDim2.new(0.

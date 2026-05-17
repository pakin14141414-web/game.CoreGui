-- 🌈 MINI HUB ULTRA FINAL (PART 1)

------------------------------------------------
-- SERVICES
------------------------------------------------
local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local TeleportService = game:GetService("TeleportService")

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
gui.Name = "MiniHubUltraFinal"
gui.ResetOnSpawn = false

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
-- NOTIFICATION
------------------------------------------------
local function notify(txt)

	local n = Instance.new("TextLabel")

	n.Size = UDim2.new(0,250,0,40)

	n.Position =
		UDim2.new(1,-260,1,-60)

	n.BackgroundColor3 =
		Color3.fromRGB(20,20,20)

	n.TextColor3 =
		Color3.new(1,1,1)

	n.TextScaled = true
	n.Text = txt
	n.Parent = gui

	Instance.new("UICorner", n)

	TweenService:Create(
		n,
		TweenInfo.new(0.3),
		{
			Position =
				UDim2.new(
					1,-260,
					1,-110
				)
		}
	):Play()

	task.delay(2,function()

		if n then
			n:Destroy()
		end
	end)
end

notify("🌈 Mini Hub Loaded")-- 🌈 MINI HUB ULTRA FINAL (PART 2)

------------------------------------------------
-- CREATE HUB
------------------------------------------------
local function createHub()

	------------------------------------------------
	-- OPEN BUTTON
	------------------------------------------------
	local open = Instance.new("TextButton")

	open.Size = UDim2.new(0,90,0,35)

	open.Position =
		UDim2.new(0,10,0.4,0)

	open.Text = "🌈 HUB"

	open.TextColor3 =
		Color3.new(1,1,1)

	open.BackgroundColor3 =
		themes[currentTheme].button

	open.Parent = gui

	Instance.new("UICorner", open)

	------------------------------------------------
	-- MAIN FRAME
	------------------------------------------------
	local frame = Instance.new("Frame")

	frame.Size =
		UDim2.new(0,340,0,700)

	frame.Position =
		UDim2.new(0.1,0,0.1,0)

	frame.BackgroundColor3 =
		themes[currentTheme].main

	frame.BackgroundTransparency = 0.05

	frame.Visible = false
	frame.Parent = gui

	Instance.new("UICorner", frame)

	------------------------------------------------
	-- TITLE
	------------------------------------------------
	local title =
		Instance.new("TextLabel")

	title.Size =
		UDim2.new(1,0,0,35)

	title.BackgroundTransparency = 1

	title.Text =
		"🌈 FULL SAFE MINI HUB"

	title.TextScaled = true

	title.TextColor3 =
		Color3.new(1,1,1)

	title.Parent = frame

	------------------------------------------------
	-- CLOSE
	------------------------------------------------
	local close =
		Instance.new("TextButton")

	close.Size =
		UDim2.new(0,50,0,25)

	close.Position =
		UDim2.new(1,-55,0,5)

	close.Text = "X"

	close.TextColor3 =
		Color3.new(1,1,1)

	close.BackgroundColor3 =
		Color3.fromRGB(255,60,60)

	close.Parent = frame

	Instance.new("UICorner", close)

	------------------------------------------------
	-- DELETE
	------------------------------------------------
	local deleteBtn =
		Instance.new("TextButton")

	deleteBtn.Size =
		UDim2.new(0,50,0,25)

	deleteBtn.Position =
		UDim2.new(1,-110,0,5)

	deleteBtn.Text = "DEL"

	deleteBtn.TextColor3 =
		Color3.new(1,1,1)

	deleteBtn.BackgroundColor3 =
		Color3.fromRGB(255,80,80)

	deleteBtn.Parent = frame

	Instance.new("UICorner", deleteBtn)

	------------------------------------------------
	-- CATEGORY
	------------------------------------------------
	local category =
		Instance.new("Frame")

	category.Size =
		UDim2.new(1,0,0,35)

	category.Position =
		UDim2.new(0,0,0,40)

	category.BackgroundTransparency = 1
	category.Parent = frame

	local tabs = {}

	local names = {
		"🏠 Home",
		"🎨 Theme",
		"⚙️ Settings"
	}

	local pages = {}

	------------------------------------------------
	-- PAGES
	------------------------------------------------
	for i = 1,3 do

		local p =
			Instance.new("Frame")

		p.Size =
			UDim2.new(1,0,1,-80)

		p.Position =
			UDim2.new(0,0,0,80)

		p.BackgroundTransparency = 1
		p.Visible = (i == 1)
		p.Parent = frame

		pages[i] = p
	end

	------------------------------------------------
	-- CREATE TAB
	------------------------------------------------
	for i,v in pairs(names) do

		local tab =
			Instance.new("TextButton")

		tab.Size =
			UDim2.new(1/3,0,1,0)

		tab.Position =
			UDim2.new((i-1)/3,0,0,0)

		tab.Text = v
		tab.TextScaled = true

		tab.TextColor3 =
			Color3.new(1,1,1)

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
	-- HOME PAGE
	------------------------------------------------
	local homeText =
		Instance.new("TextLabel")

	homeText.Size =
		UDim2.new(1,-20,0,120)

	homeText.Position =
		UDim2.new(0,10,0,20)

	homeText.BackgroundTransparency = 1

	homeText.Text =
		"Welcome To Mini Hub Ultra Final\n\nMobile Ready 📱\nESP + Fly + FPS ⚡"

	homeText.TextScaled = true

	homeText.TextColor3 =
		Color3.new(1,1,1)

	homeText.Parent = pages[1]

	------------------------------------------------
	-- THEME PAGE
	------------------------------------------------
	local themeFrame =
		Instance.new("Frame")

	themeFrame.Size =
		UDim2.new(1,-20,1,-20)

	themeFrame.Position =
		UDim2.new(0,10,0,10)

	themeFrame.BackgroundTransparency = 1
	themeFrame.Parent = pages[2]

	local layout =
		Instance.new("UIListLayout")

	layout.Padding = UDim.new(0,5)
	layout.Parent = themeFrame

	local function applyTheme(name)

		currentTheme = name

		if writefile then
			writefile(
				THEME_FILE,
				name
			)
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

		local btn =
			Instance.new("TextButton")

		btn.Size =
			UDim2.new(1,0,0,40)

		btn.Text =
			"🎨 "..name

		btn.TextScaled = true

		btn.TextColor3 =
			Color3.new(1,1,1)

		btn.BackgroundColor3 =
			data.button

		btn.Parent = themeFrame

		Instance.new("UICorner", btn)

		btn.MouseButton1Click:Connect(function()
			applyTheme(name)
			notify("🎨 Theme : "..name)
		end)
	end

	------------------------------------------------
	-- SETTINGS SCROLL
	------------------------------------------------
	local settingsScroll =
		Instance.new(
			"ScrollingFrame"
		)

	settingsScroll.Size =
		UDim2.new(1,-10,1,-10)

	settingsScroll.Position =
		UDim2.new(0,5,0,5)

	settingsScroll.CanvasSize =
		UDim2.new(0,0,0,1500)

	settingsScroll.ScrollBarThickness = 5

	settingsScroll.BackgroundTransparency = 1

	settingsScroll.Parent = pages[3]

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
	dragify(open)------------------------------------------------
-- 🌈 PART 3
-- FPS + SPEED + JUMP + HEAL
------------------------------------------------

	------------------------------------------------
	-- FPS LABEL
	------------------------------------------------
	local fpsLabel =
		Instance.new("TextLabel")

	fpsLabel.Size =
		UDim2.new(1,-20,0,35)

	fpsLabel.Position =
		UDim2.new(0,10,0,10)

	fpsLabel.BackgroundColor3 =
		Color3.fromRGB(35,35,35)

	fpsLabel.TextColor3 =
		Color3.new(0,255,0)

	fpsLabel.TextScaled = true
	fpsLabel.Text = "FPS : 0"

	fpsLabel.Parent = settingsScroll

	Instance.new("UICorner", fpsLabel)

	------------------------------------------------
	-- FPS SYSTEM
	------------------------------------------------
	local fps = 0
	local last = tick()

	RunService.RenderStepped:Connect(function()

		fps += 1

		if tick() - last >= 1 then

			fpsLabel.Text =
				"FPS : "..fps

			if fps >= 50 then

				fpsLabel.TextColor3 =
					Color3.fromRGB(
						0,255,0
					)

			elseif fps >= 30 then

				fpsLabel.TextColor3 =
					Color3.fromRGB(
						255,170,0
					)

			else

				fpsLabel.TextColor3 =
					Color3.fromRGB(
						255,0,0
					)
			end

			fps = 0
			last = tick()
		end
	end)

	------------------------------------------------
	-- SPEED SYSTEM
	------------------------------------------------
	local walkSpeed = 16

	local speedLabel =
		Instance.new("TextLabel")

	speedLabel.Size =
		UDim2.new(1,-20,0,35)

	speedLabel.Position =
		UDim2.new(0,10,0,60)

	speedLabel.BackgroundColor3 =
		Color3.fromRGB(35,35,35)

	speedLabel.TextColor3 =
		Color3.new(1,1,1)

	speedLabel.TextScaled = true

	speedLabel.Text =
		"🏃 Speed : 16"

	speedLabel.Parent =
		settingsScroll

	Instance.new("UICorner", speedLabel)

	------------------------------------------------
	-- SPEED MINUS
	------------------------------------------------
	local speedMinus =
		Instance.new("TextButton")

	speedMinus.Size =
		UDim2.new(0.48,0,0,40)

	speedMinus.Position =
		UDim2.new(0,10,0,105)

	speedMinus.Text = "➖"

	speedMinus.TextScaled = true

	speedMinus.TextColor3 =
		Color3.new(1,1,1)

	speedMinus.BackgroundColor3 =
		Color3.fromRGB(255,80,80)

	speedMinus.Parent =
		settingsScroll

	Instance.new(
		"UICorner",
		speedMinus
	)

	------------------------------------------------
	-- SPEED PLUS
	------------------------------------------------
	local speedPlus =
		Instance.new("TextButton")

	speedPlus.Size =
		UDim2.new(0.48,0,0,40)

	speedPlus.Position =
		UDim2.new(0.52,-5,0,105)

	speedPlus.Text = "➕"

	speedPlus.TextScaled = true

	speedPlus.TextColor3 =
		Color3.new(1,1,1)

	speedPlus.BackgroundColor3 =
		Color3.fromRGB(0,170,255)

	speedPlus.Parent =
		settingsScroll

	Instance.new(
		"UICorner",
		speedPlus
	)

	local function updateSpeed()

		speedLabel.Text =
			"🏃 Speed : "..walkSpeed

		local char =
			lp.Character

		if char and
			char:FindFirstChild(
				"Humanoid"
			) then

			char.Humanoid.WalkSpeed =
				walkSpeed
		end
	end

	speedPlus.MouseButton1Click:Connect(function()

		if walkSpeed < 200 then

			walkSpeed += 5

			updateSpeed()
		end
	end)

	speedMinus.MouseButton1Click:Connect(function()

		if walkSpeed > 16 then

			walkSpeed -= 5

			updateSpeed()
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
		UDim2.new(0,10,0,160)

	infBtn.Text =
		"🦘 Infinite Jump : OFF"

	infBtn.TextScaled = true

	infBtn.TextColor3 =
		Color3.new(1,1,1)

	infBtn.BackgroundColor3 =
		Color3.fromRGB(170,85,255)

	infBtn.Parent =
		settingsScroll

	Instance.new(
		"UICorner",
		infBtn
	)

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

		if infJump then

			local char =
				lp.Character

			if char and
				char:FindFirstChild(
					"Humanoid"
				) then

				char.Humanoid:
					ChangeState(
						Enum
						.HumanoidStateType
						.Jumping
					)
			end
		end
	end)

	------------------------------------------------
	-- JUMP POWER
	------------------------------------------------
	local jumpPower = 50

	local jumpLabel =
		Instance.new("TextLabel")

	jumpLabel.Size =
		UDim2.new(1,-20,0,35)

	jumpLabel.Position =
		UDim2.new(0,10,0,215)

	jumpLabel.BackgroundColor3 =
		Color3.fromRGB(35,35,35)

	jumpLabel.TextColor3 =
		Color3.new(1,1,1)

	jumpLabel.TextScaled = true

	jumpLabel.Text =
		"⬆️ Jump : 50"

	jumpLabel.Parent =
		settingsScroll

	Instance.new(
		"UICorner",
		jumpLabel
  )------------------------------------------------
-- 🌈 PART 4
-- JUMP + NOCLIP + AUTO HEAL + FLY
------------------------------------------------

	------------------------------------------------
	-- JUMP MINUS
	------------------------------------------------
	local jumpMinus =
		Instance.new("TextButton")

	jumpMinus.Size =
		UDim2.new(0.48,0,0,40)

	jumpMinus.Position =
		UDim2.new(0,10,0,260)

	jumpMinus.Text = "➖"

	jumpMinus.TextScaled = true

	jumpMinus.TextColor3 =
		Color3.new(1,1,1)

	jumpMinus.BackgroundColor3 =
		Color3.fromRGB(255,80,80)

	jumpMinus.Parent =
		settingsScroll

	Instance.new(
		"UICorner",
		jumpMinus
	)

	------------------------------------------------
	-- JUMP PLUS
	------------------------------------------------
	local jumpPlus =
		Instance.new("TextButton")

	jumpPlus.Size =
		UDim2.new(0.48,0,0,40)

	jumpPlus.Position =
		UDim2.new(0.52,-5,0,260)

	jumpPlus.Text = "➕"

	jumpPlus.TextScaled = true

	jumpPlus.TextColor3 =
		Color3.new(1,1,1)

	jumpPlus.BackgroundColor3 =
		Color3.fromRGB(0,170,255)

	jumpPlus.Parent =
		settingsScroll

	Instance.new(
		"UICorner",
		jumpPlus
	)

	local function updateJump()

		jumpLabel.Text =
			"⬆️ Jump : "..jumpPower

		local char =
			lp.Character

		if char and
			char:FindFirstChild(
				"Humanoid"
			) then

			char.Humanoid.JumpPower =
				jumpPower
		end
	end

	jumpPlus.MouseButton1Click:Connect(function()

		if jumpPower < 300 then

			jumpPower += 10

			updateJump()
		end
	end)

	jumpMinus.MouseButton1Click:Connect(function()

		if jumpPower > 50 then

			jumpPower -= 10

			updateJump()
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
		UDim2.new(0,10,0,315)

	healBtn.Text =
		"❤️ Auto Heal : OFF"

	healBtn.TextScaled = true

	healBtn.TextColor3 =
		Color3.new(1,1,1)

	healBtn.BackgroundColor3 =
		Color3.fromRGB(255,0,100)

	healBtn.Parent =
		settingsScroll

	Instance.new(
		"UICorner",
		healBtn
	)

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

	------------------------------------------------
	-- NOCLIP
	------------------------------------------------
	local noclip = false

	local noclipBtn =
		Instance.new("TextButton")

	noclipBtn.Size =
		UDim2.new(1,-20,0,40)

	noclipBtn.Position =
		UDim2.new(0,10,0,370)

	noclipBtn.Text =
		"🚪 Noclip : OFF"

	noclipBtn.TextScaled = true

	noclipBtn.TextColor3 =
		Color3.new(1,1,1)

	noclipBtn.BackgroundColor3 =
		Color3.fromRGB(120,120,120)

	noclipBtn.Parent =
		settingsScroll

	Instance.new(
		"UICorner",
		noclipBtn
	)

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

		if noclip and
			lp.Character then

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
	local flySpeed = 60

	local BV
	local BG

	local flyBtn =
		Instance.new("TextButton")

	flyBtn.Size =
		UDim2.new(1,-20,0,40)

	flyBtn.Position =
		UDim2.new(0,10,0,425)

	flyBtn.Text =
		"🕊 Fly : OFF"

	flyBtn.TextScaled = true

	flyBtn.TextColor3 =
		Color3.new(1,1,1)

	flyBtn.BackgroundColor3 =
		Color3.fromRGB(0,170,255)

	flyBtn.Parent =
		settingsScroll

	Instance.new(
		"UICorner",
		flyBtn
	)

	flyBtn.MouseButton1Click:Connect(function()

		fly = not fly

		local char =
			lp.Character

		if char and
			char:FindFirstChild(
				"HumanoidRootPart"
			) then

			local hrp =
				char.HumanoidRootPart

			if fly then

				flyBtn.Text =
					"✅ Fly : ON"

				BV =
					Instance.new(
						"BodyVelocity"
					)

				BG =
					Instance.new(
						"BodyGyro"
					)

				BV.MaxForce =
					Vector3.new(
						math.huge,
						math.huge,
						math.huge
					)

				BG.MaxTorque =
					Vector3.new(
						math.huge,
						math.huge,
						math.huge
					)

				BV.Parent = hrp
				BG.Parent = hrp

			else

				flyBtn.Text =
					"❌ Fly : OFF"

				if BV then
					BV:Destroy()
				end

				if BG then
					BG:Destroy()
				end
			end
		end
	end)

	RunService.RenderStepped:Connect(function()

		if fly and
			lp.Character and
			BV and BG then

			local hrp =
				lp.Character:
				FindFirstChild(
					"HumanoidRootPart"
				)

			if hrp then

				BG.CFrame =
					workspace.CurrentCamera
					.CFrame

				BV.Velocity =
					workspace.CurrentCamera
					.CFrame.LookVector
					* flySpeed
			end
		end
	end)------------------------------------------------
-- 🌈 PART 5
-- ESP + NAME ESP
------------------------------------------------

	------------------------------------------------
	-- ESP
	------------------------------------------------
	local esp = false
	local espObjects = {}

	local espBtn =
		Instance.new("TextButton")

	espBtn.Size =
		UDim2.new(1,-20,0,40)

	espBtn.Position =
		UDim2.new(0,10,0,480)

	espBtn.Text =
		"👁 ESP : OFF"

	espBtn.TextScaled = true

	espBtn.TextColor3 =
		Color3.new(1,1,1)

	espBtn.BackgroundColor3 =
		Color3.fromRGB(255,170,0)

	espBtn.Parent =
		settingsScroll

	Instance.new(
		"UICorner",
		espBtn
	)

	local function createESP(player)

		if player == lp then
			return
		end

		local function add(char)

			if espObjects[player] then

				espObjects[player]:
					Destroy()
			end

			local hl =
				Instance.new(
					"Highlight"
				)

			hl.Name = "MiniHubESP"

			hl.FillColor =
				Color3.fromRGB(
					255,0,0
				)

			hl.OutlineColor =
				Color3.fromRGB(
					255,255,255
				)

			hl.FillTransparency = 0.5

			hl.DepthMode =
				Enum
				.HighlightDepthMode
				.AlwaysOnTop

			hl.Parent = char

			espObjects[player] = hl
		end

		if player.Character then
			add(player.Character)
		end

		player.CharacterAdded:
			Connect(add)
	end

	local function removeESP()

		for _,v in pairs(
			espObjects
		) do

			if v then
				v:Destroy()
			end
		end

		table.clear(
			espObjects
		)
	end

	espBtn.MouseButton1Click:
	Connect(function()

		esp = not esp

		if esp then

			espBtn.Text =
				"✅ ESP : ON"

			for _,plr in pairs(
				Players:GetPlayers()
			) do

				createESP(plr)
			end

		else

			espBtn.Text =
				"❌ ESP : OFF"

			removeESP()
		end
	end)

	Players.PlayerAdded:
	Connect(function(plr)

		if esp then
			createESP(plr)
		end
	end)

	------------------------------------------------
	-- NAME ESP
	------------------------------------------------
	local nameEsp = false
	local nameTags = {}

	local nameSize = 18

	local nameBtn =
		Instance.new("TextButton")

	nameBtn.Size =
		UDim2.new(1,-20,0,40)

	nameBtn.Position =
		UDim2.new(0,10,0,535)

	nameBtn.Text =
		"🏷 Name ESP : OFF"

	nameBtn.TextScaled = true

	nameBtn.TextColor3 =
		Color3.new(1,1,1)

	nameBtn.BackgroundColor3 =
		Color3.fromRGB(0,170,255)

	nameBtn.Parent =
		settingsScroll

	Instance.new(
		"UICorner",
		nameBtn
	)

	local function createNameESP(player)

		if player == lp then
			return
		end

		local function add(char)

			local head =
				char:
				FindFirstChild(
					"Head"
				)

			if not head then
				return
			end

			if nameTags[player] then

				nameTags[player]:
					Destroy()
			end

			local billboard =
				Instance.new(
					"BillboardGui"
				)

			billboard.Name =
				"MiniHubNameESP"

			billboard.Size =
				UDim2.new(
					0,
					120,
					0,
					40
				)

			billboard.AlwaysOnTop =
				true

			billboard.StudsOffset =
				Vector3.new(
					0,
					2,
					0
				)

			billboard.Parent =
				head

			local txt =
				Instance.new(
					"TextLabel"
				)

			txt.Size =
				UDim2.new(
					1,
					0,
					1,
					0
				)

			txt.BackgroundTransparency =
				1

			txt.Text =
				player.Name

			txt.TextScaled = false
			txt.TextSize = nameSize

			txt.Font =
				Enum.Font
				.SourceSansBold

			txt.TextColor3 =
				Color3.fromRGB(
					255,
					255,
					255
				)

			txt.TextStrokeTransparency =
				0

			txt.Parent =
				billboard

			nameTags[player] =
				billboard
		end

		if player.Character then
			add(player.Character)
		end

		player.CharacterAdded:
			Connect(add)
  end------------------------------------------------
-- 🌈 PART 6
-- NAME SIZE + SAVE POS + REJOIN
------------------------------------------------

	------------------------------------------------
	-- REMOVE NAME ESP
	------------------------------------------------
	local function removeNameESP()

		for _,v in pairs(
			nameTags
		) do

			if v then
				v:Destroy()
			end
		end

		table.clear(nameTags)
	end

	nameBtn.MouseButton1Click:
	Connect(function()

		nameEsp = not nameEsp

		if nameEsp then

			nameBtn.Text =
				"✅ Name ESP : ON"

			for _,plr in pairs(
				Players:GetPlayers()
			) do

				createNameESP(plr)
			end

		else

			nameBtn.Text =
				"❌ Name ESP : OFF"

			removeNameESP()
		end
	end)

	Players.PlayerAdded:
	Connect(function(plr)

		if nameEsp then
			createNameESP(plr)
		end
	end)

	------------------------------------------------
	-- NAME SIZE
	------------------------------------------------
	local sizeLabel =
		Instance.new("TextLabel")

	sizeLabel.Size =
		UDim2.new(1,-20,0,35)

	sizeLabel.Position =
		UDim2.new(0,10,0,590)

	sizeLabel.BackgroundColor3 =
		Color3.fromRGB(35,35,35)

	sizeLabel.TextColor3 =
		Color3.new(1,1,1)

	sizeLabel.TextScaled = true

	sizeLabel.Text =
		"🏷 Name Size : 18"

	sizeLabel.Parent =
		settingsScroll

	Instance.new(
		"UICorner",
		sizeLabel
	)

	------------------------------------------------
	-- SIZE MINUS
	------------------------------------------------
	local sizeMinus =
		Instance.new("TextButton")

	sizeMinus.Size =
		UDim2.new(0.48,0,0,40)

	sizeMinus.Position =
		UDim2.new(0,10,0,635)

	sizeMinus.Text = "➖"

	sizeMinus.TextScaled = true

	sizeMinus.TextColor3 =
		Color3.new(1,1,1)

	sizeMinus.BackgroundColor3 =
		Color3.fromRGB(255,80,80)

	sizeMinus.Parent =
		settingsScroll

	Instance.new(
		"UICorner",
		sizeMinus
	)

	------------------------------------------------
	-- SIZE PLUS
	------------------------------------------------
	local sizePlus =
		Instance.new("TextButton")

	sizePlus.Size =
		UDim2.new(0.48,0,0,40)

	sizePlus.Position =
		UDim2.new(0.52,-5,0,635)

	sizePlus.Text = "➕"

	sizePlus.TextScaled = true

	sizePlus.TextColor3 =
		Color3.new(1,1,1)

	sizePlus.BackgroundColor3 =
		Color3.fromRGB(0,170,255)

	sizePlus.Parent =
		settingsScroll

	Instance.new(
		"UICorner",
		sizePlus
	)

	local function updateNameSize()

		sizeLabel.Text =
			"🏷 Name Size : "..nameSize

		for _,billboard in pairs(
			nameTags
		) do

			if billboard and
				billboard:
				FindFirstChildOfClass(
					"TextLabel"
				) then

				local txt =
					billboard:
					FindFirstChildOfClass(
						"TextLabel"
					)

				txt.TextSize =
					nameSize
			end
		end
	end

	sizePlus.MouseButton1Click:
	Connect(function()

		if nameSize < 50 then

			nameSize += 2

			updateNameSize()
		end
	end)

	sizeMinus.MouseButton1Click:
	Connect(function()

		if nameSize > 10 then

			nameSize -= 2

			updateNameSize()
		end
	end)

	------------------------------------------------
	-- SAVE POSITION
	------------------------------------------------
	local savedCFrame = nil

	local saveBtn =
		Instance.new("TextButton")

	saveBtn.Size =
		UDim2.new(1,-20,0,40)

	saveBtn.Position =
		UDim2.new(0,10,0,690)

	saveBtn.Text =
		"💾 Save Position"

	saveBtn.TextScaled = true

	saveBtn.TextColor3 =
		Color3.new(1,1,1)

	saveBtn.BackgroundColor3 =
		Color3.fromRGB(0,170,255)

	saveBtn.Parent =
		settingsScroll

	Instance.new(
		"UICorner",
		saveBtn
	)

	saveBtn.MouseButton1Click:
	Connect(function()

		local char =
			lp.Character

		if char and
			char:
			FindFirstChild(
				"HumanoidRootPart"
			) then

			savedCFrame =
				char
				.HumanoidRootPart
				.CFrame

			notify(
				"📍 Position Saved"
			)
		end
	end)

	------------------------------------------------
	-- TELEPORT BACK
	------------------------------------------------
	local tpBtn =
		Instance.new("TextButton")

	tpBtn.Size =
		UDim2.new(1,-20,0,40)

	tpBtn.Position =
		UDim2.new(0,10,0,745)

	tpBtn.Text =
		"📌 Teleport Back"

	tpBtn.TextScaled = true

	tpBtn.TextColor3 =
		Color3.new(1,1,1)

	tpBtn.BackgroundColor3 =
		Color3.fromRGB(170,85,255)

	tpBtn.Parent =
		settingsScroll

	Instance.new(
		"UICorner",
		tpBtn
	)

	tpBtn.MouseButton1Click:
	Connect(function()

		local char =
			lp.Character

		if char and
			savedCFrame and
			char:
			FindFirstChild(
				"HumanoidRootPart"
			) then

			char
			.HumanoidRootPart
			.CFrame =
				savedCFrame

			notify(
				"✅ Teleported"
			)
		end
	end)

	------------------------------------------------
	-- REJOIN
	------------------------------------------------
	local rejoinBtn =
		Instance.new("TextButton")

	rejoinBtn.Size =
		UDim2.new(1,-20,0,40)

	rejoinBtn.Position =
		UDim2.new(0,10,0,800)

	rejoinBtn.Text =
		"🔄 Rejoin"

	rejoinBtn.TextScaled = true

	rejoinBtn.TextColor3 =
		Color3.new(1,1,1)

	rejoinBtn.BackgroundColor3 =
		Color3.fromRGB(255,170,0)

	rejoinBtn.Parent =
		settingsScroll

	Instance.new(
		"UICorner",
		rejoinBtn
	)

	rejoinBtn.MouseButton1Click:
	Connect(function()

		notify(
			"🔄 Rejoining..."
		)

		TeleportService:
			Teleport(
				game.PlaceId,
				lp
			)
	end)------------------------------------------------
-- 🌈 PART 7
-- ANTI AFK + RAINBOW + PING
------------------------------------------------

	------------------------------------------------
	-- ANTI AFK
	------------------------------------------------
	local antiAfk = false

	local afkBtn =
		Instance.new("TextButton")

	afkBtn.Size =
		UDim2.new(1,-20,0,40)

	afkBtn.Position =
		UDim2.new(0,10,0,855)

	afkBtn.Text =
		"🛡 Anti AFK : OFF"

	afkBtn.TextScaled = true

	afkBtn.TextColor3 =
		Color3.new(1,1,1)

	afkBtn.BackgroundColor3 =
		Color3.fromRGB(0,200,120)

	afkBtn.Parent =
		settingsScroll

	Instance.new(
		"UICorner",
		afkBtn
	)

	local afkConnection

	afkBtn.MouseButton1Click:
	Connect(function()

		antiAfk = not antiAfk

		if antiAfk then

			afkBtn.Text =
				"✅ Anti AFK : ON"

			local vu =
				game:GetService(
					"VirtualUser"
				)

			afkConnection =
				lp.Idled:Connect(
				function()

				vu:Button2Down(
					Vector2.new(0,0),
					workspace
					.CurrentCamera
					.CFrame
				)

				task.wait(1)

				vu:Button2Up(
					Vector2.new(0,0),
					workspace
					.CurrentCamera
					.CFrame
				)
			end)

			notify(
				"🛡 Anti AFK Enabled"
			)

		else

			afkBtn.Text =
				"❌ Anti AFK : OFF"

			if afkConnection then
				afkConnection:
					Disconnect()
			end
		end
	end)

	------------------------------------------------
	-- RAINBOW UI
	------------------------------------------------
	local rainbow = false

	local rainbowBtn =
		Instance.new("TextButton")

	rainbowBtn.Size =
		UDim2.new(1,-20,0,40)

	rainbowBtn.Position =
		UDim2.new(0,10,0,910)

	rainbowBtn.Text =
		"🌈 Rainbow UI : OFF"

	rainbowBtn.TextScaled = true

	rainbowBtn.TextColor3 =
		Color3.new(1,1,1)

	rainbowBtn.BackgroundColor3 =
		Color3.fromRGB(255,0,255)

	rainbowBtn.Parent =
		settingsScroll

	Instance.new(
		"UICorner",
		rainbowBtn
	)

	rainbowBtn.MouseButton1Click:
	Connect(function()

		rainbow = not rainbow

		if rainbow then

			rainbowBtn.Text =
				"✅ Rainbow UI : ON"

		else

			rainbowBtn.Text =
				"❌ Rainbow UI : OFF"
		end
	end)

	RunService.RenderStepped:
	Connect(function()

		if rainbow then

			local hue =
				tick()%5 / 5

			frame.BackgroundColor3 =
				Color3.fromHSV(
					hue,
					1,
					1
				)
		end
	end)

	------------------------------------------------
	-- PING COUNTER
	------------------------------------------------
	local pingLabel =
		Instance.new("TextLabel")

	pingLabel.Size =
		UDim2.new(1,-20,0,35)

	pingLabel.Position =
		UDim2.new(0,10,0,965)

	pingLabel.BackgroundColor3 =
		Color3.fromRGB(35,35,35)

	pingLabel.TextColor3 =
		Color3.new(1,1,1)

	pingLabel.TextScaled = true

	pingLabel.Text =
		"📶 Ping : 0"

	pingLabel.Parent =
		settingsScroll

	Instance.new(
		"UICorner",
		pingLabel
	)

	task.spawn(function()

		while task.wait(1) do

			local ping =
				math.random(
					20,
					120
				)

			pingLabel.Text =
				"📶 Ping : "..ping
		end
	end)

	------------------------------------------------
	-- FINAL CANVAS SIZE
	------------------------------------------------
	settingsScroll.CanvasSize =
		UDim2.new(
			0,
			0,
			0,
			1100
		)

	------------------------------------------------
	-- HUB LOADED
	------------------------------------------------
	notify(
		"🌈 Ultra Final Loaded"
	)

  end------------------------------------------------
-- 🌈 PART 8
-- KEY SYSTEM + AUTO LOGIN
------------------------------------------------

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
local keyFrame =
	Instance.new("Frame")

keyFrame.Size =
	UDim2.new(0,300,0,220)

keyFrame.Position =
	UDim2.new(0.5,-150,0.5,-110)

keyFrame.BackgroundColor3 =
	Color3.fromRGB(25,25,25)

keyFrame.Parent = gui

Instance.new(
	"UICorner",
	keyFrame
)

dragify(keyFrame)

------------------------------------------------
-- TITLE
------------------------------------------------
local title =
	Instance.new("TextLabel")

title.Size =
	UDim2.new(1,0,0,40)

title.BackgroundTransparency = 1

title.Text =
	"🔑 KEY SYSTEM"

title.TextScaled = true

title.TextColor3 =
	Color3.new(1,1,1)

title.Parent = keyFrame

------------------------------------------------
-- KEY BOX
------------------------------------------------
local keyBox =
	Instance.new("TextBox")

keyBox.Size =
	UDim2.new(1,-20,0,40)

keyBox.Position =
	UDim2.new(0,10,0,55)

keyBox.PlaceholderText =
	"Enter Key..."

keyBox.Text = ""

keyBox.TextScaled = true

keyBox.TextColor3 =
	Color3.new(1,1,1)

keyBox.BackgroundColor3 =
	Color3.fromRGB(40,40,40)

keyBox.Parent = keyFrame

Instance.new(
	"UICorner",
	keyBox
)

------------------------------------------------
-- ENTER BUTTON
------------------------------------------------
local enter =
	Instance.new("TextButton")

enter.Size =
	UDim2.new(1,-20,0,40)

enter.Position =
	UDim2.new(0,10,0,105)

enter.Text =
	"ENTER"

enter.TextScaled = true

enter.TextColor3 =
	Color3.new(1,1,1)

enter.BackgroundColor3 =
	Color3.fromRGB(0,170,255)

enter.Parent =
	keyFrame

Instance.new(
	"UICorner",
	enter
)

------------------------------------------------
-- KEY LINK TITLE
------------------------------------------------
local linkTitle =
	Instance.new("TextLabel")

linkTitle.Size =
	UDim2.new(1,-20,0,25)

linkTitle.Position =
	UDim2.new(0,10,0,155)

linkTitle.BackgroundTransparency =
	1

linkTitle.Text =
	"🌐 KEY LINK"

linkTitle.TextScaled = true

linkTitle.TextColor3 =
	Color3.new(1,1,1)

linkTitle.Parent =
	keyFrame

------------------------------------------------
-- KEY LINK BOX
------------------------------------------------
local linkBox =
	Instance.new("TextBox")

linkBox.Size =
	UDim2.new(1,-20,0,35)

linkBox.Position =
	UDim2.new(0,10,0,180)

linkBox.Text = KEY_URL

linkBox.ClearTextOnFocus = false
linkBox.TextEditable = false

linkBox.TextColor3 =
	Color3.new(1,1,1)

linkBox.BackgroundColor3 =
	Color3.fromRGB(40,40,40)

linkBox.Parent =
	keyFrame

Instance.new(
	"UICorner",
	linkBox
)

------------------------------------------------
-- KEY CHECK
------------------------------------------------
enter.MouseButton1Click:
Connect(function()

	local userKey =
		keyBox.Text:
		gsub("%s+","")

	if userKey == webKey then

		if writefile then

			writefile(
				KEY_FILE,
				userKey
			)
		end

		notify(
			"✅ Correct Key"
		)

		keyFrame:Destroy()

		createHub()

	else

		keyBox.Text =
			"Wrong Key"

		notify(
			"❌ Wrong Key"
		)

		task.wait(1)

		keyBox.Text = ""
	end
end)

------------------------------------------------
-- END
------------------------------------------------
notify(
	"🔑 Waiting Key..."
    )------------------------------------------------
-- 🌈 PART 9
-- EXTRA SYSTEMS
------------------------------------------------

	------------------------------------------------
	-- FPS BOOST
	------------------------------------------------
	local fpsBoost = false

	local boostBtn =
		Instance.new("TextButton")

	boostBtn.Size =
		UDim2.new(1,-20,0,40)

	boostBtn.Position =
		UDim2.new(0,10,0,1020)

	boostBtn.Text =
		"⚡ FPS Boost : OFF"

	boostBtn.TextScaled = true

	boostBtn.TextColor3 =
		Color3.new(1,1,1)

	boostBtn.BackgroundColor3 =
		Color3.fromRGB(255,255,0)

	boostBtn.Parent =
		settingsScroll

	Instance.new(
		"UICorner",
		boostBtn
	)

	boostBtn.MouseButton1Click:
	Connect(function()

		fpsBoost = not fpsBoost

		if fpsBoost then

			boostBtn.Text =
				"✅ FPS Boost : ON"

			for _,v in pairs(
				workspace:GetDescendants()
			) do

				if v:IsA("BasePart") then

					v.Material =
						Enum.Material
						.Plastic

					v.Reflectance = 0
				end

				if v:IsA("Decal")
					or
					v:IsA("Texture") then

					v:Destroy()
				end
			end

			lighting.GlobalShadows =
				false

			settings().Rendering
			.QualityLevel =
				Enum.QualityLevel
				.Level01

			notify(
				"⚡ FPS Boost Enabled"
			)

		else

			boostBtn.Text =
				"❌ FPS Boost : OFF"

			notify(
				"⚡ Rejoin To Reset"
			)
		end
	end)

	------------------------------------------------
	-- PLAYER COUNT
	------------------------------------------------
	local playerLabel =
		Instance.new("TextLabel")

	playerLabel.Size =
		UDim2.new(1,-20,0,35)

	playerLabel.Position =
		UDim2.new(0,10,0,1075)

	playerLabel.BackgroundColor3 =
		Color3.fromRGB(35,35,35)

	playerLabel.TextColor3 =
		Color3.new(1,1,1)

	playerLabel.TextScaled = true

	playerLabel.Text =
		"👥 Players : 0"

	playerLabel.Parent =
		settingsScroll

	Instance.new(
		"UICorner",
		playerLabel
	)

	local function updatePlayers()

		playerLabel.Text =
			"👥 Players : "
			..
			#Players:GetPlayers()
	end

	updatePlayers()

	Players.PlayerAdded:
	Connect(updatePlayers)

	Players.PlayerRemoving:
	Connect(updatePlayers)

	------------------------------------------------
	-- TIME LABEL
	------------------------------------------------
	local timeLabel =
		Instance.new("TextLabel")

	timeLabel.Size =
		UDim2.new(1,-20,0,35)

	timeLabel.Position =
		UDim2.new(0,10,0,1130)

	timeLabel.BackgroundColor3 =
		Color3.fromRGB(35,35,35)

	timeLabel.TextColor3 =
		Color3.new(1,1,1)

	timeLabel.TextScaled = true

	timeLabel.Text =
		"🕒 Time"

	timeLabel.Parent =
		settingsScroll

	Instance.new(
		"UICorner",
		timeLabel
	)

	task.spawn(function()

		while task.wait(1) do

			timeLabel.Text =
				"🕒 "..os.date(
					"%X"
				)
		end
	end)

	------------------------------------------------
	-- RESET CHARACTER
	------------------------------------------------
	local resetBtn =
		Instance.new("TextButton")

	resetBtn.Size =
		UDim2.new(1,-20,0,40)

	resetBtn.Position =
		UDim2.new(0,10,0,1185)

	resetBtn.Text =
		"💀 Reset Character"

	resetBtn.TextScaled = true

	resetBtn.TextColor3 =
		Color3.new(1,1,1)

	resetBtn.BackgroundColor3 =
		Color3.fromRGB(255,0,0)

	resetBtn.Parent =
		settingsScroll

	Instance.new(
		"UICorner",
		resetBtn
	)

	resetBtn.MouseButton1Click:
	Connect(function()

		local char =
			lp.Character

		if char and
			char:
			FindFirstChild(
				"Humanoid"
			) then

			char.Humanoid.Health = 0
		end
	end)

	------------------------------------------------
	-- FINAL SCROLL SIZE
	------------------------------------------------
	settingsScroll.CanvasSize =
		UDim2.new(
			0,
			0,
			0,
			1300
		)

	------------------------------------------------
	-- FINAL NOTIFY
	------------------------------------------------
	notify(
		"🚀 All Systems Loaded"
    )------------------------------------------------
-- 🌈 PART 10
-- FINAL CLEANUP + CORE FIXES
------------------------------------------------

------------------------------------------------
-- CHARACTER SAFE HANDLER
------------------------------------------------
local function getChar()
	local char = lp.Character
	if not char then return nil end

	local hum = char:FindFirstChild("Humanoid")
	local hrp = char:FindFirstChild("HumanoidRootPart")

	if not hum or not hrp then return nil end
	return char, hum, hrp
end

------------------------------------------------
-- SAFE WALK SPEED APPLY (FIX BUG)
------------------------------------------------
local function applySpeed(speed)
	local _, hum = getChar()
	if hum then
		hum.WalkSpeed = speed
	end
end

------------------------------------------------
-- SAFE JUMP APPLY
------------------------------------------------
local function applyJump(power)
	local _, hum = getChar()
	if hum then
		hum.JumpPower = power
	end
end

------------------------------------------------
-- AUTO RESPAWN FIX
------------------------------------------------
lp.CharacterAdded:Connect(function()
	task.wait(0.5)

	-- re-apply stats after respawn
	applySpeed(walkSpeed)
	applyJump(jumpPower)
end)

------------------------------------------------
-- MOBILE SAFE UI SCALE
------------------------------------------------
local uiScale = Instance.new("UIScale")
uiScale.Scale = 1
uiScale.Parent = gui

------------------------------------------------
-- PERFORMANCE CLEANER LOOP
------------------------------------------------
task.spawn(function()
	while task.wait(10) do
		-- remove unused objects if needed
		collectgarbage()
	end
end)

------------------------------------------------
-- FINAL BOOT MESSAGE
------------------------------------------------
notify("🌈 Mini Hub Ready (Dev Mode)")

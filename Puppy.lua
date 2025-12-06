local screenGui = Instance.new("ScreenGui")
screenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 280, 0, 280)
mainFrame.Position = UDim2.new(0.3, 0, 0.3, 0)
mainFrame.BackgroundColor3 = Color3.fromRGB(80, 31, 40)
mainFrame.Active = true
mainFrame.Draggable = true
mainFrame.Parent = screenGui
print("Puppy Lodaded!")

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 30)
title.BackgroundColor3 = Color3.fromRGB(25,25,25)
title.Text = "Puppy Hub"
title.TextColor3 = Color3.new(1,1,1)
title.Parent = mainFrame

local function crearBoton(texto, posY)
    local boton = Instance.new("TextButton")
    boton.Size = UDim2.new(1, -20, 0, 40)
    boton.Position = UDim2.new(0, 10, 0, posY)
    boton.BackgroundColor3 = Color3.fromRGB(60,60,60)
    boton.TextColor3 = Color3.new(1,1,1)
    boton.Text = texto
    boton.Parent = mainFrame
    return boton
end

local boton1 = crearBoton("Inf Yield", 40)
local boton2 = crearBoton("Steal a Brainrot", 90)
local boton3 = crearBoton("99 Nights", 140)
local boton4 = crearBoton("SSA Universal Script", 190)

boton1.MouseButton1Click:Connect(function()
    print("Loading...")
    loadstring(game:HttpGet("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"))()
end)

boton2.MouseButton1Click:Connect(function()
    loadstring(game:HttpGet('https://raw.githubusercontent.com/KaspikScriptsRb/steal-a-brainrot/refs/heads/main/.lua'))()
end)

boton3.MouseButton1Click:Connect(function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/VapeVoidware/VW-Add/main/loader.lua", true))()
end)
boton4.MouseButton1Click:Connect(function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/TeamCookoo/Puppy-Hub/refs/heads/main/SSA?token=GHSAT0AAAAAADOIMVASXR3YYTVMSFJYXJCY2JULGLA"))()
end)

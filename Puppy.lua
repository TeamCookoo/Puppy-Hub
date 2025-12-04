-- Crear GUI
local screenGui = Instance.new("ScreenGui")
screenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

-- Ventana principal (movible)
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 220, 0, 180)
mainFrame.Position = UDim2.new(0.3, 0, 0.3, 0)
mainFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
mainFrame.Active = true
mainFrame.Draggable = true
mainFrame.Parent = screenGui

-- Título
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 30)
title.BackgroundColor3 = Color3.fromRGB(25,25,25)
title.Text = "Ventana Movible"
title.TextColor3 = Color3.new(1,1,1)
title.Parent = mainFrame

-- Crear botones con función auxiliar
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

-- Botones
local boton1 = crearBoton("Inf Yield", 40)
local boton2 = crearBoton("Steal a Brainrot", 90)
local boton3 = crearBoton("99 Nights", 140)
local boton4 = crearBoton("SSA Universal Script", 190)

-- Funciones de los botones
boton1.MouseButton1Click:Connect(function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"))()
end)

boton2.MouseButton1Click:Connect(function()
    print("mimimimimi")
end)

boton3.MouseButton1Click:Connect(function()
    print("ESTO")
    task.wait(0.8)
    print("SOLO ES PRUEBA")

boton4.MouseButton1Click:Connect(function()
  print(1+1)
end)

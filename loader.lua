local keyURL = "https://raw.githubusercontent.com/TeamCookoo/Puppy-Hub/main/key.txt"

local function getKeys()
    local response = game:HttpGet(keyURL)
    if not response or response == "" then
        return nil
    end

    local keys = {}
    for line in response:gmatch("[^\r\n]+") do
        table.insert(keys, line)
    end

    return keys
end

local function isValidKey(inputKey, keys)
    for _, key in ipairs(keys) do
        if inputKey == key then
            return true
        end
    end
    return false
end

-- GUI SIMPLE DE PEDIR KEY
local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
local Frame = Instance.new("Frame", ScreenGui)
Frame.Size = UDim2.new(0, 300, 0, 150)
Frame.Position = UDim2.new(0.5, -150, 0.5, -75)
Frame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)

local TextBox = Instance.new("TextBox", Frame)
TextBox.Size = UDim2.new(1, -20, 0, 40)
TextBox.Position = UDim2.new(0, 10, 0, 10)
TextBox.PlaceholderText = "Ingresa el Key"

local Button = Instance.new("TextButton", Frame)
Button.Size = UDim2.new(1, -20, 0, 40)
Button.Position = UDim2.new(0, 10, 0, 60)
Button.Text = "Verificar"

Button.MouseButton1Click:Connect(function()
    local keys = getKeys()
    if not keys then
        Button.Text = "Error cargando keys"
        return
    end

    if isValidKey(TextBox.Text, keys) then
        Button.Text = "Correcto!"
        
        -- CARGA TU SCRIPT ORIGINAL
        loadstring(game:HttpGet("https://raw.githubusercontent.com/TeamCookoo/Puppy-Hub/main/Puppy.lua"))()

        ScreenGui:Destroy()
    else
        Button.Text = "Key Incorrecto"
    end
end)

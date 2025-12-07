-- Loader definitivo (GUI + verificación desde GitHub Pages branch 'HTML' + expiración 1 hora)
-- Reemplaza KEY_PAGE_URL si tu Pages URL es distinta

local KEY_PAGE_URL = "https://teamcookoo.github.io/Puppy-Hub/" -- página (branch HTML) que muestra la key
local SCRIPT_RAW_URL = "https://raw.githubusercontent.com/TeamCookoo/Puppy-Hub/main/Puppy.lua" -- tu script real
local KEYFILE = "puppy_key.txt"
local TIMERFILE = "puppy_timer.txt"
local KEY_DURATION = 3600 -- segundos (1 hora)

local HttpService = game:GetService("HttpService")

-- util: trim
local function trim(s) return (s:gsub("^%s*(.-)%s*$", "%1")) end

-- cargar key y timestamp guardados si existen
local savedKey = (isfile and isfile(KEYFILE)) and readfile(KEYFILE) or nil
local savedTime = (isfile and isfile(TIMERFILE)) and tonumber(readfile(TIMERFILE)) or nil

local function keyExpired()
    if not savedTime then return true end
    return (os.time() - savedTime) >= KEY_DURATION
end

-- si ya venció la key guardada, eliminar archivos y forzar pedir key
if savedKey and keyExpired() then
    if delfile then
        pcall(delfile, KEYFILE)
        pcall(delfile, TIMERFILE)
    end
    savedKey = nil
    savedTime = nil
end

-- función que obtiene la key publicada en la página (parseando el HTML)
local function fetchKeyFromPage()
    local ok, body = pcall(function() return game:HttpGet(KEY_PAGE_URL) end)
    if not ok or not body then return nil end

    -- Buscar <div id="key">...clave...</div>
    local key = body:match('<div%s+id=["\']key["\']%s*[^>]*>(.-)</div>')
    if not key then
        -- alternativa más flexible: buscar contenido con id=key sin importar atributos
        key = body:match('id=["\']key["\'][^>]*>(.-)</div>') or body:match('id=%s*["\']key["\'][^>]*>(.-)</div>')
    end

    if key then
        return trim(key)
    end

    return nil
end

-- GUI (sencilla y limpia)
local function createGui(savedText)
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.ResetOnSpawn = false
    ScreenGui.Parent = game:GetService("CoreGui")

    local Main = Instance.new("Frame", ScreenGui)
    Main.Size = UDim2.new(0,330,0,190)
    Main.Position = UDim2.new(0.5,-165,0.5,-95)
    Main.BackgroundColor3 = Color3.fromRGB(20,20,20)
    Main.BorderSizePixel = 0
    local UIC = Instance.new("UICorner", Main)
    UIC.CornerRadius = UDim.new(0,12)

    local Title = Instance.new("TextLabel", Main)
    Title.Size = UDim2.new(1,0,0,30)
    Title.BackgroundTransparency = 1
    Title.Position = UDim2.new(0,0,0,6)
    Title.Font = Enum.Font.GothamBold
    Title.TextSize = 18
    Title.TextColor3 = Color3.new(1,1,1)
    Title.Text = "🔐 Puppy Hub — Key"

    local Box = Instance.new("TextBox", Main)
    Box.Size = UDim2.new(1,-40,0,36)
    Box.Position = UDim2.new(0,20,0,52)
    Box.BackgroundColor3 = Color3.fromRGB(30,30,30)
    Box.TextColor3 = Color3.new(1,1,1)
    Box.Font = Enum.Font.Gotham
    Box.TextSize = 14
    Box.PlaceholderText = "Ingresa tu key..."
    Box.Text = savedText or ""
    local UIC2 = Instance.new("UICorner", Box)
    UIC2.CornerRadius = UDim.new(0,8)

    local Btn = Instance.new("TextButton", Main)
    Btn.Size = UDim2.new(1,-40,0,36)
    Btn.Position = UDim2.new(0,20,0,100)
    Btn.BackgroundColor3 = Color3.fromRGB(46, 134, 193)
    Btn.Font = Enum.Font.GothamBold
    Btn.TextSize = 15
    Btn.TextColor3 = Color3.new(1,1,1)
    Btn.Text = "Verificar Key"
    Instance.new("UICorner", Btn).CornerRadius = UDim.new(0,8)

    local Status = Instance.new("TextLabel", Main)
    Status.Size = UDim2.new(1, -20, 0, 28)
    Status.Position = UDim2.new(0,10,1,-36)
    Status.BackgroundTransparency = 1
    Status.Font = Enum.Font.Gotham
    Status.TextSize = 14
    Status.TextColor3 = Color3.fromRGB(255,80,80)
    Status.Text = ""

    return {
        Gui = ScreenGui,
        Box = Box,
        Btn = Btn,
        Status = Status
    }
end

-- verificar key comparando con la key publicada en la página
local function verifyAndMaybeLoad(inputKey, guiObj)
    if not inputKey or inputKey == "" then
        guiObj.Status.Text = "⚠ Ingresa una key válida."
        return false
    end

    guiObj.Status.Text = "Verificando..."
    local publishedKey = fetchKeyFromPage()
    if not publishedKey then
        guiObj.Status.Text = "Error: no se pudo obtener la key pública."
        return false
    end

    if inputKey == publishedKey then
        guiObj.Status.TextColor3 = Color3.fromRGB(0,200,120)
        guiObj.Status.Text = "✔ Key válida. Cargando..."
        -- guardar key y timestamp
        if writefile then
            pcall(writefile, KEYFILE, inputKey)
            pcall(writefile, TIMERFILE, tostring(os.time()))
        end
        wait(0.9)
        if guiObj.Gui and guiObj.Gui.Destroy then pcall(function() guiObj.Gui:Destroy() end) end
        -- cargar script real
        local ok, body = pcall(function() return game:HttpGet(SCRIPT_RAW_URL) end)
        if ok and body and body:match("%S") then
            loadstring(body)()
        else
            -- failed to fetch script
            warn("No se pudo cargar el script desde el raw.")
        end
        return true
    else
        guiObj.Status.TextColor3 = Color3.fromRGB(255,80,80)
        guiObj.Status.Text = "❌ Key inválida o expirada."
        -- eliminar key guardada para forzar reingreso
        if delfile then pcall(delfile, KEYFILE) end
        return false
    end
end

-- crear GUI
local guiObj = createGui(savedKey)
guiObj.Status.Parent = guiObj.Gui:GetChildren()[1] -- añadir Status al frame (ya creado arriba)
guiObj.Status.Parent = guiObj.Gui:GetChildren()[1] -- safe

-- conectar botón
guiObj.Btn.MouseButton1Click:Connect(function()
    verifyAndMaybeLoad(guiObj.Box.Text, guiObj)
end)

-- si ya había key guardada y no expiró, intentar usarla automáticamente
if savedKey and (not keyExpired()) then
    -- intentar verificar con la key guardada; si falla, GUI quedará visible para reingresar
    pcall(function() verifyAndMaybeLoad(savedKey, guiObj) end)
end

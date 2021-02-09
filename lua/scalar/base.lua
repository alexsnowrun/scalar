Scalar.Data.Fonts = Scalar.Data.Fonts or {}
Scalar.Data.Sizes = Scalar.Data.Sizes or {}

-- Font scaling // Fonts only depend on height

local f_size, f_minsize = 0,0
local function UpdateFont(name, scalarFontData)
    f_size = scalarFontData.size * ScrH() / Scalar.Data.Resolutions[scalarFontData.res].h
    f_minsize = scalarFontData.minsize
    scalarFontData.data.size = f_size > f_minsize and f_size or f_minsize
    surface.CreateFont(name, scalarFontData.data)
end

local function UpdateFonts()
    for name, data in pairs(Scalar.Data.Fonts) do
        UpdateFont(name, data)
    end
end

function Scalar.RegisterFont(fontName, size, minsize, fontData) 
    --[[
        string fontName - name of the font
        number size - normal size of font in pixels
        number minsize - minimal size of font in pixels
        table fontData - https://wiki.facepunch.com/gmod/Structures/FontData
    ]]

    Scalar.Data.Fonts[fontName] = {
        size = size,
        minsize = minsize,
        res = Scalar.CURRES, -- Name of the resolution in which this size was found
        data = fontData
    }
    
    UpdateFont(fontName, Scalar.Data.Fonts[fontName])
end

-- Other sizes

local o_size, o_minsize = 0, 0
local function UpdateSize(name, scalarSizeData)
    local res = Scalar.Data.Resolutions[scalarSizeData.res]
    o_size = scalarSizeData.size * (scalarSizeData.widthDependent and ScrW() / res.w or ScrH() / res.h)
    o_minsize = scalarSizeData.minsize
    _G[name] = o_size > o_minsize and o_size or o_minsize
end

local function UpdateSizes()
    for name, data in pairs(Scalar.Data.Sizes) do
        UpdateSize(name, data)
    end
end

function Scalar.RegisterSize(scaleName, size, minsize, widthDependent)
    --[[
        string scaleName -- name of the global vaiable which provides scaled value. EXAMPLE: "UI_SCALE_HUD" or "SIZE_HUD" or "SCALE_MAINMENU"
        number size -- normal size in pixels
        number minsize -- minimal size in pixels
        bool widthDependent -- should we use screen width scale factor for this size? DEFAULT: false
    ]]

    Scalar.Data.Sizes[scaleName] = {
        size = size,
        minsize = minsize,
        res = Scalar.CURRES, -- Name of the resolution in which this size was found
        widthDependent = widthDependent or false,
    }
    UpdateSize(scaleName, Scalar.Data.Sizes[scaleName])
end

hook.Add("OnScreenSizeChanged", "Scalar - Global scaling handler", function()
    UpdateFonts()
    UpdateSizes()
end)

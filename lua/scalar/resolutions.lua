Scalar.Data.Resolutions = Scalar.Data.Resolutions or { -- Some of common resolutions
    -- 16:9 
    ["HD"] = {w = 1280, h = 720},
    ["WXGA"] = {w = 1366, h = 768},
    ["HD+"] = {w = 1600, h = 900},
    ["FHD"] = {w = 1920, h = 1080},
    ["QHD"] = {w = 2560, h = 1440},
    ["UHD"] = {w = 3840, h = 2160},

    -- 16:10
    ["WSXGA+"] = {w = 1680, h = 1050},
    ["WUXGA"] = {w = 1920, h = 1200},

    -- 4:3 
    ["VGA"] = {w = 640, h = 480},
    ["SVGA"] = {w = 800, h = 600},
    ["XGA"] = {w = 1024, h = 768},
    ["UXGA"] = {w = 1600, h = 1200},
}

function Scalar.RegisterResolution(name, w, h)
    Scalar.Data.Resolutions[name] = {w = w, h = h}
end

function Scalar.CheckMyResolution()
    local my_w, my_h = ScrW(), ScrH()
    for name, tb in pairs(Scalar.Data.Resolutions) do
        if tb.w == my_w and tb.h == my_h then return name end
    end
    return false
end

function Scalar.SetResolution(name)
    local rescache = Scalar.Data.Resolutions[name]
    if rescache then
        Scalar.CURRES = name
        Scalar.SCALEFACTOR.w = ScrW() / rescache.w
        Scalar.SCALEFACTOR.h = ScrH() / rescache.h
        return
    end
    ErrorNoHalt("[Scalar] Resolution \""..name.."\" does not exist!", "Setting Resolution to FHD...")
    Scalar.CURRES = "FHD"
    Scalar.SCALEFACTOR = {w = ScrW() / 1920, h = ScrH() / 1080}
end

Scalar.SetResolution("FHD")

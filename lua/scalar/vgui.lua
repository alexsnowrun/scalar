Scalar.Data.RegisteredVGUI = Scalar.Data.RegisteredVGUI or {}

local abs = math.abs
local function RegisterVGUI(panelName)
    --[[ 
    string PanelName -- name of the VGUI element
    ]]
    if Scalar.Data.RegisteredVGUI[panelName] then return end
    Scalar.Data.RegisteredVGUI[panelName] = true

    local panel = vgui.GetControlTable(panelName) or baseclass.Get(panelName)

    AccessorFunc(panel, "ParentRelativeScaling", "ParentRelativeScaling", FORCE_BOOL)
    AccessorFunc(panel, "PixelScaling", "PixelScaling", FORCE_BOOL)

    function panel:SetPos(x, y)
        if x then
            if self.ParentRelativeScaling and abs(x) < 1 then
                self.x = x * self:GetParent():GetWide()
            else
                self.x = (self.PixelScaling and Scalar.SCALEFACTOR.w * x or x)
            end
        end

        if y then
            if self.ParentRelativeScaling and abs(y) < 1 then
                self.y = y * self:GetParent():GetTall()
            else
                self.y = (self.PixelScaling and Scalar.SCALEFACTOR.h * y or y)
            end
        end
    end

    local oldsetsize = panel.SetSize

    function panel:SetSize(w, h)
        local w_fin, h_fin = 0, 0

        if w then
            if self.ParentRelativeScaling and abs(w) < 1 then
                w_fin = w * self:GetParent():GetWide()
            else
                w_fin = (self.PixelScaling and Scalar.SCALEFACTOR.h * w or w)
            end
        else
            w_fin = self:GetWide()
        end

        if h then
            if self.ParentRelativeScaling and abs(h) < 1 then
                h_fin = h * self:GetParent():GetTall()
            else
                h_fin = (self.PixelScaling and Scalar.SCALEFACTOR.h * h or h)
            end
        else
            h_fin = self:GetTall()
        end

        oldsetsize(self, w_fin, h_fin)
    end
end

RegisterVGUI("Panel")

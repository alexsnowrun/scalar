# Scalar
Scaling library for Garry's Mod.
## What can it do
* Scaling that is based on your screen resolution\*
* Automatic font scaling
* Registering sizes
* VGUI scaling\*\*
* Parent relative VGUI scaling and positioning\
\
\**You'll need to add or set your screen resolution in code beforehand. By default it is set to Full HD.*  
\**\*The result can be unexpectable for the VGUI elements that do not support scaling.*

## Scalar Functions
```lua
Scalar.RegisterResolution(string name, number width, number height)
```
### Help
Registers the resolution in the Scalar's resolution list for using it in *Scalar.SetResolution()*
### Arguments
1. string name - ID of the resolution (e.g.: "HD", "8K").
2. number width - Screen width.
3. number height - Screen height.
---
```lua
Scalar.SetResolution(string name)
```
### Help
Sets the current working resolution, typically it's coder's screen resolution. This should be called before registering the size/font and scaling of the VGUI.
### Arguments
1. string name - Name of the resolution.
---
```lua
Scalar.CheckMyResolution()
```
### Help
Checks if your screen resolution exists in the table.
### Returns
1. *string* Name of the resolution or *bool* false if not exists.

```lua
Scalar.RegisterFont(string fontName, number size, number minsize, table fontData)
```
### Help
Registers the font that will scale automatically when resolution is changed.
### Arguments
1. string fontName - The new font name.
2. number size - Normal size of font in pixels.
3. number minsize - Minimal size of font in pixels.
4. table fontData - https://wiki.facepunch.com/gmod/Structures/FontData
### Example
```lua 
Scalar.SetResolution("QHD")
Scalar.RegisterFont("MenuFont", 16, 8,
    {
        font = "Arial",
        extended = true,
        weight = 500,
        antialias = true,
    })
```
---
```lua
Scalar.RegisterSize(string scaleName, number size, number minsize, [bool widthDependent = false])
```
### Help
Registers the size in global that will scale automatically when resolution is changed.
### Arguments
1. string scaleName - The name of the scale. That's a global variable name
2. number size - Normal size of scale in pixels.
3. number minsize - Minimal size of scale in pixels.
4. bool widthDependent - (Optional) Should this size be scaled in width or not. DEFAULT: false
### Example
```lua
Scalar.SetResolution("QHD")
Scalar.RegisterSize("UI_SCALE_HUD", 512, 64)
print(UI_SCALE_HUD)
```
---
## VGUI Functions
```lua
Panel:SetParentRelativeScaling(bool enabled)
```
### Help
Enables or disables parent relative scaling. DEFAULT: Disabled
### Arguments
1. bool enabled - Should parent relative scaling be enabled or not.
---
```lua
Panel:SetPixelScaling(bool enabled)
```
### Help
Enables or disables pixel scaling. DEFAULT: Disabled
### Arguments
1. bool enabled - Should pixel scaling be enabled or not.
---
## Example
```lua
Scalar.SetResolution("QHD")
Scalar.RegisterFont("SCALAR_DEMO_FONT", 64, 12,
    {
        font = "Arial",
        extended = true,
        weight = 500,
        antialias = true,
    })

local fr = vgui.Create("DFrame")
fr:SetTitle("Scaling Test")

fr:SetParentRelativeScaling(true)
    fr:SetSize(0.5, 0.5)
    fr:SetPos(0.25, 0.25)
fr:SetParentRelativeScaling(false)

fr:MakePopup()

local text = fr:Add("DLabel")
text:SetFont("SCALAR_DEMO_FONT")
text:SetText("It takes 1/4 of the screen space")

text:SetPixelScaling(true)
    text:SetPos(32, 360 - 32)
    text:SetSize(1000, 64)
text:SetPixelScaling(false)
```
#### Quad HD
![Example Quad HD](https://imgur.com/peTeDu1.png)
#### HD 720p
![Example HD](https://imgur.com/of6Gdsk.png)
#### SVGA 800x600
![Example HD](https://imgur.com/CrwaNfe.png)

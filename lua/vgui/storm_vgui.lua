function Storm_AAText( text, font, x, y, color, align )

    draw.SimpleText( text, font, x+1, y+1, Color(0,0,0,math.min(color.a,120)), align )
    draw.SimpleText( text, font, x+2, y+2, Color(0,0,0,math.min(color.a,50)), align )
    draw.SimpleText( text, font, x, y, color, align )

end

local SaveButton = {}

surface.CreateFont( "storm.title", { font = "HudDefault", size = 18, weight = 500, antialias = true } )
surface.CreateFont( "storm.med", { font = "HudDefault", size = 14, weight = 100, antialias = true })
surface.CreateFont( "storm.small", { font = "HudDefault", size = 12, weight = 100, antialias = true })

function SaveButton:Init()
    self:SetText("")
    self.Hover = false
    self.OnCursorEntered = function() self.Hover = true end
    self.OnCursorExited = function() self.Hover = false end
end

function SaveButton:SetButtonText(text)
    self.Text = text
end

function SaveButton:Paint(w,h)
    draw.RoundedBox(0, 0, 0, w, h, Color(0, 140, 0, 255))        

    if self.Hover then
        draw.RoundedBox(0, 2, 2, w-4, h-4, Color(0, 200, 0, 255))
    end
    
    Storm_AAText( self.Text, "storm.title", w/2, 2, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER )
end

vgui.Register("AdminStormSaveButton", SaveButton, "DButton")

local afkframe = {}

function afkframe:Init()
    self:SetTitle( " " )
    self:ShowCloseButton( false )
    self:SetDraggable( false )
    self:SetDeleteOnClose(true)
end

function afkframe:SetFrameName(text)
    self.Text = text
end

function afkframe:Paint(w, h)
    --Derma_DrawBackgroundBlur( self, 0 ) 

    draw.RoundedBox(0, 0, 25, w, h, Color(0, 0, 0, 255))
    draw.RoundedBox(0, 5, 30, w-10, h-35, Color(30, 30, 30, 255))
    draw.RoundedBox(0, 0, 0, w, 25, StormAFK.bannerColor)
    
    Storm_AAText(self.Text, "storm.med", 5, 5, Color(255, 255, 255, 255), TEXT_ALIGN_LEFT)
end

vgui.Register("StormAFKFrame", afkframe, "DFrame")
# gmod-draw-functions
extra drawing functions

- draw.DrawCircle(iPosX = 0, iPosY = 0, iRadius = 100, iVertices = 200, bCache = nil)
  - Draws a filled circle, unlike surface.DrawCircle

- draw.DrawArc(iPosX = 0, iPosY = 0, iRadius = 100, iStartAngle = 0, iEndAngle = 360, bCache = nil)
  - Draws a filled circle with an angle

- draw.DrawProgressBar(iPosX = 0, iPosY = 0, iWidth = 100, iHeight = 100, tColor = Color(255, 255, 255, 255), flRatio = 1, tOutlineCol = Color(20, 20, 20, 100), bOutline = nil)
  - Draws a rectangle progress bar thingy, the width is relative to the ratio

- draw.BouncingText(sText = "", sFont = "DermaLarge", iPosX = 0, iPosY = 0, tColor = Color(255, 255, 255, 255), iHorizAlign = 0, iVertAlign = 0, iAnimHeight = 20, iAnimSpeed = 1)

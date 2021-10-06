# gmod-draw-functions
extra drawing functions
![image](https://user-images.githubusercontent.com/60613196/131150304-2c0f79ac-7f67-4bc6-98ce-62c3003a6cbf.png)


- draw.DrawCircle(iPosX = 0, iPosY = 0, iRadius = 100, iVertices = 200, bCache = nil)
  - Draws a filled circle, unlike surface.DrawCircle

- draw.DrawArc(iPosX = 0, iPosY = 0, iRadius = 100, iStartAngle = 0, iEndAngle = 360, bCache = nil)
  - Draws a filled circle with an angle

- draw.DrawProgressBar(iPosX = 0, iPosY = 0, iWidth = 100, iHeight = 100, tColor = Color(255, 255, 255, 255), flRatio = 1, tOutlineCol = Color(20, 20, 20, 100), bOutline = nil)
  - Draws a rectangle progress bar thingy, the width is relative to the ratio

- draw.BouncingText(sText = "", sFont = "DermaLarge", iPosX = 0, iPosY = 0, tColor = Color(255, 255, 255, 255), iHorizAlign = 0, iVertAlign = 0, iAnimHeight = 20, iAnimSpeed = 1) 
  - Draws bouncing text (mexican wave sorta thing)

- draw.QuadBezier(p0, p1, p2, step = 0.02)
  - Each point should be a Vector2 and the step should be no more than 0.2

- draw.CubicBezier(p0, p1, p2, p3, step = 0.02)
  - Each point should be a Vector2 and the step should be no more than 0.2

- draw.DrawRing(iPosX, iPosY, iRadius, iThickness, iStartAngle, iEndAngle, tCachedMiddle, tCachedRing)
- draw.DrawRing(tCachedMiddle, tCachedRing)
  - The tCachedMiddle is returned by draw.DrawCircle, and the ring is returned by draw.DrawArc, should've probably not named it 'tCachedRing'

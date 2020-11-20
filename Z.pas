program Z;
  uses graphABC;
  const
    H = 480;
    W = 600;
    
    X1 = W div 2;
    Y1 = H div 2;
    
    winColor = clWhite;
    
    RAD = 180 / pi;
  
  procedure Brush
  (
   color: System.Drawing.Color;
   style: System.Drawing.Drawing2D.DashStyle;
   width: integer
  );
  { Sets brush options }
  begin
    SetPenColor(color);
    SetPenStyle(style);
    SetPenWidth(width)
  end;
  
  Procedure Trapezoid
  (
    X, // X-axis of the centre of the base
    Y, // Y-axis of the centre of the base
    { @par optional 1 } top,
    height,
    { @par optional 2 }base,
    outlineWidth: integer;
    { @par optional 2 } angle: real; // equal angles at the base
    firstColor, // outline color
    secondColor: System.Drawing.Color // main color
  );
  {
    Drows isosceles trapezoid by required parameters such as X, Y, height.
    You need push one of the optional parameters such as angle and base or top.
    Push 0 to ignore an optional parameter.
  }
  var
    lX, rX, ToplX, ToprX, TopY, k: integer;
    alfa: real;
    { @var k means distance from edges of the base and top }
    { @var alfa is angle in RAD }
  begin
    
    alfa := angle / RAD;
    TopY := Y - height;
    
    { calculating k using pushed optional parameter }
    if angle = 0 then
      k := (base - top) div 2
    else
    begin
      if angle > 90 then alfa := alfa - pi;
      if round(angle) mod 90 = 0 then k := 0
      else k := round(height / (sin(alfa) / cos(alfa)))
    end;
    
    { 
      Calculating edges of the base using pushed optional parameter.
      If you ignore base it will be equal to 2k.
    }
    if (base = 0) and (angle <= 90) then base := 2*k;
    lX := X - base div 2;
    rX := X + base div 2;
    
    { edges of the top }
    ToplX := lX + k;
    ToprX := rX - k;
    
    Brush(firstColor, psSolid, outlineWidth);
    
    { draws trapezoid }
    line(lX, Y, rX, Y);
    line(lX, Y, ToplX, TopY);
    line(rX, Y, ToprX, TopY);
    line(ToplX, TopY, ToprX, TopY);
    
    FloodFill(X, (Y - height div 2), secondColor);
  end;
  
begin
    SetWindowSize(W, H);
    ClearWindow(winColor);
    
    Trapezoid(X1, Y1, 0, -100, -40, 4, 140, clBlack, clRed);
end.
    

program Z;
  uses graphABC;
  const
    H = 480;
    W = 640;
    
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
    { @par optional } top,
    height,
    base,
    outlineWidth: integer;
    { @par optional } angle: real; // equal angles at the base
    firstColor, // outline color
    secondColor: System.Drawing.Color // main color
  );
  {
    Drows isosceles trapezoid by required parameters such as X, Y, height, base.
    You need push one of the optional parameters such as angle or base.
    Push 0 to ignore an optional parameter.
  }
  var
    lX, rX, ToplX, ToprX, TopY, k: integer;
    { @var k means distance from edges of the base and top }
  begin
    { edges of the base }
    lX := X - base div 2;
    rX := X + base div 2;
    
    TopY := Y - height;
    
    { calculating k using pushed optional parameter }
    if angle = 0 then
      k := (base - top) div 2
    else
      k := round(height / tan(angle / RAD));
    
    
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
    
    Trapezoid(X1, Y1, 150, 100, 100, 4, 0, clBlack, clRed);
end.
    
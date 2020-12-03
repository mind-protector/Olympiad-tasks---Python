program Z;
  uses graphABC;
  const
    H = 480;
    W = 600;
    
    winColor = clWhite;
  
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
  
  procedure Parallelepiped
  (
    X, Y, // Front-bottom-right corner coordinates
    sideX, sideY, sideZ, // The lengths of the sides
    outlineWidth: integer;
    color: System.Drawing.Color
  );
  { Draws a parallelepiped with a 45 degree slant top and left }
  var
    V, Vx, Vy: integer;
  begin
    
    { Devide by 3 to make Y dimension volumetric }
    V := round(sideY / 3);
    
    { Back-bottom-right corner coordinates }
    Vx := X + V;
    Vy := Y - V; 
    
    { The front side of the figure (draws clockwise) }
    Brush(color, psSolid, outlineWidth);
    line(X, Y, (X + sideX), Y);
    line(X, Y, X, (Y - sideZ));
    line(X, (Y - sideZ), (X + sideX), (Y - sideZ));
    line((X + sideX), Y, (X + sideX), (Y - sideZ));
    
    { The invisible sides of the figure (draws clockwise) }
    Brush(color, psDash, outlineWidth);
    line(X, Y, Vx, Vy);
    line(Vx, Vy, Vx, (Vy - sideZ));
    line(Vx, Vy, (Vx + sideX), Vy);
    
    { Finish painting the second square }
    Brush(color, psSolid, outlineWidth);
    line(Vx, (Vy - sideZ), (Vx + sideX), (Vy - sideZ));
    line((Vx + sideX), Vy, (Vx + sideX), (Vy - sideZ));
    
    { Establish a connection between squares to form a parallelepiped }
    line(X, (Y - sideZ), Vx, (Vy - sideZ));
    line((X + sideX), Y, (Vx + sideX), Vy);
    line((X + sideX), (Y - sideZ), (Vx + sideX), (Vy - sideZ));
  end;
  
begin
    SetWindowSize(W, H);
    ClearWindow(winColor);
    
    Parallelepiped(100, 400, 150, 200, 300, 3, clBlack);
end.
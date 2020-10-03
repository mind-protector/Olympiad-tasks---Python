program Domik;
uses graphABC;
  const
    W = 1000;
    H = 800;
    
    winColor = clWhite;
    
    RAD = 180 / pi;
    
  {
    function Hypotenuse(leg1, leg2: integer): integer;
    { @Return hypotenuse length }{
    begin
      Hypotenuse := round(sqrt(sqr(leg1) + sqr(leg2))); // Pythagorean theorem
    end;
  }
  
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
    SetPenWidth(width);
  end;
  
  procedure Triangle
  (
    apexX,
    apexY,
    alfa, // the main angle
    side, //a negative side value reverses the direction of the triangle.
    width: integer;
    firstColor,
    secondColor: System.Drawing.Color
  );
  { Draws an isosceles triangle based on the side length and the main angle }
  begin
    var angle := alfa / 2 / RAD; // a half of the main angle expressed in RAD
    
    { The angle and the hypotenuse are known, you need to find the legs }
    var TrgX := round(side * sin(angle));
    var TrgY := round(side * cos(angle));
    
    Brush(firstColor, psSolid, width);
    Line(apexX, apexY, (apexX - TrgX), (apexY - TrgY));
    Line(apexX, apexY, (apexX + TrgX), (apexY - TrgY));
    Line((apexX - TrgX), (apexY - TrgY), (apexX + TrgX), (apexY - TrgY));
    FloodFill(apexX, (apexY - (TrgY div 2)), secondColor);
  end;
  
  procedure Pine
  (
    pineX,
    pineY,
    height,
    alfa: integer; // the angle of the pine twigs
    firstColor, // the trunk color
    secondColor: System.Drawing.Color // the twigs color
  );
  {
    Draws primitive pine based on height and alfa parameters.
    The principle is to draw a pine tree from top to bottom,
    dividing the height into several SECTIONS:
    
    1. the top triangle
    2. the medium triangle
    3. the large triangle
    4. the trunk
  }
  begin
    var twig: array [0..3] of integer;
    var trunk := round(height * 0.2);
    
    twig[0] := 0; // distance between the top and the current twig apex
    twig[1] := round(height * 0.2);
    twig[2] := round(height * 0.3);
    twig[3] := round(height * 0.3);
    
    for var i := 1 to 3 do
    begin
      Triangle
      (
        pineX,
        (pineY - height + twig[0]), // from top to bottom
        (alfa - 10 + i * 10), // the main angle increases by 10 per iteration
        {
          the leg and the angle (in degrees) are known,
          you need to find the hypotenuse
        }
        -round(twig[i] / cos((alfa - 10 + i * 10) / 2 / RAD)),
        3,
        clBlack,
        secondColor
      );
      twig[0] := twig[0] + twig[i]; // increases by previous twig height
    end;
    
    Brush(firstColor, psSolid, 5);
    Line(pineX, pineY, pineX, (pineY - trunk));
  end;

  procedure Cottage
  (
    Cx,
    Cy,
    height,
    alfa: integer; // the angle of the roof incline (>=90 deg)
    firstColor, // Basement color
    secondColor, // Roof color
    thirdColor, // Outline color
    fourthColor: System.Drawing.Color // Light color
  );
  { ... }
  begin
    
    { main doughts }
    var xC1, xC2, yC, oneThird: integer;
    xC1 := Cx - height div 2;
    xC2 := Cx + height div 2;
    yC := Cy - height;
    oneThird := round(height / 3);
    
    { Draws basement }
    Brush(thirdColor, psSolid, 1);
    Rectangle(xC1, Cy, xC2, yC);
    FloodFill(Cx, (Cy - height div 2), firstColor);
    
    { Draws roof }
    Triangle
    (
      Cx, 
      (Cy - 3 * height div 2), // roofs height
      alfa, 
      -round((height div 2) / cos(alfa / 2 / RAD)), // roofs incline
      1,
      thirdColor,
      secondColor
    );
    
    { Draws door }
    Brush(thirdColor, psSolid, 1);
    Rectangle
    (
      (xC1 + round(oneThird * 2)), // right X + two-thirds of height
      Cy,
      xC2,
      (yC + oneThird) // top Y + one-third of height
    );
    FloodFill((xC2 - oneThird div 2), (Cy - height div 2), thirdColor);
    
    { Draws window }
    Brush(thirdColor, psSolid, 1);
    Rectangle
    (
      { window side is equal to one-third of basement side }
      (xC1 + oneThird - oneThird div 2),
      (Cy - oneThird),
      (xC1 + oneThird + oneThird div 2),
      (yC + oneThird)
    );
    FloodFill
    (
      (xC1 + oneThird),
      (Cy - oneThird - oneThird div 2),
      fourthColor
    );
    Brush(thirdColor, psSolid, 3);
    Line // horizontal rod
    (
      (xC1 + oneThird - oneThird div 2),
      (Cy - oneThird - oneThird div 2),
      (xC1 + oneThird + oneThird div 2),
      (Cy - oneThird - oneThird div 2)
    );
    Line //vertical rod
    (
      (xC1 + oneThird),
      (Cy - oneThird),
      (xC1 + oneThird),
      (Cy - oneThird - oneThird div 2)
    );
  end;
begin
  SetWindowSize(W, H);
  ClearWindow(winColor);
  
 Pine((W div 5), (H - H div 8), (H div 2), 70, clBrown, clGreen);
 Cottage
  (
    (W div 2), (H div 2), (H div 3), 115,
    clTeal, clMaroon, clBrown, clYellow
  );
  Cottage((W - W div 3), H, (H div 4), 115, clTeal, clMaroon, clBrown, clYellow);
end.

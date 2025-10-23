program SalvaPantallasFuegosArtificiales;

uses
  CRT, Graph, Dos;

const
  MaxParticulas = 500;
  TamanoParticula = 3;

type
  TParticula = record
    posicion_x, posicion_y: Integer;
    velocidad_x, velocidad_y: Integer;
    color: Integer;
    activa: Boolean;
    edad: Integer;
    esCohete: Boolean;
  end;

var
  RutaAlControlador: string;
  gd, gm: smallInt;
  i: Integer;
  particulas: array[1..MaxParticulas] of TParticula;
  angulo, velocidad: Real;

procedure LanzarFuegoArtificial;
var
  i: Integer;

begin
  for i := 1 to MaxParticulas do
  begin
    if not particulas[i].activa then
    begin
      particulas[i].posicion_x := Random(GetMaxX - 50) + 25;
      particulas[i].posicion_y := GetMaxY;
      particulas[i].activa := True;
      particulas[i].edad := 0;
      particulas[i].esCohete := True;

      particulas[i].velocidad_y := -15 - Random(5);
      particulas[i].velocidad_x := -5 + Random(10);

      particulas[i].color := Random(15) + 1;

      Sound(440);
      Break;
    end;
  end;
end;

procedure Explotar(centro_x, centro_y: Integer; colorBase: Integer);
var
  i: Integer;
begin
  for i := 1 to MaxParticulas do
  begin
    if not particulas[i].activa then
    begin
      particulas[i].posicion_x := centro_x;
      particulas[i].posicion_y := centro_y;

      angulo := Random(360) * pi / 180;
      velocidad := Random(8) + 1;
      particulas[i].velocidad_x := Round(cos(angulo) * velocidad);
      particulas[i].velocidad_y := Round(sin(angulo) * velocidad);

      particulas[i].color := colorBase;
      particulas[i].activa := True;
      particulas[i].edad := 0;
      particulas[i].esCohete := False;


    end;
  end;
end;

begin
  RutaAlControlador := 'c:\BGI';
  gd := Detect;
  gm := 0;
  InitGraph(gd, gm, 'c:\BGI');

  if GraphResult <> grOk then
  begin
    writeln('Error al iniciar el modo grafico.');
    halt;
  end;

  for i := 1 to MaxParticulas do
    particulas[i].activa := False;

  Randomize;

  repeat
    SetColor(1);
    SetFillStyle(1, 0);
    Bar(0, 0, GetMaxX, GetMaxY);

    if Random(10) = 0 then
      LanzarFuegoArtificial;

    for i := 1 to MaxParticulas do
    begin
      if particulas[i].activa then
      begin
        particulas[i].posicion_x := particulas[i].posicion_x + particulas[i].velocidad_x;
        particulas[i].posicion_y := particulas[i].posicion_y + particulas[i].velocidad_y;

        SetColor(particulas[i].color);
        SetFillStyle(1, particulas[i].color);
        Bar(particulas[i].posicion_x, particulas[i].posicion_y,
            particulas[i].posicion_x + TamanoParticula, particulas[i].posicion_y + TamanoParticula);

        particulas[i].edad := particulas[i].edad + 1;
        if particulas[i].esCohete and (particulas[i].edad > 15) and (particulas[i].posicion_y < GetMaxY div 2) then

        begin
          Explotar(particulas[i].posicion_x, particulas[i].posicion_y, particulas[i].color);
          particulas[i].activa := False;
        end;
        if (particulas[i].edad > 30) and not particulas[i].esCohete then
          particulas[i].activa := False;

        if (particulas[i].posicion_x < 0) or (particulas[i].posicion_x > GetMaxX) or (particulas[i].posicion_y < 0) or (particulas[i].posicion_y > GetMaxY) then
          particulas[i].activa := False;
      end;
    end;

    Delay(15);

  until Keypressed;

  CloseGraph;
end.
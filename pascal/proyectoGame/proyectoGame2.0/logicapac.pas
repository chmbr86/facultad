unit logicaPac;

interface

uses
    Crt,
    sysutils,
    Graph;

type
    TCelda = (vacio, muro, pac, fruta, fantasma,fantasmap1,fantasmap2);
    TMatriz = array[1..11, 1..20] of TCelda;
    TMuro = record
        x0, y0, x1, y1: integer;
    end;
    //estructura para la posición del fantasma
       TFantasma = record
        Fila, Columna: integer;
        Color: integer; // Para dibujarlo de diferente color
        Tipo: TCelda; // Para identificarlo en el mapa (fantasma, fantasma2, fantasma3)
        UltimoContenido: TCelda; // Qué había debajo (vacio o fruta)
    end;

const 
    Filas = 11;
    Columnas = 20;
    TamanoCelda = 30;
    CantMuros = 27;
    Muros: array[1..CantMuros] of TMuro = (
        (x0:1 ; y0:1 ; x1:1 ; y1:20), //Pared Externa
        (x0:1 ; y0:1 ; x1:11 ; y1:1), //Pared Externa
        (x0:1 ; y0:20 ; x1:11 ; y1:20), //Pared Externa
        (x0:11 ; y0:1 ; x1:11 ; y1:20), //Pared Externa

        (x0:2 ; y0:6 ; x1:3 ; y1:6), //Pared Interna vertical izquierda arriba
        (x0:2 ; y0:15 ; x1:3 ; y1:15), //Pared Interna vertical derecha arriba
        (x0:3 ; y0:8 ; x1:3 ; y1:13), //Pared Interna horizontal arriba
        (x0:9 ; y0:6 ; x1:10 ; y1:6), //Pared Interna vertical izquierda abajo
        (x0:9 ; y0:15 ; x1:10 ; y1:15), //Pared Interna vertical derecha abajo
        (x0:9 ; y0:8 ; x1:9 ; y1:13), //Pared Interna horizontal abajo

        (x0:5 ; y0:5 ; x1:5 ; y1:6), //Columna izq top 
        (x0:5 ; y0:15 ; x1:5 ; y1:16), //Columna der top
        (x0:7 ; y0:5 ; x1:7 ; y1:6), //Columna izq bot
        (x0:7 ; y0:15 ; x1:7 ; y1:16), //Columna der bot

        (x0:3 ; y0:3 ; x1:3 ; y1:4), //Pared L invertida izq
        (x0:4 ; y0:3 ; x1:5 ; y1:3),

        (x0:3 ; y0:17 ; x1:3 ; y1:18), //Pared L invertida der
        (x0:4 ; y0:18 ; x1:5 ; y1:18), 

        (x0:7 ; y0:3 ; x1:8 ; y1:3), //Pared l Izq
        (x0:9 ; y0:3 ; x1:9 ; y1:4),

        (x0:7 ; y0:18 ; x1:8 ; y1:18), //Pared l Der
        (x0:9 ; y0:17 ; x1:9 ; y1:18),

        (x0:5 ; y0:8 ; x1:5 ; y1:9), //Pared Interna
        (x0:5 ; y0:12 ; x1:5 ; y1:13),
        (x0:6 ; y0:8 ; x1:7 ; y1:8),
        (x0:6 ; y0:13 ; x1:7 ; y1:13),
        (x0:7 ; y0:9 ; x1:7 ; y1:12)
        
        
    );

var
    MargenX, MargenY: integer;
    Mapa: TMatriz;
    PacmanVivo: boolean;
    Fantasma1, Fantasma2,Fantasma3: TFantasma;

procedure InicializarMapa;
procedure CargaMuros;
procedure CargaFrutasYPacman;
procedure DibujarMapa;
procedure DibujarPacman;
//procedure MostrarMapa;
procedure MoverPacman;
{procedure CargaFantasma;
procedure DibujarFantasma;}
{procedure MoverFantasma; // movimiento del fantasma
procedure VerificarColision; // Detección de colisión
procedure MostrarMensajeMuerte;} //  Mensaje de fin de juego
function condicionVictoria: boolean;
procedure mostrarMensajeVictoria;


{procedure CargarFantasma(var F: TFantasma; TipoCelda: TCelda; FilaIni, ColIni, ColorFant: integer);
procedure DibujarUnFantasma(const F: TFantasma);
procedure MoverUnFantasma(var F: TFantasma);
procedure VerificarColisionFantasma(const F: TFantasma);
procedure LimpiarCeldaEspecifica(Fila, Col: integer);}


implementation    

    procedure DibujarMuros;
    var k, i, j, x, y: integer;
    begin
    for k := 1 to CantMuros do
        for i:= 1 to Filas do
            for j:= 1 to Columnas do
                if Mapa[i,j] = muro then
                    begin
                        x := MargenX + (j - 1) * TamanoCelda;
                        y := MargenY + (i - 1) * TamanoCelda;
                        setfillstyle(solidfill, blue);
                        bar(x+1, y+1, x + TamanoCelda - 1, y + TamanoCelda - 1);
                        setcolor(black);
                        rectangle(x, y, x + TamanoCelda, y + TamanoCelda);
                    end;
    end;

    Procedure DibujarFrutas;
    var i, j, x, y : integer;
    begin 
        for i:= 1 to Filas do
            for j := 1 to Columnas do
                if Mapa[i,j] = fruta then
                    begin
                        x := MargenX + (j - 1) * TamanoCelda;
                        y := MargenY + (i - 1) * TamanoCelda;
                        setfillstyle(solidfill, red);
                        fillellipse(x + (TamanoCelda) div 2, y + (TamanoCelda) div 2, (TamanoCelda+15) div 6, (TamanoCelda+15) div 6);
                    end;
    end;

    procedure DibujarMapa;

    begin
        ClearDevice;

        MargenX := (GetMaxX - (Columnas * TamanoCelda)) div 2;
        MargenY := (GetMaxY - (Filas * TamanoCelda)) div 2;

        DibujarMuros;
        DibujarFrutas;
        DibujarPacman;
        {DibujarFantasma;}
        
    end;

    procedure InicializarMapa;
    var i, j: integer;

    begin //Posicion inicial Pacman
        for i := 1 to Filas do
            for j := 1 to Columnas do
                Mapa[i, j] := vacio;
    end;
    
    procedure CargaMuros;
    var k, i, j: integer;
        begin
        for k := 1 to CantMuros do
            for i := Muros[k].x0 to Muros[k].x1 do
                for j := Muros[k].y0 to Muros[k].y1 do
                    Mapa[i, j] := muro;
        end;
    procedure CargaFrutasYPacman; 

    var i, j : integer;
    begin
    randomize;
        for i := 1 to Filas do
            for j := 1 to Columnas do
                if (Mapa[i,j] = vacio) and (random(100) < 99) then
                    begin
                        Mapa[i,j] := fruta;
                    end;
                    mapa[6, 10] := pac;
                    {CargaFantasma;}
    end;

    procedure DibujarPacman;
    var i,j, x, y : integer;
        begin
        for i := 1 to Filas do
            for j := 1 to Columnas do
                if Mapa[i,j] = pac then
                    begin             
                        x := MargenX + (j - 1) * TamanoCelda;
                        y := MargenY + (i - 1) * TamanoCelda;
                        setfillstyle(solidfill, yellow);
                        fillellipse(x + (TamanoCelda) div 2, y + (TamanoCelda) div 2, (TamanoCelda+20) div 4, (TamanoCelda+20) div 4);
                    end;
        end;

    { ...existing code... }

    {procedure MostrarMapa;
    var i, j: integer;
        k: string;
    
    begin 
        for i := 1 to Filas do
        begin
            k:='fila ' + inttostr(i) + ': ';
            for j := 1 to Columnas do
                begin
                    case Mapa[i, j] of
                        vacio: k:=k+ '. ';
                        muro: k:=k+ '# ';
                        fruta: k:=k+ 'o ';
                        pac: k:=k+ 'P ';
                    end;
                end;
            writeln(k);
        end;
    end;}

    procedure limpiarCelda;
    var i, j, x, y: integer;
        begin
            for i:= 1 to Filas do
                for j:= 1 to Columnas do
                    if Mapa[i,j] = vacio then
                        begin
                            x := MargenX + (j - 1) * TamanoCelda;
                            y := MargenY + (i - 1) * TamanoCelda;
                            setfillstyle(solidfill, black);
                            bar(x+1, y+1, x + TamanoCelda - 1, y + TamanoCelda - 1);
                            setcolor(black);
                            rectangle(x, y, x + TamanoCelda, y + TamanoCelda);
                        end;
        end;

    procedure dibujarCelda;
    var i, j, x, y : integer;
    begin
        for i:= 1 to Filas do
            for j := 1 to Columnas do
                if Mapa[i,j] = pac then
                    begin             
                        x := MargenX + (j - 1) * TamanoCelda;
                        y := MargenY + (i - 1) * TamanoCelda;
                        setfillstyle(solidfill, yellow);
                        fillellipse(x + (TamanoCelda) div 2, y + (TamanoCelda) div 2, (TamanoCelda+20) div 4, (TamanoCelda+20) div 4);
                    end;    
    end;
    procedure moverArriba;
var i, j: integer;
begin
    for i := 1 to Filas do
        for j := 1 to Columnas do
            if Mapa[i,j] = pac then
                begin
                if (i > 1) and (Mapa[i-1,j] <> muro) then // Agregada comprobación de límites (i > 1)
                    begin
                        Mapa[i,j] := vacio;
                        Mapa[i-1,j] := pac;
                         LimpiarCelda;
                       {LimpiarCeldaEspecifica(i, j); }
                       dibujarCelda;
                    end;
                end;
end;

    procedure moverAbajo;
    var i, j: integer;
    begin       
        for i := Filas downto 1 do
            for j := Columnas downto 1 do
                if Mapa[i,j] = pac then
                    begin
                    if Mapa[i+1,j] <> muro then
                        begin
                            Mapa[i,j] := vacio;
                            Mapa[i+1,j] := pac;
                                LimpiarCelda;
                               {LimpiarCeldaEspecifica(i, j);} // Limpia solo la celda anterior
                               dibujarCelda;
                        end;
                    end;
    end;
    procedure moverIzquierda;
    var i, j: integer;  
    begin     
        for i := 1 to Filas do
            for j := 1 to Columnas do
                if Mapa[i,j] = pac then
                    begin
                    if (i<Filas) and (Mapa[i,j-1] <> muro) then
                        begin
                            Mapa[i,j] := vacio;
                            Mapa[i,j-1] := pac;
                                 LimpiarCelda;
                               {LimpiarCeldaEspecifica(i, j);}
                               dibujarCelda;
                        end;
                    end;
    end;
    procedure moverDerecha;
    var i, j: integer;
    begin
        for i := Filas downto 1 do
            for j := Columnas downto 1 do
                if Mapa[i,j] = pac then
                    begin
                    if (j<Columnas) and (Mapa[i,j+1] <> muro) then
                        begin
                            Mapa[i,j] := vacio;
                            Mapa[i,j+1] := pac;
                             LimpiarCelda;
                            {LimpiarCeldaEspecifica(i, j); }
                            dibujarCelda;

                        end;
                    end;
    end;

    function condicionVictoria:boolean;

    var i, j :integer;
        resultado: boolean;
    

    begin
    resultado := true;
    for i:= 1 to Filas do
        for j:= 1 to Columnas do
            if Mapa[i,j] = fruta then
                resultado := false;

    condicionVictoria := resultado;
    end;

    procedure mostrarMensajeVictoria;
    var xCentro, yCentro: integer;
        condicionWin: boolean;
    begin
        condicionWin := condicionVictoria;
    if condicionWin then
        begin
            InicializarMapa;
            DibujarMapa;
            xCentro := GetMaxX div 2;
            yCentro := GetMaxY div 2;
            settextstyle(defaultfont, horizdir, 5);
            setcolor(green);
            outtextxy(xCentro - 100, yCentro, '¡Victoria!');
        end;
    end;

    Procedure MoverPacman;
var
    tecla, sc: char;
begin
    repeat
        tecla := readkey;

        // Movimiento de Pacman
       { if PacmanVivo then }
        //begin
            // (Código de lectura de teclas... llama a moverArriba/Abajo/Izquierda/Derecha)
            if tecla = #0 then
            begin
                sc := readkey;
                case sc of
                    #72: moverArriba;
                    #80: moverAbajo;
                    #75: moverIzquierda;
                    #77: moverDerecha;
                end;
            end
            else
            begin
                case UpCase(tecla) of
                    'W': moverArriba;
                    'S': moverAbajo;
                    'A': moverIzquierda;
                    'D': moverDerecha;
                end;
            end;

            // Movimiento del Fantasma y Colisión
           { if PacmanVivo and (not CondicionVictoria) then
            begin
                {MoverFantasma; // Mueve a los 3 fantasmas
                VerificarColision; // Verifica si alguno chocó con Pacman}
            end; }

            // Verificación de Victoria
            if condicionVictoria then mostrarMensajeVictoria;
        //end;

    until (tecla = #27) {or (not PacmanVivo)} or condicionVictoria;
end;

{ procedure DibujarFantasma;
 begin
     // Dibuja los tres fantasmas
     DibujarUnFantasma(Fantasma1);
     DibujarUnFantasma(Fantasma2);
     DibujarUnFantasma(Fantasma3);
 end;
 procedure DibujarUnFantasma(const F: TFantasma);
var x, y: integer;
begin
    setfillstyle(solidfill, F.Color);
    x := MargenX + (F.Columna - 1) * TamanoCelda;
    y := MargenY + (F.Fila - 1) * TamanoCelda;

    // Cuerpo simple para el fantasma
    bar(x + 5, y + 5, x + TamanoCelda - 5, y + TamanoCelda - 5);
end;

 procedure MoverUnFantasma(var F: TFantasma);
var
    NuevaFila, NuevaColumna: integer;
    MovimientoValido: boolean;
    Direccion: integer;
begin
    // Restaurar contenido de la celda anterior (vacio o fruta)
    LimpiarCeldaEspecifica(F.Fila, F.Columna);
    Mapa[F.Fila, F.Columna] := F.UltimoContenido;

    MovimientoValido := false;

    repeat
        Direccion := Random(4) + 1; // 1=Arriba, 2=Abajo, 3=Izquierda, 4=Derecha
        NuevaFila := F.Fila;
        NuevaColumna := F.Columna;

        case Direccion of
            1: NuevaFila := F.Fila - 1;
            2: NuevaFila := F.Fila + 1;
            3: NuevaColumna := F.Columna - 1;
            4: NuevaColumna := F.Columna + 1;
        end;

        // Verificar límites ANTES de acceder al mapa
        if (NuevaFila >= 1) and (NuevaFila <= Filas) and
           (NuevaColumna >= 1) and (NuevaColumna <= Columnas) then
        begin
            // Solo se mueve si no es un muro y no es otro fantasma
            if (Mapa[NuevaFila, NuevaColumna] <> muro) and
               (Mapa[NuevaFila, NuevaColumna] <> fantasma) and
               (Mapa[NuevaFila, NuevaColumna] <> fantasmap1) and
               (Mapa[NuevaFila, NuevaColumna] <> fantasmap2) then
            begin
                 MovimientoValido := true;
            end;
        end;

    until MovimientoValido;

    // Actualiza posición y guarda el nuevo contenido
    F.UltimoContenido := Mapa[NuevaFila, NuevaColumna];
    F.Fila := NuevaFila;
    F.Columna := NuevaColumna;
    Mapa[F.Fila, F.Columna] := F.Tipo;

    // Dibuja el fantasma en su nueva posición
    DibujarUnFantasma(F);
end;

procedure MoverFantasma;
begin
    // Mueve cada fantasma
    MoverUnFantasma(Fantasma1);
    MoverUnFantasma(Fantasma2);
    MoverUnFantasma(Fantasma3);
end;
 procedure VerificarColisionFantasma(const F: TFantasma);
var i, j: integer;
begin
    // Buscamos la posición de Pacman (ya que puede haberse movido)
    for i := 1 to Filas do
        for j := 1 to Columnas do
            if Mapa[i, j] = pac then
            begin
                // Si la posición de Pacman coincide con la posición del fantasma
                if (i = F.Fila) and (j = F.Columna) then
                begin
                    PacmanVivo := false;
                    MostrarMensajeMuerte;
                    exit;
                end;
            end;
end;

 procedure VerificarColision;
 begin
     // Verificar Fantasma 1
     VerificarColisionFantasma(Fantasma1);

     // Si Pacman sigue vivo, verifica el siguiente fantasma
     if PacmanVivo then
     begin
         //Verificar Fantasma 2
         VerificarColisionFantasma(Fantasma2);

         // Si Pacman sigue vivo, verifica el último fantasma
         if PacmanVivo then
         begin
             // Verificar Fantasma 3
             VerificarColisionFantasma(Fantasma3);
         end;
     end;
 end;

 procedure MostrarMensajeMuerte;
var xCentro, yCentro: integer;
begin
    ClearDevice;
    PacmanVivo := False;
    xCentro := GetMaxX div 2;
    yCentro := GetMaxY div 2;
    settextstyle(defaultfont, horizdir, 5);
    setcolor(red);
    OutTextXY(xCentro - (TextWidth('GAME OVER') div 2), yCentro, 'GAME OVER');
    Readkey; // Espera una tecla para que el usuario vea el mensaje
end;
 procedure LimpiarCeldaEspecifica(Fila, Col: integer);
var x, y: integer;
begin
    x := MargenX + (Col - 1) * TamanoCelda;
    y := MargenY + (Fila - 1) * TamanoCelda;
    setfillstyle(solidfill, black);
    bar(x+1, y+1, x + TamanoCelda - 1, y + TamanoCelda - 1);
end;
 procedure CargarFantasma(var F: TFantasma; TipoCelda: TCelda; FilaIni, ColIni, ColorFant: integer);
begin
    F.Fila := FilaIni;
    F.Columna := ColIni;
    F.Color := ColorFant;
    F.Tipo := TipoCelda;
    // Asume que la posición inicial es Vacío (o Fruta, que se guarda)
    F.UltimoContenido := Mapa[FilaIni, ColIni];
    Mapa[F.Fila, F.Columna] := TipoCelda;
end;

procedure CargaFantasma;
begin
    // Fantasma 1 (Green)
    CargarFantasma(Fantasma1, fantasma, 2, 10, green);

    // Fantasma 2 (Cyan)
    CargarFantasma(Fantasma2, fantasmap1, 8, 16, cyan);

    // Fantasma 3 (Magenta)
    CargarFantasma(Fantasma3, fantasmap2, 4, 2, magenta);

    // Asegurar que la posición inicial del Pac-Man no sea un fantasma ni un muro
    Mapa[6, 10] := pac;
end;}
end.



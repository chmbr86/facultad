unit logicaPac;

interface

uses
    Crt,
    sysutils,
    Graph;

type
    TCelda = (vacio, muro, pac, fruta);
    TMatriz = array[1..11, 1..20] of TCelda;
    TMuro = record
        x0, y0, x1, y1: integer;
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



procedure InicializarMapa;
procedure CargaMuros;
procedure CargaFrutasYPacman;
procedure DibujarMapa;
procedure DibujarPacman;
//procedure MostrarMapa;
procedure MoverPacman;
function condicionVictoria: boolean;
procedure mostrarMensajeVictoria;
//procedure Menu;


implementation    

    procedure DibujarMuros;
    var k, i, j, x, y: integer;
    begin
    for k := 1 to CantMuros do
        {for i := Muros[k].x0 to Muros[k].x1 do
            for j := Muros[k].y0 to Muros[k].y1 do}
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
                    if Mapa[i-1,j] <> muro then
                        begin
                            Mapa[i,j] := vacio;
                            Mapa[i-1,j] := pac;
                                limpiarCelda;
                                dibujarCelda;
                        end;
                    end;
        condicionVictoria; 
        mostrarMensajeVictoria;
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
                                limpiarCelda;
                                dibujarCelda;
                        end;
                    end;
        condicionVictoria; 
        mostrarMensajeVictoria;
    end;
    procedure moverIzquierda;
    var i, j: integer;  
    begin     
        for i := 1 to Filas do
            for j := 1 to Columnas do
                if Mapa[i,j] = pac then
                    begin
                    if Mapa[i,j-1] <> muro then
                        begin
                            Mapa[i,j] := vacio;
                            Mapa[i,j-1] := pac;
                                limpiarCelda;
                                dibujarCelda;
                        end;
                    end;  
        condicionVictoria; 
        mostrarMensajeVictoria;
    end;
    procedure moverDerecha;
    var i, j: integer;
    begin
        for i := Filas downto 1 do
            for j := Columnas downto 1 do
                if Mapa[i,j] = pac then
                    begin
                    if Mapa[i,j+1] <> muro then
                        begin
                            Mapa[i,j] := vacio;
                            Mapa[i,j+1] := pac;
                                limpiarCelda;
                                dibujarCelda;

                        end;
                    end;
        condicionVictoria; 
        mostrarMensajeVictoria;
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
        if tecla = #0 then // Teclas Especiales (flechas)
            begin
                sc := readkey;
                case sc of
                // Flecha Arriba
                #72: moverArriba; 

                // Flecha Abajo
                #80: moverAbajo; 

                // Flecha Izquierda
                #75: moverIzquierda; 

                // Flecha Derecha
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
        // Hasta tecla Esc
    until tecla = #27;
    end;




   // procedure Menu;
    //falta hacer menu


end.



program temp;

{units usadas}
uses Crt, Graph;

{Definicion de variables, constantes y tipos}
const 
    n = 7;
type    
    T_dato = real;
    T_vector = array[1..n] of T_dato;
var
    v : T_vector;
    opcion : integer ;
    gd, gm, x, y : integer;
{Definicion de procedimientos}


{procedure CargaTemp(x:integer)
} 
{Incio del programa}
begin
    gd := Detect;
    InitGraph(gd, gm, '');

    if GraphResult <> grOk then halt(1);

    x := GetMaxX div 2;
    y := GetMaxY div 2;
    
    setcolor(red);
    setfillstyle(solidfill, cyan); 
    bar(x-100, y-80, x+100, y+80);
    rectangle(x-100, y-80, x+100, y+80);
    setcolor(15);
    outtextxy(x-80, y-60, '1. Cargar');
    outtextxy(x-80, y-40, '2. Listar');
    outtextxy(x-80, y-20, '3. Promedio');
    outtextxy(x-80, y+0,  '4. Marca Minima');
    outtextxy(x-80, y+20, '5. Marca Minima Maxima');
    outtextxy(x-80, y+40, '0. Salir');
    
    
end.


program prCola;
uses
    Crt,
    colaCir;

var 
    Q: t_cola;
    D: t_dato;
    OP:[0..2];

procedure Muestrar_Todo(var Q: t_cola);
    var
        x: t_dato;
    begin
        while not cola_vacia(Q) do
        begin
            desencolar(Q, x);
            writeln('Nombre: ', x.nom, ' - Telefono: ', x.tel);
        end;
        WriteLn('Informacion mostrada');
        readkey;
    end;

Procedure Mostrar_Cola(Var q:t_cola);
    begin
        
    end;

begin
    crearcola(q);
    repeat
    clrscr;
    writeln(1-'Cargar');
    writeln(2-'Mostrar');
    writeln(0-'Salir');
    writeln('Ingrese Opcion: ');
    readln(OP);
    case OP of
        1: Cargar_Todo(Q);
        2: Muestrar_Todo(Q);
    until OP=0;

    end;    
end.
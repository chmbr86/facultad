unit cola;

interface

const
    n = 4;

type
    t_dato = record
        nom: string[40];
        tel: string[15];
    end;

    t_cola = record
        frente, final: byte;
        elem: array[1..n] of t_dato;
        tam: byte;
    end;

procedure crearcola(var q: t_cola);
procedure encolar(var q: t_cola; x: t_dato);
function cola_llena(var q: t_cola): boolean;
function cola_vacia(var q: t_cola): boolean;
procedure desencolar(var q: t_cola; var x: t_dato);
function tamano(var q: t_cola): byte;

implementation

procedure crearcola(var q: t_cola);
    begin
        q.tam := 0;
        q.frente := 1;
        q.final := 0;
    end;

procedure encolar(var q: t_cola; x: t_dato);
    begin
        q.final := q.final + 1;
        q.elem[q.final] := x;
        inc(q.tam);
    end;

function cola_llena(var q: t_cola): boolean;
    begin
        cola_llena := (q.frente = 1) and (q.final = n); // q.tam = n
    end;

function cola_vacia(var q: t_cola): boolean;
    begin
        cola_vacia := q.frente > q.final; // q.tam = 0
    end;

procedure desencolar(var q: t_cola; var x: t_dato);
    begin
        x := q.elem[q.frente];
        q.frente := q.frente + 1;
        dec(q.tam);
    end;

function tamano(var q: t_cola): byte;
    begin
        tamano := q.tam;
    end;

end.

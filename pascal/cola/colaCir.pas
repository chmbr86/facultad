unit colacir;

interface

const
    n = 10;

type
    t_dato = record
        nom: string[40];
        tel: string[15];
    end;

    t_cola = record
        frente, final: word;
        elem: array[1..n] of t_dato;
        tam: word;
    end;

procedure crearcola(var q: t_cola);
procedure encolar(var q: t_cola; x: t_dato);
function cola_llena(var q: t_cola): boolean;
function cola_vacia(var q: t_cola): boolean;
procedure desencolar(var q: t_cola; var x: t_dato);

implementation

procedure crearcola(var q: t_cola);
    begin
        q.tam := 0;
        q.frente := 1;
        q.final := n;
    end;

procedure encolar(var q: t_cola; x: t_dato);
    begin
        if q.final = n then
            q.final := 1
        else
            q.final := q.final + 1;
        q.elem[q.final] := x;
        inc(q.tam);
    end;

function cola_llena(var q: t_cola): boolean;
    begin
        cola_llena := q.tam = n;
    end;

function cola_vacia(var q: t_cola): boolean;
    begin
        cola_vacia := q.tam = 0;
    end;

procedure desencolar(var q: t_cola; var x: t_dato);
    begin
        x := q.elem[q.frente];
        if q.frente = n then
            q.frente := 1
        else
            q.frente := q.frente + 1;
        dec(q.tam);
    end;

end.
program numeroPrimo;
var

    numero: integer;

function esPrimo(valor: integer): boolean;

var
    divisor: integer;

begin

    if (valor <= 1) then
        esPrimo := false
    else
        begin
            esPrimo := true;
            for divisor := 2 to valor div 2 do
            if (valor mod divisor = 0) then
            esPrimo := false;
        end;

end;

begin

    writeln('Ingrese un numero entero positivo:');
    readln(numero);

    if esPrimo(numero) then
        writeln('El numero ', numero, ' es primo')
    else
        writeln('El numero ', numero, ' no es primo');

end.
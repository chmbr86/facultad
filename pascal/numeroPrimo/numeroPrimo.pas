program numeroPrimo;
var
    numero1 : integer;

function esPrimo(numero1:integer):string;
    begin
        if (numero1 <= 1) then
                esPrimo := 'no es primo'
        
        else
            begin
                if (num1 mod num1 = 0) then
                    begin
                        esPrimo := 'es primo';
                    end;
                else
                    esPrimo := 'no es primo'
            end; 
    end;

begin
    writeln('ingrese un numero entero positivo');
    readln(numero1);
    writeln('el numero ', numero1,' ', esPrimo(numero1));
    

end.
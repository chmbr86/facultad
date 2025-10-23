program bucleWhile;
var
    i, num1 : integer;
begin
    i:=0;
    writeln('ingrese un numero para comenzar a contar');
    readln(num1);
    
    while i < 10 do
    begin
        i := i + num1;
        writeln(i);
    end
end.
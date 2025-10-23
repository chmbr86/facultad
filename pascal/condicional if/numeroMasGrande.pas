program numeroMasGrande;
var
    num1 : integer;
    num2 : integer;
    num3 : integer;
begin
    writeln('Este programa te pedira 3 numeros y seleccionara el mas grande');
    writeln('Ingrese el numero 1');
    readln(num1);
    writeln('Ingrese el numero 2');
    readln(num2);
    writeln('Ingrese el numero 3');
    readln(num3);
    if (num1>num2) then
        begin
        if (num1>num3) then
            writeln('El numero mas grande es: ', num1)   
        else
            writeln('El numero mas grande es: ', num3);
        end
    else
    begin
    if(num2>num3)then
        writeln('El numero mas grande es: ', num2)
    else 
        writeln('El numero mas grande es: ', num3);
    end
end. 
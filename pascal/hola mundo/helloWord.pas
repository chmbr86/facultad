program sumaNumeros;
var 
  num1 : integer;
  num2 : integer;
begin
  writeln('ingrese un numero: ');
  readln(num1);
  writeln('ingrese otro numero: ');
  readln(num2);
  
  if num2<>0 then
  begin
    writeln('el cociente de la division es : ', num1 div num2);
    writeln('el resto de la division es : ', num1 mod num2);
  end
  else
    writeln('No se puden realizar divisiones donde el divisor sea 0');

end.
program ej1;
var 
  articulos: array[1..100] of integer;
  
  i: integer;
begin
    i:=0;
    randomize; 

    while i < 100 do
    begin
        i:=i+1;
        articulos[i] := random(1000) + 1; 
        writeln('el articulo: ' , i , ' tiene un precio de: ' , articulos[i] , ' y el precio con iva es: ' , articulos[i]*1.21:0:2);
    end; 
end.

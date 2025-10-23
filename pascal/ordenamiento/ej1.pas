program ordenar_notas;
var
  notas: array[1..10] of integer;
  i, j, temp: integer;
begin
  // Cargar el vector con notas
  writeln('Ingrese 10 notas:');
  for i := 1 to 10 do
  begin
    write('Nota ', i, ': ');
    readln(notas[i]);
  end;

  // Ordenar el vector en forma ascendente (método burbuja)
  for i := 1 to 9 do
    for j := i+1 to 10 do
      if notas[i] > notas[j] then
      begin
        temp := notas[i];
        notas[i] := notas[j];
        notas[j] := temp;
      end;

  // Listar el vector ordenado
  writeln('Notas ordenadas en forma ascendente:');
  for i := 1 to 10 do
    writeln(notas[i]);
end.
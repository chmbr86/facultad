program NotasAlumnos;
uses crt;
var
	notas: array[1..1000] of real;
	n, i, alumno: integer;
	suma, promedio, nuevaNota: real;
	opcion: char;
begin
	clrscr;
	write('Ingrese la cantidad de alumnos: ');
	readln(n);
	for i := 1 to n do
	begin
		write('Ingrese la nota del alumno ', i, ': ');
		readln(notas[i]);
	end;
	suma := 0;
	for i := 1 to n do
		suma := suma + notas[i];
	promedio := suma / n;
	writeln('El promedio de las notas es: ', promedio:0:2);
	writeln;
	write('¿Desea modificar la nota de un alumno? (s/n): ');
	readln(opcion);
	while (opcion = 's') or (opcion = 'S') do
	begin
		write('Ingrese el número de alumno a modificar (1-', n, '): ');
		readln(alumno);
		if (alumno >= 1) and (alumno <= n) then
		begin
			write('Nota actual: ', notas[alumno]:0:2, '. Ingrese la nueva nota: ');
			readln(nuevaNota);
			notas[alumno] := nuevaNota;
			suma := 0;
			for i := 1 to n do
				suma := suma + notas[i];
			promedio := suma / n;
			writeln('El promedio actualizado es: ', promedio:0:2);
		end
		else
			writeln('Número de alumno inválido.');
		writeln;
		write('¿Desea modificar otra nota? (s/n): ');
		readln(opcion);
	end;
	writeln('Programa finalizado.');
	readln;
end.

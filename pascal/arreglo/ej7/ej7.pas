program ej7;
uses SysUtils;
var
	cad: string;
begin
	write('Ingrese una cadena: ');
	readln(cad);

	cad := UpperCase(cad);

	writeln('Cadena en mayúsculas:');
	writeln(cad);
end.

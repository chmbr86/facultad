program esDni;

uses SysUtils;

var 
    entrada: string;
    dni: longint;

function EsNumero(cad: string): boolean;
var
    i: integer;
begin
    EsNumero := true;
    for i := 1 to Length(cad) do
        if not (cad[i] in ['0'..'9']) then
            EsNumero := false;
end;

procedure VerificarDNI(entrada: string);
var
    dni: longint;
begin
    if (Length(entrada) >= 7) and (Length(entrada) <= 8) then
        if EsNumero(entrada) then
        begin
            dni := StrToInt(entrada);
            writeln('El DNI es valido ', dni);
        end
        else
            writeln('El valor ingresado no es un numero valido.')
    else
        writeln('El DNI no es valido.');
end;

begin
    writeln('Ingrese su DNI: ');
    readln(entrada);
    VerificarDNI(entrada);
end.

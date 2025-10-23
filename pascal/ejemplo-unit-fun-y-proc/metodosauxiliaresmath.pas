unit MetodosAuxiliaresMath;

interface
procedure divisionEntera(dividendo, divisor: Integer; var cociente, resto: Integer);

implementation

procedure divisionEntera(dividendo, divisor: Integer; var cociente, resto: Integer);
begin
    cociente := dividendo div divisor;
    resto := dividendo mod divisor;
end;

end.


program tipo_mail;
var
  email: string;
begin
  write('Ingrese su correo: ');
  readln(email);

  if pos('gmail', email) > 0 then
    writeln('Su mail es de tipo Gmail')
  else if pos('yahoo', email) > 0 then
    writeln('Su mail es de tipo Yahoo')
  else if pos('hotmail', email) > 0 then
    writeln('Su mail es de tipo Hotmail')
  else
    writeln('Tipo de mail no reconocido');
end.

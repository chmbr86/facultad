program project1;
{$codepage UTF8}
uses Crt, Menu;

var menuOpciones: T_Menu;
  opMenu: T_Menu_Opcion;
begin
  menuOpciones[1] := 'Salir';
  menuOpciones[2] := 'Hacer A';
  menuOpciones[3] := 'Hacer B';
  menuOpciones[4] := 'Hacer C';

  repeat
    opMenu := SeleccionarOpcionMenu(menuOpciones);
    WriteLn('Opción seleccionada:', opMenu, ' -> ', menuOpciones[opMenu]);
    Readkey;
  until opmenu = 1; // Opcion 'Salir'

  WriteLn('Saliendo...');
  Delay(2000);
end.


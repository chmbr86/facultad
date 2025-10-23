unit Menu;

{$codepage UTF8}

interface

const CANT_OPCIONES = 4;
type
    T_Menu_Opcion = 1..CANT_OPCIONES;
    T_Menu = array [T_Menu_Opcion] of string;

function SeleccionarOpcionMenu(var menu: T_Menu) :T_Menu_Opcion;


implementation
uses Crt;

procedure EscribirOpcion(posicion: T_Menu_Opcion; texto: string; resaltar: boolean);
begin
  GotoXY(60, 12 + posicion);
  if resaltar then
    TextColor(Green)
  else
    TextColor(White);
  Write(texto);
end;

function SeleccionarOpcionMenu(var menu: T_Menu) :T_Menu_Opcion;
var i, seleccion: T_Menu_Opcion;
  tecla: Char;
begin
  clrscr;

  for i := 1 to CANT_OPCIONES do
  begin
       EscribirOpcion(i, menu[i], false);
  end;
  seleccion := 1;
  EscribirOpcion(seleccion, menu[seleccion], true);

  repeat
        tecla := readkey;
        if tecla = #0 then // Teclas Especiales
        begin
          tecla := readkey;
          case tecla of
          // Flecha Arriba
          #72:
            begin
                 EscribirOpcion(seleccion, menu[seleccion], false);
                 if seleccion = 1 then
                   seleccion := CANT_OPCIONES
                 else
                   seleccion := seleccion - 1;
                 EscribirOpcion(seleccion, menu[seleccion], true);
            end;
          // Flecha Abajo
          #80:
            begin
                 EscribirOpcion(seleccion, menu[seleccion], false);
                 if seleccion = CANT_OPCIONES then
                   seleccion := 1
                 else
                   seleccion := seleccion + 1;
                 EscribirOpcion(seleccion, menu[seleccion], true);
            end;
          end;
        end;
  until tecla = #13; // Tecla Enter

  ClrScr;
  SeleccionarOpcionMenu := seleccion;
end;

end.


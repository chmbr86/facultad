program menuProgram;

uses Crt,Menu;

var menuOpciones: T_Menu;
    opMenu: T_menu_Opcion;

begin
    menuOpciones[1] := 'Salir';
    menuOpciones[2] := 'Hacer A';
    menuOpciones[3] := 'Hacer B';
    menuOpciones[4] := 'Hacer C';

    repeat
        opMenu := SeleccionarOpcionMenu(menuOpciones);
            1: writeln('Saliendo...');
            2: writeln('Haciendo A...');
            3: writeln('Haciendo B...');
            4: writeln('Haciendo C...');
        
    until opMenu = 1;
unit Menu;
interface

uses
    Crt,
    Graph,
    sysutils;

// Definimos el tipo de dato para manejar la opción seleccionada
type
    TOpcionMenu = (Jugar, Salir, Ninguna);

// La función que muestra el menú y devuelve la opción seleccionada por el usuario
function MostrarMenuPrincipal: TOpcionMenu;

implementation

function MostrarMenuPrincipal: TOpcionMenu;
const
    NumOpciones = 2;
    Opciones: array[1..NumOpciones] of string = ('Jugar', 'Salir');
    YInicial = 250;
    Separacion = 50;
var
    opcionActual: integer;
    tecla, sc: char;
    xCentro: integer;
    ResultadoOpcion: TOpcionMenu;
    i: integer;

begin
    opcionActual := 1; // 1 = Jugar
    xCentro := GetMaxX div 2;
    ResultadoOpcion := Ninguna;

    repeat
        ClearDevice;

        // --- Dibujar Título ---
        settextstyle(defaultfont, horizdir, 5);
        setcolor(yellow);
        OutTextXY(xCentro - (TextWidth('PAC-MAN PASCAL') div 2), 100, 'PAC-MAN PASCAL');

        // --- Bucle de Selección Interactiva ---
        repeat
            // Redibujar las opciones para actualizar el color
            for i := 1 to NumOpciones do
            begin
                if i = opcionActual then
                    SetColor(Green) // Opción seleccionada
                else
                    SetColor(White); // Opción normal

                OutTextXY(xCentro - (TextWidth(Opciones[i]) div 2), YInicial + (i - 1) * Separacion, Opciones[i]);
            end;

            // Leer entrada
            tecla := ReadKey;

            if tecla = #0 then // Teclas Especiales (flechas)
            begin
                sc := ReadKey;
                case sc of
                    #72: // Flecha Arriba
                        if opcionActual > 1 then
                            opcionActual := opcionActual - 1
                        else
                            opcionActual := NumOpciones; // Bucle a la última opción
                    #80: // Flecha Abajo
                        if opcionActual < NumOpciones then
                            opcionActual := opcionActual + 1
                        else
                            opcionActual := 1; // Bucle a la primera opción
                end;
            end;
        until (tecla = #13) or (tecla = #27); // Salir del bucle si es ENTER (#13) o ESC (#27)


        if tecla = #13 then // Si presionó ENTER
        begin
            case opcionActual of
                1: ResultadoOpcion := Jugar;
                2: ResultadoOpcion := Salir;
            end;
        end
        else if tecla = #27 then // Si presionó ESC
        begin
            ResultadoOpcion := Salir;
        end;

    until ResultadoOpcion <> Ninguna;

    MostrarMenuPrincipal := ResultadoOpcion;
end;

end.




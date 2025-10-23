program proyectoGame;

uses
    Graph,
    Crt,
    logicaPac;

var
    RutaAlControlador: string;
    gd, gm: smallInt;
    ErrorCode: integer;

begin

    RutaAlControlador := 'c:\BGI';
    gd := Detect;
    gm := 0;
    InitGraph(gd, gm, 'c:\BGI'); 

    ErrorCode := GraphResult;
    if ErrorCode <> grOk then 
    begin
        writeln('Error al inicializar el modo gráfico: ', GraphErrorMsg(ErrorCode));
        ReadKey;
        Halt(1); 
    end;

    
    //Inicializar La matriz donde se van a cargar tds los objetos
    InicializarMapa;
    //Cargar Muros en la matriz
    CargaMuros;
    //Cargar Frutas y Pacman en la matriz
    CargaFrutasYPacman;
    //Dibujar la matriz en la ventana grafica 
    DibujarMapa;
    //Detecta La tecla, mueve el pacman en la posicion y limpia y redibuja la nueva y antigua celda
    MoverPacman;

    
    writeln('Presiona una tecla para cerrar...');
    ReadKey;

    CloseGraph; // Cierra la ventana gráfica  

end.
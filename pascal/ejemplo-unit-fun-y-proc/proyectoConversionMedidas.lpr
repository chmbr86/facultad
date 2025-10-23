program proyectoConversionMedidas;

uses Crt, Conversion_Medidas, MetodosAuxiliaresMath;

var
  // cm: Real;
  a, b, c, r: Integer;

begin
    //write('Leer cantidad de centimetros a convertir:');
    //readln(cm);
    //mostrarConversion(cm, 'centimetros', centimetrosAdecimetros(cm), 'decimetros');
    //mostrarConversion(cm, 'centimetros', cmApulgadas(cm), 'pulgadas');
    //mostrarConversion(cm, 'centimetros', cmApies(cm), 'pies');

    writeln('Ingresar dividendo: ');
    read(a);
    writeln('Ingresar divisor: ');
    read(b);
    divisionEntera(a, b, c, r);
    writeln('Cociente: ', c);
    writeln('Resto: ', r);
    readkey;
end.


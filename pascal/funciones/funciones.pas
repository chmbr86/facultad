program clase9del9;

uses Crt;

var
    lado:integer;
    altura:integer;
    opcion:string;

function areaCuadrado(lado:integer):integer;
    begin
        areaCuadrado:= lado*lado;
    end;
function areaRectangulo(lado, altura:integer):integer;
    begin
        areaRectangulo:= lado*altura;
    end;
function areaTriangulo(lado, altura:integer):real;
    begin
        areaTriangulo:= ((lado*altura) / 2) ;
    end;
function areaCirculo(lado:integer):real;
    begin
        areaCirculo:= ((lado*lado) * 3.14) ;
    end;

begin
    writeln('1- calcular area de cuadrado');
    writeln('2- calcular area de rectangulo');
    writeln('3- calcular area de triangulo');
    writeln('4- calcular area de circulo');
    readln(opcion);

    if opcion='1' then
        begin
            writeln('Ingrese el lado del cuadrado');
            readln(lado);
            writeln('El area del cuadrado es de ', areaCuadrado(lado) , ' centimetros cuadrados');
        end
    else
        begin
            if opcion='2' then
                begin
                    writeln('Ingrese un lado del rectangulo');
                    readln(lado);
                    writeln('Ingrese la altura del rectangulo');
                    readln(altura);
                    writeln('El area del rectangulo es de ', areaRectangulo(lado, altura) ,' cm cuadrados' );
                end
            else
                begin
                    if opcion='3' then
                        begin
                            writeln('Ingrese base del triangulo');
                            readln(lado);
                            writeln('Ingrese altura del triangulo');
                            readln(altura);
                            writeln('El area del rectangulo es de ', areaTriangulo(lado, altura):0:2 ,' cm cuadrados' );     
                        end 
                    else
                        begin
                            if opcion='4' then
                                begin
                                    writeln('Ingrese radio del circulo');
                                    readln(lado);
                                    writeln('El area del rectangulo es de ', areaCirculo(lado):0:2 ,' cm cuadrados');     
                                end 
                            else
                                writeln('seleccione una opcion valida');
                        end
                end
                
        end 

end.

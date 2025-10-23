program calse;
 {$CODEPAGE utf8}
uses COLACIR,CRT;
 var
   Q:T_COLA;
   x:T_DATO;
     op:0..3;

     Procedure carga_todo(var Q:T_Cola);
var
  x:T_dato;
begin
  while not (cola_llena(Q)) do
begin

    write('Nombre: ');readln(x.NOM);
    write('Telefono: ');readln(x.TEL);
    encolar(Q,X);
    end;
     writeln ('Informacion cargada');

  end;
Procedure Muestra_todo(var Q:T_Cola);
var
  x:T_dato;
begin
  while not (cola_vacia(Q)) do
begin

    writeln('Nombre: ',x.NOM);
    writeln('Telefono: ',x.TEL);
    desencolar(Q,X);
    end;
     writeln ('Informacion Mostrada..');

  end;
PROCEDURE AGREGAR_UNO(VAR Q:T_COLA);
VAR
  X:T_DATO;
  BEGIN
    IF NOT COLA_LLENA(Q) THEN
    BEGIN
    WRITELN('iNGRESE VALOR');
    READLN(X);
    ENCOLAR(Q,X);
   END
  ELSE
     WRITELN('COLA LLENA');
      READKEY;
  END;
PROCEDURE INVERTIR(VAR Q:T_COLA);
VAR
  XQ:T_DATO;
  XP:T_DATO1;
  P:T_PILA
  BEGIN
    CREARPILA(P);
    WHILE NOT COLAVACIA(Q) DO
   BEGIN
     DESENCOLAR(Q,XQ);
     XP.NOM:=XQ.NOM ;
     XP.TEL:=XQ.TEL;
     APILAR(P,XP);

    END;
    WHILE NOT PILAVACIA(P) DO
   BEGIN
     DESAPILAR(,XP);
     XQ.NOM:=XP.NOM ;
     XQ.TEL:=XP.TEL;
     ENCOLAR(Q,XQ);
    END;

  END;
  end;
PROCEDURE INVERTIR1(VAR Q:T_COLA);
BEGIN
  IF NOT COLAVACIA(Q) THEN INVERTIR(Q)
  ELSE WRITELN('COLA VACIA')
  READKEY;

  END;

begin
  CREARCOLA(Q);

  repeat
    writeln('1_Cargar');
    writeln('2_Mostar');
     writeln('3_AGREGAR UNO');
      writeln('4_INVERTIR CONTENIDO');
    writeln('0_Salir');
     writeln('Ingrese opcion ');
     readln(op);
     case op of
     1:Carga_todo(Q);
     2:Muestra_todo(Q);
     3:AGREGAR_UNO(Q);
     4:INVERTIR1(Q);
     end;
  until op = 0;
  END;
    readkey;
end.


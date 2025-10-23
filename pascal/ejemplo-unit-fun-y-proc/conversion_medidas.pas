unit Conversion_Medidas;

interface
function cmApulgadas(cm:Real): Real;
function cmApies(cm:Real): Real;
function centimetrosAdecimetros(centimetros:Real): Real;
procedure mostrarConversion(valor1: Real; unidad1: String; valor2: Real; unidad2: String);


implementation

function cmApulgadas(cm:Real): Real;
begin
     cmApulgadas := cm/2.5;
end;

function cmApies(cm:Real): Real;
begin
     cmApies := cm/30;
end;

function centimetrosAdecimetros(centimetros:Real): Real;
begin
     centimetrosAdecimetros := centimetros/10;
end;

procedure mostrarConversion(valor1: Real; unidad1: String; valor2: Real; unidad2: String);
begin
    writeln(valor1:0:2, ' ', unidad1,' equivalen a ', valor2:0:2 ,' ', unidad2);
end;

end.


program ej3;
var
    vector: array[1..10] of integer;
    i, temp: integer;
begin
    randomize;

    for i := 1 to 10 do vector[i] := random(100);

    writeln('el vector inicial es:');
    for i := 1 to 10 do
    begin
        write(vector[i]);
        write(' ');
    end;
    for i := 1 to 10 do
    begin
        if (i mod 2 = 0) then
            begin
                temp := vector[i];
                vector[i] := vector[i+1];
                vector[i+1] := temp;
            end;        
    end;
    writeln;
    writeln('el vector final es:'); 
        
        for i := 1 to 10 do
        begin
            write(vector[i]);
            write(' ');
        end;
end.

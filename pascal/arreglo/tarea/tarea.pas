program tarea;
const
    n = 20;
    type t_vector = array[1..n] of integer;
var
    vector: t_vector;
    i: integer;
procedure AvanzarVector(var vector: t_vector; n: integer);
var
    i, temp: integer;
begin
        temp := vector[n];
        for i := n downto 1 do
            begin        
                if (i=1) then
                    vector[1] := temp 
                else
                    vector[i] := vector[i-1];  
            end;    
end;

begin  
    for i := 1 to n do 
        begin
            if (i mod 2 = 0) then
                vector[i] := 1
            else
            vector[i] := 0;
        end;
    
    writeln('el vector inicial es:');
    for i := 1 to n do
    begin
        write(vector[i]);
        write(' ');
    end;

    AvanzarVector(vector, n);
    
    writeln;

    writeln('el vector final es:'); 
        for i := 1 to n do
            begin
                write(vector[i]);
                write(' ');
            end;

end.

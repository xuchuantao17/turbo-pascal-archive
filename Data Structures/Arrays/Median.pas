program median (input,output);

{**** THE COMPLEXITY OF THIS PROGRAM IS : O(log(min(n,m)) ****}

const
    max=1000;
    interval=50;
type
    int_array=array [1..max]of integer;

procedure init_array (var vector:int_array;var size:integer);
    var
       x:integer;
       ch:char;
    begin
       repeat
        write('Enter Array Size:');
        readln (size);
       until (size>1) and (size<=max);
       repeat
         write ('Initialize Menualy ? (Y/N): ');
         readln(ch)
       until ((ch='y') or (ch='Y') or (ch='n') or (ch='N'));
       if (ch='y') or (ch='Y')
       then
          for x:=1 to size do
          begin
            write('Num',x,' = ');
            readln(vector[x]);
          end
       else
       begin
         vector[1]:=random(interval);
         for x:=2 to size do vector[x]:=(vector[x-1]+random(interval));
       end
    end;

    procedure print_array (vector:int_array;size:integer);
    var
      x:integer;
    begin
        for x:=1 to size do write (vector[x],' ');
    end;


    procedure find_median (var a1,a2,b1,b2:integer;arr1,arr2:int_array);
    var
       med1,med2:integer;
       size     :integer;
    begin
         while (b2>(b1+1)) do
         begin
            med1:=(a1+a2) div 2;
            med2:=(b1+b2) div 2;
            size:=med2-b1;
            if arr1[med1] > arr2[med2]
            then begin
                   a2:=a2-size;
                   b1:=b1+size;
                 end
            else
                 begin
                   a1:=a1+size;
                   b2:=b2-size;
                 end
         end
    end;

    procedure print_median (first1,last1,first2,last2:integer;
                            var big,small:int_array);

    var
        temp:array[1..4]of integer;
        even:boolean;
        x:integer;
    begin
         even:=((last1-first1+1) mod 2=0);
         if even
         then if last1>first1+1
              then begin
                    first1:=((first1+last1) div 2)-1;
                    last1:=first1+3;
                   end
         else begin
                first1:=((first1+last1) div 2)-1;
                last1:=first1+2;
              end;
         x:=1;
         while (x<5) and (first1<=last1) and (first2<=last2) do
         begin
           if big[first1]>small[first2]
           then begin
                  temp[x]:=small[first2];
                  first2:=first2+1;
                  x:=x+1;
                end
           else begin
                  temp[x]:=big[first1];
                  first1:=first1+1;
                  x:=x+1;
                end
        end;

        if first1>last1
        then
           while (x<5) do
           begin
             temp[x]:=small[first2];
             first2:=first2+1;
             x:=x+1
           end
        else
          while (x<5)do
          begin
             temp[x]:=big[first1];
             first1:=first1+1;
             x:=x+1
          end;

        if even then writeln ('median1=',temp[3],' median2=',temp[4])
                else writeln ('only one median=',temp[3]);
    end;

var
    a1,a2,b1,b2:integer;
    arr1,arr2:int_array;
begin {main}
    randomize;
    init_array(arr1,a2);
    init_array(arr2,b2);
    write ('FIRST ARRAY: ');
    print_array(arr1,a2);
    writeln;
    write ('SECOND ARRAY: ');
    print_array(arr2,b2);
    writeln;
    a1:=1;b1:=1;
    if a2>b2
    then begin
           find_median(a1,a2,b1,b2,arr1,arr2);
           print_median(a1,a2,b1,b2,arr1,arr2);
         end
    else begin
          find_median(b1,b2,a1,a2,arr2,arr1);
          print_median(b1,b2,a1,a2,arr2,arr1);
         end;
    writeln;
    readln;
end.


 
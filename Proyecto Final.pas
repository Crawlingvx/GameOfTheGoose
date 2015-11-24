//Nota: Se ha tratado de eliminar todas las lineas de codigo posible, pero una gran cantidad de lineas aun se deben a necesidad de funciones TextColor para la presentacion grafica del proyecto, y los dibujos tales como
//el de presentacion, el de los dados, y el del ganador, los cuales no son amigables con estructuras de repeticion. A pesar de esto, se ha optimizado el codigo lo maximo posible, eliminando mas de lineas desde que se
//concluyo el programa.
Program Proyecto;
Uses
    CRT;
Const
    H=8;
    W=8;
Type
    Scoreboards=Record
                    NumeroJuego:Integer;
                    NombreYApellido:String[50];
                    Edad:Byte;
                    InicialesG:String[4];
                    FechaJuego:Integer;
              end;

    Tablero=Array[1..H, 1..W] of Integer;
Var
    NumeroJuego:Integer; //Para modificar Archivos
    Scoreboard:Scoreboards; //Archivo
    LaOca,LaOcaT:File of Scoreboards;
    Seleccion,SeleccionR:Integer; //Seleccion de las opciones del menu de juego y del menu de registros
    A,B,C,D:Integer; //Orden aleatorio de los jugadores
    ASt,BSt,CSt,DSt:String; //Nombre respectico de cada jugador
    Dado1,Dado2:Integer; //Dados del juego
    CasA,CasB,CasC,CasD:Integer; //Casillas en las que cada jugador se encuentra en el tablero, y casillas de Ocas
    V,VA,VB,VC,VD:Integer; //Contadores de turnos para cada jugador y numero de ronda, para control de las casillas especiales. Ejemplo: La Carcel
    AcA,AcB,AcC,AcD:Integer; //Variables para contar las casillas avanzadas una por una. Aseguran la funcionalidad de la casilla del Pozo
    Tab: Tablero; //Tablero del Juego
    Boo:Boolean; //Boolean para las Ocas

Procedure DibujoDeBienvenida;
Begin
    Textcolor(White);
    Writeln('                                    /\      /\      /\            ');
    Writeln('                                   /  \    /  \    /  \           ');
    Writeln('                                  /_  _\  /_  _\  /_  _\          ');
    Writeln('                                    ||______||______||            ');
    Writeln('                                    | /\          /\ |            ');
    Writeln('                                    |/  \ La Oca /  \|            ');
    Writeln('                                    |\  /  Real  \  /|            ');
    Writeln('                                    |_\/__________\/_|            ');
    Writeln('       /\                               _________                 ');
    Writeln('      \/ \/                            /         \                ');
    Writeln('     \/   \/       _                  /           \               ');
    Writeln('    \/_ _ _\/     | |                /      _      \              ');
    Writeln('   \/\     /\/    | |        __ _   |      (_)      |  ___   __ _ ');
    Writeln('  \/  \   /  \/   | |       / _` |   \             /  / __/ / _` |');
    Writeln(' \/_ _ \ /_ _ \/  | |_ _ _ | (_| |    \           /  | (_  | (_| |');
    Writeln(' \/\/\/\/\/\/\/   |_ _ _ _| \__,_|     \_________/    \___\ \__,_|');
    Writeln;
    Writeln;
end;

Procedure MenuDelJuego(Var Seleccion: Integer);
Begin
          Writeln('                         Introduzca Una Opcion:');
          Writeln('                             1 - 2 Jugadores');
          Writeln('                             2 - 3 Jugadores');
          Writeln('                             3 - 4 Jugadores');
          Writeln('                            4 - Menu de Registros');
          Writeln('                          5 - Finalizar el programa');
          Readln(Seleccion);
end;

Procedure MenuRegistro(Var SeleccionR:Integer);
Begin
     Clrscr;
     Writeln('Introduzca su opcion');
     Writeln('1 - Crear nuevo archivo');
     Writeln('2 - Agregar registros en archivo existente');
     Writeln('3 - Consultar todos los registros');
     Writeln('4 - Eliminar registro');
     Writeln('5 - Actualizar algún campos en el archivo');
     Writeln('6 - Actualizar todos los campos en un registro del archivo');
     Writeln('7 - Fin del programa');
     Readln(SeleccionR);
end;

Procedure AsignarArchivo(Var LaOca: file of Scoreboards);
Begin
     Assign(LaOca,'C:\LaOca.txt');
end;

Procedure Opcion1Registro(Var LaOca: file of Scoreboards);
Var
   Resp:Char;
Begin
     AsignarArchivo(LaOca);
     Rewrite(LaOca);
     Resp:='Y';
     While(Resp='Y') or (Resp='y')do
     Begin
          Write('Introduzca el Numero de Juego: ');
          Readln(Scoreboard.NumeroJuego);
          Write('Introduzca el Nombre: ');
          Readln(Scoreboard.NombreYApellido);
          Write('Introduzca la Edad del Jugador: ');
          Readln(Scoreboard.Edad);
          Write('Introduzca las Iniciales del Jugador: ');
          Readln(Scoreboard.InicialesG);
          Write('Introduzca la Fecha del juego: ');
          Readln(Scoreboard.FechaJuego);
          Write(LaOca,Scoreboard);
          Write ('Desea introducir mas infomarcion? Y/N');
          Readln(Resp);
      end;
      Close(LaOca);
      Writeln('Los Registros han sido insertados con exito!');
      Readln;
end;

Procedure Opcion2Registro(Var LaOca: file of Scoreboards);
Var
   Resp:Char;
Begin
     Resp:='Y';
     AsignarArchivo(LaOca);
     Reset(LaOca);
     While(Resp='Y') or (Resp='y') do
     Begin
          Clrscr;
          Seek(LaOca,filesize(LaOca));
          Write('Introduzca el Numero de Juego: ');
          Readln(Scoreboard.NumeroJuego);
          Write('Introduzca el Nombre: ');
          Readln(Scoreboard.NombreYApellido);
          Write('Introduzca la Edad del Jugador: ');
          Readln(Scoreboard.Edad);
          Write('Introduzca las Iniciales del Jugador: ');
          Readln(Scoreboard.InicialesG);
          Write('Introduzca la Fecha del juego: ');
          Readln(Scoreboard.FechaJuego);
          Write(LaOca,Scoreboard);
          Write ('Desea introducir mas infomarcion? Y/N');
          Readln(Resp);
     end;
     Close(LaOca);
     writeln('Ha insertado un nuevo registro exitosamente');
     Readln;
end;

Procedure Opcion3Registro(Var LaOca: file of Scoreboards);
Begin
     AsignarArchivo(LaOca);
     Reset(LaOca);
     Writeln('Numero',' Nombre ',' Edad ',' Iniciales ',' Fecha ');
     While(not EOF(LaOca)) do
     Begin
          Read(LaOca,Scoreboard);
          Writeln(Scoreboard.NumeroJuego,' ',Scoreboard.NombreYApellido,' ',Scoreboard.Edad,' ',Scoreboard.InicialesG,' ',Scoreboard.FechaJuego);
     end;
     Close(LaOca);
     Readln;
end;

Procedure Opcion4Registro(Var LaOca, LaOcaT: file of Scoreboards; NumeroJuego:Integer);
Begin
     AsignarArchivo(LaOca);
     Reset(LaOca);
     Assign(LaOcaT,'C:\LaOcaTemporal.txt');
     Rewrite(LaOcaT);
     Write('Numero de Juego a Eliminar: ');
     Readln(NumeroJuego);
     While(not EOF(LaOca))do
     Begin
          Read(LaOca,Scoreboard);
          If(NumeroJuego<>Scoreboard.NumeroJuego)then
          Begin
               Write(LaOcaT,Scoreboard);
          end;
     end;
     Close(LaOca);
     Close(LaOcaT);
     Erase(LaOca);
     Rename(LaOcaT,'LaOca.txt');
     Write('Se ha eliminado el registro exitosamente');
     Readln;
end;

Procedure Opcion5Registro(Var LaOca,LaOcaT: file of Scoreboards);
Var
   N:Integer;
Begin
     AsignarArchivo(LaOca);
     Reset(LaOca);
     Assign(LaOcaT,'LaOcaT.txt');
     Rewrite(LaOcaT);
     Writeln('Introduzca lo que se quiere anadir o sutraer de la Edad:');
     Readln(N);
     While(not EOF(LaOca))do
     Begin
          Read(LaOca,Scoreboard);
          Scoreboard.Edad:=Scoreboard.Edad+N;
          Write(LaOcaT,Scoreboard);
     end;
     Close(LaOca);
     Close(LaOcaT);
     Erase(LaOca);
     Rename(LaOcaT,'LaOca.txt');
     Write('Se ha actualizado el registro exitosamente');
     Readln;
end;

Procedure Opcion6Registro(Var LaOca,LaOcaT: file of Scoreboards; Var NumeroJuego:Integer);
Begin
     AsignarArchivo(LaOca);
     Reset(LaOca);
     Assign(LaOcaT,'LaOcaT.txt');
     Rewrite(LaOcaT);
     Write('Numero de Juego a Editar: ');
     Readln(NumeroJuego);
     While (not EOF(LaOca)) do
     Begin
          Read(LaOca,Scoreboard);
          If(NumeroJuego=Scoreboard.NumeroJuego)then
          Begin
               Write('Introduzca el Numero de Juego nuevo: ');
               Readln(Scoreboard.NumeroJuego);
               Write('Introduzca el Nombre nuevo: ');
               Readln(Scoreboard.NombreYApellido);
               Write('Introduzca la Edad del Jugador nueva: ');
               Readln(Scoreboard.Edad);
               Write('Introduzca las Iniciales del Jugador nuevo: ');
               Readln(Scoreboard.InicialesG);
               Write('Introduzca la Fecha del juego nuevo: ');
               Readln(Scoreboard.FechaJuego);
               Write(LaOca,Scoreboard);
         end;
    end;
    Close(LaOca);
    Close(LaOcaT);
    Erase(LaOca);
    Rename(LaOcaT,'LaOca.txt');
    Write('El registro se ha actualizado exitosamente');
    Readln;
end;

Procedure SeleccionarRegistro(SeleccionR:Integer);
Begin
     While(SeleccionR<>7)do
     Begin
          SeleccionR:=0;
          MenuRegistro(SeleccionR);
          Clrscr;
          Case SeleccionR of
               1: Opcion1Registro(LaOca);
               2: Opcion2Registro(LaOca);
               3: Opcion3Registro(LaOca);
               4: Opcion4Registro(LaOca,LaOcaT,NumeroJuego);
               5: Opcion5Registro(LaOca,LaOcaT);
               6: Opcion6Registro(LaOca,LaOcaT,NumeroJuego);
               7: Writeln('Adios!');
          else Writeln('Opcion Incorrecta'); Readln;
          end;
     end;
     Readln;
     Halt;
end;

Procedure SeleccionarJugadores(Var A,B,C,D:Integer; Seleccion:Integer; Var ASt,BSt,CSt,DSt:String);
Begin
    Repeat //Elige el Orden de los Jugadores
          Randomize;
                  A:=Random(4);
                  B:=Random(4);
                  C:=Random(4);
                  D:=Random(4);
    Until(A<>B) and (A<>C) and (A<>D) and (B<>C) and (B<>D) and (C<>D);

    If(Seleccion=1)then
    Begin
        Writeln('Introduzca su nombre y opriman Enter:');
        TextColor(LightBlue);
        Write('Jugador 1: ');
        Readln(ASt);
        Textcolor(Red);
        Write('Jugador 2: ');
        Readln(BSt);
    end
    else If(Seleccion=2)then
    Begin
        Writeln('Introduzca su nombre y opriman Enter:');
        TextColor(LightBlue);
        Write('Jugador 1: ');
        Readln(ASt);
        Textcolor(Red);
        Write('Jugador 2: ');
        Readln(BSt);
        TextColor(Yellow);
        Write('Jugador 3: ');
        Readln(CSt);
    end
    else If(Seleccion=3)then
    Begin
        Writeln('Introduzca su nombre y opriman Enter:');
        TextColor(LightBlue);
        Write('Jugador 1: ');
        Readln(ASt);
        Textcolor(Red);
        Write('Jugador 2: ');
        Readln(BSt);
        TextColor(Yellow);
        Write('Jugador 3: ');
        Readln(CSt);
        TextColor(Green);
        Write('Jugador 4: ');
        Readln(DSt);
    end;

    If(Seleccion=4)then
    Begin
         SeleccionarRegistro(SeleccionR);
    end;

    If(Seleccion=5)then
    Begin
        Writeln('                                   Adios!');
        Readln;
        Halt;
    end;

    If(Seleccion<1) or (Seleccion>5)then
    Begin
         Writeln('Esa opcion es invalida!');
         Readln;
         clrscr;
         DibujodeBienvenida;
         MenudelJuego(Seleccion);
         SeleccionarJugadores(A,B,C,D,Seleccion,ASt,BSt,CSt,DSt);
    end;
    Writeln;
end;

Procedure ImprimirTablero(CasA,CasB,CasC,CasD:integer); //Muestra el Tablero de Juego
Var
    I, J: Integer;
Begin
    For I:=1 to H do
    Begin
        For J:=1 to H do
        Begin
             TextColor(White);
             If(Tab[I,J]=CasA)then //Estos If hacen la casilla del Tablero de Juego del color del jugador que se encuentre en ella (Ejemplo: Jugador 2 = Casilla Roja)
             Begin
                  TextColor(LightBlue);
             end
             else If(Tab[I,J]=CasB)then
             Begin
                  TextColor(Red);
             end
             else If(Tab[I,J]=CasC) and ((Seleccion=2) or (Seleccion=3))then
             Begin
                  TextColor(Yellow);
             end
             else If(Tab[I,J]=CasD) and (Seleccion=3)then
             Begin
                  TextColor(Green);
             end;
            Write('|',Tab[I,J]:3, ' | ');
        end;
        Writeln;
    end;
    Writeln;
end;

Procedure TableroDeJuego; //Ordena el Tablero de Juego a traves de Bubblesort
Var
    I,L,N,M,Ac,J, Aux: Integer;
Begin
     Ac:=-1;
     For I:=1 to 8 do
     Begin
          For L:=1 to 8 do
          Begin
               Ac:=Ac+1;
               Tab[I,L]:=AC;
               TextColor(white);
          end;
     end;

     M:=8;
     N:=8;
     For I:=1 to N do
     Begin
          For J:=1 to M-1 do
          Begin
               For L:=1 to (M-J) do
               Begin
                    If((I mod 2 = 0) and (Tab[I,L]<Tab[I,L+1])) or ((I mod 2 <> 0) and (Tab[I,L]>Tab[I,L+1])) then
                    Begin
                         Aux:=Tab[I,L+1];
                         Tab[I,L+1]:=Tab[I,L];
                         Tab[I,L]:=Aux;
                    end;
               end;
          end;
     end;
     Writeln;
     ImprimirTablero(CasA,CasB,CasC,CasD);
end;

Procedure Dados(Var Dado1,Dado2:Integer); //Se encarga de asignar el valor rodado con los dados
Begin
     Textcolor(11);
     Writeln('Presiona cualquier tecla para lanzar los dados!!!');
     Readln();
     Writeln('...');
     Delay(2000); //Le da algo de suspenso al lanzamiento de los Dados =p
     TextColor(White);

     Dado1:=Random(5);
     Dado2:=Random(5);
     Dado1:=Dado1+1;
     Dado2:=Dado2+1;
     If(Dado1=1) or (Dado2=1)then
     Begin
          Writeln(' _ _ _ _ _');
          Writeln('|         |');
          Writeln('|    _    |');
          Writeln('|   (_)   | Haz rodado un Uno!');
          Writeln('|         |');
          Writeln('|_ _ _ _ _|');
          Writeln;
     end;
     If(Dado1=2) or (Dado2=2)then
     Begin
          Writeln(' _ _ _ _ _');
          Writeln('| _       |');
          Writeln('|(_)      |');
          Writeln('|       _ | Haz rodado un Dos!');
          Writeln('|      (_)|');
          Writeln('|_ _ _ _ _|');
          Writeln;
     end;
     If(Dado1=3) or (Dado2=3)then
     Begin
          Writeln(' _ _ _ _ _');
          Writeln('|       _ |');
          Writeln('|    _ (_)|');
          Writeln('| _ (_)   | Haz rodado un Tres!');
          Writeln('|(_)      |');
          Writeln('|_ _ _ _ _|');
          Writeln;
     end;
     If(Dado1=4) or (Dado2=4)then
     Begin
          Writeln(' _ _ _ _ _');
          Writeln('| _     _ |');
          Writeln('|(_)   (_)|');
          Writeln('| _     _ | Haz rodado un Cuatro!');
          Writeln('|(_)   (_)|');
          Writeln('|_ _ _ _ _|');
          Writeln;
     end;
     If(Dado1=5) or (Dado2=5)then
     Begin
          Writeln(' _ _ _ _ _');
          Writeln('| _     _ |');
          Writeln('|(_) _ (_)|');
          Writeln('| _ (_) _ | Haz rodado un Cinco!');
          Writeln('|(_)   (_)|');
          Writeln('|_ _ _ _ _|');
          Writeln;
     end;
     If(Dado1=6) or (Dado2=6)then
     Begin
          Writeln(' _ _ _ _ _');
          Writeln('| _  _  _ |');
          Writeln('|(_)(_)(_)|');
          Writeln('| _  _  _ | Haz rodado un Seis!');
          Writeln('|(_)(_)(_)|');
          Writeln('|_ _ _ _ _|');
          Writeln;
     end;
     If(Dado1=Dado2)then
     Begin
          Textcolor(3);
          Writeln('Haz rodado dos dados del mismo tipo!'); //En caso de rodar dos dados iguales
          Writeln();
     end;
end;

Procedure Casillas(Var CasA,CasB,CasC,CasD,VA,VB,VC,VD,AcA,AcB,AcC,AcD: Integer; Var Boo:Boolean); //Ocas, Posada, Laberinto, Carcel, Calavera
Var
   Oca1,Oca2,N:Integer;
Begin
     Oca1:=0;
     Oca2:=5;
     N:=0;
     Boo:=False;
     //OCAS
     Textcolor(11);
     While(N<=54)do
     Begin
          If(CasA=Oca1+N) and (CasA<>0) and (N<>55)then
          Begin
               Writeln('Haz caido en una Oca!');
               Writeln;
               Repeat
                     CasA:=CasA+1;
               Until(CasA=AcA+5);
               N:=55;
          end
          else If(CasA=Oca2+N) and (CasA<>0) and (N<>55)then
          Begin
               Writeln('Haz caido en una Oca!');
               Writeln;
               Repeat
                     CasA:=CasA+1;
               Until(CasA=AcA+4);
               N:=55;
          end;

          If(CasB=Oca1+N) and (CasB<>0) and (N<>55)then
          Begin
               Writeln('Haz caido en una Oca!');
               Writeln;
               Repeat
                     CasB:=CasB+1;
               Until(CasB=AcB+5);
               N:=55;
          end
          else If(CasB=Oca2+N) and (CasB<>0) and (N<>55)then
          Begin
               Writeln('Haz caido en una Oca!');
               Writeln;
               Repeat
                     CasB:=CasB+1;
               Until(CasB=AcB+4);
               N:=55;
          end;

          If(CasC=Oca1+N) and (Seleccion=2) and (CasC<>0) and (N<>55)then
          Begin
               Writeln('Haz caido en una Oca!');
               Writeln;
               Repeat
                     CasC:=CasC+1;
               Until(CasC=AcC+5);
               N:=55;
          end
          else If(CasC=Oca2+N) and (Seleccion=2) and (CasC<>0) and (N<>55)then
          Begin
               Writeln('Haz caido en una Oca!');
               Writeln;
               Repeat
                     CasC:=CasC+1;
               Until(CasC=AcC+4);
               N:=55;
          end;

          If(CasD=Oca1+N) and (Seleccion=3) and (CasD<>0) and (N<>55)then
          Begin
               Writeln('Haz caido en una Oca!');
               Writeln;
               Repeat
                     CasD:=CasD+1;
               Until(CasD=AcD+5);
               N:=55;
          end
          else If(CasD=Oca2+N) and (Seleccion=3) and (CasD<>0) and (N<>55)then
          Begin
               Writeln('Haz caido en una Oca!');
               Writeln;
               Repeat
                     CasD:=CasD+1;
               Until(CasD=AcD+4);
               N:=55;
          end;
          N:=N+9;
     end;
     If(N=64)then
     Begin
          Boo:=True;
     end;

     //POSADA
     If(CasA=19) and (V=VA)then
     Begin
          Writeln('Haz caido en La Posada! Pierdes un turno!');
          Writeln;
          VA:=VA+1;
     end
     else If(CasB=19) and (V=VB)then
     Begin
          Writeln('Haz caido en La Posada! Pierdes un turno!');
          Writeln;
          VB:=VB+1;
     end
     else If(CasC=19) and (V=VC)then
     Begin
          Writeln('Haz caido en La Posada! Pierdes un turno!');
          Writeln;
          VC:=VC+1;
     end
     else If(CasD=19) and (V=VD)then
     Begin
          Writeln('Haz caido en La Posada! Pierdes un turno!');
          Writeln;
          VD:=VD+1;
     end;

     //POZO
     If(CasA=31) and (V=VA)then
     Begin
          Writeln('Ohh no! Haz caido en El Pozo! No podras volver a lanzar hasta ser rescatado!');
          Writeln;
          VA:=100;
     end
     else If(CasB=31) and (V=VB)then
     Begin
          Writeln('Ohh no! Haz caido en El Pozo! No podras volver a lanzar hasta ser rescatado!');
          Writeln;
          VB:=100;
     end
     else If(CasC=31) and (V=VC)then
     Begin
          Writeln('Ohh no! Haz caido en El Pozo! No podras volver a lanzar hasta ser rescatado!');
          Writeln;
          VC:=100;
     end
     else If(CasD=31) and (V=VD)then
     Begin
          Writeln('Ohh no! Haz caido en El Pozo! No podras volver a lanzar hasta ser rescatado!');
          Writeln;
          VD:=100;
     end;

     //LABERINTO
     If(CasA=42)then
     Begin
          Writeln('Te has perdido en el Laberinto! Te encuentras en la casilla 30 nuevamente!');
          Writeln;
          CasA:=30;
     end
     else If(CasB=42)then
     Begin
          Writeln('Te has perdido en el Laberinto! Te encuentras en la casilla 30 nuevamente!');
          Writeln;
          CasB:=30;
     end
     else If(CasC=42)then
     Begin
          Writeln('Te has perdido en el Laberinto! Te encuentras en la casilla 30 nuevamente!');
          Writeln;
          CasC:=30;
     end
     else If(CasD=42)then
     Begin
          Writeln('Te has perdido en el Laberinto! Te encuentras en la casilla 30 nuevamente!');
          Writeln;
          CasD:=30;
     end;

     //CARCEL
     If(CasA=56) and (V=VA)then
     Begin
          Writeln('Haz caido en La Carcel! Pierdes dos turnos!');
          Writeln;
          VA:=VA+2;
     end
     else If(CasB=56) and (V=VB)then
     Begin
          Writeln('Haz caido en La Carcel! Pierdes dos turnos!');
          Writeln;
          VB:=VB+2;
     end
     else If(CasC=56) and (V=VC)then
     Begin
          Writeln('Haz caido en La Carcel! Pierdes dos turnos!');
          Writeln;
          VC:=VC+2;
     end
     else If(CasD=56) and (V=VD)then
     Begin
          Writeln('Haz caido en La Carcel! Pierdes dos turnos!');
          Writeln;
          VD:=VD+2;
     end;

     //CALAVERA
     If(CasA=58)then
     Begin
          Writeln('Ohh no! Haz caido en La Calavera! Regresas a la Casilla 0!');
          Writeln;
          CasA:=0;
     end
     else If(CasB=58)then
     Begin
          Writeln('Ohh no! Haz caido en La Calavera! Regresas a la Casilla 0!');
          Writeln;
          CasB:=0;
     end
     else If(CasC=58)then
     Begin
          Writeln('Ohh no! Haz caido en La Calavera! Regresas a la Casilla 0!');
          Writeln;
          CasC:=0;
     end
     else If(CasD=58)then
     Begin
          Writeln('Ohh no! Haz caido en La Calavera! Regresas a la Casilla 0!');
          Writeln;
          CasD:=0;
     end;
end;

Procedure RescateDelPozo(CasA,CasB,CasC,CasD:Integer; Var VA,VB,VC,VD:Integer); //Saca al jugador del pozo
Begin
     If((CasA=31) and (V<>VA)) and ((CasB=31) or (CasC=31) or (CasD=31))then
     Begin
          Textcolor(LightBlue);
          Writeln(ASt);
          Textcolor(11);
          Writeln('Haz sido rescatado del pozo! Podras lanzar el siguiente turno!');
          Writeln;
          VA:=V+1;
     end
     else If((CasB=31) and (V<>VB)) and ((CasA=31) or (CasC=31) or (CasD=31))then
     Begin
          Textcolor(LightBlue);
          Writeln(BSt);
          Textcolor(11);
          Writeln('Haz sido rescatado del pozo! Podras lanzar el siguiente turno!');
          Writeln;
          VB:=V+1;
     end
     else If((CasC=31) and (V<>VC)) and ((CasB=31) or (CasA=31) or (CasD=31))then
     Begin
          Textcolor(LightBlue);
          Writeln(CSt);
          Textcolor(11);
          Writeln('Haz sido rescatado del pozo! Podras lanzar el siguiente turno!');
          Writeln;
          VC:=V+1;
     end
     else If((CasD=31) and (V<>VD)) and ((CasB=31) or (CasC=31) or (CasA=31))then
     Begin
          Textcolor(LightBlue);
          Writeln(DSt);
          Textcolor(11);
          Writeln('Haz sido rescatado del pozo! Podras lanzar el siguiente turno!');
          Writeln;
          VD:=V+1;
     end;
end;


Procedure ElJuegoDeLaOca(A,B,C,D:Integer; Var CasA,CasB,CasC,CasD,V,VA,VB,VC,VD,AcA,AcB,AcC,AcD:Integer; ASt,BSt,CSt,DSt:String; Boo:Boolean);
Var
    I: integer;
Begin
     CasA:=0;
     CasB:=0;
     CasC:=0;
     CasD:=0;
     AcA:=0;
     AcB:=0;
     AcC:=0;
     AcD:=0;
     V:=0;
     VA:=1;
     VB:=1;
     VC:=1;
     VD:=1;
     Repeat
           V:=V+1;
           Writeln;
           TextColor(White);
           Writeln('Vuelta ',V,'!');
           TableroDeJuego;
           For I:=0 to 3 do
           Begin
                Writeln;
                If(A=I) and (V=VA)then //Jugador 1
                Begin
                     If(Boo=False)then //Para que no se repita este mensaje en caso de caer en una Oca
                     Begin
                          TextColor(cyan);
                          Write('Es el turno de: ');
                          TextColor(LightBlue);
                          Writeln(ASt);
                     end;
                     Readln;
                     Dados(Dado1,Dado2);
                     Repeat
                           CasA:=CasA+1;
                           RescateDelPozo(CasA,CasB,CasC,CasD,VA,VB,VC,VD);
                     Until(CasA=AcA+Dado1+Dado2);
                     AcA:=CasA;
                     Casillas(CasA,CasB,CasC,CasD,VA,VB,VC,VD,AcA,AcB,AcC,AcD,Boo);
                     AcA:=CasA;
                     TextColor(LightBlue);
                     Write(ASt,'! ');
                     TextColor(8);
                     Write('Te encuentras en la casilla ');
                     TextColor(LightBlue);
                     Write(CasA,'!');
                     Readln;
                     VA:=VA+1;
                end
                else If(B=I) and (V=VB)then //Jugador 2
                Begin
                     If(Boo=False)then //Para que no se repita este mensaje en caso de caer en una Oca
                     Begin
                          TextColor(cyan);
                          Write('Es el turno de: ');
                          TextColor(Red);
                          Writeln(BSt);
                     end;
                     Readln;
                     Dados(Dado1,Dado2);
                     Repeat
                           CasB:=CasB+1;
                           RescateDelPozo(CasA,CasB,CasC,CasD,VA,VB,VC,VD);
                     Until(CasB=AcB+Dado1+Dado2);
                     AcB:=CasB;
                     Casillas(CasA,CasB,CasC,CasD,VA,VB,VC,VD,AcA,AcB,AcC,AcD,Boo);
                     AcB:=CasB;
                     TextColor(Red);
                     Write(BSt,'! ');
                     TextColor(8);
                     Write('Te encuentras en la casilla ');
                     TextColor(Red);
                     Write(CasB,'!');
                     Readln;
                     VB:=VB+1;
                end
                else If(C=I) and ((Seleccion=2) or (Seleccion=3)) and (V=VC)then //Jugador 3
                Begin
                     If(Boo=False)then //Para que no se repita este mensaje en caso de caer en una Oca
                     Begin
                          TextColor(cyan);
                          Write('Es el turno de: ');
                          TextColor(Yellow);
                          Writeln(CSt);
                     end;
                     Readln;
                     Dados(Dado1,Dado2);
                     Repeat
                           CasC:=CasC+1;
                           RescateDelPozo(CasA,CasB,CasC,CasD,VA,VB,VC,VD);
                     Until(CasC=AcC+Dado1+Dado2);
                     AcC:=CasC;
                     Casillas(CasA,CasB,CasC,CasD,VA,VB,VC,VD,AcA,AcB,AcC,AcD,Boo);
                     AcC:=CasC;
                     TextColor(Yellow);
                     Write(CSt,'! ');
                     TextColor(8);
                     Write('Te encuentras en la casilla ');
                     TextColor(Yellow);
                     Write(CasC,'!');
                     Readln;
                     VC:=VC+1;
                end
                else If(D=I) and (Seleccion=3) and (V=VD)then //Jugador 4
                Begin
                     If(Boo=False)then //Para que no se repita este mensaje en caso de caer en una Oca
                     Begin
                          TextColor(cyan);
                          Write('Es el turno de: ');
                          TextColor(Green);
                          Writeln(DSt);
                     end;
                     Readln;
                     Dados(Dado1,Dado2);
                     Repeat
                           CasD:=CasD+1;
                           RescateDelPozo(CasA,CasB,CasC,CasD,VA,VB,VC,VD);
                     Until(CasD=AcD+Dado1+Dado2);
                     AcD:=CasD;
                     Casillas(CasA,CasB,CasC,CasD,VA,VB,VC,VD,AcA,AcB,AcC,AcD,Boo);
                     AcD:=CasD;
                     TextColor(Green);
                     Write(DSt,'! ');
                     TextColor(8);
                     Write('Te encuentras en la casilla ');
                     TextColor(Green);
                     Write(CasD,'!');
                     Readln;
                     VD:=VD+1
                end;

                If(Boo=True) and (A=I)then //Repite el turno si el jugador 1 cae en una Oca
                Begin
                     VA:=VA-1;
                     I:=I-1;
                end
                else If(Boo=True) and (B=I)then //Repite el turno si el jugador 2 cae en una Oca
                Begin
                     VB:=VB-1;
                     I:=I-1;
                end
                else If(Boo=True) and (C=I)then //Repite el turno si el jugador 3 cae en una Oca
                Begin
                     VC:=VC-1;
                     I:=I-1;
                end
                else If(Boo=True) and (D=I)then //Repite el turno si el jugador 4 cae en una Oca
                Begin
                     VD:=VD-1;
                     I:=I-1;
                end;


                If(CasA>=63) or (CasB>=63) or (CasC>=63) or (CasD>=63)then //Termina el juego
                Begin
                     I:=4;
                end;
           end;
    Until(CasA>=63) or (CasB>=63) or (CasC>=63) or (CasD>=63)
end;

Procedure MensajeYDibujoFinal;
Begin
     Writeln;
     Writeln('Me toca, me toca! Llegue al jardin de La Oca!');
     Readln;
     TextColor(White);
     Writeln;
     Writeln('                $$$$$$$$$$$$$$$$$$$$$$');
     Writeln('              $$$$$$$$$$$$$$$$$$$$$$$$');
     Writeln('            $$$$    $$$$$$$$$$$$$$$$$$$$');
     Writeln('           $$$$$     $$$$$$$$$$$$$$$$$$$');
     Writeln('         $$$$$$$$     $$$$$$$$$$$$$$$$$$');
     Writeln('       $$$$$$$$$$$     $$$$$$$$$$$$$$$');
     Writeln('      $$$$$$$$$$$$$     $$$$$$$$$$$$$$');
     Writeln('     $$$$$$$$$$$$$$$     $$$$$$$$$$$$$');
     Writeln('       $$$$$$$$$$$$$$    $$$$$$$$$$$$$');
     Writeln('         $$$$$$$$$$$$$$$$$$$$$$$$$$$$$');
     Writeln('           $$$$$$$$$$$$$$$$$$$$$$$$$$$      $$$$$$ ');
     Writeln('            $$$$$$$$$$$$          $$$$   $$$$   $$$');
     Writeln('         $$$$$$$                  $$    $$$$    $$$');
     Writeln('      $$$$$$$$$$$$$$$$$$          $$$$$$$$   $$$$  $');
     Writeln('   $$$$               $$$$$$$$$$$$$       $$$$$$$$$$');
     Writeln(' $$$$    $$$$$$$$$$                   $$$$$$$$$$$$');
     Writeln(' $$   $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$ $$$$$$$$$$');
     Writeln('$  $$$$$$$$$$$$$$$$$$$$$                   $$$$$$');
     Writeln('$  $$$$$$$$$$$$$$$$$                       $$$$');
     Writeln('$  $$$$$$$$$$$$$$                       $$$$$');
     Writeln(' $$  $$$$$$$$$$           $$$$$       $$$    $$');
     Writeln('  $$$$$$$$$$$$         $$$   $$$     $$$    $$');
     Writeln('     $$$$$$$$           $      $$$$     $      $$');
     Writeln('    $$  $$$$$           $        $      $$$$   $$');
     Writeln('      $$  $$$  $$$$     $        $$$    $$$$$  $$ $$$$');
     Writeln('   $$$$$$$   $$         $  $$$$  $$$    $$$$$  $$$$   $$ ');
     Writeln(' $$$       $$$   $$$    $$$$$$$$  $$  $$$$$$$  $$$    $$');
     Writeln(' $$   $$   $$  $$$$$$$  $$$$$$$$$ $$$$$$$$$$$$$$$$    $$ ');
     Writeln(' $$ $$$        $$   $$  $$$$$$$$$   $$     $$    $$$$$$$$$ ');
     Writeln('  $$$$  $$     $$   $$    $$$$$$$ $$$$     $$$$$$$$$     $$');
     Writeln('  $$$ $$   $$$$$$ $$$$$$   $$$$$$$$$$$$$ $$$$$$$    $$$  $$');
     Writeln('   $$$$$$$$    $$$$ $$  $$$$$$$$$$$          $$$$ $$$$$$$ ');
     Writeln('               $$$$   $$                   $$$$$$$$$');
     Writeln('                 $$$   $$$$$            $$$$$$$ $$$ ');
     Writeln('                  $$$$  $$$$$$$     $$$$$$$$$$$$$');
     Writeln('                   $$$$$   $$$$$$$$$$$$$$$$$$  $$ ');
     Writeln('                    $$$$$$   $$$$$$$$$$$$$$  $$ ');
     Writeln('                      $$$$$     $$$$$$$$$$$  $$ ');
     Writeln('                        $$$$$$$        $$$$$$$$ ');
     Writeln('                          $$$$$$$$$$$$$$$$ $$ ');
     Writeln('                            $$$$$$$$$$$$');
     Readln;
end;

Procedure LeerRegistros(Scoreboard:Scoreboards);
Begin
     Clrscr;
     AsignarArchivo(LaOca);
     Rewrite(LaOca);
     Write('Introduzca el Numero de Juego: ');
     Readln(Scoreboard.NumeroJuego);
     Write('Introduzca el Nombre: ');
     Readln(Scoreboard.NombreYApellido);
     Write('Introduzca la Edad del Jugador: ');
     Readln(Scoreboard.Edad);
     Write('Introduzca las Iniciales del Jugador: ');
     Readln(Scoreboard.InicialesG);
     Write('Introduzca la Fecha del juego: ');
     Readln(Scoreboard.FechaJuego);
     Write(LaOca,Scoreboard);
     Close(LaOca);
     Writeln;
     Writeln('Gracias por jugar a La Oca!');
end;

Begin
     DibujoDeBienvenida;
     MenuDelJuego(Seleccion);
     SeleccionarJugadores(A,B,C,D,Seleccion,ASt,BSt,CSt,DSt);
     ElJuegoDeLaOca(A,B,C,D,CasA,CasB,CasC,CasD,V,VA,VB,VC,VD,AcA,AcB,AcC,AcD,ASt,BSt,CSt,DSt,Boo);
     MensajeYDibujoFinal;
     LeerRegistros(Scoreboard);
     Readkey;
end.

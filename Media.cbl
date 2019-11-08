       IDENTIFICATION DIVISION.
       PROGRAM-ID.  Media-Notas.
       ENVIRONMENT DIVISION.

      *special-names.
      *    decimal-point is comma.

       DATA DIVISION.

       WORKING-STORAGE SECTION.

       01 DADOS.
           02 WNota1      PIC  9(02)v9.
           02 WNota2      PIC  9(02)V9.
           02 WMedia      PIC  9(02)v9.

       01 EDITADAS.
           02 WNota1-E      PIC  99.9.
           02 WNota2-E      PIC  99.9.
           02 WMedia-E      PIC  99.9.
          
       01 MENSAGEMS-DE-TELA.
           02 MENSA1            PIC X(50) VALUE
                "DIGITE A NOTA1".
           02 MENSA2            PIC X(50) VALUE
                "DIGITE A NOTA2".
           02 MENSA3            PIC X(30) VALUE
                "F I M  D O  P R O G R A M A".
           02 MENSA4            PIC X(30) VALUE SPACE.

       01 DATA-DO-SISTEMA.
           02 ANO               PIC 9(02) VALUE ZEROS.
           02 MES               PIC 9(02) VALUE ZEROS.
           02 DIA               PIC 9(02) VALUE ZEROS.

       SCREEN SECTION.
       01 TELA01.
           02 LINE 02 COLUMN 05 PIC 9(02)/ USING DIA.
           02 LINE 02 COLUMN 08 PIC 9(02)/ USING MES.
           02 LINE 02 COLUMN 11 PIC 9(02)  USING ANO.
           02 LINE 02 COLUMN 28 VALUE
                "Cálcula da Média das Notas".
           02 LINE 08 COLUMN 15 VALUE "Nota 1:".
           02 LINE 10 COLUMN 15 VALUE "Nota 2:".
           02 LINE 12 COLUMN 15 VALUE "Média :".
 
       PROCEDURE DIVISION.

       Inicio.
           ACCEPT  DATA-DO-SISTEMA FROM DATE.
           DISPLAY ERASE       AT    0101.
           DISPLAY TELA01      AT    0101.
           MOVE    ZEROS       TO    DADOS.
      
       Entrada.
           DISPLAY MENSA1 AT 2030.
           ACCEPT WNOTA1-E AT 0823.
           DISPLAY MENSA2 AT 2030.
           ACCEPT WNOTA2-E AT 1023.
           DISPLAY MENSA4 AT 2030.

       Calcula.
           MOVE WNOTA1-E TO WNOTA1.
           MOVE WNOTA2-E TO WNOTA2.           
           compute WMEDIA = (WNOTA1 + WNOTA2) / 2.
           MOVE WMEDIA TO WMEDIA-E.
           DISPLAY WMEDIA-E AT 1223.

       Finaliza.
           DISPLAY MENSA3 AT 1830.
           stop " ".
           Stop Run.
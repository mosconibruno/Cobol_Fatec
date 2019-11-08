       program-id. Meses as "Meses".

       data division.

       working-storage section.
       01 Opcao pic x value spaces.
       01 Meses-Ano.
           02 filler pic x(9) value "JANEIRO".
           02 filler pic x(9) value "FEVEREIRO".
           02 filler pic x(9) value "MARÇO".
           02 filler pic x(9) value "ABRIL".
           02 filler pic x(9) value "MAIO".
           02 filler pic x(9) value "JUNHO".
           02 filler pic x(9) value "JULHO".
           02 filler pic x(9) value "AGOSTO".
           02 filler pic x(9) value "SETEMBRO".
           02 filler pic x(9) value "OUTUBRO".
           02 filler pic x(9) value "NOVEMBRO".
           02 filler pic x(9) value "DEZEMBRO".
           
       01 Tabela-Meses redefines Meses-Ano.
           02 mes-t pic x(9) occurs 12 times.

       01 Data-qualquer.
           02 dia pic 99 value zeros.
           02 mes pic 99 value zeros.
           02 ano pic 99 value zeros.
           screen section
           
           02 TELA.
               
       procedure division.

       INICIO.
           PERFORM CORPO UNTIL OPCAO = "N".
           DISPLAY "Fim de Programa" AT 2030.
           STOP RUN.
       
       CORPO.
           PERFORM ABERTURA.
           PERFORM RECEBE-DIA UNTIL DIA >= 1 AND <= 31.
           PERFORM RECEBE-MES UNTIL MES >= 1 AND <= 12.
           PERFORM RECEBE-ANO UNTIL ANO >0.
           PERFORM MOSTRA.
           PERFORM CONTINUA UNTIL OPCAO = "S" OR "N".
           
        ABERTURA
           DISPLAY ERASE AT 0101.
           DISPLAY TELA.
       
       RECEBE-DIA.
           ACCEPT DIA AT 1240 WITH PROMPT AUTO.
       
       RECEBE-MES.
           ACCEPT MES AT 1243 WITH PROMPT AUTO.
       
       RECEBE-ANO.
           ACCEPT ANO AT 1246 WITH PROMPT AUTO.
           
       MOSTRA.
           DISPLAY "Data por extenso:" AT 1320.
           DISPLAY DIA "de" AT 1420.
           DISPLAY MES-T (MES)"de" AT 1432.
           DISPLAY ANO AT 1442.
       
       CONTINUA.
           DISPLAY "Continua (S/N)?" AT 1635.
           ACCEPT OPCAO AT 1650 WITH PROMPT AUTO.
       
       accept NUM-MES at 2040
       display "ESTAMOS NO MÊS DE "MES-T(NUM-MES) AT 2230.
       
           goback.

       end program Meses.
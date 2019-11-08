        IDENTIFICATION DIVISION.
        PROGRAM-ID. BANCO-INLINE.
        ENVIRONMENT DIVISION.
        CONFIGURATION SECTION.
        SPECIAL-NAMES.
        DECIMAL-POINT IS COMMA.
        INPUT-OUTPUT SECTION.
        FILE-CONTROL.
            SELECT CLIENTE ASSIGN TO DISK
            ORGANIZATION INDEXED
            ACCESS MODE DYNAMIC
            RECORD KEY CD_CLIENTE-P
            FILE STATUS ARQST.
        DATA DIVISION.
        FILE SECTION.

        FD CLIENTE LABEL RECORD STANDARD
               DATA RECORD IS REG-CLIENTE
               VALUE OF FILE-ID IS "CLIENTE.DAT".

        01 REG-CLIENTE.
           02 CD_CLIENTE-P PIC 9(4).
           02 NOME-P PIC X(30).
           02 CPF-P PIC 9(11).
           02 AGENCIA-P PIC 9(5).
           02 CONTA-CORRENTE-P PIC X(10).
           02 IDADE-P PIC 9(3).
           02 SEXO-P PIC X(01).
           02 SALDO-P PIC 9(5)V99.
           02 DEPOSITO-P PIC 9(5)V99.
           02 SALARIO-P PIC 9(5)V99.
           02 LIMITE-P PIC 9(5)V99.

        WORKING-STORAGE SECTION.

        01 ESPACO PIC X(30) VALUE SPACES.
        01 CPF-DIGITOS OCCURS 11 TIMES.
            02 CPFDIG PIC 9(1) VALUE ZEROES.

        01 VARIAVEIS.
             02 CD_CLIENTE PIC 9(4) VALUE ZEROES.
             02 NOME PIC X(30) VALUE SPACES.
             02 CPF PIC 9(11)   VALUE ZEROS.
             02 SOMA1 PIC 9(3) VALUE ZEROS.
             02 SOMA2 PIC 9(3) VALUE ZEROS.
             02 RESTO1 PIC 9(2) VALUE ZEROS.
             02 RESTO2 PIC 9(2) VALUE ZEROS.
             02 DIGV1 PIC 9(1) VALUE ZEROS.
             02 DIGV2 PIC 9(1) VALUE ZEROS.
             02 I PIC 99 VALUE ZEROES.
             02 AGENCIA PIC 9(5) VALUE ZEROES.
             02 CONTA-CORRENTE PIC X(10) VALUE SPACES.
             02 IDADE PIC 9(3) VALUE ZEROS.
               88 IDADE-18-150 VALUE 18 THRU 150.
             02 SEXO PIC X(01) VALUE SPACES.
               88 FM VALUE "F" "M" "f" "m".
             02 SALDO PIC 9(05)V99 VALUE ZEROS.
             02 DEPOSITO PIC 9(5)V99 VALUE ZEROS.
             02 SAQUE PIC 9(5)V99 VALUE ZEROS.
             02 SALARIO PIC 9(5)V99 VALUE ZEROS.
             02 LIMITE PIC 9(5)V99 VALUE ZEROS.
             02 WS-CONT PIC X(1) VALUE SPACES.
             02 ARQST PIC X(2).
             02 OPCAO PIC X(1) VALUE SPACES.
             02 SALVA PIC X(1) VALUE SPACES.
             02 IGUAL PIC 9 VALUE ZEROS.



        01 MENSAGENS-DE-CRITICA.
             02 MENSA1 PIC X(30) VALUE
             "CODIGO INVALIDO <REDIGITE>".
             02 MENSA2 PIC X(30) VALUE
             "NOME INVALIDO <REDIGITE>".
             02 MENSA3 PIC X(40) VALUE
             "CPF INVALIDO <REDIGITE>".
             02 MENSA4 PIC X(30) VALUE
             "AGENCIA INVALIDA <REDIGITE>".
             02 MENSA5 PIC X(50) VALUE
             "CONTA CORRENTE INVALIDA <REDIGITE>".
             02 MENSA6 PIC X(30) VALUE
             "IDADE INVALIDA <REDIGITE>".
             02 MENSA7 PIC X(30) VALUE
             "SEXO INVALIDO <REDIGITE>".
             02 MENSA8 PIC X(30) VALUE
             "VALOR INVALIDO <REDIGITE>".
             02 MENSA9 PIC X(40) VALUE
             "SALARIO INVALIDO <REDIGITE>".
             02 MENSA10 PIC X(30) VALUE
             "OPCAO INVALIDA <REDIGITE>".
             02 MENSA11 PIC X(30) VALUE
             "FIM DE PROGRAMA".
             02 MENSA12 PIC X(30) VALUE SPACES.


        01 DATA-DO-SISTEMA.
             02 ANO PIC 9(02) VALUE ZEROS.
             02 MES PIC 9(02) VALUE ZEROS.
             02 DIA PIC 9(02) VALUE ZEROS.


        SCREEN SECTION.
        01 EASTER-EGG-BATMAN.



             02 BLANK SCREEN.

       02 LINE 03 COLUMN 15 VALUE
       "       _==/           i     i           \==_       ".
       02 LINE 04  COLUMN 15 VALUE
       "      /XX/            |\___/|            \XX\      ".
       02 LINE 05  COLUMN 15 VALUE
       "    /XXXX\            |XXXXX|            /XXXX\    ".
       02 LINE 06  COLUMN 15 VALUE
       "   |XXXXXX\_         _XXXXXXX_         _/XXXXXX|   ".
       02 LINE 07  COLUMN 15 VALUE
       "  XXXXXXXXXXXxxxxxxxXXXXXXXXXXXxxxxxxxXXXXXXXXXXX  ".
       02 LINE 08  COLUMN 15 VALUE
       " |XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX| ".
       02 LINE 09  COLUMN 15 VALUE
       " XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX ".
       02 LINE 10  COLUMN 15 VALUE
       " |XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX| ".
       02 LINE 11  COLUMN 15 VALUE
       "  XXXXXX/^^^^ \XXXXXXXXXXXXXXXXXXXXX/^^^^^\XXXXXX  ".
       02 LINE 12  COLUMN 15 VALUE
       "   |XXX|       \XXX/^^\XXXXX/^^\XXX/       |XXX|  ".
       02 LINE 13  COLUMN 15 VALUE
       "     \XX\       \X/    \XXX/    \X/       /XX/    ".
       02 LINE 14  COLUMN 15 VALUE
       "         \              \X/              /       ".
       02 LINE 16 COLUMN 15 VALUE "HELLO, SIR WAYNE,".

       02 LINE 17 COLUMN 15 VALUE "YOUR CREDIT IS INFINITE.".

        01 TELA.
             02 BLANK SCREEN.
             02 LINE 02 COLUMN 28 VALUE

              "B A N C O  I N L I N E".
             02 LINE 04 COLUMN 21 VALUE "CD.: ".
             02 LINE 04 COLUMN 33 VALUE "NOME  ".
             02 LINE 06 COLUMN 21 VALUE "CPF    ".
             02 LINE 08 COLUMN 21 VALUE "AGENCIA    ".
             02 LINE 10 COLUMN 21 VALUE "CONTA CORRENTE    ".
             02 LINE 12 COLUMN 21 VALUE "IDADE    ".
             02 LINE 14 COLUMN 21 VALUE "SEXO    ".
             02 LINE 16 COLUMN 21 VALUE "DEPOSITO INICIAL    ".
             02 LINE 18 COLUMN 21 VALUE "SALARIO    ".

      *      02 LINE 20 COLUMN 21 VALUE "CONTINUA (S/N) < >".
             02 LINE 22 COLUMN 21 VALUE
             "+----------------MENSAGEM----------------+ ".
             02 LINE 23 COLUMN 21 VALUE "|".
             02 LINE 23 COLUMN 62 VALUE "|".
             02 LINE 24 COLUMN 21 VALUE
             "+----------------------------------------+ ".

        PROCEDURE DIVISION.


        ROT-INICIO.
            PERFORM ABRE-ARQ.
            PERFORM ROT-INCLUIR UNTIL OPCAO = "N".
            CLOSE CLIENTE.
            STOP RUN.

        ABRE-ARQ.
            OPEN I-O CLIENTE.
            IF ARQST NOT = "00"
                CLOSE CLIENTE
                OPEN OUTPUT CLIENTE.

        ROT-INCLUIR.
             PERFORM ROT-ABERTURA.
             PERFORM ROT-RECEBE.
             PERFORM ROT-CONTINUA UNTIL OPCAO = "S" OR "N" OR "s" OR
             "n".


        ROT-ABERTURA.
            DISPLAY TELA.
            ACCEPT DATA-DO-SISTEMA FROM DATE.
            DISPLAY  DIA "/" MES "/" ANO AT 0107.
            MOVE SPACES TO SEXO NOME CONTA-CORRENTE ARQST.
            MOVE ZEROS TO CD_CLIENTE I SOMA1 SOMA2
            CPF AGENCIA IDADE DEPOSITO SAQUE
            SALDO SALARIO LIMITE DIGV1 DIGV2 AGENCIA
            RESTO1 RESTO2.
            MOVE SPACE TO WS-CONT OPCAO SALVA SEXO-P.
            MOVE SPACES TO NOME-P CONTA-CORRENTE-P.
            MOVE ZEROS TO CPF-P CD_CLIENTE-P
            AGENCIA-P IDADE-P SALDO-P SALARIO-P LIMITE-P.

        ROT-RECEBE.
            PERFORM ROT-CODIGO UNTIL CD_CLIENTE > 0.
            PERFORM ROT-NOME.
            PERFORM ROT-CPF.
            PERFORM ROT-AGENCIA.
            PERFORM ROT-CONTA-CORRENTE.
            PERFORM ROT-IDADE.
            PERFORM ROT-SEXO.
            PERFORM ROT-SALDO.
            PERFORM ROT-DEPOSITO-INICIAL.
            PERFORM ROT-SALARIO.
            PERFORM ROT-LIMITE.
            PERFORM ROT-GRAVA UNTIL SALVA = "S" OR = "N" OR = "s" OR
            "n".

        ROT-CODIGO.
            SET IGUAL TO 0.
            ACCEPT CD_CLIENTE AT 0426 WITH PROMPT AUTO.
            DISPLAY MENSA12 AT 2331.
            MOVE CD_CLIENTE TO CD_CLIENTE-P.
            IF CD_CLIENTE = ZEROES
            THEN
                DISPLAY MENSA1 AT 2323
            ELSE
               READ CLIENTE NOT INVALID KEY
                   DISPLAY "JA CADASTRADO" AT 2323
                   PERFORM ROT-CODIGO
               END-READ
                   DISPLAY MENSA12 AT 2323
            END-IF.
      ******************************************************************
      * JA-CADASTRADO.
      *     DISPLAY "JA CADASTRADO" AT 2323.
      *     SET IGUAL TO 1.
      *     MOVE SPACE TO SEXO-P.
      *     MOVE SPACES TO NOME-P CONTA-CORRENTE-P.
      *     MOVE ZEROS TO CD_CLIENTE-P CPF-P
      *     AGENCIA-P IDADE-P SALDO-P DEPOSITO-P SALARIO-P LIMITE-P.
      *****************************************************************

        ROT-NOME.
            ACCEPT  NOME WITH PROMPT AT 0439.
            DISPLAY MENSA12 AT 2331.
            MOVE NOME TO NOME-P
            IF NOME-P = "BATMAN"
               DISPLAY ERASE AT 0101
               DISPLAY EASTER-EGG-BATMAN STOP RUN
               DISPLAY MENSA11 AT 2323.

            IF NOME-P <> SPACES
                 DISPLAY MENSA12 AT 2323
            ELSE
                 DISPLAY  MENSA2 AT 2323 PERFORM ROT-NOME.

        ROT-CPF.
             ACCEPT CPF AT 0639 WITH PROMPT AUTO.
             MOVE CPF TO CPF-P.
             IF CPF = ZEROS OR CPF = 11111111111 OR CPF= 22222222222
                         OR CPF = 33333333333 OR CPF= 44444444444
                         OR CPF = 55555555555 OR CPF= 66666666666
                         OR CPF = 77777777777 OR CPF= 88888888888
                         OR CPF = 99999999999
                DISPLAY MENSA3 AT 2323 PERFORM ROT-CPF
             ELSE
                PERFORM VARYING I FROM 1 BY 1 UNTIL I > 11
                   COMPUTE CPFDIG(I) = FUNCTION MOD (CPF , 10)
                   COMPUTE CPF = CPF / 10
                END-PERFORM
      *# VERIFICACAO DO DIGITO 1
                COMPUTE SOMA1 = (CPFDIG(1)* 10) + (CPFDIG(2)* 9)
                              + (CPFDIG(3)*  8) + (CPFDIG(4)* 7)
                              + (CPFDIG(5)*  6) + (CPFDIG(6)* 5)
                              + (CPFDIG(7)* 4) + (CPFDIG(8)* 3)
                              + (CPFDIG(9)*  2)
                   COMPUTE RESTO1 = FUNCTION MOD (SOMA1, 11)
               IF RESTO1 < 2
                   COMPUTE DIGV1 = 0
               ELSE
                   COMPUTE RESTO1 = 11 - RESTO1
                   COMPUTE DIGV1  = RESTO1
               END-IF
      *  VERIFICACAO DO DIGITO 2
               COMPUTE SOMA2 =  (CPFDIG(1)* 11) + (CPFDIG( 2) * 10)
                               + (CPFDIG(3)*  9) + (CPFDIG( 4) *  8)
                               + (CPFDIG(5)*  7) + (CPFDIG( 6) *  6)
                               + (CPFDIG(7)*  5) + (CPFDIG( 8) *  4)
                               + (CPFDIG(9)*  3) + (CPFDIG(10)*  2)
               COMPUTE RESTO2 = FUNCTION MOD (SOMA2, 11)

                 IF RESTO2 < 2
                      COMPUTE DIGV2 = 0
                 ELSE
                      COMPUTE RESTO2 = 11 - RESTO2
                      COMPUTE DIGV2  = RESTO2
                 END-IF

                 IF CPFDIG(10) = DIGV1 AND CPFDIG(11) = DIGV2
                 THEN NEXT SENTENCE

                 ELSE DISPLAY MENSA3 AT 2323 PERFORM ROT-CPF.
      ******************************************************************
      *          DISPLAY CPFDIG(10) AT 2323
      *          DISPLAY DIGV1 AT 2324
      *          DISPLAY CPFDIG(11) AT 2326
      *          DISPLAY DIGV2 AT 2327
      *****************************************************************
             EXIT.

        ROT-AGENCIA.
             ACCEPT  AGENCIA WITH PROMPT AT 0839.
             DISPLAY  MENSA12 AT 2331.
             MOVE AGENCIA TO AGENCIA-P.
             IF AGENCIA <> SPACES
               DISPLAY MENSA12 AT 2323
             ELSE
               DISPLAY MENSA4 AT 2323 PERFORM ROT-AGENCIA.

        ROT-CONTA-CORRENTE.
             ACCEPT  CONTA-CORRENTE WITH PROMPT AT 1039.
             DISPLAY MENSA12 AT 2331.
             MOVE CONTA-CORRENTE TO CONTA-CORRENTE-P.
             IF CONTA-CORRENTE = SPACES
               DISPLAY MENSA5 AT 2323 PERFORM ROT-CONTA-CORRENTE
             ELSE
               DISPLAY MENSA12 AT 2323.

        ROT-IDADE.
             ACCEPT  IDADE WITH PROMPT AT 1239.
             DISPLAY  MENSA12 AT 2331.
             IF IDADE-18-150
                DISPLAY MENSA12 AT 2323
                MOVE IDADE TO IDADE-P
             NEXT SENTENCE
             ELSE DISPLAY MENSA6 AT 2323 PERFORM ROT-IDADE.


        ROT-SEXO.
             ACCEPT  SEXO WITH PROMPT AT 1439.
             DISPLAY MENSA12 AT 2331.
             IF FM
                DISPLAY MENSA12 AT 2323
                MOVE SEXO TO SEXO-P
             NEXT SENTENCE
             ELSE DISPLAY MENSA7 AT 2323 PERFORM ROT-SEXO.

        ROT-DEPOSITO-INICIAL.
             ACCEPT DEPOSITO WITH PROMPT AT 1639.
             DISPLAY MENSA12 AT 2331.
             IF DEPOSITO <=  0
               DISPLAY MENSA8 AT 2323 PERFORM ROT-DEPOSITO-INICIAL
               MOVE DEPOSITO TO DEPOSITO-P
               COMPUTE SALDO  = DEPOSITO
             ELSE
                DISPLAY MENSA12 AT 2323.


        ROT-SALARIO.
             ACCEPT SALARIO WITH PROMPT AT 1839.
             DISPLAY MENSA12 AT 2331.
             IF SALARIO <= 0
               DISPLAY MENSA9 AT 2323 PERFORM ROT-SALARIO
               MOVE SALARIO TO SALARIO-P
             ELSE
                DISPLAY MENSA12 AT 2323.

        ROT-SALDO.
             MOVE SALDO TO SALDO-P.
      *      DISPLAY MENSA8 AT 2323 PERFORM ROT-SALARIO
             DISPLAY MENSA12 AT 2323.

        ROT-LIMITE.
                COMPUTE LIMITE = SALDO * 1.10.
                MOVE LIMITE TO LIMITE-P.
      *         DISPLAY MENSA8 AT 2323 PERFORM ROT-LIMITE
                DISPLAY MENSA12 AT 2323.

      ******************************************************************
      * ROT-CONTINUA.
      *      ACCEPT WS-CONT WITH PROMPT AT 2033
      *      DISPLAY MENSA12 AT 2331.
      *      IF WS-CONT = "S" OR "s" GO TO  ROT-INICIO.
      *      IF WS-CONT = "N" OR "n" DISPLAY MENSA11 AT 2323 STOP RUN
      *      ELSE DISPLAY MENSA12 AT 2323 GO TO ROT-CONTINUA.
      ******************************************************************

        ROT-GRAVA.
            DISPLAY "SALVAR (S/N)?   [ ]" AT 2323.
            ACCEPT SALVA AT 2340.
            IF SALVA = "S" OR "s"
                WRITE REG-CLIENTE INVALID KEY STOP RUN.

        ROT-CONTINUA.
            DISPLAY "CONTINUA (S/N)? [ ]" AT 2323.
            ACCEPT OPCAO AT 2340.
            IF OPCAO = "S" OR = "N" OR = "s" OR "n"
                DISPLAY MENSA11 AT 2323
            ELSE
                DISPLAY "DIGITE S OU N" AT 2323
            END-IF.

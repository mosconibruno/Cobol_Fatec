       program-id. P2 as "P2".

       environment division.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           select arq-clientes assign to disk
           ORGANIZATION INDEXED
           access mode DYNAMIC
           RECORD key codigo
           file status arq-ok. 
       
       configuration section.

       data division.
       file SECTION.
       FD   arq-clientes label record standard
             value of FILE-ID is "Prova.DAT".
           01 RegistroBancario
               02 nome pic x(30)
               02 codigo pic 9(2) values 0
               02 saldo pic 9(3)v99.
       working-storage section.
           01 arq-ok pic x(02).
       
       screen section.
           01 Tela_cadastro.
               02 line 01 column 40 values "Cadastro de Cliente ".
               02 line 3 column 01 value "Digite seu nome :".
               02 line 4 column 01 value "Digite a quantia que deseja 
      -         "depositar"
       procedure division.
           display erase.
           display Tela_cadastro at 0101.

           goback.

       end program P2.

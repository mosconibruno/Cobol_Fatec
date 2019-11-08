       program-id. qwe as "qwe".

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
               02 nome_d pic x(30)
               02 codigo pic 9(2) values 0
               02 saldo-d pic 9(3)v99.
       working-storage section.
           01 arq-ok pic x(02).
           01 Dado .
               02 nome pic x(30).
               2 codigoP pic 9(2)
               2 saldo pic zz9.99.
               2 saldoB pic 9(3)v99.
       screen section.
           01 Tela_cadastro.
               02 line 01 column 40 values "Cadastro de Cliente ".
               02 line 3 column 01 value "Digite seu nome :".
               02 line 4 column 01 value "Digite a quantia que deseja "
     
            
       procedure division.
           display erase at 0101.
           display Tela_cadastro at 0101.
           accept nome at 0320 prompt auto.
           accept saldo at 0450.
       perform cadastro.
           
       cadastro.
           open input arq-clientes.
           compute codigo =codigo + 1.
           move nome to nome_d.
           move saldo to saldoB.
           move saldoB to saldo-d.
           write RegistroBancario INVALID key 
              
           END-WRITE.
           close arq-clientes.
       leitura.
       
           accept codigo at 0110.
           
           open OUTPUT arq-clientes.
           read arq-clientes INVALID key Display "ERRO"
           
           END-READ.
           close arq-clientes.
           display  nome_d saldo-d at 1001. 
           goback.

       end program qwe.

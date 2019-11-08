       program-id. SistemaBancario as "SistemaBancario".

       environment division.
       input-output section.
       file-control.
           select arq-banco assign to disk
           organization indexed
           access mode dynamic
           record key codigo
           file status arq-ok.
      
       configuration section.

       data division.
       file section.
       fd  arq-banco label record standard
           data record is reg-arqbc
           value of file-id is "arqbc.dat".
       01  reg-arqbc.
           02 codigo           pic 9(4).
           02 codigo-agencia   pic 9(4).
           02 codigo-cc        pic 9(9).
           02 nome             pic x(30).
           02 saldo            pic 9(5)v99.
       working-storage section.
       01 data-sis.
           02 ano pic 99.
           02 mes pic 99.
           02 dia pic 99.
       01 arq-ok pic x(2).
       01 senha pic x(6).
       01 dados-clientes.
           02 codigo-p         pic 9(4) value zeros.
           02 codigo-agencia-p pic 9(4) value 3265.
           02 codigo-cc-p      pic 9(9) value zeros.
           02 nome-p           pic x(30).
           02 saldo-p          pic 9(5)v99.
       screen section.
       01 Tela-Login.
           02 line 2 col 1 value "+-------SISTEMA BANCARIO-------+".
           02 line 3 col 1 value "|                              |".
           02 line 4 col 1 value "|   Bem-Vindo ao Banco BBVA    |".
           02 line 5 col 1 value "|                              |".
           02 line 6 col 1 value "|  Digite a senha de acesso:   |".
           02 line 7 col 1 value "|                              |".
           02 line 8 col 1 value "|                              |".
           02 line 9 col 1 value "|                              |".
           02 line 10 col 1 value"+------------------------------+ ".
           02 line 11 col 1 value " ".
           
       01 Tela-Inicio.
           02 line 2 col 1 value "+---------BANCO BBVA-----------+".
           02 line 3 col 1 value "|                              |".
           02 line 4 col 1 value "|  1. Incluir Conta Corrente   |".
           02 line 5 col 1 value "|  2. Alterar Conta Corrente   |".
           02 line 6 col 1 value "|  3. Excluir Conta Corrente   |".
           02 line 7 col 1 value "|  4. Consultar Conta Corrente |".
           02 line 8 col 1 value "|  5. Encerrar Sistema         |".
           02 line 9 col 1 value "|                              |".
           02 line 10 col 1 value"|  Digite sua opcao:           |".
           02 line 11 col 1 value"+------------------------------+".
           02 line 12 col 1 value " ".
       01 Tela-Inclusao.
           02 line 2 col 1 value "+--------INCLUIR CONTA---------+".
           02 line 3 col 1 value " ".
           02 line 4 col 1 value " Codigo Agencia:".
           02 line 5 col 1 value " Codigo CC:".
           02 line 6 col 1 value " Nome:".
           02 line 7 col 1 value " Saldo:".
           02 line 8 col 1 value " ".
       01 Tela-Consulta.
           02 line 2 col 1 value "+--------CONSULTAR CONTA---------+".
           02 line 3 col 1 value " ".
           02 line 4 col 1 value " Codigo Agencia:".
           02 line 5 col 1 value " Codigo CC:".
           02 line 6 col 1 value " Nome:".
           02 line 7 col 1 value " Saldo:".
           02 line 8 col 1 value " ".
       01 Tela-Altera.
           02 line 2 col 1 value "+--------ALTERAR CONTA---------+".
           02 line 3 col 1 value " ".
           02 line 4 col 1 value " Codigo Agencia:".
           02 line 5 col 1 value " Codigo CC:".
           02 line 6 col 1 value " Nome:".
           02 line 7 col 1 value " Saldo:".
           02 line 8 col 1 value " ". 
           
       procedure division.
       Inicio.
           display erase at 0101.
           accept data-sis from date.
           display "Data: " at 0205.
           display dia at 0211.
           display "/" at 0213.
           display mes at 0214.
           display "/" at 0216.
           display ano at 0217.
           display Tela-Login at 0401.
           
           

           goback.

       end program SistemaBancario.

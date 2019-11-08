       program-id. SistemaBancario as "SistemaBancario".
       environment division.
       configuration section.
       special-names.
       decimal-point is comma.
       input-output section.
       file-control.
           select arq-banco assign to disk
           organization indexed
           access mode dynamic
           record key cpf-p
           file status arq-ok.
           
           select cod-conta assign to disk
           organization line sequential
           access mode sequential
           file status arq-ok2.
      
       data division.
       file section.
       fd  arq-banco label record standard
           data record is reg-arqbc
           value of file-id is "arqbc.dat".
       01  reg-arqbc.
           02 cpf-p              pic 9(11).
           02 codigo-agencia-p   pic 9(4).
           02 codigo-cc-p        pic 9(9).
           02 nome-p             pic A(30).
           02 saldo-p            pic 9(5)v99.
           02 cont-p             pic 9(9).
       fd cod-conta label record standard
           data record reg-conta
           value of file-id is "codconta.dat".
       01 reg-conta.
           02 cod-p        pic 9(9).
       working-storage section.
       01 data-do-sistema.
           02 ano pic 9(2) value zeros.
           02 mes pic 9(2) value zeros.
           02 dia pic 9(2) value zeros.

       01 arq-ok pic x(2).
       01 arq-ok2 pic x(2).
       01 cpf-digitos occurs 11 times.
           02 cpfdig         pic 9(1) value zeros.
       01 dados-clientes.
           02 codigo-agencia pic 9(4) value 3265.
           02 codigo-cc      pic 9(9) value zeros.
           02 cpf            pic 9(11) value zeros.
           02 cpf-z          pic 999.999.999/99.
           02 cpf-valid      pic 9(11).
           02 nome           pic A(30).
           02 saldo          pic 9(5)v99.
           02 saldo-z        pic zz.zz9,99.
       01 variaveis.
           02 senha pic x(8) value spaces.
           02 cont pic 9(9) value zeros.
           02 salva pic x(1) value spaces.
           02 opcao pic x(1) value spaces.
           02 opcaoC pic x(1) value spaces.
           02 opcaoE pic x(1) value spaces.
           02 soma1 pic 9(3) value zeros.
           02 soma2 pic 9(3) value zeros.
           02 resto1 pic 9(2) value zeros.
           02 resto2 pic 9(2) value zeros.
           02 digv1 pic 9(1) value zeros.
           02 digv2 pic 9(1) value zeros.
           02 i pic 99 value zeros.
       01 d  pic 9(02).
       01 Mensagens-de-Erro.
             02 MENSA1 pic X(30) value
             "CODIGO INVALIDO <REDIGITE>".
             02 MENSA2 pic X(30) value
             "NOME INVALIDO <REDIGITE>".
             02 MENSA3 pic X(40) value
             "CPF INVALIDO <REDIGITE>".
             02 MENSA4 pic X(30) value
             "AGENCIA INVALIDA <REDIGITE>".
             02 MENSA5 pic X(50) value
             "CONTA CORRENTE INVALIDA <REDIGITE>".
             02 MENSA8 pic X(30) value
             "VALOR INVALIDO <REDIGITE>".
             02 MENSA9 pic X(30) value
             "SENHA INCORRETA <REDIGITE>".
             02 MENSA10 pic X(30) value
             "OPCAO INVALIDA <REDIGITE>".
             02 MENSA11 pic X(20) value
             "FIM DO PROGRAMA".
             02 LIMPA-MSG pic X(29) value spaces.
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
           02 line 14 col 1 value"+---------MENSAGEM-------------+".
           02 line 15 col 1 value"|".
           02 line 15 col 32 value "|".
           02 line 16 col 1 value"+------------------------------+".
           02 line 17 col 1 value" ".
           02 line 18 col 1 value " ".
           
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
           02 line 14 col 1 value"+---------MENSAGEM-------------+".
           02 line 15 col 1 value"|".
           02 line 15 col 32 value"|".
           02 line 16 col 1 value"+------------------------------+".
           02 line 17 col 1 value" ".
           02 line 18 col 1 value " ".
       01 Tela-Inclusao.
           02 line 2 col 1 value "+--------INCLUIR CONTA---------+".
           02 line 3 col 1 value " ".
           02 line 4 col 1 value " Codigo Agencia:                ".
           02 line 5 col 1 value " Codigo CC:                     ".
           02 line 6 col 1 value " Nome:                          ".
           02 line 7 col 1 value " CPF:                           ".
           02 line 8 col 1 value " Saldo: R$                      ".
           02 line 9 col 1 value " ".
           02 line 10 col 1 value "                                ".
           02 line 14 col 1 value"+---------MENSAGEM-------------+".
           02 line 15 col 1 value"|".
           02 line 15 col 32 value"|".
           02 line 16 col 1 value"+------------------------------+".
           02 line 17 col 1 value" ".
           02 line 18 col 1 value " ".
       01 Tela-Consultar.
           02 line 2 col 1 value "+--------CONSULTAR CONTA-------+".
           02 line 3 col 1 value " ".
           02 line 4 col 1 value " CPF:                           ".
           02 line 5 col 1 value "                                ".
           02 line 6 col 1 value "                                ".
           02 line 7 col 1 value "                                ".
           02 line 8 col 1 value "                                ".
           02 line 10 col 1 value "                                ".
           02 line 14 col 1 value"+---------MENSAGEM-------------+".
           02 line 15 col 1 value"|".
           02 line 15 col 32 value"|".
           02 line 16 col 1 value"+------------------------------+".
           02 line 17 col 1 value" ".
           02 line 18 col 1 value " ".
           
       01 Mostrar-Consulta.
           02 line 2 col 1 value "+--------CONSULTAR CONTA---------+".
           02 line 3 col 1 value " ".
           02 line 4 col 1 value " Codigo Agencia:                ".
           02 line 5 col 1 value " Codigo CC:                     ".
           02 line 6 col 1 value " Nome:                          ".
           02 line 7 col 1 value " CPF:                           ".
           02 line 8 col 1 value " Saldo: R$                      ".
           02 line 9 col 1 value " ".
           02 line 10 col 1 value "                                ". 
           02 line 14 col 1 value"+---------MENSAGEM-------------+".
           02 line 15 col 1 value"|".
           02 line 15 col 32 value"|".
           02 line 16 col 1 value"+------------------------------+".
           02 line 17 col 1 value" ".
           02 line 18 col 1 value " ".
           
       01 Tela-Alterar.
           02 line 2 col 1 value "+--------ALTERAR CONTA---------+".
           02 line 3 col 1 value " ".
           02 line 4 col 1 value " CPF:                           ".
           02 line 5 col 1 value "                                ".
           02 line 6 col 1 value "                                ".
           02 line 7 col 1 value "                                ".
           02 line 8 col 1 value "                                ".
           02 line 14 col 1 value"+---------MENSAGEM-------------+".
           02 line 15 col 1 value"|".
           02 line 15 col 32 value"|".
           02 line 16 col 1 value"+------------------------------+".
           02 line 17 col 1 value" ".
           02 line 18 col 1 value " ".
           
       01 Tela-Excluir.
           02 line 2 col 1 value "+--------EXCLUIR CONTA---------+".
           02 line 3 col 1 value " ".
           02 line 4 col 1 value " CPF:                           ".
           02 line 5 col 1 value "                                ".
           02 line 6 col 1 value "                                ".
           02 line 7 col 1 value "                                ".
           02 line 8 col 1 value "                                ".
           02 line 10 col 1 value "                                ".
           02 line 14 col 1 value"+---------MENSAGEM-------------+".
           02 line 15 col 1 value"|".
           02 line 15 col 32 value"|".
           02 line 16 col 1 value"+------------------------------+".
           02 line 17 col 1 value" ".
           02 line 18 col 1 value " ".    
       
       01 Mostrar-Excluir.
           02 line 2 col 1 value "+--------EXCLUIR CONTA---------+".
           02 line 3 col 1 value " ".
           02 line 4 col 1 value " Codigo Agencia:                ".
           02 line 5 col 1 value " Codigo CC:                     ".
           02 line 6 col 1 value " Nome:                          ".
           02 line 7 col 1 value " CPF:                           ".
           02 line 8 col 1 value " Saldo: R$                      ".
           02 line 9 col 1 value " ".
           02 line 10 col 1 value "                                ". 
           02 line 14 col 1 value"+---------MENSAGEM-------------+".
           02 line 15 col 1 value"|".
           02 line 15 col 32 value"|".
           02 line 16 col 1 value"+------------------------------+".
           02 line 17 col 1 value" ".
           02 line 18 col 1 value " ".
       
       01 Mostrar-Alterar.
           02 line 2 col 1 value "+--------ALTERAR CONTA---------+".
           02 line 3 col 1 value " ".
           02 line 4 col 1 value " Codigo Agencia:                ".
           02 line 5 col 1 value " Codigo CC:                     ".
           02 line 6 col 1 value " Nome:                          ".
           02 line 7 col 1 value " CPF:                           ".
           02 line 8 col 1 value " Saldo: R$                      ".
           02 line 9 col 1 value " ".
           02 line 10 col 1 value "                                ".
           02 line 14 col 1 value"+---------MENSAGEM-------------+".
           02 line 15 col 1 value"|".
           02 line 15 col 32 value"|".
           02 line 16 col 1 value"+------------------------------+".
           02 line 17 col 1 value" ".
           02 line 18 col 1 value " ".
           
       01 Easter-Egg-Batman.
       
       02 blank screen.

       02 line 03 column 15 value
       "       _==/           i     i           \==_       ".
       02 line 04  column 15 value
       "      /XX/            |\___/|            \XX\      ".
       02 line 05  column 15 value
       "    /XXXX\            |XXXXX|            /XXXX\    ".
       02 line 06  column 15 value
       "   |XXXXXX\_         _XXXXXXX_         _/XXXXXX|   ".
       02 line 07  column 15 value
       "  XXXXXXXXXXXxxxxxxxXXXXXXXXXXXxxxxxxxXXXXXXXXXXX  ".
       02 line 08  column 15 value
       " |XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX| ".
       02 line 09  column 15 value
       " XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX ".
       02 line 10  column 15 value
       " |XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX| ".
       02 line 11  column 15 value
       "  XXXXXX/^^^^ \XXXXXXXXXXXXXXXXXXXXX/^^^^^\XXXXXX  ".
       02 line 12  column 15 value
       "   |XXX|       \XXX/^^\XXXXX/^^\XXX/       |XXX|  ".
       02 line 13  column 15 value
       "     \XX\       \X/    \XXX/    \X/       /XX/    ".
       02 line 14  column 15 value
       "         \              \X/              /       ".
       02 line 16 column 15 value "OLA, SENHOR WAYNE,".
       02 line 17 column 15 value "SEU SALDO EH INFINITO.".
       02 line 18 column 15 value "O SENHOR COMPROU O BANCO.".
       02 line 19 column 1 value " ".

       procedure division.
       Inicio.
           display erase at 0101.
           accept data-do-sistema from date.
           perform Abre-Arq.
           perform Login.
           goback.
           
       Abre-Arq.
            open i-o arq-banco.
            if arq-ok not = "00"
                open output arq-banco
                close arq-banco
                open i-o arq-banco
            end-if.
            open input cod-conta.
            if arq-ok2 not = "00"
                open output cod-conta
                close cod-conta
                open input cod-conta
            end-if.
       
       Login.
           display erase at 0201.
           display dia at 0101 "/" mes "/" ano.
           move spaces to senha.
           display Tela-Login at 0201.
           accept senha lower at 0912 with prompt.
           if senha = "fatec123"
               perform Menu
           else
               display MENSA9 at 1603
               call "C$SLEEP" using "1,5"
               perform Login
           end-if.
           
       Menu.
           display erase at 0201.
           display dia "/" mes "/" ano at 0107.
           display Tela-Inicio at 0201.
           display LIMPA-MSG at 1603.
           move spaces to opcao.
           accept opcao at 1122 with prompt.
           evaluate true
               when opcao = 1 
                   perform Incluir
               when opcao = 2
                   perform Alterar
               when opcao = 3 
                  perform Excluir 
               when opcao = 4 
                  perform Consultar 
               when opcao = 5 
                   display MENSA11 at 1603
                   display " " at 1801
                   stop run
               when other
                   display MENSA10 at 1603
                   call "C$SLEEP" using "1,5"
                   perform Menu
               end-evaluate.
       Incluir.
           display erase at 0201.
           display dia "/" mes "/" ano at 0107.
           display Tela-Inclusao at 0201.
           display codigo-agencia at 0518.
           move codigo-agencia to codigo-agencia-p.
           read cod-conta into cont.
           move cod-p to cont.
           close cod-conta.
           compute codigo-cc = cont + 1.
           move codigo-cc to codigo-cc-p.
           compute cont = cont + 1.
           open output cod-conta.
           move cont to cod-p.
           write reg-conta.
           close cod-conta.
           move cont to cont-p.
           display codigo-cc at 0612.
           perform Recebe-Nome.
           perform Recebe-CPF.
           perform Recebe-Saldo.
           perform Gravar.
           perform Incluir-Nov.
           perform Continuar until opcaoC = "S" OR "N" OR "s" OR
             "n".
       Recebe-Nome.
           move spaces to nome.
           accept nome at 0708 with prompt.
           move nome to nome-p.
           if nome-p = "BATMAN" or "batman"
               display erase at 0101
               display Easter-Egg-Batman 
               stop run.
           if nome-p <> spaces
               display LIMPA-MSG AT 2323
           else
               display  MENSA2 AT 1603 
               call "C$SLEEP" using "1,5"
               display LIMPA-MSG at 1603
               perform Recebe-Nome.
       
       Recebe-CPF.
           move zeros to cpf.
           move zeros to cpf-z.
           move zeros to cpf-valid.
           accept cpf-z at 0807 with prompt.
           move cpf-z to cpf.
           move cpf to cpf-valid.
           if cpf = zeros or cpf = 11111111111 or cpf= 22222222222
                         or cpf = 33333333333 or cpf= 44444444444
                         or cpf = 55555555555 or cpf= 66666666666
                         or cpf = 77777777777 or cpf= 88888888888
                         or cpf = 99999999999
              display MENSA3 at 1603 
              call "C$SLEEP" using "1,5"
              display LIMPA-MSG at 1603 
              perform Recebe-CPF
           else
              perform varying i from 1 by 1 until i > 11
                 compute cpfdig(i) = function mod (cpf-valid , 10)
                 compute cpf-valid = cpf-valid / 10
              end-perform
      *# VERIFICACAO DO DIGITO 1
              compute soma1 = (cpfdig(1)* 10) + (cpfdig(2)* 9)
                              + (cpfdig(3)* 8) + (cpfdig(4)* 7)
                              + (cpfdig(5)* 6) + (cpfdig(6)* 5)
                              + (cpfdig(7)* 4) + (cpfdig(8)* 3)
                              + (cpfdig(9)* 2)
      *           compute resto1 = function mod (soma1, 11)
                  divide soma1 by 11 giving d remainder resto1
              if resto1 < 2
                 compute digv1 = 0
              else
                 compute resto1 = 11 - resto1
                 compute digv1  = resto1
              end-if
      *  VERIFICACAO DO DIGITO 2
              compute soma2 =  (cpfdig(1)* 11) + (cpfdig( 2) * 10)
                               + (cpfdig(3)* 9) + (cpfdig( 4) *  8)
                               + (cpfdig(5)* 7) + (cpfdig( 6) *  6)
                               + (cpfdig(7)* 5) + (cpfdig( 8) *  4)
                               + (cpfdig(9)* 3) + (cpfdig(10) *  2)
              compute resto2 = function mod (soma2, 11)

                 if resto2 < 2
                      compute digv2 = 0
                 else
                      compute resto2 = 11 - resto2
                      compute digv2  = resto2
                 end-if

                 if cpfdig(10) = digv1 and cpfdig(11) = digv2
                      move cpf to cpf-p
                      read arq-banco
                      not invalid key
                           display "CPF JA CADASTRADO" at 1603
                           call "C$SLEEP" using "1,5"
                           display LIMPA-MSG at 1603
                           perform Recebe-CPF
                 else
                      display MENSA3 at 1603
                      call "C$SLEEP" using "1,5"
                      display LIMPA-MSG at 1603
                      perform Recebe-CPF
                 end-if
             exit.
       Recebe-Saldo.
           move zeros to saldo-z.
           move zeros to saldo.
           accept saldo-z at 0912.
           move saldo-z to saldo.
           move saldo to saldo-p.
           display LIMPA-MSG AT 1603.
           if saldo <= 0
             display MENSA8 at 1603 
             call "C$SLEEP" using "1,5"
             display LIMPA-MSG at 1603
             perform Recebe-Saldo
           else
              display LIMPA-MSG at 1603.
              
       Incluir-Nov.
           display "DESEJA INCLUIR OUTRA CONTA (S/N)? [ ]" at 1202
                   move spaces to opcaoE
                   accept opcaoE at 1237
                   if opcaoE = "S" or "s"
                       display LIMPA-MSG at 1202
                       perform Incluir
                   else
                       if opcaoE = "N" or "n"
                           display LIMPA-MSG at 1202
                           perform Menu
                       else
                          move spaces to opcaoE
                          display MENSA10 at 1803
                          call "C$SLEEP" using "1,5"
                          display LIMPA-MSG at 1202
                          display LIMPA-MSG at 1803
                          perform Incluir-Nov.       
              
       Alterar.
           display erase at 0201.
           display dia "/" mes "/" ano at 0107.
           move zeros to cpf.
           move zeros to cpf-z.
           display Tela-Alterar at 0201.
           accept cpf-z at 0507 with prompt.
           move cpf-z to cpf.
           move cpf to cpf-p.
           read arq-banco
               invalid key
                   display "CPF NAO ENCONTRADO" at 1603
                   call "C$SLEEP" using "1,5"
                   display LIMPA-MSG at 1603
                   perform Alterar-Nov
                   perform Continuar
               not invalid key
                   display "CPF ENCONTRADO" at 1603
                   call "C$SLEEP" using "1,5"
                   display LIMPA-MSG at 1603
                   display Mostrar-Alterar at 0201
                   display codigo-agencia at 0518
                   display codigo-cc-p at 0612
                   display cpf-z at 0807
                   perform Recebe-Nome
                   perform Recebe-Saldo
                   perform Regravar
                   perform Alterar-Nov
           end-read.      
         
       Alterar-Nov.
           display "DESEJA ALTERAR OUTRA CONTA (S/N)? [ ]" at 1202
                   move spaces to opcaoE
                   accept opcaoE at 1237
                   if opcaoE = "S" or "s"
                       display LIMPA-MSG at 1202
                       perform Alterar
                   else
                       if opcaoE = "N" or "n"
                           display LIMPA-MSG at 1202
                           perform Menu
                       else
                          move spaces to opcaoE
                          display MENSA10 at 1603
                          call "C$SLEEP" using "1,5"
                          display LIMPA-MSG at 1202
                          display LIMPA-MSG at 1603
                          perform Alterar-Nov.  
           
       Excluir.
           display erase at 0201.
           display dia "/" mes "/" ano at 0107.
           move zeros to cpf.
           move zeros to cpf-z.
           display Tela-Excluir at 0201.
           accept cpf-z at 0507 with prompt.
           move cpf-z to cpf.
           move cpf to cpf-p.
           read arq-banco
               invalid key
                   display "CPF NAO ENCONTRADO" at 1603
                   call "C$SLEEP" using "1,5"
                   display LIMPA-MSG at 1603
                   perform Excluir-Nov
               not invalid key
                   display "CPF ENCONTRADO" at 1603
                   call "C$SLEEP" using "1,5"
                   display LIMPA-MSG at 1603
                   perform Excluir-Tela
                   perform Excluir-Def 
           end-read.
       
       Excluir-Tela.
           display Mostrar-Excluir at 0201.
           display codigo-agencia-p at 0518.
           display codigo-cc-p at 0612.
           display nome-p at 0708.
           move cpf-p to cpf-z.
           display cpf-z at 0807.
           move saldo-p to saldo-z.
           display saldo-z at 0912.
       
       Excluir-Def.
           display "DESEJA REALMENTE EXCLUIR (S/N)? [ ]" at 1202
                   move spaces to opcaoE
                   accept opcaoE at 1235
                   if opcaoE = "S" or "s"
                   delete arq-banco
                       not invalid key
                       display "EXCLUIDO COM SUCESSO" at 1603
                       call "C$SLEEP" using "1,5"
                       display erase at 0201
                       display dia "/" mes "/" ano at 0107
                       display Tela-Excluir at 0201
                       display LIMPA-MSG at 1603
                       display LIMPA-MSG at 1202
                       perform Excluir-Nov
                 perform Continuar until opcaoC = "S" OR "N" OR "s" OR
             "n"
                   else
                       if opcaoE = "N" or "n"
                           perform Excluir-Nov
                           perform Menu
                       else
                          move spaces to opcaoE
                          display MENSA10 at 1803
                          call "C$SLEEP" using "1,5"
                          display LIMPA-MSG at 1803
                          perform Excluir-Def.
       
       Excluir-Nov.
           display "DESEJA EXCLUIR OUTRA CONTA (S/N)? [ ]" at 1202
                   move spaces to opcaoE
                   accept opcaoE at 1237
                   if opcaoE = "S" or "s"
                       display LIMPA-MSG at 1202
                       perform Excluir
                   else
                       if opcaoE = "N" or "n"
                           display LIMPA-MSG at 1202
                           perform Menu
                       else
                          move spaces to opcaoE
                          display MENSA10 at 1803
                          call "C$SLEEP" using "1,5"
                          display LIMPA-MSG at 1202
                          display LIMPA-MSG at 1803
                          perform Excluir-Nov.
       
       Consultar.
           display erase at 0201.
           display dia "/" mes "/" ano at 0107.
           move zeros to cpf.
           move zeros to cpf-z.
           display Tela-Consultar at 0201.
           accept cpf-z at 0507 with prompt.
           move cpf-z to cpf.
           move cpf to cpf-p.
           read arq-banco
               invalid key
                   display "CPF NAO ENCONTRADO" at 1603
                   call "C$SLEEP" using "1,5"
                   display LIMPA-MSG at 1603
                   perform Consultar-Nov
                   perform Continuar
               not invalid key
                   display Mostrar-Consulta at 0201
                   display codigo-agencia-p at 0518
                   display codigo-cc-p at 0612
                   display nome-p at 0708
                   move cpf-p to cpf-z
                   display cpf-z at 0807
                   move saldo-p to saldo-z
                   display saldo-z at 0912
                   perform Consultar-Nov
               perform Continuar until opcaoC = "S" OR "N" OR "s" OR
             "n"
           end-read.
       
       Consultar-Nov.
           display "DESEJA CONSULTAR OUTRA CONTA (S/N)? [ ]" at 1202
                   move spaces to opcaoE
                   accept opcaoE at 1239
                   if opcaoE = "S" or "s"
                       display LIMPA-MSG at 1202
                       perform Consultar
                   else
                       if opcaoE = "N" or "n"
                           display LIMPA-MSG at 1202
                           perform Menu
                       else
                          move spaces to opcaoE
                          display MENSA10 at 1803
                          call "C$SLEEP" using "1,5"
                          display LIMPA-MSG at 1202
                          display LIMPA-MSG at 1803
                          perform Consultar-Nov.
       
       Gravar.
            display "SALVAR (S/N)?   [ ]" at 1603.
            display LIMPA-MSG at 1803.
            accept salva at 1620.
            if salva = "S" or "s"
                move spaces to salva
                write reg-arqbc
                invalid key
                   display "CPF JA CADASTRADO" at 1803
                   call "C$SLEEP" using "1,5"
                   display LIMPA-MSG at 1803
                   display LIMPA-MSG at 1603
                not invalid key
                   display "SALVO COM  SUCESSO" at 1803
                   call "C$SLEEP" using "1,5"
                   display LIMPA-MSG at 1803
                   display LIMPA-MSG at 1603
            else
               if salva = "N" or "n"
                   move spaces to salva
                   perform Continuar
               else
                   move spaces to salva
                   display MENSA10 at 1803
                   call "C$SLEEP" using "1,5"
                   perform Gravar 
            end-if.    
       
       Regravar.
            display "SALVAR (S/N)?   [ ]" at 1603.
            display LIMPA-MSG at 1803.
            move spaces to salva.
            accept salva at 1620.
            if salva = "S" or "s"
                move spaces to salva
                rewrite reg-arqbc
                invalid key
                   display "CPF JA CADASTRADO" at 1803
                   call "C$SLEEP" using "1,5"
                   display LIMPA-MSG at 1803
                   display LIMPA-MSG at 1603
                   perform Alterar-Nov
                not invalid key
                   display "SALVO COM  SUCESSO" at 1803
                   call "C$SLEEP" using "1,5"
                   display LIMPA-MSG at 1803
                   display LIMPA-MSG at 1603
                   perform Alterar-Nov
            else
               if salva = "N" or "n"
                   move spaces to salva
                   display LIMPA-MSG at 1603
                   perform Alterar-Nov
               else
                   move spaces to salva
                   display MENSA10 at 1803
                   call "C$SLEEP" using "1,5"
                   display LIMPA-MSG at 1803
                   display LIMPA-MSG at 1603
                   perform Regravar
            end-if.
                

       Continuar.
            display "VOLTAR AO MENU (S/N)? [ ]" at 1603.
            display LIMPA-MSG at 1803.
            accept opcaoC at 1626.
            if opcaoC = "S" or = "s"
                move spaces to opcaoC
                perform Menu
            else
               if opcaoC = "N" or "n"
                   move spaces to opcaoC
                   display MENSA11 at 1803
                   display spaces at 1801
                   stop run
               else
                   move spaces to opcaoC
                   display "DIGITE S OU N" at 1803
                   call "C$SLEEP" using "1,5"
                   perform Continuar
            end-if.

       end program SistemaBancario.
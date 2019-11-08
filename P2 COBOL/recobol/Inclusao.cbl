       program-id. Inclusao as "Inclusao".

       environment division.
       configuration section.

       data division.
       file section.
       FD  produtos labe record standard
           data record is reg-prod
           value of file-id is "PRODUTOS.DAT".
       01  reg-prod.
           02 codig-p pic 9(4).
           02 nome-p pic x(30).
           02 qtdade-p pic 9(4).
           02 unit-p pic 9(5)v99.
           02 total-p pic 9(6)v99.
           
       working-storage section.
       01 data-sis.
           02 ano pic 99.
           02 mes pic 99.
           02 dia pic 99.
       01 arqst pic x(2).
       01 opcao pic x(1) value spaces.
       01 salva pic x(1) value spaces.
       01 igual pic 9 value zeros.
       01 espaco pic x(30) value spaces.
       01 mens1 pic x(20) value "FIM DE PROGRAMA".
       01 dados-editados.
           02 codigo pic 9.999.
           02 nome pic x(30) value spaces.
           02 qt pic 9.999.
           02 unitario pic $ZZ.ZZ9,99.
           02 tot pic $ZZZ.ZZ9,99.
       
       screen section.
       
       01 tela.
           02 line 2 col 5 value "///".
           02 col 29 value "CONTROLE DE MERCADORIAS:".
           02 line 4 col 19 value "CODIGO DO PRODUTO:".
           02 line 6 col 19 value "NOME DO PRODUTO:".
           02 line 8 col 19 value "QUANTIDADE:".
           02 line 10 col 19 value "CUSTO UNITÁRIO:".
           02 line 12 col 19 value "CUSTO TOTAL:".
           02 line 15 col 25 value "MENSAGEM:".
           
       procedure division.
       
       INICIO.
           perform abre-arq.
           perform incluir until opcao = "N".
           display mens1 at 1535.
           close produtos.
           stop run.
           
       ABRE-ARQ.
           open I-O produtos.
           if arqst not = "00"
               close produtos
               open output produtos.
       
       INCLUIR.
           perform abertura.
           perform recebe.
           perform continua until opcao = "S" or "N".
           
       ABERTURA.
           display erase at 0101.
           display tela.
           accept data-sis from date.
           display dia at 0205.
           display mes at 0208.
           display ano at 0211.
           
       *///Inicialização das variáveis
       
           move spaces to opcao salva.
           move spaces to nome.
           move zeros to codigo qt unitario tot.
           move spaces to nome-p.
           move zeros to codig-p qtdade-p unit-p total-p.
           display espaco at 1535.
           
       RECEBE.
           perform testa-cod until codig-p > 0 and igual = 0.
           perform testa-nome until nome-p not = spaces.
           perform testa-qt until qtdade-p >= 10.
           perform testa-custo until unit-p > 0.
           perform calculo-total.
           perform grava until salva = "S" = "N".
           
       TESTA-COD.
           set igual to 0.
           accept codigo at 0438 with prompt auto.
           move codigo to codig-p.
           if codig-p = zeros
           then
               display "codigo igual zero" at 1535
           else
               read produtos not invalid key
               perform ja-cadastrado
               end-read
           end-if.
           
       JA-CADASTRADO.
           display "JA CADASTRADO" at 1535.
           set igual to 1.
           
       *///é preciso zerar novamente os campos
           move spaces to nome-p.
           move zeros to codig-p qtdade-p unit-p total-p.
           
       TESTA-NOME.
           accept nome at 0636 with prompt auto.
           move nome to nome-p.
           if nome-p = spaces
               display "DIGITE O NOME DO PRODUTO" at 1535
           else
               display espaco at 1535.
               
       TESTA-QT.
           accept nome at 0831 with prompt auto.
           move qt to qtdade-p.
           if qtdade-p < 10
               display "QUANTIDADE MÍNIMA = 10" at 1535
           else
               display espaco at 1535.
       
       TESTA-CUSTO.
           accept unitario at 1035 with prompt auto.
           move unitario to unit-p.
           if unit-p = zeros
               display "CUSTO INVÁLIDO" at 1535
           else
               display espaco at 1535.
               
       CALCULO-TOTAL.
           compute total-p = qtdade-p * unit-p.
           move total-p to tot.
           display tot at 1232.
           
       GRAVA.
           display "SALVAR (S/N)? []" at 1430.
           accept salva at 1445 with prompt auto.
           if salva = "S"
               write reg-prod invalid key stop run.
       
       CONTINUA.
           display "CONTINUA (S/N)? []" at 1430.
           accept opcao at 1445 with prompt auto.
           if opcao = "S" or "N"
           then
               display espaco at 1430
               display espaco at 1535
           else
               display espaco at 1535
               display "DIGITE S OU N" at 1535
           end-if.
       
           goback.

       end program Inclusao.

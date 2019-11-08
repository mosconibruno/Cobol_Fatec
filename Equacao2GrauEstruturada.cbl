       program-id. Equacao2GrauEstruturada as "Equacao2GrauEstruturada".

       environment division.
       configuration section.

       data division.
       working-storage section.
           01 equacao.
               02 a pic 9(2).
               02 b pic 9(2).
               02 c pic 9(2).
               02 d pic S9(3).
               02 x1 pic 9(2).
               02 x2 pic 9(2).
       screen section.
           01 tela1.
               02 line 01 column 01 value "--Programa Equacao 2 Grau--".
               02 line 02 column 01 value "Digite o valor de A: ".
               02 line 03 column 01 value "Digite o valor de B : ".
               02 line 04 column 01 value "Digite o valor de C : ".

       procedure division.
       Inicio.
           Perform Processo.
           Perform Saida.
           stop run.
       Processo.
           Perform Tela.
           Perform Entrada-Dados.
           Perform Calcula-Delta.
           Perform Calcula-x.
       Tela.
           display erase at 0101.
           display tela1 at 0101.
       Entrada-Dados.
           accept a at 0222.
           if a = 0 
               display "Digite outro valor para A" at 0501
               accept a at 0222.
           accept b at 0323.
           accept c at 0423.
       Calcula-Delta.
           compute d =  b*b - 4*a*c.
           Perform Resultado-Delta.
       Resultado-Delta.
           display "O valor de Delta eh: " at 0601.
           display d at 0622.
       Calcula-x.
           if d < 0
               display "Nao existe raiz" at 0701
               stop run
           else
               if d = 0
                   compute x1 = -b /(2*a)
                   display "O valor de x eh: " at 0901
                   display x1 at 0917
                   stop run
               else
                   compute x1 = -b + function sqrt(d) / (2*a)
                   compute x2 = -b - function sqrt(d) / (2*a).
           Perform Resultado-x.
       Resultado-x.
           display "O valor de x1 eh: " at 1101.
           display x1 at 1122.
           display "O valor de x2 eh: " at 1201.
           display x2 at 1222.
           display " " at 1301.
       Saida.
           
           display "----Programa Encerrado----" at 2501.
                   

       end program Equacao2GrauEstruturada.

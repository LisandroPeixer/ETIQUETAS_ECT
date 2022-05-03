@echo off
mode con:cols=80 lines=30
title REFUGO
color 4F  

::_________________________________________________________
::declarando variaveis
::_________________________________________________________

  set PRAZO= 0
  set DIA= 0 
  set MES= 0 
  set ANO= 0 
  set SAIDADIA= 0 
  set SAIDAMES= 0 
  set SAIDAANO= 0 
  set ACAO= 0
  set SIM= 0
  set ORDEM= 0
  set OBJETO= 0
  set NOME= 0
  set ULTIMO= 0

::__________________________________________________________
::algoritmo para controlar datas
::__________________________________________________________

  set PRAZO=90

  ::ENTRADA
  set DIA=%DATE:~0,2%
  set MES=%DATE:~3,2%
  set ANO=%DATE:~6%
  echo.
  ::echo ENTRADA %DIA%/%MES%/%ANO%
  echo.  

  ::FATOR
  set /a FATORDIA=1%DIA%%%100+%PRAZO%
  set /a FATORMES=1%MES%%%100*30  
  set /a FATOR=%FATORDIA%+%FATORMES%
  set /a FATORANO=%FATOR%/365
  ::echo %FATOR% dias

  ::SAIDA
  set /a SAIDAMES=%FATOR%/30
  set /a SAIDADIA=%FATOR%%%30
  set /a SAIDAANO=%ANO%

  ::MES+
  if %SAIDADIA% GEQ 30 (  
    set /a SAIDADIA=%FATORDIA%+1
    set /a SAIDAMES=%FATORMES%
  ) 

  ::ANO+
  if %SAIDAMES% GEQ 13 (  
    set /a SAIDAMES=%SAIDAMES%%%12
    set /a SAIDAANO=%ANO%+%FATORANO%
  )

  ::dia/
  set Dlength = 0 
  set D#=%SAIDADIA%
  :Dloop
    if defined D# ( 
      set D#=%D#:~1%
      set /A Dlength += 1
      goto Dloop 
    )
    IF %Dlength% == 1 ( 
      set SAIDADIA=0%SAIDADIA%
      ) else (
      set SAIDADIA=%SAIDADIA%
      )
    if %SAIDADIA% == 0 (
      set SAIDADIA=30
      )
      ::echo %Dlength%

  ::/mes
  set Mlength = 0
  set M#=%SAIDAMES%
  :Mloop
    if defined M# ( 
      set M#=%M#:~1%
      set /A Mlength += 1
      goto Mloop 
    )
    IF %Mlength% == 1 ( 
      set SAIDAMES=0%SAIDAMES%
      )  else (
        set SAIDAMES=%SAIDAMES%
      )
    if %SAIDADIA% == 00 (
      set SAIDADIA=30
      )
      ::echo %Mlength%

  ::echo %SAIDADIA:~0,2%
  ::echo %SAIDAMES:~0,2%
  ::echo SAIDA   %SAIDADIA%/%SAIDAMES%/%SAIDAANO%

::__________________________________________________________
::Cabecalho
::__________________________________________________________
  :INICIO
  cls

  setlocal enabledelayedexpansion

  set  arrayline[0]=    _________________________________________
  set  arrayline[1]=    I                                       I
  set  arrayline[2]=    I               REFUGO                  I
  set  arrayline[3]=    I_______________________________________I

  ::read it using a FOR /L statement
  for /l %%n in (0,1,3) do ( echo !arrayline[%%n]! )
  echo.
  echo %DIA%/%MES%/%ANO%
  echo.

::__________________________________________________________
::menu
::__________________________________________________________
  echo Oque voce deseja fazer?
  echo.
  echo Digite:  1 - Para pesquisar um REFUGO
  echo          2 - Para ver todos os REFUGOS
  echo          3 - Para adicionar um novo REFUGO
  echo          4 - Para atualizar um REFUGO
  echo          5 - Para BACKUP
  echo          6 - Para voltar ao MENU

   set /p ACAO= 
  if %ACAO%==1 (GOTO PESQUISA)
  if %ACAO%==2 (GOTO LISTA)
  if %ACAO%==3 (GOTO CADASTRO)
  if %ACAO%==4 (GOTO ATUALIZAR)
  if %ACAO%==5 (GOTO BACKUP)
  if %ACAO%==6 (GOTO SAIR) else (GOTO INICIO)

::__________________________________________________________
::algoritmo para pesquisar refugos
::__________________________________________________________

  :PESQUISA
  cls
  for /l %%n in (0,1,3) do ( echo !arrayline[%%n]! )
  echo.
  echo %DIA%/%MES%/%ANO%
  echo.
   set /p PESQUISA= Digite oque voce procura: 
  echo.
  echo OBJETO;         ENTRADA;      SAIDA;        ORDEM;    NOME;
  type cadastro.db | find /i "%PESQUISA%"
  echo.
  set SIM=0
  echo Deseja deletar estes objetos?
  echo Se nao houver objetos na pesquisa, nada sera deletado
  echo.
  echo Digite:  SIM  (para deletar)  
  echo          2  (para sair)
  set /p SIM= 
  if %SIM%==SIM ( GOTO DELETE )
  if %SIM%==2 ( GOTO INICIO ) else ( 
    echo opcao invalida tente novamente 
    PAUSE
    GOTO PESQUISA ) 

::__________________________________________________________
::algoritmo para deletar refugos
::__________________________________________________________

  :DELETE
  type cadastro.db | find /i "%PESQUISA%" /v > delete.txt
  type delete.txt > cadastro.db
  echo objeto deletado com sucesso
  echo.
  pause > nul
  echo.
  set SIM=0
  echo Deseja procurar mais um objeto?
  echo Digite:  1  (para procurar)  
  echo          2  (para sair)
  set /p SIM= 
  if %SIM%==1 ( GOTO PESQUISA )
  if %SIM%==2 ( GOTO INICIO ) else (
    echo opcao invalida tente novamente
    PAUSE
    GOTO PESQUISA )

::__________________________________________________________
::algoritmo para listar refugos
::__________________________________________________________

  :LISTA
  cls
  for /l %%n in (0,1,3) do ( echo !arrayline[%%n]! )
  echo.
  echo %DIA%/%MES%/%ANO%
  echo.
  echo LISTAGEM DE REFUGOS
  ::type cadastroBKP.db
  echo Deseja imprimir?
  echo Digite:  1  (para imprimir)
  echo Digite:  2  (para planilha)  
  echo          3  (para sair)
   set SIM= 0
   set /p SIM= 

  if %SIM%==1 (
    echo "<html><head><title></title><meta charset="utf-8"/><style>html, body {margin: -30px 0px 0px -12px; padding: 0px;} table, th, td {margin: 15px; padding: 0px; font-size:15px; width:300px; border: 1px solid black; border-collapse: collapse; text-align:center;} #sequencia{font-size:60px;} div {page-break-after:always;} div:last-child {page-break-after:avoid;} </style></head><body><div><table align=center>" > impressao.html

    for /f "tokens=5,1,2,3,4,5 delims=;" %%A in (cadastro.db) do (
      echo "<tr><td>%%A</td><td>%%B</td><td>%%C</td><td>%%D</td><td>%%E</td></tr>" >> impressao.html
    )

    echo "</table></div></body></html>" >> impressao.html
    start impressao.html
    PAUSE
    GOTO INICIO )

  if %SIM%==2 (
    type cadastro.db > cadastro.csv
    start cadastro.csv 
    GOTO INICIO )	

  if %SIM%==3 (
    GOTO INICIO
    ) else (
      echo opcao invalida tente novamente
      PAUSE
      GOTO LISTA )
  
::__________________________________________________________
::algoritmo para cadastrar refugos
::__________________________________________________________

  :CADASTRO
  cls
  for /l %%n in (0,1,3) do ( echo !arrayline[%%n]! )
  echo.
  set OBJETO= 0
  set NOME= 0
  echo %DIA%/%MES%/%ANO%
  echo.
   for /f "tokens=4,4* delims=;" %%U in (cadastro.db) do set ULTIMO=%%U

   set /a "ORDEM=%ULTIMO%+1" > nul
   echo Digite o objeto: 	
   set /p "OBJETO=>"
   echo Digite o nome: 
   set /p "NOME=>"
   set NOME="%NOME%"

   if %OBJETO% == 0 (
    echo opcao invalida tente novamente
    PAUSE
    GOTO CADASTRO
   )
    if %NOME% == 0 (
    echo opcao invalida tente novamente
    PAUSE
    GOTO CADASTRO
   )
  
  echo %OBJETO%;  %DIA%/%MES%/%ANO%;    %SAIDADIA%/%SAIDAMES%/%SAIDAANO%;    %ORDEM%;    %NOME:"=%; >> cadastro.db
   
::__________________________________________________________
::algoritmo para gerar etiquetas
::_________________________________________________________

  echo "<html><head><title></title><meta charset="utf-8"/><style>html, body {margin: 0px 0px 0px -12px; padding: 0px;} table, th, td {margin: 15px; padding: 0px; font-size:20px; width:300px; border: 1px solid black; border-collapse: collapse; text-align:center;} #sequencia{font-size:60px;} div {page-break-after:always;} div:last-child {page-break-after:avoid;} </style></head><body>" > impressao.html
 
  echo "<div><table align=center>    <tr>    <th>REFUGO</th>    <td>%OBJETO%</td>  </tr>  <tr><td colspan=2>%NOME:"=%</td></tr><tr><th colspan=2 id=sequencia>%ORDEM%</th>  </tr>   <tr>    <td>ENTRADA</td>    <td>%DIA%/%MES%/%ANO%</td>  </tr>  <tr>    <td>SAIDA</td>    <th>%SAIDADIA%/%SAIDAMES%/%SAIDAANO%</th>  </tr></table></div>" >> impressao.html 

  echo "</body></html>" >> impressao.html
  start impressao.html
  ::print USB003 impressao.html
  echo.
  echo.
  echo dados inseridos com sucesso!!!
  echo Deseja adicionar mais un objeto?
  echo Digite:  1  (para adicionar)  
  echo          2  (para sair)
   set SIM= 0
   set /p SIM= 
  if %SIM%==1 (GOTO CADASTRO)
  if %SIM%==2 (GOTO INICIO) else (
    opcao invalida tente novamente 
    PAUSE
    )
  GOTO CADASTRO

::__________________________________________________________
::algoritmo para atualizar registro
::_________________________________________________________
  :ATUALIZAR
  cls
  for /l %%n in (0,1,3) do ( echo !arrayline[%%n]! )
  echo.
  set OBJETO= 0
  set NOME= 0
  echo %DIA%/%MES%/%ANO%
  echo.
  ::PESQUISA
  set /p PESQUISA= Digite oque voce procura: 
  echo.
  echo OBJETO;         ENTRADA;      SAIDA;        ORDEM;    NOME;
  type cadastro.db | find /i "%PESQUISA%"
  echo.
  ::DELETA
  set OBJATUALIZAR=0 
  echo Qual objeto voce deseja atualiza?
  set /p OBJATUALIZAR= 
     if %OBJATUALIZAR% == 0 (
    echo opcao invalida tente novamente
    PAUSE
    GOTO ATUALIZAR
   )
  type cadastro.db | find /i "%OBJATUALIZAR%" /v > delete.txt
  type delete.txt > cadastro.db
  echo objeto deletado com sucesso
  echo.
  ::NOVO REGISTRO
  echo O objeto recebera um novo numero de ORDEM
  echo.
   for /f "tokens=4,4* delims=;" %%U in (cadastro.db) do set ULTIMO=%%U

   set /a "ORDEM=%ULTIMO%+1" > nul	

  set /p "OBJETO= Digite o objeto: " 
  echo Digite o nome: 
   set /p "NOME=>"
   set NOME="%NOME%"
  set /p "ENTRADA= Digite a data de entrada: " 
  set /p "SAIDA= Digite a data de saida: "

   if %OBJETO% == 0 (
    echo opcao invalida tente novamente
    PAUSE
    GOTO ATUALIZAR
   )
   if %NOME% == 0 (
    echo opcao invalida tente novamente
    PAUSE
    GOTO ATUALIZAR
   )
   if %ENTRADA% == 0 (
    echo opcao invalida tente novamente
    PAUSE
    GOTO ATUALIZAR
   )
   if %SAIDA% == 0 (
    echo opcao invalida tente novamente
    PAUSE
    GOTO ATUALIZAR
   )
  
  echo "<html><head><title></title><meta charset="utf-8"/><style>html, body {margin: 0px 0px 0px -12px; padding: 0px;} table, th, td {margin: 15px; padding: 0px; font-size:20px; width:300px; border: 1px solid black; border-collapse: collapse; text-align:center;} #sequencia{font-size:60px;} div {page-break-after:always;} div:last-child {page-break-after:avoid;} </style></head><body>" > impressao.html
 
  echo "<div><table align=center>    <tr>    <th>REFUGO</th>    <td>%OBJETO%</td>  </tr>  <tr><td colspan=2>%NOME:"=%</td></tr><tr><th colspan=2 id=sequencia>%ORDEM%</th>  </tr>   <tr>    <td>ENTRADA</td>    <td>%ENTRADA%</td>  </tr>  <tr>    <td>SAIDA</td>    <th>%SAIDA%</th>  </tr></table></div>" >> impressao.html 

  echo "</body></html>" >> impressao.html
  start impressao.html

  echo %OBJETO%;  %ENTRADA%;    %SAIDA%;    %ORDEM%;    %NOME:"=%; >> cadastro.db
  echo.
  echo dados atualizados com sucesso!!!
  echo.
  echo Deseja atualizar mais un objeto?
  echo Digite:  1  (para atualizar)  
  echo          2  (para sair)
   set SIM= 0
   set /p SIM= 
  if %SIM%==1 (GOTO ATUALIZAR)
  if %SIM%==2 (GOTO INICIO) else (opcao invalida tente novamente)
  GOTO ATUALIZAR

::_________________________________________________________
::algoritmo BACKUP
::_________________________________________________________
  :BACKUP
  cls
  type cadastro.db > cadastroBKP.db
  echo BACKUP realizado com sucesso
  PAUSE
  GOTO INICIO 
::_________________________________________________________
::algoritmo para navegacao
::_________________________________________________________

  :SAIR
  call MENU.bat


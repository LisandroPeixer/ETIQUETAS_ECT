@echo off
mode con:cols=50 lines=25
title ROTULOS_MALA
color a0

::_________________________________________________________
::declarando variaveis
::_________________________________________________________

  set PACSEDEX= 0
  set OETTO= 0
  set SERVICO= 0
  set DIRECAO= 0
  set FINAL= 0
  set INICIOMENU= 0

::__________________________________________________________
::algoritmo para controlar datas
::__________________________________________________________

  ::ENTRADA
  set /a DIA=%date:~0,2%
  if "%date:~0,2%" EQU "0" (set DIA=%date:~1,1%) else set DIA=%date:~0,2%
  set /a MES=%date:~3,2%
  if "%date:~3,2%" EQU "0" (set MES=%date:~4,1%) else set MES=%date:~3,2%
  set /a ANO=%date:~6%

::__________________________________________________________
::Cabecalho
::__________________________________________________________
  :INICIO
  cls

  setlocal enabledelayedexpansion

  set  arrayline[0]=    _________________________________________
  set  arrayline[1]=    I                                       I
  set  arrayline[2]=    I             ROTULOS_MALA              I
  set  arrayline[3]=    I_______________________________________I

  ::read it using a FOR /L statement
  for /l %%n in (0,1,3) do ( echo !arrayline[%%n]! )
  echo.
  echo %DIA%/%MES%/%ANO%
  echo.

::_________________________________________________________
::algoritmo para gerar etiquetas
::_________________________________________________________

  echo %DIA%/%MES%/%ANO%

  echo DIGITE 1 PARA PAC
  echo        2 PARA SEDEX: 
  set /p PACSEDEX=

  if %PACSEDEX% == 1 ( GOTO PAC )
  if %PACSEDEX% == 2 ( GOTO SEDEX ) else ( 
    echo OPCAO INVALIDA TENTE NOVAMENTE 
    pause
    GOTO INICIO
    )

  :PAC
    set SERVICO= PAC
    GOTO PACOETTO
  :SEDEX 
    set SERVICO= SEDEX
    set DIRECAO= CID-TTO-OE/PO 
    GOTO FINAL
  
  :PACOETTO  
  echo DIGITE 1 PARA OE
  echo        2 PARA TTO: 

  set /p OETTO=
  if %OETTO%==1 ( GOTO OE/PO )
  if %OETTO%==2 ( GOTO TTO/PO ) else ( 
    echo OPCAO INVALIDA TENTE NOVAMENTE 
    pause
    GOTO INICIO
    )
  :OE/PO
    set DIRECAO= OE/PO
    GOTO FINAL
  :TTO/PO
    set DIRECAO= TTO/PO 

  :FINAL
  echo SERVICO %SERVICO%
  echo DIRECAO %DIRECAO%
  echo DIGITE A QUANTIDADE DE ETIQUETAS: 
  set /p FINAL=
  echo "<html><head><title></title><meta charset="utf-8"/><style> html, body {margin: 0px 0px 0px -15px; padding: 0px;} table {margin: 0px 0px 0px 40px; padding: 0px; width:300px; text-align:center; border: 2px solid black; border-collapse: collapse;}  th {margin: 0px 0px 0px 0px; padding: 15px 0px 10px 0px; border: 1px solid black;} td {margin: 0px 0px 0px 0px; padding: 2px 2px 20px 2px; border: 1px solid black;} div {page-break-after:always;} div:last-child {page-break-after:avoid;} p{font-size: 20px; margin: 0px 0px 0px 0px;} .campo{text-align: left; font-size: 12; margin: 0px 0px 0px 0px;} .valor{margin: 0px 0px -15px 0px;}</style></head><body>" > impressao.html

  for /l %%I in (1 1 %FINAL%) do (
  echo "<div><table align=center><tr><th colspan="2"><p><b>CTCE FNS %DIRECAO%</b></p><p>88110-970</p></th ></tr>    <tr><td><p class="campo">Selo plastico</p></td ><td><p class="campo">Peso KG</p></td ></tr><tr><td><P class="campo">Origem</p><p class="valor"><b>PALHOCA</b></p></td ><td><p class="campo">Especie</p><p class="valor"><b>%SERVICO%</b></p></td ></tr></table></div>" >> impressao.html
  )
  echo "</body></html>" >> impressao.html
  start impressao.html
  ::print USB003 impressao.html
  echo.

::_________________________________________________________
::algoritmo para navegacao
::_________________________________________________________

  echo DIGITE 1 PARA MAIS ETIQUETAS
  echo        2 PARA VOLTAR AO MENU
  set /p INICIOMENU=
  if %INICIOMENU% == 1 (
    GOTO INICIO
  ) 
  if %INICIOMENU% == 2 (
    call MENU.bat
  ) else ( 
    echo opcao invalida tente novamente 
    pause
    goto INICIO
    )
  PAUSE


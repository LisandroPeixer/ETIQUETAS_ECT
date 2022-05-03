@echo off
mode con:cols=50 lines=25
title DATADOR
color 70

::_________________________________________________________
::declarando variaveis
::_________________________________________________________

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
  set  arrayline[2]=    I                DATADOR                I
  set  arrayline[3]=    I_______________________________________I

  ::read it using a FOR /L statement
  for /l %%n in (0,1,3) do ( echo !arrayline[%%n]! )
  echo.
  echo %DIA%/%MES%/%ANO%
  echo.
::__________________________________________________________
::algoritmo para gerar etiquetas
::_________________________________________________________

  echo DIGITE A QUANTIDADE DE ETIQUETAS COM 6 DATADORES: 
  set /p FINAL= 
 

  echo "<html><head><title></title><meta charset="utf-8"/><style> html, body {margin: 0px 0px 0px -15px; padding: 0px;} table {margin: -20px 0px 0px 40px; padding: 0px; width:320px; text-align:center;}  td {margin: 0px 0px 0px 0px; padding: 25px 14px 36px 0px; border: 0px solid black; background: url(fundoDatador.jpg); background-size: 105px 105px;} div {page-break-after:always;} div:last-child {page-break-after:avoid;} p{font-size: 15px; margin: 18px 0px 0px 15px;} </style></head><body>" > impressao.html

  for /l %%I in (1 1 %FINAL%) do (
  echo "<div><table align=center><tr><td><p><b>%DIA%/%MES%/%ANO%</b></p></td ><td><p><b>%DIA%/%MES%/%ANO%</b></p></td ><td><p><b>%DIA%/%MES%/%ANO%</b></p></td ></tr><tr><td><p><b>%DIA%/%MES%/%ANO%</b></p></td ><td><p><b>%DIA%/%MES%/%ANO%</b></p></td ><td><p><b>%DIA%/%MES%/%ANO%</b></p></td ></tr></table></div>" >> impressao.html
  )
  echo "</body></html>" >> impressao.html
  start impressao.html
  ::print Zebra_LP2844-Z impressao.html
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


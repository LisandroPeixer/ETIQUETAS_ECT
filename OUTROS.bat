@echo off
mode con:cols=50 lines=25
title OUTROS
color 2F  

::_________________________________________________________
::declarando variaveis
::_________________________________________________________

 set MALDEV= 0
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
  set  arrayline[2]=    I              ETIQUETAS                I
  set  arrayline[3]=    I_______________________________________I

  ::read it using a FOR /L statement
  for /l %%n in (0,1,3) do ( echo !arrayline[%%n]! )
  echo.
  echo %DIA%/%MES%/%ANO%
  echo.

::__________________________________________________________
::algoritmo para gerar etiquetas
::_________________________________________________________

  echo DIGITE 1 PARA MAL_ENCAMINHADO 
  echo        2 PARA DEVOLUCAO_A_PEDIDO
  set /p MALDEV=

  if %MALDEV% == 1 (
    set SERVICO= MAL_ENCAMINHADO
    GOTO FINAL
  ) 
  if %MALDEV% == 2 (
    set SERVICO= DEVOLUCAO_A_PEDIDO
    ) else ( 
    echo opcao invalida tente novamente 
    pause
    goto INICIO
    )
  :FINAL
  echo.   
  echo SERVICO %SERVICO%
  echo.
  echo DIGITE A QUANTIDADE DE ETIQUETAS: 
  set /p FINAL=
 
  echo "<html><head><title></title><meta charset="utf-8"/><style> html, body {margin: 0px 0px 0px -12px; padding: 0px;} div{margin-left:40px;} table {margin: auto; padding: 0px; width:300px; text-align:center; border: 2px solid black; border-collapse: collapse;}  th {margin: 0px 0px 0px 0px; padding: 15px 0px 10px 0px; border: 1px solid black;} td {margin: 0px 0px 0px 0px; padding: 2px 2px 20px 2px; border: 1px solid black;} div {page-break-after:always;} div:last-child {page-break-after:avoid;} p{font-size: 23px; margin: 0px 0px 0px 0px;} .campo{text-align: left; font-size: 12; margin: 0px 0px 0px 0px;} .valor{margin: 0px 0px -15px 0px;}</style></head><body>" > impressao.html

  for /l %%I in (1 1 %FINAL%) do (
  echo "<div><table align=center><tr><td colspan="2"><P class="campo">Motivo</p><p><b>%SERVICO%</b></p></td > </tr>    <tr><td><P class="campo">De</p><p class="valor">Palhoca</p></td ><td><p class="campo">Data</p><p class="valor"><b>%DIA%/%MES%/%ANO%</b></p></td ></tr><tr><td colspan="2"><p class="campo">Para</p><p class="valor"> CTCE FNS / 88110-970 </p></td ></tr></table></div>" >> impressao.html
  )
  echo "</body></html>" >> impressao.html
  start impressao.html
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


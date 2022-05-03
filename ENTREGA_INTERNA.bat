@echo off
mode con:cols=50 lines=25
title ENTREGA_INTERNA
color E0


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
  set  arrayline[2]=    I            ENTREGA_INTERNA            I
  set  arrayline[3]=    I_______________________________________I

  ::read it using a FOR /L statement
  for /l %%n in (0,1,3) do ( echo !arrayline[%%n]! )
  echo.
  echo %DIA%/%MES%/%ANO%
  echo.

::_________________________________________________________
::declarando variaveis
::_________________________________________________________

  set PRAZO=0
  set INICIO=0
  set FINAL=0
  set SAIDADIA=0
  set SAIDAMES=0
  set SAIDAANO=0
  set INICIOMENU=0
  set Mlength=0
  set Dlength=0

::__________________________________________________________
::algoritmo para gerar etiquetas
::_________________________________________________________
  set /p PRAZO=DIGITE O PRAZO: 
  if %PRAZO% == 0 ( 
    echo opcao invalida tente novamente 
    pause
    goto INICIO
    )
  
  ::ENTRADA
  set DIA=%DATE:~0,2%
  set MES=%DATE:~3,2%
  set ANO=%DATE:~6%
  echo.
  echo ENTRADA %DIA%/%MES%/%ANO%
  echo.  

  ::FATOR
  set /a FATORDIA=1%DIA%%%100+%PRAZO%
  set /a FATORMES=1%MES%%%100*30  
  set /a FATOR=%FATORDIA%+%FATORMES%
  set /a FATORANO=%FATOR%/365
  ::echo %FATOR% dias

  ::SAIDA
  set /a SAIDADIA=%FATOR%%%30
  set /a SAIDAMES=%FATOR%/30
  set /a SAIDAANO=%ANO%

  ::MES+
  if %SAIDADIA% GEQ 31 (  
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
  IF %Dlength% NEQ 2 ( 
    set SAIDADIA=0%SAIDADIA%
    ) else (
      set SAIDADIA=%SAIDADIA%
    )

   ::/mes
  set Mlength = 0
  set M#=%SAIDAMES%
  :Mloop
    if defined M# ( 
      set M#=%M#:~1%
      set /A Mlength += 1
      goto Mloop 
    )
  IF %Mlength% NEQ 2 ( 
    set SAIDAMES=0%SAIDAMES%
    )  else (
      set SAIDAMES=%SAIDAMES%
    )
   if %SAIDADIA% == 00 (
     set SAIDAMES=%MES%
     set SAIDADIA=30
     )

  ::echo %SAIDADIA:~0,2%
  ::echo %SAIDAMES:~0,2%
  echo SAIDA   %SAIDADIA%/%SAIDAMES%/%SAIDAANO% 
  echo.
  set /p INICIO=DIGITE O INICIO: 
  echo.
  set /p FINAL=DIGITE O FINAL: 

  echo "<html><head><title></title><meta charset="utf-8"/><style>html, body {margin: 0px 0px 0px -12px; padding: 0px;} div {margin-left: 40px} table, th, td {margin: 15px; padding: 0px; font-size:20px; width:300px; border: 1px solid black; border-collapse: collapse; text-align:center;} #sequencia{font-size:80px;} div {page-break-after:always;} div:last-child {page-break-after:avoid;} </style></head><body>" > impressao.html

  for /l %%I in (%INICIO% 1 %FINAL%) do (
  echo "<div><table align=center><tr><th colspan=2>ENTREGA INTERNA</th></tr><tr><th colspan=2 id=sequencia>%%I</th>  </tr>  <tr>    <td>ENTRADA</td>    <td>%DIA%/%MES%/%ANO%</td>  </tr>  <tr>    <td>SAIDA</td>    <th>%SAIDADIA%/%SAIDAMES%/%SAIDAANO%</th>  </tr></table></div>" >> impressao.html 
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


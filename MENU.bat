@echo off
mode con:cols=50 lines=25
title ETIQUETAS
color 1E

::_________________________________________________________
::declarando variaveis
::_________________________________________________________

 set ESCOLHA= 0

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
 
  echo DIGITE 1 PARA DATADOR
  echo        2 PARA DEVOLUCAO
  echo        3 PARA ENTREGA_INTERNA
  echo        4 PARA ROTULO_MALA
  echo        5 PARA OUTROS
  echo        6 PARA REFUGO
  echo        7 PARA SROWEB
  set /p ESCOLHA=

  if %ESCOLHA% == 1 (
    call DATADOR.bat
  ) 
  if %ESCOLHA% == 2 (
    call DEVOLUCAO.bat
  ) 
    if %ESCOLHA% == 3 (
    call ENTREGA_INTERNA.bat
  ) 
    if %ESCOLHA% == 4 (
    call ROTULO_MALA.bat
  )
    if %ESCOLHA% == 5 (
    call OUTROS.bat
  )
    if %ESCOLHA% == 6 (
    call REFUGO.bat
  )
    if %ESCOLHA% == 7 (
    call SROWEB.bat
  ) else ( 
    echo opcao invalida tente novamente 
    pause
    goto INICIO
    )

  PAUSE


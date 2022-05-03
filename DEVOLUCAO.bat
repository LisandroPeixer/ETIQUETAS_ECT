@echo off
mode con:cols=50 lines=25
title DEVOLUCAO
color 3f

::_________________________________________________________
::declarando variaveis
::_________________________________________________________

  set NAOREC= 0
  set MOTIVO= 0 
  set LIMUED= 0
  set USUARIO= 0
  set MATRICULA= 0
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
  set  arrayline[2]=    I              DEVOLUCAO                I
  set  arrayline[3]=    I_______________________________________I

  ::read it using a FOR /L statement
  for /l %%n in (0,1,3) do ( echo !arrayline[%%n]! )
  echo.
  echo %DIA%/%MES%/%ANO%
  echo.
::__________________________________________________________
::algoritmo para gerar etiquetas
::_________________________________________________________

  echo DIGITE 1 PARA Nao_procurado
  echo        2 PARA Recusado:
  set /p NAOREC=

  if %NAOREC% == 1 ( GOTO Nao_procurado )
  if %NAOREC% == 2 ( GOTO Recusado ) else ( 
    echo OPCAO INVALIDA TENTE NOVAMENTE 
    pause
    GOTO INICIO
    )
  :Nao_procurado
    set MOTIVO= Nao_procurado
  GOTO PROXIMO   
  :Recusado   
    set MOTIVO= Recusado
  :PROXIMO 
    
  echo DIGITE 1 PARA Lisandro_Peixer 
  echo        2 PARA Murillo_Rosa
  echo        3 PARA Eduardo_Luciano:
  set /p LIMUED=
  if %LIMUED% == 1 ( GOTO Lisandro_Peixer )
  if %LIMUED% == 2 ( GOTO Murillo_Rosa )
  if %LIMUED% == 3 ( GOTO Eduardo_Luciano ) else ( 
    echo OPCAO INVALIDA TENTE NOVAMENTE 
    pause
    GOTO INICIO
    )

  :Lisandro_Peixer   
    set USUARIO= Lisandro_Peixer
    set MATRICULA= 8.708.597-6
  GOTO PROXIMO1   
  :Murillo_Rosa
    set USUARIO= Murillo_Rosa
    set MATRICULA= 8.711.783-5
  GOTO PROXIMO1   
  :Eduardo_Luciano
    set USUARIO= Eduardo_Luciano
    set MATRICULA= 8.710.011-8
  GOTO PROXIMO1   

  :PROXIMO1
  echo MOTIVO %MOTIVO%
  echo USUARIO %USUARIO%
  echo MATRICULA %MATRICULA%
  echo.
  echo DIGITE A QUANTIDADE DE ETIQUETAS COM 3 DEVOLUCOES: 
  set /p FINAL=

  echo "<html><head><title></title><meta charset="utf-8"/><style> html, body {margin: 0px 0px 0px -15px; padding: 0px;} table {margin: 0px 0px 0px 40px; padding: 0px; width:300px; text-align:center;}  th {margin: 0px 0px 0px 0px; padding: 5px 1px; border: 1px solid black;} td {margin: 0px 0px 0px 0px; padding: 1px 1px 21px 1px; border: 1px solid black;background: url(fundoDatador.jpg); background-size: 105px 90px;} div {page-break-after:always;} div:last-child {page-break-after:avoid;} p{font-size: 12px; margin: 0px 0px 0px 0px;} .campo{text-align: center; font-size: 12px; margin: 30px 0px 20px 0px;} </style></head><body>"  > impressao.html

  for /l %%I in (1 1 %FINAL%) do (
  echo "<div><table align=center><tr><th><p>AO_REMETENTE</p></th ><th><p>AO_REMETENTE</p></th><th>  <p>AO_REMETENTE</p></th> </tr>    <th><p>%MOTIVO%</p></th ><th><p>%MOTIVO%</p></th><th>  <p>%MOTIVO%</p></th> </tr>    <tr><td><p class="campo">%DIA%/%MES%/%ANO%</p></td ><td><p class="campo">%DIA%/%MES%/%ANO%</p></td ><td><p class="campo">%DIA%/%MES%/%ANO%</p></td ></tr>    <th><p>%USUARIO%</p><p>%MATRICULA%</p></th ><th><p>%USUARIO%</p><p>%MATRICULA%</p></th><th>  <p>%USUARIO%</p><p>%MATRICULA%</p></th> </tr> </table></div>"  >> impressao.html
  )
  echo "</body></html>" >> impressao.html
  start impressao.html

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

@echo off
mode con:cols=80 lines=25
title Aviso_data
color 9f

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
  set  arrayline[2]=    I              Aviso_data               I
  set  arrayline[3]=    I_______________________________________I

  ::read it using a FOR /L statement

  :: ESTAGIO 1
  ::read it using a FOR /L statement
  for /l %%n in (0,1,3) do ( echo !arrayline[%%n]! )
  echo.
  echo %DIA%/%MES%/%ANO%
  echo.
  echo Voce esta alterando a data de um:

  rmdir /s aviso 
  mkdir aviso
  start aviso
  cls

  :: ESTAGIO 2
  ::read it using a FOR /L statement
  for /l %%n in (0,1,3) do ( echo !arrayline[%%n]! )
  echo.
  echo %DIA%/%MES%/%ANO%
  echo.
  echo 1 - Salve a lista nesta pasta  -  ctrl + C / ctrl + V
  echo 2 - feche a pasta              -  alt + F4
  echo.
  pause
  
  ren aviso\*.html Aviso.html
  //taskkill /f aviso
  cls

  :: ESTAGIO 3
  ::read it using a FOR /L statement
  for /l %%n in (0,1,3) do ( echo !arrayline[%%n]! )
  echo.
  echo %DIA%/%MES%/%ANO%
  echo. 


  echo DIGITE:   1  (para ALTERAR DATA)
  echo           2  (para RECOMECAR)
  echo           3  (para SAIR)
   set SIM=0
   set /p SIM= 

    if %SIM%==1 (

    echo  "<script>      const data = new Date();        let dataFormatada = prompt('digite a data dd/mm/aaaa:');      let tdata= document.getElementsByTagName('td');            for(let i=8; i<=tdata.length; i+=26) {                     var muda= tdata[i].innerHTML = '<b>À DISPOSIÇÃO PARA<br>RETIRADA ATÉ: <br></b>' + dataFormatada;         };         for(let i=19; i<=tdata.length; i+=26) {                     var usuario= tdata[i].innerHTML = 'Rubrica do empregado dos Correios:' + %username%;         }; </script> " >> Aviso\Aviso.html

    
    start aviso\aviso.html
    GOTO PROXIMO)

   :PROXIMO  
  cls

  :: ESTAGIO 4
  ::read it using a FOR /L statement
  for /l %%n in (0,1,3) do ( echo !arrayline[%%n]! )
  echo.
  echo %DIA%/%MES%/%ANO%

  echo.  
  echo Abra o arquivo salvo na area de trabalho
  echo.
  echo DIGITE:   2  (para RECOMECAR)
  echo           3  (para SAIR)
   set SIM=0


   set /p SIM= 
  if %SIM%==2 (
    GOTO INICIO  ) 

  if %SIM%==3 (
    call MENU.bat
    ) else (
      echo opcao invalida tente novamente
      GOTO INICIO )
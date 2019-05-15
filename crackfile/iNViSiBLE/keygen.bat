@echo off

set JAVA8="auto"
set JAR=confluence_keygen.jar

set X86="%ProgramFiles%"
if %JAVA8% == "auto" (
  echo Autodetecting java
  if %X86% NEQ "" (
    echo Testing x86 folder
    for /D %%j in ("%ProgramFiles%\jre8*" "%ProgramFiles%\jre1.8.*" "%ProgramFiles%\jdk1.8.*" "%ProgramFiles%\Java\jre8*" "%ProgramFiles%\Java\jre1.8.*" "%ProgramFiles%\Java\jdk1.8.*") do (
      echo Checking %%j folder
      if exist "%%j\bin\java.exe" (
        echo Found java in %%j folder
        set JAVA8="%%j\bin\java.exe"
      )
    )
  ) else (
    echo Testing default folder
    if defined ProgramFiles (
    for /D %%j in ("%ProgramFiles%\jre8*" "%ProgramFiles%\jre1.8.*" "%ProgramFiles%\jdk1.8.*" "%ProgramFiles%\Java\jre8*" "%ProgramFiles%\Java\jre1.8.*" "%ProgramFiles%\Java\jdk1.8.*") do (
        echo Checking %%j folder
        if exist "%%j\bin\java.exe" (
          echo Found java in %%j folder
          set JAVA8="%%j\bin\java.exe"
        )
      )
    )
  )
)

:rerun
if %JAVA8% == "auto" (
  echo ERROR: Java not found!
  echo Please download and install from java.com
  pause
  exit
) else (
  echo Starting java from %JAVA8%
  %JAVA8% -jar %JAR%

  if errorlevel 11 (
    if not exist %JAR% (
      echo ========================================
      echo Warning: %JAR% not not found.
      echo ========================================
    )

    echo ERROR: Failed to run %JAR%
    echo JAVA8=%JAVA8%
    pause
    exit
  )

  if errorlevel 10 (
    goto rerun
  )

  if errorlevel 1 (
    if not exist %JAR% (
      echo ========================================
      echo Warning: %JAR% not found.
      echo ========================================
    )

    echo ERROR: Failed to run %JAR%
    echo JAVA8=%JAVA8%
    pause
    exit
  )
)

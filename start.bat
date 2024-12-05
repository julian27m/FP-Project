@echo off
echo === Building Hummingbird ===
echo.
echo Compiling StringTools...
ozc -c StringTools.oz
if errorlevel 1 goto error

echo Compiling Core...
ozc -c Core.oz
if errorlevel 1 goto error

echo Compiling Main...
ozc -c Main.oz
if errorlevel 1 goto error

echo.
echo === Running Hummingbird ===
echo.
ozengine.exe Main.ozf
goto end

:error
echo.
echo Error during compilation!
pause
exit /b 1

:end
echo.
echo === Execution Complete ===
pause
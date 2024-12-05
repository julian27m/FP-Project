@echo off
echo Cleaning up Hummingbird build files...
if exist *.ozf (
    del *.ozf
    echo Successfully deleted .ozf files.
) else (
    echo No .ozf files found.
)
pause
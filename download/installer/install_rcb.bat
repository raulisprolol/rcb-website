@echo off
echo Installing RCB Programming Language...

:: Check if Visual Studio Build Tools are installed
where cl >nul 2>&1
if %errorlevel% neq 0 (
    echo Visual Studio Build Tools not found. Please install them first.
    echo Download from: https://visualstudio.microsoft.com/visual-cpp-build-tools/
    pause
    exit /b 1
)

:: Create installation directories
set RCB_HOME=%~dp0
set BIN_DIR=%RCB_HOME%bin
set LIB_DIR=%RCB_HOME%lib
set INCLUDE_DIR=%RCB_HOME%include

if not exist "%BIN_DIR%" mkdir "%BIN_DIR%"
if not exist "%LIB_DIR%" mkdir "%LIB_DIR%"
if not exist "%INCLUDE_DIR%" mkdir "%INCLUDE_DIR%"

:: Compile the compiler
echo Compiling RCB Compiler...
pushd "%RCB_HOME%compiler"
cl /Fe:"%BIN_DIR%\rcbcc.exe" compiler.c
if %errorlevel% neq 0 (
    echo Failed to compile compiler
    pause
    exit /b 1
)
popd

:: Compile the package manager
echo Compiling Package Manager...
pushd "%RCB_HOME%package-manager"
cl /Fe:"%BIN_DIR%\rcbpkg.exe" package_manager.c
if %errorlevel% neq 0 (
    echo Failed to compile package manager
    pause
    exit /b 1
)
popd

:: Copy header files
echo Copying header files...
copy "%RCB_HOME%graphics-lib\graphics.h" "%INCLUDE_DIR%" >nul

:: Create registry entry for file associations
reg add "HKCU\Software\Classes\.rcb" /ve /t REG_SZ /d "RCBFile" /f
reg add "HKCU\Software\Classes\RCBFile\Shell\Open\Command" /ve /t REG_SZ /d """%BIN_DIR%\rcbcc.exe"" ""%1""" /f

:: Add to PATH
echo Adding RCB to PATH...
setx PATH "%PATH%;%BIN_DIR%" /M

:: Create environment variables
setx RCB_HOME "%RCB_HOME%" /M
setx RCB_BIN "%BIN_DIR%" /M

:: Create uninstaller
echo @echo off > "%BIN_DIR%\uninstall_rcb.bat"
echo echo Uninstalling RCB Programming Language... >> "%BIN_DIR%\uninstall_rcb.bat"
echo rmdir /s /q "%RCB_HOME%" >> "%BIN_DIR%\uninstall_rcb.bat"
echo del /f /q "%0" >> "%BIN_DIR%\uninstall_rcb.bat"

:: Create shortcuts
set SHORTCUT_DIR=%APPDATA%\Microsoft\Windows\Start Menu\Programs\RCB
echo Creating shortcuts...
if not exist "%SHORTCUT_DIR%" mkdir "%SHORTCUT_DIR%"

:: Create RCB Compiler shortcut
powershell -Command "^$WshShell = New-Object -comObject WScript.Shell; ^$Shortcut = ^$WshShell.CreateShortcut('%SHORTCUT_DIR%\RCB Compiler.lnk'); ^$Shortcut.TargetPath = '%BIN_DIR%\rcbcc.exe'; ^$Shortcut.Save()"

:: Create RCB Package Manager shortcut
powershell -Command "^$WshShell = New-Object -comObject WScript.Shell; ^$Shortcut = ^$WshShell.CreateShortcut('%SHORTCUT_DIR%\RCB Package Manager.lnk'); ^$Shortcut.TargetPath = '%BIN_DIR%\rcbpkg.exe'; ^$Shortcut.Save()"

:: Create RCB Documentation shortcut
powershell -Command "^$WshShell = New-Object -comObject WScript.Shell; ^$Shortcut = ^$WshShell.CreateShortcut('%SHORTCUT_DIR%\RCB Documentation.lnk'); ^$Shortcut.TargetPath = '%RCB_HOME%\README.md'; ^$Shortcut.Save()"

echo Installation complete!
echo.
echo You can now use RCB by typing 'rcbcc' in your terminal.
echo.
echo To uninstall, run '%BIN_DIR%\uninstall_rcb.bat'.
pause

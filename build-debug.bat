if not defined in_subprocess (cmd /k set in_subprocess=y ^& %0 %*) & exit )

call common.bat

set OPTS= ^
	/ENTRY:start ^
	/SUBSYSTEM:WINDOWS ^
	/PRINT:IMPORTS ^
	/PRINT:LABELS

REM very slow unpack, avoid /TINYHEADER

%SHADER_MINIFIER% --format nasm --preserve-externals -o shader.inc shader.glsl || exit /b 1
%SHADER_MINIFIER% --format nasm --preserve-externals -o vertex.inc vertex.glsl || exit /b 1
%NASM% -fwin32 -o intro.obj -DDEBUG intro.asm || exit /b 2

%CRINKLER% ^
	%OPTS% ^
	%LIBS% ^
	intro.obj /OUT:intro-debug.exe ^
	|| exit /b 2

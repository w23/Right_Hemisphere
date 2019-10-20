set LIBS= /LIBPATH:libs opengl32.lib winmm.lib kernel32.lib user32.lib gdi32.lib
set OPTS= ^
	/ENTRY:entrypoint ^
	/CRINKLER ^
	/SUBSYSTEM:WINDOWS ^
	/UNSAFEIMPORT ^
	/NOINITIALIZERS ^
	/RANGE:opengl32 ^
	/PRINT:IMPORTS ^
	/PRINT:LABELS ^
	/TRANSFORM:CALLS ^
	/TINYIMPORT ^
	/TINYHEADER
set CLOPTS=/GS- /analyze- /W3 /Gy- /Zc:wchar_t /Zi /Gm- /O1 /Ob1 /sdl-  /Zc:inline /fp:fast /Zp1 /D "FULLSCREEN=1" /D "_MBCS" /errorReport:prompt /GF /WX- /Zc:forScope /GR- /arch:IA32 /Gz /Oy /MT /FC /nologo /Zl /FAcs /Os /diagnostics:classic /QIfist ^
	/D "NO_AUDIO" ^
	/c


shader_minifier.exe -o shader.glsl.h --preserve-externals shader.glsl
cl %CLOPTS% intro.c
REM /out:intro.o

REM nasm.exe -fwin32 -o intro.o intro.asm || exit /b 1

link.exe ^
	%OPTS% ^
	/COMPMODE:FAST /REPORT:report-fast.html ^
	%LIBS% ^
	intro.obj /OUT:intro-fast.exe ^
	|| exit /b 2

pause

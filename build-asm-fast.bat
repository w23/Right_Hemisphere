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

shader_minifier.exe --format nasm -o shader.glsl.inc shader.glsl

nasmw.exe -fwin32 -o 4klang.obj 4klang.asm
nasmw.exe -fwin32 -o intro.obj intro.asm

link.exe ^
	%OPTS% ^
	/COMPMODE:FAST /REPORT:report-asm-fast.html ^
	%LIBS% ^
	4klang.obj intro.obj /OUT:intro-asm-fast.exe

pause

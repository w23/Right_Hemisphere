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
	/TINYIMPORT

REM very slow unpack, avoid /TINYHEADER

python introgen.py --precision 4 --automation glsl shader.txt
shader_minifier.exe --format nasm -o shader.glsl.inc shader.glsl
python shaderpatch.py --patch shader.glsl.inc glsl

nasmw.exe -fwin32 -o 4klang.obj 4klang.asm
nasmw.exe -fwin32 -o intro.obj intro.asm

link.exe ^
	%OPTS% ^
	/COMPMODE:SLOW /ORDERTRIES:16000 /REPORT:report-asm-slow.html ^
	%LIBS% ^
	4klang.obj intro.obj /OUT:intro-asm-slow.exe

pause

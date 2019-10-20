#define COUNTOF(a) (sizeof(a)/sizeof(a[0]))

#ifndef WIDTH
#define WIDTH 1920
#endif
#ifndef HEIGHT
#define HEIGHT 1080
#endif

#ifdef _DEBUG
#ifdef FULLSCREEN
#undef FULLSCREEN
#endif
#define DEBUG_FUNCLOAD
#define SHADER_DEBUG
#endif

#if defined(CAPTURE)
#define NO_AUDIO
#include <stdio.h>
#ifdef __linux__
#include <unistd.h>
#include <stdlib.h>
#endif
#else
//#error not capture is not really supported
#endif

#ifdef _WIN32
#define WIN32_LEAN_AND_MEAN
#define WIN32_EXTRA_LEAN
#define VC_LEANMEAN
#define VC_EXTRALEAN
#include <windows.h>
#include <mmsystem.h>
#include <mmreg.h>
#include <GL/gl.h>
#include "glext.h"

#ifdef _DEBUG
//#pragma data_seg(".fltused")
int _fltused = 1;
#endif

#define WINGL_INPLACE
#ifdef WINGL_INPLACE
#define oglCreateShaderProgramv ((PFNGLCREATESHADERPROGRAMVPROC)wglGetProcAddress("glCreateShaderProgramv"))
#define oglUseProgram ((PFNGLUSEPROGRAMPROC)wglGetProcAddress("glUseProgram"))
#define oglGetUniformLocation ((PFNGLGETUNIFORMLOCATIONPROC)wglGetProcAddress("glGetUniformLocation"))
#define oglUniform1f ((PFNGLUNIFORM1FPROC)wglGetProcAddress("glUniform1f"))
#define oglUniform2f ((PFNGLUNIFORM2FPROC)wglGetProcAddress("glUniform2f"))
#else
#define oglCreateShaderProgramv gl.CreateShaderProgramv
#define oglUseProgram gl.UseProgram
#define oglGetUniformLocation gl.GetUniformLocation
#define oglUniform1f gl.Uniform1f
#endif

// debug
#define oglGetObjectParameteriv ((PFNGLGETOBJECTPARAMETERIVARBPROC) wglGetProcAddress("glGetObjectParameterivARB"))
#define oglGetInfoLog ((PFNGLGETINFOLOGARBPROC) wglGetProcAddress("glGetInfoLogARB"))

#elif defined(__linux__)
#define GL_GLEXT_PROTOTYPES
#include <GL/gl.h>

#define __stdcall
#define __forceinline inline __attribute__((always_inline))

#define oglCreateShaderProgramv glCreateShaderProgramv
#define oglUseProgram glUseProgram
#define oglGetUniformLocation glGetUniformLocation
#define oglUniform1f glUniform1f
#define oglUniform2f glUniform2f

// debug
#define oglGetObjectParameteriv glGetObjectParameterivARB
#define oglGetInfoLog glGetInfoLogARB
#endif

#ifdef CAPTURE
#define SHADER_DEBUG
#undef FULLSCREEN
#ifndef CAPTURE_FRAMERATE
#define CAPTURE_FRAMERATE 60
#endif
#define LOL(x) #x
#define STR(x) LOL(x)
static const char *FFMPEG_CAPTURE_INPUT = "ffmpeg.exe"
" -y -f rawvideo -vcodec rawvideo"
" -s " STR(WIDTH) "x" STR(HEIGHT) " -pix_fmt rgb24"
" -framerate " STR(CAPTURE_FRAMERATE)
" -i -"
" -f f32le -ar 44100 -ac 2"
" -i audio.raw"
" -c:a aac -b:a 160k"
" -c:v libx264 -vf vflip"
//" -c:v h264_nvenc -vf vflip"
//" -profile:v high444p -pixel_format yuv444p -preset slow"
" -movflags +faststart"
//" -level:v 4.2 -profile:v high -preset slower -crf 20.0 -pix_fmt yuv420p"
" -level:v 4.1 -preset slow -b:v 23M" //-crf 20.0"
//" -tune film"
" -tune grain"
//" -x264-params keyint=600:bframes=3:scenecut=60:ref=3:qpmin=10:qpstep=8:vbv-bufsize=24000:vbv-maxrate=24000:merange=32"
" capture_" STR(WIDTH) "x" STR(HEIGHT) ".mp4"
;

static GLubyte backbufferData[WIDTH*HEIGHT * 3];
#endif

#pragma data_seg(".shader.glsl")
#include "shader.glsl.h"

#include "automation.c"

#ifndef NO_AUDIO
#include "4klang.h"
#else
#define SAMPLE_TYPE float
#define SAMPLE_RATE 44100
#define MAX_SAMPLES (3 * 60 * 2 * SAMPLE_RATE)
#endif

/*
#define NOISE_SIZE 1024
static unsigned char noise_bytes[4 * NOISE_SIZE * NOISE_SIZE];
*/

#define FUNCLIST \
	FUNCLIST_DO(PFNGLCREATESHADERPROGRAMVPROC, CreateShaderProgramv) \
	FUNCLIST_DO(PFNGLUSEPROGRAMPROC, UseProgram) \
	FUNCLIST_DO(PFNGLGETUNIFORMLOCATIONPROC, GetUniformLocation) \
	FUNCLIST_DO(PFNGLUNIFORM1FPROC, Uniform1f) \

#ifndef DEBUG
#define FUNCLIST_DBG
#else
#define FUNCLIST_DBG \
  FUNCLIST_DO(PFNGLGETPROGRAMINFOLOGPROC, GetProgramInfoLog) \
  FUNCLIST_DO(PFNGLGETSHADERINFOLOGPROC, GetShaderInfoLog) \
  FUNCLIST_DO(PFNGLCHECKFRAMEBUFFERSTATUSPROC, CheckFramebufferStatus)
#endif

#define FUNCLISTS FUNCLIST FUNCLIST_DBG

#ifndef NO_AUDIO
#pragma bss_seg(".sound_buffer")
static SAMPLE_TYPE sound_buffer[MAX_SAMPLES * 2];
#endif

#pragma bss_seg(".program")
static GLuint program;

#ifdef _WIN32
#ifndef WINGL_INPLACE
#pragma data_seg(".gl_names")
#define FUNCLIST_DO(T,N) "gl" #N "\0"
static const char gl_names[] =
FUNCLISTS
"\0";

#pragma data_seg(".gl_procs")
#undef FUNCLIST_DO
#define FUNCLIST_DO(T,N) T N;
static struct {
	FUNCLISTS
} gl;
#undef FUNCLIST_DO
#endif // WINGL_INPLACE

#pragma data_seg(".pfd")
static const PIXELFORMATDESCRIPTOR pfd = {
	sizeof(PIXELFORMATDESCRIPTOR), 1, PFD_DRAW_TO_WINDOW|PFD_SUPPORT_OPENGL|PFD_DOUBLEBUFFER, PFD_TYPE_RGBA,
	32, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 32, 0, 0, PFD_MAIN_PLANE, 0, 0, 0, 0 };

#ifdef FULLSCREEN
#pragma data_seg(".devmode")
static const DEVMODE screenSettings = { {0},
	#if _MSC_VER < 1400
	0,0,148,0,0x001c0000,{0},0,0,0,0,0,0,0,0,0,{0},0,32,WIDTH,HEIGHT,0,0,      // Visual C++ 6.0
	#else
	0,0,156,0,0x001c0000,{0},0,0,0,0,0,{0},0,32,WIDTH,HEIGHT,{0}, 0,           // Visual Studio 2005+
	#endif
	#if(WINVER >= 0x0400)
	0,0,0,0,0,0,
	#if (WINVER >= 0x0500) || (_WIN32_WINNT >= 0x0400)
	0,0
	#endif
	#endif
	};
#endif // ifdef FULLSCREEN

#ifndef NO_AUDIO
#pragma data_seg(".wavefmt")
static const WAVEFORMATEX WaveFMT =
{
#ifdef FLOAT_32BIT
	WAVE_FORMAT_IEEE_FLOAT,
#else
	WAVE_FORMAT_PCM,
#endif
	2,                                   // channels
	SAMPLE_RATE,                         // samples per sec
	SAMPLE_RATE * 2 * sizeof(SAMPLE_TYPE), // bytes per sec
	sizeof(SAMPLE_TYPE) * 2,             // block alignment;
	sizeof(SAMPLE_TYPE) * 8,             // bits per sample
	0                                    // extension not needed
};

#pragma data_seg(".wavehdr")
static WAVEHDR WaveHDR =
{
	(LPSTR)sound_buffer, MAX_SAMPLES * 2 * sizeof(SAMPLE_TYPE),0,0,WHDR_PREPARED,0,0,0
};
#endif // NO_AUDIO
#endif /* _WIN32 */

#if !defined(_DEBUG) && !defined(CAPTURE)
#define GLCHECK()
#define glGetError()
#else
static const char *a__GlPrintError(int error) {
	const char *errstr = "UNKNOWN";
	switch (error) {
	case GL_INVALID_ENUM: errstr = "GL_INVALID_ENUM"; break;
	case GL_INVALID_VALUE: errstr = "GL_INVALID_VALUE"; break;
	case GL_INVALID_OPERATION: errstr = "GL_INVALID_OPERATION"; break;
#ifdef GL_STACK_OVERFLOW
	case GL_STACK_OVERFLOW: errstr = "GL_STACK_OVERFLOW"; break;
#endif
#ifdef GL_STACK_UNDERFLOW
	case GL_STACK_UNDERFLOW: errstr = "GL_STACK_UNDERFLOW"; break;
#endif
	case GL_OUT_OF_MEMORY: errstr = "GL_OUT_OF_MEMORY"; break;
#ifdef GL_TABLE_TOO_LARGE
	case GL_TABLE_TOO_LARGE: errstr = "GL_TABLE_TOO_LARGE"; break;
#endif
	case 1286: errstr = "INVALID FRAMEBUFFER"; break;
	};
	return errstr;
}
static void GLCHECK() {
	const int glerror = glGetError();
	if (glerror != GL_NO_ERROR) {
#ifdef _WIN32
		MessageBox(NULL, a__GlPrintError(glerror), "GLCHECK", 0);
		ExitProcess(0);
#else
		printf("%s\n", a__GlPrintError(glerror));
		abort();
#endif
	};
}
#endif // gl debug

#pragma code_seg(".compileProgram")
static __forceinline GLuint compileProgram(const char *fragment) {
	const char* sources[1] = { fragment };
#ifdef NO_CREATESHADERPROGRAMV
	const int pid = oglCreateProgram();
	const int fsId = oglCreateShader(GL_FRAGMENT_SHADER);
	oglShaderSource(fsId, 2, sources, 0);
	oglCompileShader(fsId);

#ifdef SHADER_DEBUG
	int result;
	char info[2048];
	oglGetObjectParameteriv(fsId, GL_OBJECT_COMPILE_STATUS_ARB, &result);
	oglGetInfoLog(fsId, 2047, NULL, (char*)info);
	if (!result)
	{
#ifdef _WIN32
		MessageBox(NULL, info, "COMPILE", 0x00000000L);
		ExitProcess(0);
#else
		printf("%s\n", info);
		abort();
#endif
	}
#endif

	oglAttachShader(pid, fsId);
	oglLinkProgram(pid);

#else
	const GLuint pid = oglCreateShaderProgramv(GL_FRAGMENT_SHADER, 1, sources);
#endif

#ifdef SHADER_DEBUG
	{
		int result;
		char info[2048];
		oglGetObjectParameteriv(pid, GL_OBJECT_LINK_STATUS_ARB, &result);
		oglGetInfoLog(pid, 2047, NULL, (char*)info);
		if (!result)
		{
#ifdef _WIN32
			MessageBox(NULL, info, "COMPILE", 0x00000000L);
			ExitProcess(0);
#else
			printf("%s\n", info);
			abort();
#endif
		}
	}
#endif
	return pid;
}

#pragma code_seg(".introInit")
static __forceinline void introInit() {
	program = compileProgram(shader_glsl);
	oglUseProgram(program);
	GLCHECK();
}

#pragma code_seg(".introPaint")
static __forceinline void introPaint(float t) {
	GLCHECK();
	setUniforms(program, t);
	oglUniform1f(oglGetUniformLocation(program, "t"), t);
	oglUniform2f(oglGetUniformLocation(program, "R_"), WIDTH, HEIGHT);
	GLCHECK();
	glRects(-1, -1, 1, 1);
	GLCHECK();
}

#ifdef _WIN32
#ifdef _DEBUG
void checkResult(int result) {
	if (result != 0)
		ExitProcess(0);
}
#endif

#pragma code_seg(".entry")
#ifdef CAPTURE
int main(int argc, char * argv[]) {
	(void)argc; (void)argv;
#else
void entrypoint(void) {
#endif
#ifdef FULLSCREEN
	ChangeDisplaySettings(&screenSettings, CDS_FULLSCREEN);
	ShowCursor(0);
	HDC hDC = GetDC(CreateWindow((LPCSTR)0xC018, 0, WS_POPUP | WS_VISIBLE, 0, 0, WIDTH, HEIGHT, 0, 0, 0, 0));
#else
	HDC hDC = GetDC(CreateWindow("static", 0, WS_POPUP | WS_VISIBLE, 0, 0, WIDTH, HEIGHT, 0, 0, 0, 0));
#endif

	// initalize opengl
	SetPixelFormat(hDC, ChoosePixelFormat(hDC, &pfd), &pfd);
	wglMakeCurrent(hDC, wglCreateContext(hDC));

#ifndef WINGL_INPLACE
	{
		const char *next_gl_func = gl_names;
		void **funcptr = &gl;
		while (next_gl_func[0] != '\0') {
			*funcptr = wglGetProcAddress(next_gl_func);
#ifdef DEBUG_FUNCLOAD
			if (!*funcptr) {
				\
					MessageBox(NULL, next_gl_func, "wglGetProcAddress", 0x00000000L); \
			}
#endif
			++funcptr;
			while (*(next_gl_func++) != '\0');
		}
	}
#endif

	introInit();

#ifdef CAPTURE
	//AllocConsole();
	//freopen("CONIN$", "r", stdin);
	//freopen("CONOUT$", "w", stdout);
	//freopen("CONOUT$", "w", stderr);

	FILE* captureStream = _popen(FFMPEG_CAPTURE_INPUT, "wb");
	if (!captureStream) {
		*(int*)0 = 0;
	}
#endif

#ifndef NO_AUDIO
#ifdef _DEBUG
#define CHECK(f) checkResult(f)
#else
#define CHECK(f) (f)
#endif
#ifndef CAPTURE
	HWAVEOUT hWaveOut;
	CreateThread(0, 0, (LPTHREAD_START_ROUTINE)_4klang_render, sound_buffer, 0, 0);
	CHECK(waveOutOpen(&hWaveOut, WAVE_MAPPER, &WaveFMT, NULL, 0, CALLBACK_NULL));
	//CHECK(waveOutPrepareHeader(hWaveOut, &WaveHDR, sizeof(WaveHDR)));
	CHECK(waveOutWrite(hWaveOut, &WaveHDR, sizeof(WaveHDR)));
#else
#if 1
	_4klang_render(sound_buffer);
	FILE *f = fopen("sound.raw", "wb");
	fwrite(sound_buffer, 1, sizeof(sound_buffer), f);
	fclose(f);
#endif
#endif
#else
	const int start = timeGetTime();
#endif

	// play intro
	do {
#ifndef CAPTURE
#ifndef NO_AUDIO
		MMTIME mmtime;
		mmtime.wType = TIME_BYTES;
		CHECK(waveOutGetPosition(hWaveOut, &mmtime, sizeof(mmtime)));
		const float t = mmtime.u.cb / sizeof(SAMPLE_TYPE) / SAMPLERATE / CHANNELS;
		//itime = mmtime.u.cb;/// (float)(SAMPLES_PER_TICK);
		//uniforms[0] = itime / (float)(SAMPLES_PER_TICK);
		//const float time_ticks = (float)mmtime.u.cb / (BYTES_PER_TICK);
#else
		//const float time_ticks = (timeGetTime() - start) / MS_PER_TICK;
#endif
#else
		static int frame = 0;
		//const int frames = MAX_SAMPLES * CAPTURE_FRAMERATE / SAMPLE_RATE;
		itime = sizeof(SAMPLE_TYPE) * 2 * SAMPLE_RATE * frame++ / CAPTURE_FRAMERATE;
#endif

		introPaint(t);
		SwapBuffers(hDC);

#ifdef CAPTURE
		glReadPixels(0, 0, WIDTH, HEIGHT, GL_RGB, GL_UNSIGNED_BYTE, backbufferData);
		fwrite(backbufferData, 1, WIDTH*HEIGHT * 3, captureStream);
		fflush(captureStream);
#endif

		/* hide cursor properly */
		PeekMessageA(0, 0, 0, 0, PM_REMOVE);
		if (itime >= MAX_SAMPLES * 2 * sizeof(SAMPLE_TYPE)) break;
	} while (!GetAsyncKeyState(VK_ESCAPE));
		// && MMTime.u.sample < MAX_SAMPLES);

	#ifdef CLEANDESTROY
	sndPlaySound(0,0);
	ChangeDisplaySettings( 0, 0 );
	ShowCursor(1);
	#endif

#ifdef CAPTURE
	fclose(captureStream);
	return 0;
#endif

	ExitProcess(0);
}
#elif defined(__linux__)
#include <SDL.h>
#include <pthread.h>

#ifdef CAPTURE
#define NO_AUDIO
#endif

#ifndef NO_AUDIO

static int audio_cursor = 0;

static void audioPlay(void *userdata, Uint8 *stream, int len) {
	short *p = (short*)stream;
	int i;
	len /= sizeof(short);
	for (i = 0; i < len; ++i) {
		audio_cursor = (audio_cursor + 1) % (MAX_SAMPLES * 2);
		p[i] = sound_buffer[audio_cursor] * 32767.f;
	}
}

static SDL_AudioSpec as = {SAMPLE_RATE, 0x8010, 2, 0, 0, 0, 0, audioPlay};
#endif /* AUDIO */

#ifndef COMPACT
int main() {
#else
void _start() {
#endif
#ifndef NO_AUDIO
	pthread_t audio_thread;
	pthread_create(&audio_thread, 0, (void *(*)(void*))__4klang_render, sound_buffer);
#endif
	SDL_Init(SDL_INIT_VIDEO | SDL_INIT_AUDIO);
#ifdef FULLSCREEN
#define FULLSCREEN SDL_FULLSCREEN
	SDL_ShowCursor(0);
#else
#define FULLSCREEN 0
#endif
	SDL_SetVideoMode(WIDTH, HEIGHT, 32, SDL_OPENGL | FULLSCREEN);
	glViewport(0, 0, WIDTH, HEIGHT);
	glClearColor(0,0,0,0);
	glClear(GL_COLOR_BUFFER_BIT);

	introInit();

#ifndef CAPTURE
#ifndef NO_AUDIO
	SDL_OpenAudio(&as, 0);
	SDL_PauseAudio(0);
#endif
	const uint32_t start = SDL_GetTicks();
	for(;;) {
		const uint32_t now = SDL_GetTicks() - start;
		const int itime = (int)((double)now * SAMPLE_RATE * sizeof(SAMPLE_TYPE) * 2 / 1000.);
		const float t = (now - start) / 1000.f;
#else
	const uint32_t total_frames = CAPTURE_FRAMERATE * MAX_SAMPLES / SAMPLE_RATE;
	const uint32_t global_start = SDL_GetTicks();
	uint32_t frame_start = SDL_GetTicks();
	int frame = 0;
	for (;;) {
		//const int frames = MAX_SAMPLES * CAPTURE_FRAMERATE / SAMPLE_RATE;
		const int itime = (double)sizeof(SAMPLE_TYPE) * 2 * SAMPLE_RATE * frame++ / CAPTURE_FRAMERATE;
#endif
		SDL_Event e;
		SDL_PollEvent(&e);
		if ((e.type == SDL_KEYDOWN && e.key.keysym.sym == SDLK_ESCAPE) || (itime >= MAX_SAMPLES)) break;
		introPaint(t);

#ifdef CAPTURE
		const uint32_t frame_end = SDL_GetTicks();
		const uint32_t total_time = frame_end - global_start;
		glReadPixels(0, 0, WIDTH, HEIGHT, GL_RGB, GL_UNSIGNED_BYTE, backbufferData);
		write(1, backbufferData, WIDTH * HEIGHT * 3);
		fprintf(stderr, "frame %d/%d: %dms/frame, total: %ds/%llds, MBytes: %lld/%lld\n",
			frame, total_frames, frame_end - frame_start,
			total_time / 1000, (unsigned long long)total_time * total_frames / frame / 1000,
			((unsigned long long)frame * WIDTH * HEIGHT * 3) / 1024 / 1024,
			((unsigned long long)total_frames * WIDTH * HEIGHT * 3) / 1024 / 1024);
		usleep(1000);
		frame_start = frame_end;
#endif

//#ifndef CAPTURE
		SDL_GL_SwapBuffers();
//#endif
	}

#ifdef COMPACT
	asm ( \
		"xor %eax,%eax\n" \
		"inc %eax\n" \
		"int $0x80\n" \
	);
#else
	SDL_Quit();
	return 0;
#endif
}
#else
#error Not ported
#endif

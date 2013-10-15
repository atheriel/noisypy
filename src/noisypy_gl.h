#include <noise/module/modulebase.h>

#ifndef __NOISYPY_GL_MODULE
#define __NOISYPY_GL_MODULE

using namespace noise::module;

static double DEFAULT_NOISE_RESOLUTION = 64.0;

extern unsigned char *
get_noisedata_2d(
	int width, 
	int height, 
	const Module &source, 
	double resolution = DEFAULT_NOISE_RESOLUTION);

extern unsigned char *
get_noisedata_3d(
	int width, 
	int height, 
	int depth, 
	const Module &source, 
	double resolution = DEFAULT_NOISE_RESOLUTION);

extern unsigned int
new_gltexture_2d(
	int width,
	int height, 
	const Module &source, 
	double resolution = DEFAULT_NOISE_RESOLUTION);

extern unsigned int
new_gltexture_3d(
	int width, 
	int height, 
	int depth, 
	const Module &source, 
	double resolution = DEFAULT_NOISE_RESOLUTION);
 
#endif

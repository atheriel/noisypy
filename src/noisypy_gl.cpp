#include <iostream>
#include <OpenGL/gl.h>
#include "noisypy_gl.h"
 
#ifdef __cplusplus
extern "C" {
#endif

/*
	Returns raw, unsigned bytes sampled from the noise module. Anticipates values in [0,1].
 */
unsigned char * get_noisedata_2d(int width, int height, const Module &source, double resolution) {
	unsigned char *data = new unsigned char[height * width];
	int i, j;
	for (i = 0; i < width; i++) {
		for (j = 0; j < height; j++) {
			data[i * width + j] = (unsigned char) (source.GetValue(i / resolution, j / resolution, 0) * 255);
		}
	}
	return data;
}

/*
	Returns raw, unsigned bytes sampled from the noise module. Anticipates values in [0,1].
 */
unsigned char * get_noisedata_3d(int width, int height, int depth, const Module &source, double resolution) {
	unsigned char *data = new unsigned char[depth * height * width];
	int i, j, k;
	for (i = 0; i < depth; i++) {
		for (j = 0; j < height; j++) {
			for (k = 0; k < width; k++) {
				data[i * depth * depth + j * height + k] = (unsigned char) (source.GetValue(i / resolution, j / resolution, k / resolution) * 255);
			}
		}
	}
	return data;
}

unsigned int new_gltexture_2d(int width, int height, const noise::module::Module &source, double resolution) {
	unsigned char * data = get_noisedata_2d(width, height, source, resolution);
	GLuint texture_id;

	glGenTextures(1, &texture_id);
	glBindTexture(GL_TEXTURE_2D, texture_id);
	glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GL_REPEAT);
	glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GL_REPEAT);
	glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR);
	glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR);
	glTexImage2D(GL_TEXTURE_2D, 0, GL_LUMINANCE, width, height, 0, GL_LUMINANCE, GL_UNSIGNED_BYTE, data);

	return (unsigned int) texture_id;
}

unsigned int new_gltexture_3d(int width, int height, int depth, const noise::module::Module &source, double resolution) {
	unsigned char * data = get_noisedata_3d(width, height, depth, source, resolution);
	GLuint texture_id;

	glGenTextures(1, &texture_id);
	glBindTexture(GL_TEXTURE_3D, texture_id);
	glTexParameteri(GL_TEXTURE_3D, GL_TEXTURE_WRAP_S, GL_REPEAT);
	glTexParameteri(GL_TEXTURE_3D, GL_TEXTURE_WRAP_T, GL_REPEAT);
	glTexParameteri(GL_TEXTURE_3D, GL_TEXTURE_MAG_FILTER, GL_LINEAR);
	glTexParameteri(GL_TEXTURE_3D, GL_TEXTURE_MIN_FILTER, GL_LINEAR);
	glTexImage3D(GL_TEXTURE_3D, 0, GL_LUMINANCE, width, height, depth, 0, GL_LUMINANCE, GL_UNSIGNED_BYTE, data);

	return (unsigned int) texture_id;
}
 
#ifdef __cplusplus
}
#endif

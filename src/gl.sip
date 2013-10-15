%Module(name = noisypy.gl, keyword_arguments = "All", version = 1)
{
    %Docstring "deindented"
    This module contains methods for creating 2- and 3D OpenGL textures by sampling from a noise module.
    %End
};

%Import modules.sip

%UnitCode
#include "noisypy_gl.h"
%End

int create_texture(SIP_PYTUPLE dimensions, const Module &source, double resolution = DEFAULT_NOISE_RESOLUTION);
%Docstring "deindented"
    This method creates an OpenGL texture of the given dimensions (either 2 or 3) and returns its ID.
%End
%MethodCode
		int dims[3];
		int result;
		
		Py_ssize_t dim_num = PyTuple_Size(a0);
		
		if(!dim_num) {
			if(!PyErr_Occurred()) {
				PyErr_SetString(PyExc_TypeError, "You must supply at least one argument.");
			}
			sipIsErr = 1;
		}

		else if (dim_num == 2) {
			if (PyArg_ParseTuple(a0, "ii", &dims[0], &dims[1])) {
				// 2D Texture
	            result = new_gltexture_2d(dims[0], dims[1], *a1, a2);
	        } else {
	        	sipIsErr = 1;
	        }
		}

		else if (dim_num == 3) {
			if (PyArg_ParseTuple(a0, "iii", &dims[0], &dims[1], &dims[2])) {
	        	// 3D Texture
				result = new_gltexture_3d(dims[0], dims[1], dims[2], *a1, a2);
	        } else {
	        	sipIsErr = 1;
	        }
		}

		else {
			PyErr_SetString(PyExc_TypeError, "You cannot supply more than three dimensions.");
			sipIsErr = 1;
		}

        sipRes = result;
%End

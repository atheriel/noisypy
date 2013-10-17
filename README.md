*Note: Contrary to GitHub's assertion, this is NOT written in Objective-C. It is written primarily in C++, with an interface to Python.*

# Noisypy

Noisypy is a set of "pythonic" bindings for the procedural noise generation library [libnoise](http://libnoise.sourceforge.net/). It is indended to offer the growing community of games written in Python access to a well-established PCG library. Although libnoise is quite old -- it was last updated in 2007 -- it is quite feature-complete, and functions orders of magnitude faster than noise algorithms written in Python itself.

The bindings are written using SIP. In order to make the API more "pythonic" than libnoise itself (ie. properties, keyword arguments in `__init__` methods, naming conventions, etc.) the source files contain a large quantity of handwritten C++ code using a mixture of SIP and the Python C API. If you are interested in using C++ code to optimize routines in Python, the `.sip` files in the `src/` directory may be of some interest.

## Building

First, you must actually have libnoise installed. You can get one fork I believe to be working with

	$ git clone git@github.com:eXpl0it3r/libnoise.git
	$ cd libnoise
	$ cmake .
	$ make && make install

Once that seems to be working (try compiling a demo from the `examples/` folder), you can install noisypy with

	$ git clone git@github.com:atheriel/noisypy.git
	$ cd noisypy
	$ python setup.py build install

To test this, try

	$ python -c "import noisypy.demos; noisypy.demos.jade()"

which should produce some texture images. I haven't yet had the chance to try building and installing this on another machine, so please open an issue if you are unable to get it working.

## Status

Most of the modules from libnoise are available, albiet without documentation. Almost all of `noiseutils.h` is available as well, which is used to run the demos. The documentation for the utilities is generally pretty good.

## License

The code specific to Noisypy itself is licensed under the ISC. However, libnoise itself (including the in-code documentation which appears in the bindings) and `noiseutils` are licensed under the LGPL v2, and consequently both the documentation and the two C++ source files included in Noisypy are licensed under the LGPL v2 as well. See the `LICENSE` file for details.

I'm not an expert on licenses, so if this system offends, please let me know.
import os

os.environ["ARCHFLAGS"] = "-arch x86_64"

from distutils.core import setup, Extension

try:
    import sipdistutils
except ImportError:
    sys.stderr.write("ERROR: You must have SIP installed to build this extension\n")
    sys.stderr.write("-> http://www.riverbankcomputing.com/software/sip\n")
    exit(1)

setup(
    name = 'noisypy',
    version = '0.1',
    packages=['noisypy'],
    py_modules=['noisypy.demos'],
    ext_modules=[
        Extension(
            "noisypy.noise",
            ["src/noise.sip"],
            libraries=['libnoise']),
        Extension(
            "noisypy.modules",
            ["src/modules.sip"],
            libraries=['libnoise']),
        Extension(
            "noisypy.utils",
            ["src/utils.sip", "src/noiseutils.cpp"],
            include_dirs=['src'],
            libraries=['libnoise']),
        Extension(
            "noisypy.gl",
            ["src/gl.sip", "src/noisypy_gl.cpp"],
            include_dirs=['src'],
            libraries=['libnoise'],
            extra_link_args=['-framework', 'OpenGL', '-v']),
    ],

  cmdclass = {'build_ext': sipdistutils.build_ext}
)

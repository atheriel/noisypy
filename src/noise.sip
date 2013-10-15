%Module(name = noisypy.noise, keyword_arguments = "All", version = 1)
{
    %Docstring "deindented"
    This module contains the wrapper for the headers in the noise/ directory of libnoise.
    %End
};

%UnitCode
#include <noise/misc.h>
#include <noise/interp.h>
#include <noise/latlon.h>
#include <noise/noisegen.h>
using namespace noise;
%End

/* ========
    Content from <noise/misc.h>
   ========================================================================= */

int ClampValue(int value, int lowerBound, int upperBound) /PyName=clamp_value/;

/* ========
    Content from <noise/interp.h>
   ========================================================================= */

double CubicInterp(double n0, double n1, double n2, double n3, double a) /PyName=cubic_interp/ ;
double LinearInterp(double n0, double n1, double a) /PyName=linear_interp/ ;
double SCurve3(double a);
double SCurve5(double a);

/* ========
    Content from <noise/latlon.h>
   ========================================================================= */

void LatLonToXYZ(double lat, double lon, double& x, double& y, double& z);

/* ========
    Content from <noise/noisegen.h>
   ========================================================================= */

enum NoiseQuality {
    QUALITY_FAST = 0,
    QUALITY_STD  = 1,
    QUALITY_BEST = 2
};

double MakeInt32Range(double n);

int IntValueNoise3D(int x, int y, int z, int seed = 0);
double ValueNoise3D(int x, int y, int z, int seed = 0);
double GradientNoise3D(double fx, double fy, double fz, int ix, int iy, int iz, int seed = 0);

double ValueCoherentNoise3D(double x, double y, double z, int seed = 0, 
    NoiseQuality noiseQuality = QUALITY_STD);
double GradientCoherentNoise3D(double x, double y, double z, int seed = 0, 
    NoiseQuality noiseQuality = QUALITY_STD);

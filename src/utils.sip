%Module(name = noisypy.utils, keyword_arguments = "All", version = 1)
{
    %Docstring "deindented"
    This module contains the bindings for ``noiseutils.h``, which comes
    packaged with the libnoise examples.
    %End
};

%Import modules.sip

%UnitCode
#include "noiseutils.h"
using namespace noise;
using namespace noise::utils;
using namespace noise::module;
%End

%Include utils/noisemap.sip
%Include utils/image.sip

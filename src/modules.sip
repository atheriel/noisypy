%Module(name = noisypy.modules, keyword_arguments = "All", version = 1)
{
    %Docstring "deindented"
    This module contains the wrappers for the libnoise noise modules.
    %End
};

%Import noise.sip

%Include modules/modulebase.sip

/* Generator Modules */
%Include modules/billow.sip
%Include modules/checkerboard.sip
%Include modules/const.sip
%Include modules/cylinders.sip
%Include modules/perlin.sip
%Include modules/ridgedmulti.sip
%Include modules/spheres.sip
%Include modules/voronoi.sip

/* Modifier Modules */
%Include modules/abs.sip
%Include modules/add.sip
%Include modules/blend.sip
%Include modules/clamp.sip
%Include modules/rotatepoint.sip
%Include modules/scalebias.sip
%Include modules/scalepoint.sip
%Include modules/translatepoint.sip
%Include modules/terrace.sip
%Include modules/turbulence.sip


/* Models */
%Include models/plane.sip

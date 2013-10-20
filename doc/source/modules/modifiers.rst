Modifier Modules
================

Modifier modules take as input one or more source modules and produce output based on these sources. They can be used to combine modules or transform a single module in interesting ways. This page contains documentation for these modules generated from the docstrings of the classes themselves, which are in turn ported from the original in-code documentation of libnoise (albeit with some modifications).

Contents
--------

Modules that take a single source of input:

.. autosummary::

	noisypy.modules.Abs
	noisypy.modules.Clamp
	noisypy.modules.Curve
	noisypy.modules.Displace
	noisypy.modules.Exponent
	noisypy.modules.Invert
	noisypy.modules.RotatePoint
	noisypy.modules.ScaleBias
	noisypy.modules.ScalePoint
	noisypy.modules.Terrace
	noisypy.modules.TranslatePoint
	noisypy.modules.Turbulence

Modules that take multiple sources of input:

.. autosummary::

	noisypy.modules.Add
	noisypy.modules.Blend
	noisypy.modules.Max
	noisypy.modules.Min
	noisypy.modules.Multiply
	noisypy.modules.Power
	noisypy.modules.Select

Documentation
-------------

.. autoclass:: noisypy.modules.Abs
	:members:
	:undoc-members:
	:inherited-members:

.. autoclass:: noisypy.modules.Clamp
	:members:
	:undoc-members:
	:inherited-members:
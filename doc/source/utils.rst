noisypy.utils
=============

The ``noisypy.utils`` extension contains the bindings for the ``noiseutils.h`` interface that comes packaged with the libnoise examples. It provides classes and methods for creating two-dimensional noise maps, filling those noise maps by sampling from planar, cylindrical, and spherical surfaces, and finally rendering those noise maps to images.

The classes are used extensively in the demonstrations found in the :py:mod:`noisypy.demos` module.

Contents
--------

The following is a list of classes in (roughly) the order you might need them.

.. autosummary::

	noisypy.utils.NoiseMapBuilder
	noisypy.utils.PlanarNoiseMapBuilder
	noisypy.utils.SphericalNoiseMapBuilder
	noisypy.utils.CylindricalNoiseMapBuilder
	noisypy.utils.NoiseMapRenderer
	noisypy.utils.BMPWriter

The bindings also allow access to the low-level components

.. autosummary::

	noisypy.utils.NoiseMap
	noisypy.utils.Image

Documentation
-------------

.. automodule:: noisypy.utils
	:members:
	:undoc-members:
	:inherited-members:

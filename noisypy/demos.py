'''
This module contains demonstrations of the libnoise bindings.
'''

__author__ = 'Aaron Jacobs'
__version__ = 0.1

try:
    import noisypy.noise as noise
    import noisypy.modules as nmods
    import noisypy.utils as nutils
except:
    print 'There was an error importing the noisypy modules.'

def _create_planar_noisemap(noise_module, seamless, height, width, debug = True):
    if debug:
        print 'Creating planar noise map.'

    # Map the output values from the noise module onto a plane. This will
    # create a two-dimensional noise map which can be rendered as a flat
    # texture map.
    builder = nutils.PlanarNoiseMapBuilder()
    builder.bounds = (-1.0, 1.0, -1.0, 1.0)
    builder.size = (height, width)
    builder.seamless = seamless

    noisemap = builder.build_with_source(noise_module)

    return noisemap

def _create_spherical_noisemap(noise_module, height, width, debug = True):
    if debug:
        print 'Creating spherical noise map.'

    # Map the output values from the noise module onto a sphere. This will
    # create a two-dimensional noise map which can be rendered as a flat
    # texture map.
    builder = nutils.SphericalNoiseMapBuilder()
    builder.bounds = (-90.0, 90.0, -180.0, 180.0)
    builder.size = (height * 2, width)

    noisemap = builder.build_with_source(noise_module)

    return noisemap

def _write_bmp(image, filename, debug = True):
    if debug:
        print 'Writing to disk.'

    textureWriter = nutils.BMPWriter()
    textureWriter.set_image(image)
    textureWriter.filename = filename
    textureWriter.write()


def jade(filename = 'jade', seed = 0, quiet = False):
    """
    This demo is a port of the ``texturejade.cpp`` example which comes packaged
    with libnoise. It produces three 256x256 ``.bmp`` images intended to look
    like a jade texture.

    :param string filename: The name of the file to write to.
    :param int seed: The seed for the noise modules.
    :param bool quiet: Whether to silence output.
    """
    if quiet:
        debug = False
    else:
        debug = True
    
    if debug:
        print 'The jade demo is based on the <texturejade.cpp> example which comes packaged with libnoise.'
        print 'Creating noise modules.'

    # Primary jade texture. The ridges from the ridged-multifractal module
    # produces the veins.
    primaryJade = nmods.RidgedMulti()
    primaryJade.seed = seed
    primaryJade.frequency = 2.0
    primaryJade.lacunarity = 2.20703125
    primaryJade.octaves = 6
    primaryJade.noise_quality = noise.QUALITY_STD

    # Base of the secondary jade texture. The base texture uses concentric
    # cylinders aligned on the z axis, which will eventually be perturbed.
    baseSecondaryJade = nmods.Cylinders()
    baseSecondaryJade.frequency = 2.0

    # Rotate the base secondary jade texture so that the cylinders are not
    # aligned with any axis. This produces more variation in the secondary
    # jade texture since the texture is parallel to the y-axis.
    rotatedBaseSecondaryJade = nmods.RotatePoint()
    rotatedBaseSecondaryJade.SetSourceModule(0, baseSecondaryJade)
    rotatedBaseSecondaryJade.angles = (90.0, 25.0, 5.0)

    # Slightly perturb the secondary jade texture for more realism.
    perturbedBaseSecondaryJade = nmods.Turbulence()
    perturbedBaseSecondaryJade.SetSourceModule(0, rotatedBaseSecondaryJade)
    perturbedBaseSecondaryJade.seed = seed + 1
    perturbedBaseSecondaryJade.frequency = 4.0
    perturbedBaseSecondaryJade.power = 0.25
    perturbedBaseSecondaryJade.roughness = 4

    # Scale the secondary jade texture so it contributes a small part to the
    # final jade texture.
    secondaryJade = nmods.ScaleBias()
    secondaryJade.SetSourceModule (0, perturbedBaseSecondaryJade)
    secondaryJade.scale = 0.25
    secondaryJade.bias =  0.0

    # Add the two jade textures together. These two textures were produced
    # using different combinations of coherent noise, so the final texture will
    # have a lot of variation.
    combinedJade = nmods.Add()
    combinedJade.SetSourceModule(0, primaryJade)
    combinedJade.SetSourceModule(1, secondaryJade)

    # Finally, perturb the combined jade textures to produce the final jade
    # texture. A low roughness produces nice veins.
    finalJade = nmods.Turbulence()
    finalJade.SetSourceModule(0, combinedJade)
    finalJade.seed = seed + 2
    finalJade.frequency = 4.0
    finalJade.power = 1.0 / 16.0
    finalJade.roughness =  2

    noisemap = _create_planar_noisemap(finalJade, False, 256, 256, debug)

    if debug:
        print 'Rendering image.'

    renderer = nutils.NoiseMapRenderer()

    # Create a nice jade palette
    renderer.clear_gradient()
    renderer.add_gradient_point(-1.0, (24, 146, 102, 255))
    renderer.add_gradient_point(0, (78, 154, 115, 255))
    renderer.add_gradient_point(0.25, (128, 204, 165, 255))
    renderer.add_gradient_point(0.375, (78, 154, 115, 255))
    renderer.add_gradient_point(1.0, (29, 135, 102, 255))

    # Set up us the texture renderer and pass the noise map to it.
    image = nutils.Image()
    renderer.set_noisemap(noisemap)
    renderer.set_image(image)
    renderer.lighting = False

    # Render the texture.
    renderer.render()

    _write_bmp(image, filename + '.bmp', debug)

    noisemap = _create_planar_noisemap(finalJade, True, 256, 256, debug)
    renderer.set_noisemap(noisemap)
    renderer.render()
    _write_bmp(image, filename + '-seamless.bmp', debug)

    noisemap = _create_spherical_noisemap(finalJade, 256, 256, debug)
    renderer.set_noisemap(noisemap)
    renderer.render()
    _write_bmp(image, filename + '-sphere.bmp', debug)

def wood(filename = 'wood', seed = 0, quiet = False):
    """
    This demo is a port of the ``texturewood.cpp`` example which comes packaged
    with libnoise. It produces three 256x256 ``.bmp`` images intended to look
    like a wood texture.

    :param string filename: The name of the file to write to.
    :param int seed: The seed for the noise modules.
    :param bool quiet: Whether to silence output.
    """
    if quiet:
        debug = False
    else:
        debug = True
    
    if debug:
        print 'The wood demo is based on the <texturewood.cpp> example which comes packaged with libnoise.'
        print 'Creating noise modules.'

    baseWood = nmods.Cylinders()
    baseWood.frequency = 16.0

    # Perlin noise to use for the wood grain.
    woodGrainNoise = nmods.Perlin()
    woodGrainNoise.seed = seed
    woodGrainNoise.frequency = 48.0
    woodGrainNoise.persistence = 0.5
    woodGrainNoise.lacunarity = 2.20703125
    woodGrainNoise.octaves = 3
    woodGrainNoise.noise_quality = noise.QUALITY_STD

    # Stretch the Perlin noise in the same direction as the center of the
    # log. This produces a nice wood-grain texture.
    scaledBaseWoodGrain = nmods.ScalePoint()
    scaledBaseWoodGrain.SetSourceModule(0, woodGrainNoise)
    scaledBaseWoodGrain.y_scale = 0.25

    # Scale the wood-grain values so that they may be added to the base wood
    # texture.
    woodGrain = nmods.ScaleBias()
    woodGrain.SetSourceModule (0, scaledBaseWoodGrain)
    woodGrain.scale = 0.25
    woodGrain.bias = 0.125

    # Add the wood grain texture to the base wood texture.
    combinedWood = nmods.Add()
    combinedWood.SetSourceModule (0, baseWood)
    combinedWood.SetSourceModule (1, woodGrain)

    # Slightly perturb the wood texture for more realism.
    perturbedWood = nmods.Turbulence()
    perturbedWood.SetSourceModule (0, combinedWood)
    perturbedWood.seed = seed + 1
    perturbedWood.frequency = 4.0
    perturbedWood.power = 1.0 / 256.0
    perturbedWood.roughness = 4

    # Cut the wood texture a small distance from the center of the "log".
    translatedWood = nmods.TranslatePoint()
    translatedWood.SetSourceModule (0, perturbedWood)
    translatedWood.z_translation = 1.48

    # Cut the wood texture on an angle to produce a more interesting wood
    # texture.
    rotatedWood = nmods.RotatePoint()
    rotatedWood.SetSourceModule (0, translatedWood)
    rotatedWood.angles = (84.0, 0.0, 0.0)

    # Finally, perturb the wood texture to produce the final texture.
    finalWood = nmods.Turbulence()
    finalWood.SetSourceModule(0, rotatedWood)
    finalWood.seed = seed + 2
    finalWood.frequency = 2.0
    finalWood.power = 1.0 / 64.0
    finalWood.roughness = 4

    noisemap = _create_planar_noisemap(finalWood, False, 256, 256, debug)

    if debug:
        print 'Rendering image.'

    renderer = nutils.NoiseMapRenderer()

    # Create a dark-stained wood palette (oak?)
    renderer.clear_gradient()
    renderer.add_gradient_point(-1.0, (189, 94, 4, 255))
    renderer.add_gradient_point(0.5, (144, 48, 6, 255))
    renderer.add_gradient_point(1.0, (60, 10, 8, 255))

    # Set up us the texture renderer and pass the noise map to it.
    image = nutils.Image()
    renderer.set_noisemap(noisemap)
    renderer.set_image(image)
    renderer.lighting = False

    # Render the texture.
    renderer.render()

    _write_bmp(image, filename + '.bmp', debug)

    noisemap = _create_planar_noisemap(finalWood, True, 256, 256, debug)
    renderer.set_noisemap(noisemap)
    renderer.render()
    _write_bmp(image, filename + '-seamless.bmp', debug)

    noisemap = _create_spherical_noisemap(finalWood, 256, 256, debug)
    renderer.set_noisemap(noisemap)
    renderer.render()
    _write_bmp(image, filename + '-sphere.bmp', debug)




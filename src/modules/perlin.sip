/* ========
    Content from <noise/module/perlin.h>
======== */

class Perlin: public Module {
%Docstring "deindented"
    Noise module that outputs three-dimensional Perlin noise.

    .. image:: http://libnoise.sourceforge.net/docs/moduleperlin.png
        :align: left

    :param float frequency: The frequency of the first octave.
    :param float lacunarity: The lacunarity of the noise.
    :param int octave_count: The number of octaves to use in generating noise.
    :param float persistence: The persistence of the noise.
    :param int seed: The seed value for the noise.
    :param noisypy.noise.NoiseQuality noise_quality: The quality of the noise.

    Perlin noise is the sum of several coherent-noise functions of ever-increasing 
    frequencies and ever-decreasing amplitudes.

    An important property of Perlin noise is that a small change in the input value
    will produce a small change in the output value, while a large change in the 
    input value will produce a random change in the output value.

    This noise module outputs Perlin-noise values that usually range from ``-1.0``
    to ``+1.0``, but there are no guarantees that all output values will exist
    within that range.

    For a better description of Perlin noise, see the links in the *References and
    Acknowledgments* section.

    This noise module does not require any source modules.

    The noise can be parameterized in either the init method or using the properties:

    .. code-block:: python
        :linenos:

        noise1 = noisypy.modules.Perlin(frequency = 3.5, octave_count = 8, seed = 1337)
        # which is equivalent to
        noise1 = noisypy.modules.Perlin()
        noise1.frequency = 3.5
        noise1.octave_count = 8
        noise1.seed = 1337

    **Octaves**
    
    The number of octaves control the *amount of detail* of the Perlin noise. Adding
    more octaves increases the detail of the Perlin noise, but with the drawback of
    increasing the calculation time.
    
    An octave is one of the coherent-noise functions in a series of coherent-noise
    functions that are added together to form Perlin noise.
    
    An application may specify the frequency of the first octave by using the
    :py:attr:`frequency` property.
    
    An application may specify the number of octaves that generate Perlin noise by
    using the :py:attr:`octave_count` property.
    
    These coherent-noise functions are called octaves because each octave has, by
    default, double the frequency of the previous octave. Musical tones have this
    property as well; a musical C tone that is one octave higher than the previous C
    tone has double its frequency.
    
    **Persistence**
    
    The persistence value controls the *roughness* of the Perlin noise. Larger
    values produce rougher noise.
    
    The persistence value determines how quickly the amplitudes diminish for
    successive octaves. The amplitude of the first octave is ``1.0``. The amplitude
    of each subsequent octave is equal to the product of the previous octave's
    amplitude and the persistence value. So a persistence value of ``0.5`` sets the
    amplitude of the first octave to ``1.0``; the second, ``0.5``; the third,
    ``0.25``; etc.
    
    An application may specify the persistence value by using the :py:attr:`persistence`
    property.
    
    **Lacunarity**
    
    The lacunarity specifies the frequency multipler between successive octaves.
    
    The effect of modifying the lacunarity is subtle; you may need to play with the
    lacunarity value to determine the effects. For best results, set the lacunarity
    to a number between ``1.5`` and ``3.5``.
    
    **References and acknowledgments**
    
    `The Noise Machine`_ -- From the master, Ken Perlin himself. This page contains a
    presentation that describes Perlin noise and some of its variants. He won an
    Oscar for creating the Perlin noise algorithm!
    
    `Perlin Noise`_ -- Hugo Elias's webpage contains a very good description of Perlin
    noise and describes its many applications. This page gave me the inspiration to
    create libnoise in the first place. Now that I know how to generate Perlin noise,
    I will never again use cheesy subdivision algorithms to create terrain (unless I
    absolutely need the speed.)
    
    `Perlin noise math FAQ`_ -- A good page that describes Perlin noise in plain
    English with only a minor amount of math. During development of libnoise, I
    noticed that my coherent-noise function generated terrain with some "regularity"
    to the terrain features. This page describes a better coherent-noise function
    called *gradient noise*. This version of the class uses gradient coherent noise
    to generate Perlin noise.

    .. _The Noise Machine: http://www.noisemachine.com/talk1/
    .. _Perlin Noise: http://freespace.virgin.net/hugo.elias/models/m_perlin.htm
    .. _Perlin noise math FAQ: http://www.robo-murito.net/code/perlin-noise-math-faq.html
%End

    %TypeHeaderCode
    #include <noise/module/perlin.h>
    using namespace noise;
    using namespace noise::module;
    %End

    public:
        Perlin ();

        Perlin(double frequency = DEFAULT_PERLIN_FREQUENCY, 
               double lacunarity = DEFAULT_PERLIN_LACUNARITY,
               int octave_count = DEFAULT_PERLIN_OCTAVE_COUNT,
               double persistence = DEFAULT_PERLIN_PERSISTENCE,
               int seed = DEFAULT_PERLIN_SEED,
               NoiseQuality noise_quality = DEFAULT_PERLIN_QUALITY) /NoDerived/ ;
        %MethodCode
            Py_BEGIN_ALLOW_THREADS
            try {
                sipCpp = new sipPerlin();
            } catch (...) {
                Py_BLOCK_THREADS

                sipRaiseUnknownException();
                return NULL;
            }
            sipCpp->SetFrequency(a0);
            sipCpp->SetLacunarity(a1);
            sipCpp->SetOctaveCount(a2);
            sipCpp->SetPersistence(a3);
            sipCpp->SetSeed(a4);
            sipCpp->SetNoiseQuality(a5);
            Py_END_ALLOW_THREADS
        %End

        virtual double GetValue (double x, double y, double z) const /PyName=get_value/;

        int _GetSourceModuleCount();
        %MethodCode
            Py_BEGIN_ALLOW_THREADS
            sipRes = sipSelfWasArg ? sipCpp->Perlin::GetSourceModuleCount()
                                   : sipCpp->GetSourceModuleCount();
            Py_END_ALLOW_THREADS
        %End

        %Property(name=source_module_count, get=_GetSourceModuleCount)

        double GetFrequency () const /PyName=_get_frequency/ ;
        void SetFrequency(double frequency) /PyName=_set_frequency/ ;

        %Property(name=frequency, get=_get_frequency, set=_set_frequency) {
            %Docstring "deindented"
                The frequency of the first octave.
            %End
        };

        double GetLacunarity () const /PyName=_get_lacunarity/ ;
        void SetLacunarity(double lacunarity) /PyName=_set_lacunarity/ ;

        %Property(name=lacunarity, get=_get_lacunarity, set=_set_lacunarity) {
            %Docstring "deindented"
                The lacunarity specifies the frequency multiplier between successive 
                octaves.

                The effect of modifying the lacunarity is subtle; you may need to play 
                with the lacunarity value to determine the effects. For best results, 
                set the lacunarity to a number between ``1.5`` and ``3.5``.
            %End
        };

        int GetOctaveCount () const /PyName=_get_octave_count/ ;
        void SetOctaveCount(int octaveCount) /PyName=_set_octave_count/ ;

        %Property(name=octave_count, get=_get_octave_count, set=_set_octave_count) {
            %Docstring "deindented"
                The number of octaves controls the amount of detail in the Perlin noise.
                Adding more octaves increases the detail of the Perlin noise, but with
                the drawback of increasing the calculation time.

                An octave is one of the coherent-noise functions in a series of coherent-
                noise functions that are added together to form Perlin noise.

                An application may specify the frequency of the first octave by calling
                using the frequency property.

                An application may specify the number of octaves that generate Perlin
                noise by using the octaves property.

                These coherent-noise functions are called octaves because each octave has,
                by default, double the frequency of the previous octave.  Musical tones
                have this property as well; a musical C tone that is one octave higher
                than the previous C tone has double its frequency.
            %End
        };

        double GetPersistence () const /PyName=_get_persistence/ ;
        void SetPersistence(double persistence) /PyName=_set_persistence/ ;
        
        %Property(name=persistence, get=_get_persistence, set=_set_persistence) {
            %Docstring "deindented"
                The persistence value controls the roughness of the Perlin noise. Larger 
                values produce rougher noise.

                The persistence value determines how quickly the amplitudes diminish
                for successive octaves. The amplitude of the first octave is ``1.0``.
                The amplitude of each subsequent octave is equal to the product of the
                previous octave's amplitude and the persistence value. So a persistence
                value of ``0.5`` sets the amplitude of the first octave to ``1.0``; the
                second, ``0.5``; the third, ``0.25``; etc.

                For best results, set the persistence to a number between ``0.0`` and
                ``1.0``.
            %End
        };

        int GetSeed () const /PyName=_get_seed/ ;
        void SetSeed(int seed) /PyName=_set_seed/ ;

        %Property(name=seed, get=_get_seed, set=_set_seed) {
            %Docstring "deindented"
                The seed value used by the Perlin-noise function.
            %End
        };

        NoiseQuality GetNoiseQuality () const /PyName=_get_noise_quality/ ;
        void SetNoiseQuality(NoiseQuality noiseQuality) /PyName=_set_noise_quality/ ;

        %Property(name=noise_quality, get=_get_noise_quality, set=_set_noise_quality) {
            %Docstring "deindented"
                The quality of the Perlin noise.
            %End
        };
};

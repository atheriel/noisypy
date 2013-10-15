/* ========
    Content from <noise/module/perlin.h>
======== */

class Perlin: public Module {
%Docstring "deindented"
    Noise module that outputs 3-dimensional Perlin noise.

    @image html moduleperlin.png

    Perlin noise is the sum of several coherent-noise functions of ever-increasing 
    frequencies and ever-decreasing amplitudes.

    An important property of Perlin noise is that a small change in the input value
     will produce a small change in the output value, while a large change in the 
     input value will produce a random change in the output value.

    This noise module outputs Perlin-noise values that usually range from -1.0 to +1.0, 
    but there are no guarantees that all output values will exist within that range.

    For a better description of Perlin noise, see the links in the <i>References and 
    Acknowledgments</i> section.

    This noise module does not require any source modules.
%End

    %TypeHeaderCode
    #include <noise/module/perlin.h>
    using namespace noise;
    using namespace noise::module;
    %End

    public:
        Perlin ();

        double GetFrequency () const;
        double GetLacunarity () const;
        NoiseQuality GetNoiseQuality () const;
        int GetOctaveCount () const;
        double GetPersistence () const;
        int GetSeed () const;

        void SetFrequency(double frequency);
        void SetLacunarity(double lacunarity);
        void SetNoiseQuality(NoiseQuality noiseQuality);
        void SetOctaveCount(int octaveCount);
        void SetPersistence(double persistence);
        void SetSeed(int seed);

        virtual double GetValue (double x, double y, double z) const /PyName=get_value/;

        // Make things a little more pythonic

        int _GetSourceModuleCount();
        %MethodCode
            Py_BEGIN_ALLOW_THREADS
            sipRes = sipSelfWasArg ? sipCpp->Perlin::GetSourceModuleCount()
                                   : sipCpp->GetSourceModuleCount();
            Py_END_ALLOW_THREADS
        %End

        %Property(name=source_module_count, get=_GetSourceModuleCount)

        %Property(name=frequency, get=GetFrequency, set=SetFrequency) {
            %Docstring "deindented"
                The frequency of the first octave.
            %End
        };

        %Property(name=lacunarity, get=GetLacunarity, set=SetLacunarity) {
            %Docstring "deindented"
                The lacunarity specifies the frequency multiplier between successive 
                octaves.

                The effect of modifying the lacunarity is subtle; you may need to play 
                with the lacunarity value to determine the effects. For best results, 
                set the lacunarity to a number between 1.5 and 3.5.
            %End
        };

        %Property(name=octave_count, get=GetOctaveCount, set=SetOctaveCount) {
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
        
        %Property(name=persistence, get=GetPersistence, set=SetPersistence) {
            %Docstring "deindented"
                The persistence value controls the roughness of the Perlin noise. Larger 
                values produce rougher noise.

                The persistence value determines how quickly the amplitudes diminish
                for successive octaves.  The amplitude of the first octave is 1.0.
                The amplitude of each subsequent octave is equal to the product of the
                previous octave's amplitude and the persistence value.  So a
                persistence value of 0.5 sets the amplitude of the first octave to
                1.0; the second, 0.5; the third, 0.25; etc.

                For best results, set the persistence to a number between 0.0 and 1.0.
            %End
        };

        %Property(name=seed, get=GetSeed, set=SetSeed) {
            %Docstring "deindented"
                The seed value used by the Perlin-noise function.
            %End
        };

        %Property(name=noise_quality, get=GetNoiseQuality, set=SetNoiseQuality) {
            %Docstring "deindented"
                The quality of the Perlin noise.
            %End
        };
};

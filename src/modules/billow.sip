/* ========
    Content from <noise/module/billow.h>
======== */

class Billow: public Module {

    %TypeHeaderCode
    #include <noise/module/billow.h>
    using namespace noise;
    using namespace noise::module;
    %End

    public:
        Billow ();

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
            sipRes = sipSelfWasArg ? sipCpp->Billow::GetSourceModuleCount()
                                   : sipCpp->GetSourceModuleCount();
            Py_END_ALLOW_THREADS
        %End

        %Property(name=source_module_count, get=_GetSourceModuleCount)

        %Property(name=frequency, get=GetFrequency, set=SetFrequency)
        %Property(name=lacunarity, get=GetLacunarity, set=SetLacunarity)
        %Property(name=octave_count, get=GetOctaveCount, set=SetOctaveCount)
        %Property(name=persistence, get=GetPersistence, set=SetPersistence)
        %Property(name=seed, get=GetSeed, set=SetSeed)
        %Property(name=noise_quality, get=GetNoiseQuality, set=SetNoiseQuality)
};

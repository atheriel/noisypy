/* ========
    Content from <noise/module/turbulence.h>
======== */

class Turbulence: public Module {

    %TypeHeaderCode
    #include <noise/module/turbulence.h>
    using namespace noise;
    using namespace noise::module;
    %End

    public:
        Turbulence ();

        double GetFrequency() const;
        int GetSeed() const;
        double GetPower() const;
        int GetRoughnessCount() const;
        
        void SetFrequency(double frequency);
        void SetSeed(int seed);
        void SetPower(double power);
        void SetRoughness(int roughness);

        virtual double GetValue(double x, double y, double z) const /PyName=get_value/;

        // Make things a little more pythonic

        int _GetSourceModuleCount();
        %MethodCode
            Py_BEGIN_ALLOW_THREADS
            sipRes = sipSelfWasArg ? sipCpp->Turbulence::GetSourceModuleCount()
                                   : sipCpp->GetSourceModuleCount();
            Py_END_ALLOW_THREADS
        %End

        %Property(name=source_module_count, get=_GetSourceModuleCount)

        %Property(name=frequency, get=GetFrequency, set=SetFrequency)
        %Property(name=seed, get=GetSeed, set=SetSeed)
        %Property(name=power, get=GetPower, set=SetPower)
        %Property(name=roughness, get=GetRoughnessCount, set=SetRoughness)
};

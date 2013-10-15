/* ========
    Content from <noise/module/voronoi.h>
======== */

class Voronoi: public Module {

    %TypeHeaderCode
    #include <noise/module/voronoi.h>
    using namespace noise;
    using namespace noise::module;
    %End

    public:
        Voronoi ();

        void EnableDistance(bool enable = true);
        double GetDisplacement() const;
        double GetFrequency() const;
        int GetSeed() const;
        
        bool IsDistanceEnabled() const;
        void SetDisplacement(double displacement);
        void SetFrequency(double frequency);
        void SetSeed(int seed);

        virtual double GetValue (double x, double y, double z) const /PyName=get_value/;

        // Make things a little more pythonic

        int _GetSourceModuleCount();
        %MethodCode
            Py_BEGIN_ALLOW_THREADS
            sipRes = sipSelfWasArg ? sipCpp->Voronoi::GetSourceModuleCount()
                                   : sipCpp->GetSourceModuleCount();
            Py_END_ALLOW_THREADS
        %End

        %Property(name=source_module_count, get=_GetSourceModuleCount)

        %Property(name=frequency, get=GetFrequency, set=SetFrequency)
        %Property(name=displacement, get=GetDisplacement, set=SetDisplacement)
        %Property(name=seed, get=GetSeed, set=SetSeed)
        %Property(name=distance_enabled, get=IsDistanceEnabled, set=EnableDistance)
};

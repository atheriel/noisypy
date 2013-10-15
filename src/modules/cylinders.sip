/* ========
    Content from <noise/module/cylinders.h>
======== */

class Cylinders: public Module {

    %TypeHeaderCode
    #include <noise/module/cylinders.h>
    using namespace noise;
    using namespace noise::module;
    %End

    public:
        Cylinders();

        double GetFrequency() const;

        void SetFrequency(double frequency);

        virtual double GetValue(double x, double y, double z) const /PyName=get_value/;

        // Make things a little more pythonic

        int _GetSourceModuleCount();
        %MethodCode
            Py_BEGIN_ALLOW_THREADS
            sipRes = sipSelfWasArg ? sipCpp->Cylinders::GetSourceModuleCount()
                                   : sipCpp->GetSourceModuleCount();
            Py_END_ALLOW_THREADS
        %End

        %Property(name=source_module_count, get=_GetSourceModuleCount)

        %Property(name=frequency, get=GetFrequency, set=SetFrequency)
};

/* ========
    Content from <noise/module/scalebias.h>
======== */

class ScaleBias: public Module {

    %TypeHeaderCode
    #include <noise/module/scalebias.h>
    using namespace noise;
    using namespace noise::module;
    %End

    public:
        ScaleBias();

        virtual double GetValue(double x, double y, double z) const /PyName=get_value/;
        virtual void SetSourceModule (int index, const Module& sourceModule);

        int _GetSourceModuleCount();
        %MethodCode
            Py_BEGIN_ALLOW_THREADS
            sipRes = sipSelfWasArg ? sipCpp->ScaleBias::GetSourceModuleCount()
                                   : sipCpp->GetSourceModuleCount();
            Py_END_ALLOW_THREADS
        %End

        %Property(name=source_module_count, get=_GetSourceModuleCount)

        double GetScale() const;
        double GetBias() const;

        void SetScale (double scale);
        void SetBias (double bias);

        %Property(name=scale, get=GetScale, set=SetScale)
        %Property(name=bias, get=GetBias, set=SetBias)
};

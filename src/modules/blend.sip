/* ========
    Content from <noise/module/blend.h>
======== */

class Blend: public Module {

    %TypeHeaderCode
    #include <noise/module/blend.h>
    using namespace noise;
    using namespace noise::module;
    %End

    public:
        Blend();

        virtual double GetValue(double x, double y, double z) const /PyName=get_value/;
        virtual void SetSourceModule (int index, const Module& sourceModule);

        int _GetSourceModuleCount();
        %MethodCode
            Py_BEGIN_ALLOW_THREADS
            sipRes = sipSelfWasArg ? sipCpp->Blend::GetSourceModuleCount()
                                   : sipCpp->GetSourceModuleCount();
            Py_END_ALLOW_THREADS
        %End

        %Property(name=source_module_count, get=_GetSourceModuleCount)

        const Module& GetControlModule () const;
        void SetControlModule (const Module& controlModule);

        %Property(name=control_module, get=GetControlModule, set=SetControlModule)
};

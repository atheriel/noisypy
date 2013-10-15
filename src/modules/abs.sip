/* ========
    Content from <noise/module/abs.h>
======== */

class Abs: public Module {

    %TypeHeaderCode
    #include <noise/module/abs.h>
    using namespace noise;
    using namespace noise::module;
    %End

    public:
        Abs ();

        virtual double GetValue (double x, double y, double z) const /PyName=get_value/;

        int _GetSourceModuleCount();
        %MethodCode
            Py_BEGIN_ALLOW_THREADS
            sipRes = sipSelfWasArg ? sipCpp->Abs::GetSourceModuleCount()
                                   : sipCpp->GetSourceModuleCount();
            Py_END_ALLOW_THREADS
        %End

        %Property(name=source_module_count, get=_GetSourceModuleCount)
};

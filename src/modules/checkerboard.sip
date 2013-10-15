/* ========
    Content from <noise/module/checkerboard.h>
======== */

class Checkerboard: public Module {

    %TypeHeaderCode
    #include <noise/module/checkerboard.h>
    using namespace noise;
    using namespace noise::module;
    %End

    public:
        Checkerboard();

        virtual double GetValue(double x, double y, double z) const /PyName=get_value/;
        virtual void SetSourceModule (int index, const Module& sourceModule);

        int _GetSourceModuleCount();
        %MethodCode
            Py_BEGIN_ALLOW_THREADS
            sipRes = sipSelfWasArg ? sipCpp->Checkerboard::GetSourceModuleCount()
                                   : sipCpp->GetSourceModuleCount();
            Py_END_ALLOW_THREADS
        %End

        %Property(name=source_module_count, get=_GetSourceModuleCount)
};

/* ========
    Content from <noise/module/add.h>
======== */

class Add: public Module {

	%TypeHeaderCode
    #include <noise/module/add.h>
    using namespace noise;
    using namespace noise::module;
    %End

    public:
        Add ();

        virtual double GetValue (double x, double y, double z) const /PyName=get_value/;

        int _GetSourceModuleCount();
        %MethodCode
            Py_BEGIN_ALLOW_THREADS
            sipRes = sipSelfWasArg ? sipCpp->Add::GetSourceModuleCount()
                                   : sipCpp->GetSourceModuleCount();
            Py_END_ALLOW_THREADS
        %End

        %Property(name=source_module_count, get=_GetSourceModuleCount)
};

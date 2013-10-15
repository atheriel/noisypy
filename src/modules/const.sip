/* ========
    Content from <noise/module/const.h>
======== */

class Const: public Module {

    %TypeHeaderCode
    #include <noise/module/const.h>
    using namespace noise;
    using namespace noise::module;
    %End

    public:
        Const ();

        virtual double GetValue(double x, double y, double z) const /PyName=get_value/;

        int _GetSourceModuleCount();
        %MethodCode
            Py_BEGIN_ALLOW_THREADS
            sipRes = sipSelfWasArg ? sipCpp->Const::GetSourceModuleCount()
                                   : sipCpp->GetSourceModuleCount();
            Py_END_ALLOW_THREADS
        %End

        %Property(name=source_module_count, get=_GetSourceModuleCount)

        double GetConstValue () const;
        void SetConstValue (double constValue);

        %Property(name=const_value, get=GetConstValue, set=SetConstValue)
};

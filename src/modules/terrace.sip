/* ========
    Content from <noise/module/terrace.h>
======== */

class Terrace: public Module {

    %TypeHeaderCode
    #include <noise/module/terrace.h>
    using namespace noise;
    using namespace noise::module;
    %End

    public:
        Terrace();
        ~Terrace();

        virtual double GetValue(double x, double y, double z) const /PyName=get_value/;
        virtual void SetSourceModule (int index, const Module& sourceModule);

        int _GetSourceModuleCount();
        %MethodCode
            Py_BEGIN_ALLOW_THREADS
            sipRes = sipSelfWasArg ? sipCpp->Terrace::GetSourceModuleCount()
                                   : sipCpp->GetSourceModuleCount();
            Py_END_ALLOW_THREADS
        %End

        %Property(name=source_module_count, get=_GetSourceModuleCount)

        void AddControlPoint (double value);
        void ClearAllControlPoints ();
        int GetControlPointCount () const;
        void InvertTerraces (bool invert = true);
        bool IsTerracesInverted () const;
        void MakeControlPoints (int controlPointCount);
};

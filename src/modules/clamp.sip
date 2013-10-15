/* ========
    Content from <noise/module/clamp.h>
======== */

class Clamp: public Module {

    %TypeHeaderCode
    #include <noise/module/clamp.h>
    using namespace noise;
    using namespace noise::module;
    %End

    public:
        Clamp();

        virtual double GetValue(double x, double y, double z) const /PyName=get_value/;
        virtual void SetSourceModule (int index, const Module& sourceModule);

        int _GetSourceModuleCount();
        %MethodCode
            Py_BEGIN_ALLOW_THREADS
            sipRes = sipSelfWasArg ? sipCpp->Clamp::GetSourceModuleCount()
                                   : sipCpp->GetSourceModuleCount();
            Py_END_ALLOW_THREADS
        %End

        %Property(name=source_module_count, get=_GetSourceModuleCount)

        // The C++ API has a strange method for setting bounds. Using a 
        // two-element tuple a more pythonic approach, and lets us use 
        // a property, too.

        SIP_PYTUPLE GetBounds();
        %MethodCode
            Py_BEGIN_ALLOW_THREADS
            double bounds[2] = {sipCpp->GetLowerBound(), sipCpp->GetUpperBound()};
            sipRes = Py_BuildValue("dd", bounds[0], bounds[1]);
            Py_END_ALLOW_THREADS
        %End

        void SetBounds(SIP_PYTUPLE);
        %MethodCode
            double bounds[2];

            if (PyArg_ParseTuple(a0, "dd", &bounds[0], &bounds[1])) {
                Py_BEGIN_ALLOW_THREADS
                sipCpp->SetBounds(bounds[0], bounds[1]);
                Py_END_ALLOW_THREADS
            } else {
                // PyArg_ParseTuple() will have raised the exception.
                sipIsErr = 1;
            }
        %End

        %Property(name=bounds, get=GetBounds, set=SetBounds)
};

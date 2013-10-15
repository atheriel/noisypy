/* ========
    Content from <noise/module/translatepoint.h>
======== */

class TranslatePoint: public Module {

    %TypeHeaderCode
    #include <noise/module/translatepoint.h>
    using namespace noise;
    using namespace noise::module;
    %End

    public:
        TranslatePoint();

        double GetXTranslation () const;
        double GetYTranslation () const;
        double GetZTranslation () const;

        void SetXTranslation (double xTranslation);
        void SetYTranslation (double yTranslation);
        void SetZTranslation (double zTranslation);

        virtual double GetValue(double x, double y, double z) const /PyName=get_value/;

        // Make things a little more pythonic

        int _GetSourceModuleCount();
        %MethodCode
            Py_BEGIN_ALLOW_THREADS
            sipRes = sipSelfWasArg ? sipCpp->TranslatePoint::GetSourceModuleCount()
                                   : sipCpp->GetSourceModuleCount();
            Py_END_ALLOW_THREADS
        %End

        %Property(name=source_module_count, get=_GetSourceModuleCount)

        %Property(name=x_translation, get=GetXTranslation, set=SetXTranslation)
        %Property(name=y_translation, get=GetYTranslation, set=SetYTranslation)
        %Property(name=z_translation, get=GetZTranslation, set=SetZTranslation)

        SIP_PYTUPLE _GetTranslation();
        %MethodCode
            Py_BEGIN_ALLOW_THREADS
            double translation[3] = {sipCpp->GetXTranslation(), sipCpp->GetYTranslation(), sipCpp->GetZTranslation()};
            sipRes = Py_BuildValue("ddd", translation[0], translation[1], translation[2]);
            Py_END_ALLOW_THREADS
        %End

        void _SetTranslation(SIP_PYTUPLE);
        %MethodCode
            double translation[3];
            
            Py_ssize_t dim_num = PyTuple_Size(a0);
            
            if(!dim_num) {
                if(!PyErr_Occurred()) {
                    PyErr_SetString(PyExc_TypeError, "You must supply at least one argument.");
                }
                sipIsErr = 1;
            }

            /* This doesn't work right now. */
            else if (dim_num == 1) {
                if (PyArg_ParseTuple(a0, "d", &translation[0])) {
                    Py_BEGIN_ALLOW_THREADS
                    sipCpp->SetXTranslation(translation[0]);
                    sipCpp->SetYTranslation(translation[0]);
                    sipCpp->SetZTranslation(translation[0]);
                    Py_END_ALLOW_THREADS
                } else {
                    sipIsErr = 1;
                }
            }

            else if (dim_num == 3) {
                if (PyArg_ParseTuple(a0, "ddd", &translation[0], &translation[1], &translation[2])) {
                    Py_BEGIN_ALLOW_THREADS
                    sipCpp->SetXTranslation(translation[0]);
                    sipCpp->SetYTranslation(translation[1]);
                    sipCpp->SetZTranslation(translation[2]);
                    Py_END_ALLOW_THREADS
                } else {
                    sipIsErr = 1;
                }
            }

            else {
                PyErr_SetString(PyExc_TypeError, "You must specify either one or three translation factors.");
                sipIsErr = 1;
            }
        %End

        %Property(name=translation, get=_GetTranslation, set=_SetTranslation)
};

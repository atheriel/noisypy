/* ========
    Content from <noise/module/rotatepoint.h>
======== */

class RotatePoint: public Module {

    %TypeHeaderCode
    #include <noise/module/rotatepoint.h>
    using namespace noise;
    using namespace noise::module;
    %End

    public:
        RotatePoint();

        double GetXAngle () const;
        double GetYAngle () const;
        double GetZAngle () const;

        void SetXAngle (double xAngle);
        void SetYAngle (double yAngle);
        void SetZAngle (double zAngle);

        virtual double GetValue(double x, double y, double z) const /PyName=get_value/;

        // Make things a little more pythonic

        int _GetSourceModuleCount();
        %MethodCode
            Py_BEGIN_ALLOW_THREADS
            sipRes = sipSelfWasArg ? sipCpp->RotatePoint::GetSourceModuleCount()
                                   : sipCpp->GetSourceModuleCount();
            Py_END_ALLOW_THREADS
        %End

        %Property(name=source_module_count, get=_GetSourceModuleCount)

        %Property(name=x_translation, get=GetXAngle, set=SetXAngle)
        %Property(name=y_translation, get=GetYAngle, set=SetYAngle)
        %Property(name=z_translation, get=GetZAngle, set=SetZAngle)

        SIP_PYTUPLE _GetAngles();
        %MethodCode
            Py_BEGIN_ALLOW_THREADS
            double angles[3] = {sipCpp->GetXAngle(), sipCpp->GetYAngle(), sipCpp->GetZAngle()};
            sipRes = Py_BuildValue("ddd", angles[0], angles[1], angles[2]);
            Py_END_ALLOW_THREADS
        %End

        void _SetAngles(SIP_PYTUPLE);
        %MethodCode
            double angles[3];
            
            Py_ssize_t dim_num = PyTuple_Size(a0);
            
            if(!dim_num) {
                if(!PyErr_Occurred()) {
                    PyErr_SetString(PyExc_TypeError, "You must supply at least one argument.");
                }
                sipIsErr = 1;
            }

            /* This doesn't work right now. */
            else if (dim_num == 1) {
                if (PyArg_ParseTuple(a0, "d", &angles[0])) {
                    Py_BEGIN_ALLOW_THREADS
                    sipCpp->SetXAngle(angles[0]);
                    sipCpp->SetYAngle(angles[0]);
                    sipCpp->SetZAngle(angles[0]);
                    Py_END_ALLOW_THREADS
                } else {
                    sipIsErr = 1;
                }
            }

            else if (dim_num == 3) {
                if (PyArg_ParseTuple(a0, "ddd", &angles[0], &angles[1], &angles[2])) {
                    Py_BEGIN_ALLOW_THREADS
                    sipCpp->SetXAngle(angles[0]);
                    sipCpp->SetYAngle(angles[1]);
                    sipCpp->SetZAngle(angles[2]);
                    Py_END_ALLOW_THREADS
                } else {
                    sipIsErr = 1;
                }
            }

            else {
                PyErr_SetString(PyExc_TypeError, "You must specify either one or three angles factors.");
                sipIsErr = 1;
            }
        %End

        %Property(name=angles, get=_GetAngles, set=_SetAngles)
};

/* ========
    Content from <noise/module/scalepoint.h>
======== */

class ScalePoint: public Module {

    %TypeHeaderCode
    #include <noise/module/scalepoint.h>
    using namespace noise;
    using namespace noise::module;
    %End

    public:
        ScalePoint ();

        double GetXScale () const;
        double GetYScale () const;
        double GetZScale () const;

        void SetXScale (double xScale);
        void SetYScale (double yScale);
        void SetZScale (double zScale);

        virtual double GetValue (double x, double y, double z) const /PyName=get_value/;

        // Make things a little more pythonic

        int _GetSourceModuleCount();
        %MethodCode
            Py_BEGIN_ALLOW_THREADS
            sipRes = sipSelfWasArg ? sipCpp->ScalePoint::GetSourceModuleCount()
                                   : sipCpp->GetSourceModuleCount();
            Py_END_ALLOW_THREADS
        %End

        %Property(name=source_module_count, get=_GetSourceModuleCount)

        %Property(name=x_scale, get=GetXScale, set=SetXScale)
        %Property(name=y_scale, get=GetYScale, set=SetYScale)
        %Property(name=z_scale, get=GetZScale, set=SetZScale)

        SIP_PYTUPLE _GetScale();
        %MethodCode
            Py_BEGIN_ALLOW_THREADS
            double scale[3] = {sipCpp->GetXScale(), sipCpp->GetYScale(), sipCpp->GetZScale()};
            sipRes = Py_BuildValue("ddd", scale[0], scale[1], scale[2]);
            Py_END_ALLOW_THREADS
        %End

        void _SetScale(SIP_PYTUPLE);
        %MethodCode
            double scale[3];
            
            Py_ssize_t dim_num = PyTuple_Size(a0);
            
            if(!dim_num) {
                if(!PyErr_Occurred()) {
                    PyErr_SetString(PyExc_TypeError, "You must supply at least one argument.");
                }
                sipIsErr = 1;
            }

            /* This doesn't work right now. */
            else if (dim_num == 1) {
                if (PyArg_ParseTuple(a0, "d", &scale[0])) {
                    Py_BEGIN_ALLOW_THREADS
                    sipCpp->SetXScale(scale[0]);
                    sipCpp->SetYScale(scale[0]);
                    sipCpp->SetZScale(scale[0]);
                    Py_END_ALLOW_THREADS
                } else {
                    sipIsErr = 1;
                }
            }

            else if (dim_num == 3) {
                if (PyArg_ParseTuple(a0, "ddd", &scale[0], &scale[1], &scale[2])) {
                    Py_BEGIN_ALLOW_THREADS
                    sipCpp->SetXScale(scale[0]);
                    sipCpp->SetYScale(scale[1]);
                    sipCpp->SetZScale(scale[2]);
                    Py_END_ALLOW_THREADS
                } else {
                    sipIsErr = 1;
                }
            }

            else {
                PyErr_SetString(PyExc_TypeError, "You must specify either one or three scale factors.");
                sipIsErr = 1;
            }
        %End

        %Property(name=scale, get=_GetScale, set=_SetScale)
};

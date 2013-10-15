/* ========
    Content from <noise/module/modulebase.h>
======== */

class Module /Abstract/ {

    %TypeHeaderCode
    #include <noise/module/modulebase.h>
    using namespace noise;
    using namespace noise::module;
    %End

    public:
        Module();
        %MethodCode
            sipIsErr = 1;
        %End
        // Module (int sourceModuleCount);
        // virtual ~Module ();
        // virtual const Module& GetSourceModule (int index) const;
        virtual void SetSourceModule (int index, const Module& sourceModule);

    private:

        // This stops SIP from creating an assignment method
        // See <noise/module/modulebase.h:347> for rationale
        Module(const Module&);

};

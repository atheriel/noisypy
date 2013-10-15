/* ========
    Content from "noiseutils.h":107-149
======== */

class Color {
%Docstring "deindented"
    Defines a color.

    A color object contains four 8-bit channels: ``red``, ``green``,
    ``blue``, and an ``alpha`` (transparency) channel. Channel values
    range from ``0`` to ``255``.

    The alpha channel defines the transparency of the color. If the alpha
    channel has a value of ``0``, the color is completely transparent. If
    the alpha channel has a value of ``255``, the color is completely
    opaque.
%End

    public:
        Color();
};

class Image {

    public:
        Image();
        Image(int width, int height);
        Image(const Image& rhs);
        ~Image();

        void Clear(const Color& value);
        void ReclaimMem();
        void TakeOwnership(Image& source);

        Color GetValue(int x, int y) const;
        void SetValue(int x, int y, const Color& value);
        
        Color GetBorderValue() const;
        void SetBorderValue(const Color& borderValue);
        
        int GetHeight() const;
        int GetWidth() const;
        void SetSize(int width, int height);

        int GetStride() const;

        %Property(name=border_color, get=GetBorderValue, set=SetBorderValue)
        %Property(name=stride, get=GetStride)

        SIP_PYTUPLE _getSize();
        %MethodCode
            Py_BEGIN_ALLOW_THREADS
            int size[2] = {sipCpp->GetHeight(), sipCpp->GetWidth()};
            sipRes = Py_BuildValue("ii", size[0], size[1]);
            Py_END_ALLOW_THREADS
        %End

        void _setSize(SIP_PYTUPLE);
        %MethodCode
            int size[2];
            
            Py_ssize_t dim_num = PyTuple_Size(a0);
            
            if(!dim_num) {
                if(!PyErr_Occurred()) {
                    PyErr_SetString(PyExc_TypeError, "You must supply at least one argument.");
                }
                sipIsErr = 1;
            }

            else if (dim_num == 2) {
                if (PyArg_ParseTuple(a0, "ii", &size[0], &size[1])) {
                    Py_BEGIN_ALLOW_THREADS
                    sipCpp->SetSize(size[0], size[1]);
                    Py_END_ALLOW_THREADS
                } else {
                    sipIsErr = 1;
                }
            }

            else {
                PyErr_SetString(PyExc_TypeError, "You must specify two dimensions.");
                sipIsErr = 1;
            }
        %End

        %Property(name=size, get=_getSize, set=_setSize)

};

/* ========
    Content from "noiseutils.h":1820-2354
======== */

class RendererImage /PyName=NoiseMapRenderer/ {
%Docstring "deindented"
    Renders an image from a noise map.

    This class renders an image given the contents of a noise-map object.

    An application can configure the output of the image in three ways:

    1. Specify the color gradient.
    2. Specify the light source parameters.
    3. Specify the background image.

    **1. Specify the color gradient**

    This class uses a color gradient to calculate the color for each pixel
    in the destination image according to the value from the corresponding
    position in the noise map.

    A color gradient is a list of gradually-changing colors. A color
    gradient is defined by a list of *gradient points*. Each gradient
    point has a position and a color. In a color gradient, the colors
    between two adjacent gradient points are linearly interpolated.

    For example, suppose this class contains the following color gradient:

    * ``-1.0`` maps to dark blue.
    * ``-0.2`` maps to light blue.
    * ``-0.1`` maps to tan.
    * ``0.0`` maps to green.
    * ``1.0`` maps to white.

    The value ``0.5`` maps to a greenish-white color because 0.5 is halfway
    between ``0.0`` (mapped to green) and ``1.0`` (mapped to white).

    The value ``-0.6`` maps to a medium blue color because ``-0.6`` is
    halfway between ``-1.0`` (mapped to dark blue) and ``-0.2`` (mapped
    to light blue).

    The color gradient requires a minimum of two gradient points.

    This class contains two pre-made gradients: a grayscale gradient and a
    color gradient suitable for terrain. To use these pre-made gradients,
    call the :py:func:`use_grayscale_gradient()` or :py:func:`use_terrain_gradient()`
    methods, respectively.

    .. note::

        The color value passed to :py:func:`add_gradient_point()` has an alpha
        channel. This alpha channel specifies how a pixel in the background
        image (if specified) is blended with the calculated color. If the
        alpha value is high, this class weighs the blend towards the
        calculated color, and if the alpha value is low, this class weighs the
        blend towards the color from the corresponding pixel in the background
        image.

    **2. Specify the light source parameters**

    This class contains a parallel light source that lights the image. It
    interprets the noise map as a bump map.

    To enable or disable lighting, use the :py:func:`lighting` property.

    To set the position of the light source in the "sky", use the
    :py:attr:`light_azimuth` and :py:attr:`light_elevation` properties.

    To set the color of the light source, use the :py:attr:`light_color`
    property.

    To set the intensity of the light source, use the :py:attr:`light_intensity`
    property. A good intensity value is 2.0, although that value tends to
    "wash out" very light colors from the image.

    To set the contrast amount between areas in light and areas in shadow,
    :py:attr:`light_contrast` property. Determining the correct contrast
    amount requires some trial and error, but if your application
    interprets the noise map as a height map that has its elevation values
    measured in meters and has a horizontal resolution of ``h`` meters, a
    good contrast amount to use is ``1.0 / h``.

    **3. Specify the background image**

    To specify a background image, pass an :py:class:`Image` object to the
    :py:func:`set_background_image` method.

    This class determines the color of a pixel in the destination image by
    blending the calculated color with the color of the corresponding
    pixel from the background image.

    The blend amount is determined by the alpha of the calculated color.
    If the alpha value is high, this class weighs the blend towards the
    calculated color, and if the alpha value is low, this class weighs the
    blend towards the color from the corresponding pixel in the background
    image.

    **Rendering the image**

    To render the image, perform the following steps:

    * Pass a :py:class:`NoiseMap` object to the :py:func:`set_noisemap` method.
    * Pass an :py:class:`Image` object to the :py:func:`set_image` method.
    * Pass an :py:class:`Image` object to the :py:func:`set_background_image` method (optional).
    * Call the :py:func:`render()` method.

    A simple example:

    .. code-block:: python
        :linenos:

        renderer = noisypy.utils.NoiseMapRenderer()
        renderer.set_noisemap(my_noisemap)
        renderer.set_image(my_image)
        renderer.render() # my_image now contains the values from my_noisemap

    More complex examples can be found in the :py:mod:`noisypy.demos` module.
%End

    public:
        RendererImage ();

        void add_gradient_point(double gradientPos, SIP_PYTUPLE);
        %Docstring "deindented"
            add_gradient_point(position, color)

            Adds a gradient point to this gradient object. No two gradient points
            may have the same position.

            :param float position: The position of this gradient point.
            :param color: The color of this gradient point.
            :type color: (int, int, int, int)

            This object uses a color gradient to calculate the color for each
            pixel in the destination image according to the value from the
            corresponding position in the noise map.
            
            The gradient requires a minimum of two gradient points.
            
            The specified color value passed to this method has an alpha
            channel. This alpha channel specifies how a pixel in the
            background image (if specified) is blended with the calculated
            color. If the alpha value is high, this object weighs the blend
            towards the calculated color, and if the alpha value is low, this
            object weighs the blend towards the color from the corresponding
            pixel in the background image.
        %End
        %MethodCode
            int colors[4];
            
            Py_ssize_t dim_num = PyTuple_Size(a1);
            
            if(!dim_num) {
                if(!PyErr_Occurred()) {
                    PyErr_SetString(PyExc_TypeError, "You must supply at least one argument.");
                }
                sipIsErr = 1;
            }

            else if (dim_num == 4) {
                if (PyArg_ParseTuple(a1, "iiii", &colors[0], &colors[1], &colors[2], &colors[3])) {
                    Py_BEGIN_ALLOW_THREADS
                    sipCpp->AddGradientPoint(a0, Color(colors[0], colors[1], colors[2], colors[3]));
                    Py_END_ALLOW_THREADS
                } else {
                    sipIsErr = 1;
                }
            }

            else {
                PyErr_SetString(PyExc_TypeError, "You must specify four color values.");
                sipIsErr = 1;
            }
        %End

        void BuildGrayscaleGradient () /PyName=use_grayscale_gradient/ ;
        %Docstring "deindented"
            Use the grayscale gradient.

            The original gradient is cleared and a grayscale gradient is
            created.

            This color gradient contains the following gradient points:
            
            * ``-1.0`` maps to black (that is, ``[255, 255, 255, 255]``)
            * ``1.0`` maps to white (that is, ``[0, 0, 0, 255]``)
        %End

        void BuildTerrainGradient() /PyName=use_terrain_gradient/ ;
        %Docstring "deindented"
            Use a color gradient suitable for terrain.

            The original gradient is cleared and a grayscale gradient is
            created.

            This gradient color at position ``0.0`` is the "sea level".
            Above that value, the gradient contains greens, browns, and
            whites. Below that value, the gradient contains various shades
            of blue.
        %End

        void ClearGradient() /PyName=clear_gradient/ ;
        %Docstring "deindented"
            Clears the color gradient.

            Before calling the :py:func:`render()` method, the application
            must specify a new color gradient with at least two gradient
            points.
        %End

        bool IsLightEnabled () const /PyName=_is_lighting_enabled/ ;
        void EnableLight (bool enable = true) /PyName=_enable_lighting/ ;

        %Property(name=lighting, get=_is_lighting_enabled, set=_enable_lighting) {
            %Docstring "deindented"
                Enables or disables the light source.

                :type: bool

                If the light source is enabled, this object will interpret the
                noise map as a bump map.
            %End
        };

        bool IsWrapEnabled () const /PyName=_is_wrap_enabled/ ;
        void EnableWrap (bool enable = true) /PyName=_enable_wrap/ ;

        %Property(name=wrap, get=_is_wrap_enabled, set=_enable_wrap) {
            %Docstring "deindented"
                Enables or disables noise map wrapping.

                :type: bool

                This object requires five points (the initial point and its four
                neighbors) to calculate light shading. If wrapping is enabled,
                and the initial point is on the edge of the noise map, the
                appropriate neighbors that lie outside of the noise map will
                "wrap" to the opposite side(s) of the noise map.  Otherwise, the
                appropriate neighbors are cropped to the edge of the noise map.
                Enabling wrapping is useful when creating spherical renderings and
                tileable textures.
            %End
        };

        double GetLightAzimuth () const /PyName=_get_light_azimuth/ ;
        void SetLightAzimuth (double lightAzimuth) /PyName=_set_light_azimuth/;

        %Property(name=light_azimuth, get=_get_light_azimuth, set=_set_light_azimuth) {
            %Docstring "deindented"
                The azimuth of the light source, in degrees.

                :type: float

                The azimuth is the location of the light source around the
                horizon:

                * ``0.0`` degrees is east.
                * ``90.0`` degrees is north.
                * ``180.0`` degrees is west.
                * ``270.0`` degrees is south.
                
                Make sure the light source is enabled by setting the :py:attr:`lighting`
                property before calling the :py:func:`render()` method.
            %End
        };

        double GetLightElev () const /PyName=_get_light_elev/ ;
        void SetLightElev (double lightAzimuth) /PyName=_set_light_elev/;

        %Property(name=light_elevation, get=_get_light_elev, set=_set_light_elev) {
            %Docstring "deindented"
                The elevation of the light source, in degrees.

                :type: float

                The elevation is the angle above the horizon:

                * ``0.0`` degrees is on the horizon.
                * ``90.0`` degrees is straight up.

                Make sure the light source is enabled by setting the :py:attr:`lighting`
                property before calling the :py:func:`render()` method.
            %End
        };

        double GetLightContrast () const /PyName=_get_light_contrast/ ;
        void SetLightContrast (double lightContrast) /PyName=_set_light_contrast/ ;

        %Property(name=light_contrast, get=_get_light_contrast, set=_set_light_contrast) {
            %Docstring "deindented"
                The contrast of the light source. Must be positive.

                :type: float

                The contrast specifies how sharp the boundary is between the
                light-facing areas and the shadowed areas.

                The contrast determines the difference between areas in light and
                areas in shadow.  Determining the correct contrast amount requires
                some trial and error, but if your application interprets the noise
                map as a height map that has a spatial resolution of ``h`` meters
                and an elevation resolution of ``1`` meter, a good contrast amount
                to use is ``1.0 / h``.

                Make sure the light source is enabled by setting the :py:attr:`lighting`
                property before calling the :py:func:`render()` method.
            %End
        };

        double GetLightIntensity () const /PyName=_get_light_intensity/ ;
        void SetLightIntensity (double lightIntensity) /PyName=_set_light_intensity/ ;

        %Property(name=light_intensity, get=_get_light_intensity, set=_set_light_intensity) {
            %Docstring "deindented"
                The intensity of the light source.

                :type: float

                A good value for intensity is 2.0.

                Make sure the light source is enabled by setting the :py:attr:`lighting`
                property before calling the :py:func:`render()` method.
            %End
        };

        double GetLightBrightness () const /PyName=_get_light_brightness/ ;
        void SetLightBrightness (double lightBrightness) /PyName=_set_light_brightness/ ;

        %Property(name=light_brightness, get=_get_light_brightness, set=_set_light_brightness) {
            %Docstring "deindented"
                The brightness of the light source.

                :type: float

                Make sure the light source is enabled by setting the :py:attr:`lighting`
                property before calling the :py:func:`render()` method.
            %End
        };

        SIP_PYTUPLE _get_light_color();
        %MethodCode
            Py_BEGIN_ALLOW_THREADS
            Color light_color = sipCpp->GetLightColor();
            int color[4] = {(int) light_color.red,
                            (int) light_color.blue,
                            (int) light_color.green,
                            (int) light_color.alpha};
            sipRes = Py_BuildValue("iiii", color[0], color[1], color[2], color[3]);
            Py_END_ALLOW_THREADS
        %End

        void _set_light_color(SIP_PYTUPLE);
        %MethodCode
            unsigned char color[4];
            
            Py_ssize_t dim_num = PyTuple_Size(a0);
            
            if(!dim_num) {
                if(!PyErr_Occurred()) {
                    PyErr_SetString(PyExc_TypeError, "You must supply at least one argument.");
                }
                sipIsErr = 1;
            }

            else if (dim_num == 4) {
                if (PyArg_ParseTuple(a0, "iiii", &color[0], &color[1], &color[2], &color[3])) {
                    Py_BEGIN_ALLOW_THREADS
                    sipCpp->SetLightColor(Color(color[0], color[1], color[2], color[3]));
                    Py_END_ALLOW_THREADS
                } else {
                    sipIsErr = 1;
                }
            }

            else {
                PyErr_SetString(PyExc_TypeError, "You must specify four color values.");
                sipIsErr = 1;
            }
        %End

        %Property(name=light_color, get=_get_light_color, set=_set_light_color) {
            %Docstring "deindented"
                The color of the light source.

                :type: (int, int, int, int)

                Make sure the light source is enabled by setting the :py:attr:`lighting`
                property before calling the :py:func:`render()` method.
            %End
        };

        void Render () /PyName=render/;
        %Docstring "deindented"
            Renders the destination image using the contents of the source
            noise map and an optional background image.

            The original content of the destination image is destroyed.

            The background image and the destination image can safely refer to
            the same image, although in this case, the destination image is
            irretrievably blended into the background image.
        %End

        void SetBackgroundImage (const Image& backgroundImage) /PyName=set_background_image/ ;
        %Docstring "deindented"
            set_background_image(background_image)

            Sets the background image.

            :param noisypy.utils.Image background_image: The background image.

            If a background image has been specified, the :py:func:`render()`
            method blends the pixels from the background image onto the
            corresponding pixels in the destination image. The blending
            weights are determined by the alpha channel in the pixels in the
            destination image.
        
            The destination image must exist throughout the lifetime of this
            object unless another image replaces that image.
        %End

        void SetDestImage (Image& destImage) /PyName=set_image/ ;
        %Docstring "deindented"
            set_image(image)

            Sets the destination image.

            :param noisypy.utils.Image image: The destination image.

            The destination image will contain the rendered image after a
            successful call to the :py:func:`render()` method.

            The destination image must exist throughout the lifetime of this
            object unless another image replaces that image.
        %End
        
        void SetSourceNoiseMap (const NoiseMap& sourceNoiseMap) /PyName=set_noisemap/ ;
        %Docstring "deindented"
            set_noisemap(noisemap)

            Sets the source noise map.

            :param noisypy.utils.NoiseMap noisemap: The source noise map.

            The source noise map must exist throughout the lifetime of this
            object unless another noise map replaces it.
        %End
};

/* ========
    Mapped Type for using std::string objects
======== */

%MappedType std::string
{
    %TypeHeaderCode
    #include <string>
    %End

    %ConvertFromTypeCode
        // convert an std::string to a Python (unicode) string
        PyObject* newstring;
        newstring = PyUnicode_DecodeUTF8(sipCpp->c_str(), sipCpp->length(), NULL);
        if(newstring == NULL) {
            PyErr_Clear();
            newstring = PyString_FromString(sipCpp->c_str());
        }
        return newstring;
    %End

    %ConvertToTypeCode
        // Allow a Python string (or a unicode string) whenever a string is
        // expected.
        // If argument is a Unicode string, just decode it to UTF-8
        // If argument is a Python string, assume it's UTF-8
        if (sipIsErr == NULL)
            return (PyString_Check(sipPy) || PyUnicode_Check(sipPy));
        if (sipPy == Py_None) {
            *sipCppPtr = new std::string;
            return 1;
        }
        if (PyUnicode_Check(sipPy)) {
            PyObject* s = PyUnicode_AsEncodedString(sipPy, "UTF-8", "");
            *sipCppPtr = new std::string(PyString_AS_STRING(s));
            Py_DECREF(s);
            return 1;
        }
        if (PyString_Check(sipPy)) {
            *sipCppPtr = new std::string(PyString_AS_STRING(sipPy));
           return 1;
        }
        return 0;
    %End
};

/* ========
    Content from "noiseutils.h":1098-1186
======== */

class WriterBMP /PyName=BMPWriter/ {
%Docstring "deindented"
    Windows bitmap image writer class.

    This class creates a file in Windows bitmap ``.bmp`` format given the
    contents of an :py:class:`Image` object.

    To write the image to a file, perform the following steps:

    * Set the :py:attr:`filename` property.
    * Pass an :py:class:`Image` object to the :py:func:`set_image()` method.
    * Call the :py:func:`write()` method.

    For example:

    .. code-block:: python
        :linenos: 

        writer = noisypy.utils.BMPWriter()
        writer.filename = 'awesome_noisemap.bmp'
        writer.set_image(my_noisemap_image)
        writer.write()
%End

    public:
        WriterBMP();

        std::string GetDestFilename() const /PyName=_get_filename/ ;
        void SetDestFilename(const std::string& filename) /PyName=_set_filename/ ;

        %Property(name=filename, get=_get_filename, set=_set_filename) {
            %Docstring "deindented"
                The name of the file to write.

                :type: string

                Set this property before calling the :py:func:`write()` method.
            %End
        };

        void SetSourceImage(Image& sourceImage) /PyName=set_image/ ;
        %Docstring "deindented"
            set_image(source_image)

            Sets the image object that is written to the file.

            :param noisypy.utils.Image source_image: The image object that is written to the file.

            The writer only stores a pointer to an image object, so make sure
            this image still exists before calling the :py:func:`write()` method.
        %End

        void WriteDestFile() /PyName=write/ ;
        %Docstring "deindented"
            Writes the contents of the image object to the file.

            This method encodes the contents of the image and writes it to a
            file. Before calling this method, call the :py:func:`set_image()`
            method to specify the image, then set the :py:attr:`filename` 
            property to specify the name of the file to write.
        %End
};

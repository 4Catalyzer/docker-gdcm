FROM buildpack-deps:jessie

RUN apt-get update && apt-get install -y --no-install-recommends \
        python-dev \
        cmake \
        swig \
 && rm -rf /var/lib/apt/lists/*

WORKDIR /root

RUN wget "https://downloads.sourceforge.net/project/gdcm/gdcm%202.x/GDCM%202.4.6/gdcm-2.4.6.tar.bz2" \
 && tar xvf gdcm-2.4.6.tar.bz2 \
 && rm gdcm-2.4.6.tar.bz2 \
 && mkdir build_files \
 && cd build_files \
 && cmake -DGDCM_BUILD_SHARED_LIBS=ON  -DGDCM_WRAP_PYTHON=ON ../gdcm-2.4.6 \
 && make

RUN cd build_files && make install \
 && cp bin/*gdcm*py bin/_gdcmswig.so /usr/local/lib/python2.7/dist-packages/

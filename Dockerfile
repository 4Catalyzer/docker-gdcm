FROM buildpack-deps:jessie

RUN apt-get update && apt-get install -y --no-install-recommends \
        python-dev \
        cmake \
        swig \
 && rm -rf /var/lib/apt/lists/*

WORKDIR /root

RUN wget "https://downloads.sourceforge.net/project/gdcm/gdcm%202.x/GDCM%202.6.1/gdcm-2.6.1.tar.bz2" \
 && tar xvf gdcm-2.6.1.tar.bz2 \
 && rm gdcm-2.6.1.tar.bz2 \
 && mkdir build_files \
 && cd build_files \
 && cmake -DGDCM_BUILD_SHARED_LIBS=ON -DGDCM_BUILD_APPLICATIONS=ON -DGDCM_INSTALL_PYTHONMODULE_DIR='/usr/local/lib/python2.7/dist-packages/' -DGDCM_WRAP_PYTHON=ON ../gdcm-2.6.1 \
 && make

#RUN cd build_files && make install
RUN cd build_files && cp bin/*gdcm*py bin/_gdcmswig.so /usr/local/lib/python2.7/dist-packages/
ENV PATH "$PATH:/root/build_files/bin"

# image for TBSW
# current version: ????

FROM ubuntu
ENV HOME /root

WORKDIR $HOME
RUN apt-get update &&\
	apt-get -y install software-properties-common &&\
	apt-get update &&\
	add-apt-repository ppa:george-edison55/cmake-3.x &&\
	apt-get update &&\
	apt-get -y install cmake git g++ libqt4-dev dpkg-dev g++ gcc binutils libx11-dev libxpm-dev libxft-dev libxext-dev default-jdk software-properties-common libroot-bindings-python-dev python2.7 python-numpy python-psutil&&\
	apt-get clean &&\
# compile CLHEP
	git clone https://gitlab.cern.ch/CLHEP/CLHEP.git &&\
	mkdir CLHEP_Install CLHEP_Build &&\
	cd  $HOME/CLHEP_Build &&\
	cmake -DCMAKE_INSTALL_PREFIX=~/CLHEP_Install ~/CLHEP &&\
	cmake --build . --config RelWithDebInfo &&\
	ctest &&\
	cmake --build . --target install &&\
# compile LCIO
	cd $HOME &&\
	git clone https://github.com/iLCSoft/LCIO.git &&\
	cd LCIO &&\
	mkdir build &&\
	cd build &&\
	cmake .. &&\
	make install &&\
# compile cern-root
	cd $HOME &&\
	git clone http://root.cern.ch/git/root.git &&\
	cd root &&\
	git checkout -b v6-08-06 v6-08-06 &&\
	mkdir builddir &&\
	cd builddir &&\
	cmake $HOME/root &&\
	cmake --build . &&\
# setup tbsw
	cd $HOME &&\
	git clone https://BenjaminSchwenker@bitbucket.org/BenjaminSchwenker/tbsw.git &&\
	cd tbsw &&\
	sh install.sh &&\
	cp -r workspace ../workspace-test &&\
	cd $HOME/workspace-test && echo schnuffi &&\
	/bin/bash -c "cat /root/root/builddir/bin/thisroot.sh >> /etc/bash.bashrc" &&\
	/bin/bash -c "cat init_tbsw.sh >> /etc/bash.bashrc" 

ENTRYPOINT ["/usr/bin/python"]
WORKDIR $HOME/workspace-test
CMD ["testbeam-luise.py"]

#!/bin/bash
# python
python3 -m venv ../pyenv 
echo ". ../pyenv/bin/activate" >> activate
. activate
pip install -U pip # 활성화된 가상환경에서 pip 업그레이드
pip install ansible # ansible 설치

# podman install  
dnf install -y container-selinux
dnf install -y conmon
dnf install -y fuse-overlayfs
dnf install -y libsubid.so.3
dnf install -y netavark
dnf install -y oci-runtime
#dnf install -y install-runtime
dnf install -y slirp4netns
dnf install -y containers-common
#        (container-selinux if selinux-policy) is needed by podman-2:4.6.1-5.el9.x86_64
#	conmon >= 2.0.25 is needed by podman-2:4.6.1-5.el9.x86_64
#	containers-common >= 2:1-27 is needed by podman-2:4.6.1-5.el9.x86_64
#	fuse-overlayfs is needed by podman-2:4.6.1-5.el9.x86_64
#	libsubid.so.3()(64bit) is needed by podman-2:4.6.1-5.el9.x86_64
#	netavark is needed by podman-2:4.6.1-5.el9.x86_64
#	oci-runtime is needed by podman-2:4.6.1-5.el9.x86_64
	slirp4netns >= 0.4.0-1 is needed by podman-2:4.6.1-5.el9.x86_64

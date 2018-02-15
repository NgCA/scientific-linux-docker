FROM sl:latest

RUN sed -i 's/tsflags=nodocs//g' /etc/yum.conf
RUN yum install -y openssh-server openssh-clients vim man
RUN echo root:root | chpasswd
RUN sed -i 's/#PermitRootLogin/PermitRootLogin/' /etc/ssh/sshd_config
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd
RUN ssh-keygen -A

EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]

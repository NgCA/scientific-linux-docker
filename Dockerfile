FROM sl:latest

#allow us to get documentation
RUN sed -i 's/tsflags=nodocs//g' /etc/yum.conf

RUN yum install -y openssh-server openssh-clients vim man rsyslog
RUN echo root:root | chpasswd

#allow ssh with root
RUN sed -i 's/#PermitRootLogin/PermitRootLogin/' /etc/ssh/sshd_config
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

#host keys are not automatically generated so do it manually
RUN ssh-keygen -A
RUN rsyslogd

EXPOSE 22
CMD /usr/sbin/sshd && bash

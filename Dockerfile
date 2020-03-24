FROM fedora:latest

COPY bin/ /usr/bin/

WORKDIR /var/lib/boinc

USER root

RUN groupadd -r boinc -g 1000 && \
    useradd -u 1000 -r -g boinc -m -d /opt/boinc -s /sbin/nologin -c "BOINC User" boinc && \
    chmod 755 /opt/boinc && \
    usermod -a -G 0 boinc

RUN dnf -y install boinc-client && \ 
    chmod +x /usr/bin/start-boinc.sh && \
    chgrp -R 0 /var/lib/boinc && \
    chmod -R g=u /var/lib/boinc

USER 1000

CMD ["start-boinc.sh"]
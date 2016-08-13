FROM python:2.7-onbuild

MAINTAINER Mike Terzo <mike@terzo.org>

COPY root /root

ENTRYPOINT ["/usr/local/bin/ansible-playbook", "-i", "inventory", "play.yaml"]
CMD ["-v"]

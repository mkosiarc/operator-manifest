FROM registry.redhat.io/ubi8/python-39

USER 0
RUN dnf install -y \
    --setopt=deltarpm=0 \
    --setopt=install_weak_deps=false \
    --setopt=tsflags=nodocs \
    skopeo \
    && dnf clean all

USER 1001
WORKDIR /opt/app-root/src
COPY . .
RUN \
    pip install -r requirements.txt  --no-deps --require-hashes && \
    pip install . --no-deps

WORKDIR /opt/app-root/workdir
CMD ["operator-manifest", "--help"]

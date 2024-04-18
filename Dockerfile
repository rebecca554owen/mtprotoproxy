FROM ubuntu:22.04
ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -y --no-install-recommends \
    python3 python3-uvloop python3-cryptography python3-socks libcap2-bin ca-certificates && \
    rm -rf /var/lib/apt/lists/* && \
    setcap cap_net_bind_service=+ep /usr/bin/python3.10 && \
    useradd tgproxy -u 10000

USER tgproxy

WORKDIR /home/tgproxy/

COPY --chown=tgproxy mtprotoproxy.py config.py /home/tgproxy/

CMD ["python3", "mtprotoproxy.py"]

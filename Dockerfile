FROM alpine:3.15

ENV BASE_URL="https://get.helm.sh"

ENV HELM_2_FILE="helm-v2.17.0-linux-amd64.tar.gz"
ENV HELM_3_FILE="helm-v3.4.2-linux-amd64.tar.gz"

RUN apk add --no-cache ca-certificates \
    --repository http://dl-cdn.alpinelinux.org/alpine/v3.15/community \
    --repository http://dl-cdn.alpinelinux.org/alpine/v3.15/main \
    jq curl bash nodejs aws-cli && \
    # Install helm version 2:
    curl -L ${BASE_URL}/${HELM_2_FILE} |tar xvz && \
    mv linux-amd64/helm /usr/bin/helm && \
    chmod +x /usr/bin/helm && \
    rm -rf linux-amd64 && \
    # Install helm version 3:
    curl -L ${BASE_URL}/${HELM_3_FILE} |tar xvz && \
    mv linux-amd64/helm /usr/bin/helm3 && \
    chmod +x /usr/bin/helm3 && \
    rm -rf linux-amd64 && \
    # Init version 2 helm:
    helm init --client-only

ENV PYTHONPATH "/usr/lib/python3.9/site-packages/"

COPY . /usr/src/
ENTRYPOINT ["node", "/usr/src/index.js"]

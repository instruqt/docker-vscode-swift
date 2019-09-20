FROM satishbabariya/sourcekit-lsp

ENV CODE_SERVER_VERSION=2.1523-vsc1.38.1

RUN curl -skL https://github.com/cdr/code-server/releases/download/${CODE_SERVER_VERSION}/code-server${CODE_SERVER_VERSION}-linux-x86_64.tar.gz | \
    tar xz code-server${CODE_SERVER_VERSION}-linux-x86_64/code-server --strip-components=1 && \
    mv code-server /usr/bin/

ADD sourcekit-lsp-vscode-dev.vsix /tmp/
RUN code-server --install-extension /tmp/sourcekit-lsp-vscode-dev.vsix --force

RUN mkdir -p /workspace
WORKDIR /workspace

ADD hello.swift /workspace/
ADD settings.json /root/.local/share/code-server/User/

EXPOSE 8080
ENTRYPOINT ["code-server"]
CMD ["/workspace"]

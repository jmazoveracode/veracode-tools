FROM centos:7

COPY SRCCLR.repo /etc/yum.repos.d/SRCCLR.repo
RUN yum update -y && yum install -y epel-release && yum install -y zlib-devel bzip2 bzip2-devel readline-devel sqlite sqlite-devel \
openssl-devel xz xz-devel libffi-devel findutils git gcc gcc-c++ make ack jq srcclr zip unzip java-11-openjdk-devel && yum clean all

ENV PATH="/root/.pyenv/bin:/root/.pyenv/shims/:${PATH}"
RUN curl -s https://pyenv.run | bash \
&& printf 'eval "$(pyenv init -)"\neval "$(pyenv virtualenv-init -)"' > /root/.bashrc \
&& . /root/.bashrc \
&& PYENV_LATEST_V2=$(pyenv install --list | sed 's/^  //' | grep -P '^2.7.\d' | grep -v 'dev\|a\|b' | tail -1) \
&& PYENV_LATEST=$(pyenv install --list | sed 's/^  //' | grep -P '^\d' | grep -v 'dev\|a\|b' | tail -1) \
&& pyenv install $PYENV_LATEST_V2 \
&& pyenv install $PYENV_LATEST \
&& pyenv global $PYENV_LATEST_V2 \
&& pip install --upgrade pip \
&& pip install 'httpie>=0.9.9,<2' \
&& pip install https://downloads.veracode.com/securityscan/hmac/python/security_apisigning_python-17.9.1-py2-none-any.whl

WORKDIR /veracode

RUN VERACODE_WRAPPER_VERSION=$(curl -sS "https://search.maven.org/solrsearch/select?q=g:%22com.veracode.vosp.api.wrappers%22&rows=20&wt=json" | jq -r '.["response"]["docs"][0].latestVersion') \
&& curl -sS -o veracode-wrapper.jar "https://repo1.maven.org/maven2/com/veracode/vosp/api/wrappers/vosp-api-wrappers-java/${VERACODE_WRAPPER_VERSION}/vosp-api-wrappers-java-${VERACODE_WRAPPER_VERSION}.jar" \
&& echo "Veracode wrapper version $VERACODE_WRAPPER_VERSION"

RUN curl -sS -O https://downloads.veracode.com/securityscan/gl-scanner-java-LATEST.zip \
&& unzip gl-scanner-java-LATEST.zip gl-scanner-java.jar && rm -f gl-scanner-java-LATEST.zip

WORKDIR /workspace
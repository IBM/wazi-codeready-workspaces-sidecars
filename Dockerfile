#
# Copyright IBM Corporation 2020 - 2021
# This program and the accompanying materials are made
# available under the terms of the Eclipse Public License 2.0
# which is available at https://www.eclipse.org/legal/epl-2.0/
#
# SPDX-License-Identifier: EPL-2.0
#
# Contributors:
#   IBM Corporation - implementation
#

FROM registry.access.redhat.com/ubi8/nodejs-12

# Build Arguments
ARG PRODUCT_VERSION=1.2.5

# Environment and Label Variables
ENV HOME=/home/wazi \
    NODEJS_VERSION="12" \
    PATH=/usr/lib/jvm/java-1.8.0-openjdk/jre/bin:$HOME/node_modules/.bin/:$HOME/.npm-global/bin/:/usr/bin:$PATH \
    JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk \
    PRODUCT="IBM Wazi Developer for Red Hat CodeReady Workspaces" \
    COMPANY="IBM" \
    VERSION=$PRODUCT_VERSION \
    ZOWE_CLI_VERSION="6.30.0" \
    RELEASE="1" \
    SUMMARY="IBM Wazi Developer for Workspaces" \
    DESCRIPTION="IBM Wazi Developer for Red Hat CodeReady Workspaces - Container" \
    PRODTAG="wazi-code-codeready"

LABEL name="$PRODUCT" \
      vendor="$COMPANY" \
      version="$VERSION" \
      release="$RELEASE" \
      summary="$SUMMARY" \
      description="$DESCRIPTION" \
      io.k8s.description="$DESCRIPTION" \
      io.k8s.display-name="$SUMMARY" \
      io.openshift.tags="$PRODTAG,$COMPANY" \
      com.redhat.component="$PRODTAG" \
      io.openshift.expose-services="" \
      productName="$PRODUCT" \
      productVersion="$VERSION"

USER root

# add user, install java jdk, python, curl, bzip, apply permissions
RUN rm -rf /etc/mysql /etc/my.cnf* && \
    useradd -u 1000 -G wheel,root -d /home/wazi --shell /bin/bash -m wazi && \
    yum remove -y kernel-headers && \
    yum install -y java-1.8.0-openjdk java-1.8.0-openjdk-devel java-1.8.0-openjdk-headless python36 && \
    yum update -y --nobest && \
    yum update -y nodejs npm python3-six pango libnghttp2 && \
    yum clean all && rm -rf /var/cache/yum && \
    mkdir -p /projects && \
    mkdir -p /licenses && \
    for f in "/home/wazi" "/etc/passwd" "/etc/group" "/projects"; do\
        chgrp -R 0 ${f} && \
        chmod -R g+rwX ${f}; \
    done && \
    mkdir -p ${HOME}/rse-rest /opt/app-root/src/.npm-global/bin && \
    ln -s /usr/bin/node /usr/bin/nodejs

# Install Zowe CLI
RUN npm install -g @zowe/cli@$ZOWE_CLI_VERSION --ignore-scripts

# TODO Installing Keytar and Secure Credentials TODO
#RUN npm install -g keytar --ignore-scripts && \
#    npm install -g @zowe/cli@zowe-v1-lts --ignore-scripts && \
#    npm install -g @zowe/secure-credential-store-for-zowe-cli@zowe-v1-lts --ignore-scripts

# Copy RSE API for Zowe CLI Plugin and License
COPY ibm-rse-api-for-zowe-cli.tgz ${HOME}/rse-rest/ibm-rse-api-for-zowe-cli.tgz
COPY LICENSE /licenses

# Install RSE API for Zowe CLI Plugin
RUN npm install -g "${HOME}/rse-rest/ibm-rse-api-for-zowe-cli.tgz" && \
    rm -rf ${HOME}/rse-rest

# Apply Permissions
RUN for f in "${HOME}" "/opt/app-root/src/.npm-global"; do \
      chgrp -R 0 ${f} && \
      chmod -R g+rwX ${f}; \
    done && \
    echo "Installed Packages" && rpm -qa | sort -V && echo "End Of Installed Packages"

WORKDIR ${HOME}

# Add GitConfig and Profile to Zowe CLI Install
COPY --chown=wazi:wazi gitconfig.txt ${HOME}/.gitconfig
COPY --chown=wazi:wazi profile.txt ${HOME}/.profile
RUN ln -sf ${HOME}/.profile ${HOME}/.bashrc

# Wazi User
USER wazi

ADD etc/entrypoint.sh ${HOME}/entrypoint.sh
ENV SHELL=/bin/bash
ENTRYPOINT ["/home/wazi/entrypoint.sh"]

WORKDIR /projects
CMD tail -f /dev/null

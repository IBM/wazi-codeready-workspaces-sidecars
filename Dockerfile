#
# Copyright IBM Corporation 2020
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

# Summary of the Container
ENV PRODUCT="IBM Wazi Developer for Red Hat CodeReady Workspaces"\
    COMPANY="IBM" \
    VERSION="1.1.0" \
    RELEASE="1" \
    SUMMARY="IBM Wazi Developer for Workspaces" \
    DESCRIPTION="IBM Wazi Developer for Red Hat CodeReady Workspaces - Container" \
    PRODTAG="wazi-code-codeready" \
    PRODID="9d41d2d8126f4200b62ba1acc0dffa2e" \
    PRODMETRIC="VIRTUAL_PROCESSOR_CORE" \
    PRODCHARGEDCONTAINERS="All"

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
      productID="$PRODID" \
      productName="$PRODUCT" \
      productMetric="$PRODMETRIC" \
      productChargedContainers="$PRODCHARGEDCONTAINERS" \
      productVersion="$VERSION"

USER root

# Set Environment Variable for Home Dir and Node Dir
ENV HOME=/home/wazi \
    NODEJS_VERSION=12 \
    PATH=$HOME/node_modules/.bin/:$HOME/.npm-global/bin/:/usr/bin:$PATH

# add user, install java jdk, python, curl, bzip, apply permissions
RUN rm -rf /etc/mysql /etc/my.cnf* && \
    useradd -u 1000 -G wheel,root -d /home/wazi --shell /bin/bash -m wazi && \
    yum remove -y kernel-headers && \
    yum install -y java-1.8.0-openjdk java-1.8.0-openjdk-devel java-1.8.0-openjdk-headless python36 && \
    yum update -y && \
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

# set java environment variable
ENV JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk
ENV PATH=${PATH}:/usr/lib/jvm/java-1.8.0-openjdk/jre/bin

# Install Zowe CLI
RUN npm install -g @zowe/cli@6.22.0 --ignore-scripts

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

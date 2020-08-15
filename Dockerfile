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

# get nodejs12 UBI 8 image from redhat registry
FROM registry.access.redhat.com/ubi8/nodejs-12
# Summary of the container
ENV SUMMARY="IBM Wazi for CodeReady Workspaces Development Client - Container" \
    DESCRIPTION="IBM Wazi for CodeReady Workspaces Development Client - IBM Wazi Code CodeReady" \
    PRODNAME="wazi-code-codeready" \
    COMPNAME="ibm"
LABEL name="$COMPNAME-$PRODNAME" \
      vendor="IBM" \
      version="v1.1.0" \
      release="1" \
      summary="$SUMMARY" \
      description="$DESCRIPTION" \
      io.k8s.description="$DESCRIPTION" \
      io.k8s.display-name="$SUMMARY" \
      io.openshift.tags="$PRODNAME,$COMPNAME" \
      com.redhat.component="$COMPNAME-$PRODNAME-container" \
      io.openshift.expose-services=""
USER root
# set environment variable for home direcotry and node directory
ENV HOME=/home/wazi \
    NODEJS_VERSION=10 \
    PATH=$HOME/node_modules/.bin/:$HOME/.npm-global/bin/:/usr/bin:$PATH
# add user, install java jdk, python, curl, bzip, apply permissions
RUN rm -rf /etc/mysql /etc/my.cnf* && \
    useradd -u 1000 -G wheel,root -d /home/wazi --shell /bin/bash -m wazi && \
    yum remove -y kernel-headers && \
    yum install -y java-1.8.0-openjdk java-1.8.0-openjdk-devel java-1.8.0-openjdk-headless curl bzip2 python36 && \
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
RUN npm install -g @zowe/cli@zowe-v1-lts --ignore-scripts
# Copy RSE API for Zowe CLI Plugin
COPY ibm-rse-api-for-zowe-cli.tgz ${HOME}/rse-rest/ibm-rse-api-for-zowe-cli.tgz
# install rse api for zowe cli plugin
RUN npm install -g "${HOME}/rse-rest/ibm-rse-api-for-zowe-cli.tgz" && \
    rm -rf ${HOME}/rse-rest
# apply permissions
RUN for f in "${HOME}" "/opt/app-root/src/.npm-global"; do \
      chgrp -R 0 ${f} && \
      chmod -R g+rwX ${f}; \
    done && \
    echo "Installed Packages" && rpm -qa | sort -V && echo "End Of Installed Packages"
WORKDIR ${HOME}
# add gitconfig and profile to install zowe cli
COPY LICENSE /licenses
COPY --chown=wazi:wazi gitconfig.txt ${HOME}/.gitconfig
COPY --chown=wazi:wazi profile.txt ${HOME}/.profile
RUN ln -sf ${HOME}/.profile ${HOME}/.bashrc
# change user root to wazi
USER wazi
ADD etc/entrypoint.sh ${HOME}/entrypoint.sh
ENV SHELL=/bin/bash
ENTRYPOINT ["/home/wazi/entrypoint.sh"]
WORKDIR /projects
CMD tail -f /dev/null

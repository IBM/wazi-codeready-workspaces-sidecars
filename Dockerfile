###############################################################################
# Licensed Materials - Property of IBM
# (c) Copyright IBM Corporation 2018, 2020. All Rights Reserved.
#
# Note to U.S. Government Users Restricted Rights:
# Use, duplication or disclosure restricted by GSA ADP Schedule
# Contract with IBM Corp.
###############################################################################

# Copyright (c) 2019 Red Hat, Inc.
# This program and the accompanying materials are made
# available under the terms of the Eclipse Public License 2.0
# which is available at https://www.eclipse.org/legal/epl-2.0/
#
# SPDX-License-Identifier: EPL-2.0
#
# Contributors:
#   Red Hat, Inc. - initial API and implementation
FROM node:10.16-alpine

ENV HOME=/home/theia
# Install Zowe CLI
RUN npm config set @brightside:registry https://api.bintray.com/npm/ca/brightside && \
    npm install -g @brightside/core@lts-incremental --ignore-scripts

RUN rm -rf ${HOME}
RUN mkdir /projects ${HOME} && \
    # Change permissions to let any arbitrary user
    for f in "${HOME}" "/etc/passwd" "/projects" "/tmp"; do \
      echo "Changing permissions on ${f}" && chgrp -R 0 ${f} && \
      chmod -R g+rwX ${f}; \
    done

RUN apk --update --no-cache add openjdk8 procps nss curl

RUN curl -u prasang.a.prajapati@ibm.com:AKCp5ek86EKHPCHz36pa4yhdvBBf8iNiAdXmCbTQ37vHicSN8AiDU9Wr4qTXSeYEbqiHBVgu2 https://eu.artifactory.swg-devops.com/artifactory/sys-zowe-ext-maven-local/com/ibm/zowe/ide/ibm-rse-rest-for-zowe-cli/0.4.6-SNAPSHOT/ibm-rse-rest-for-zowe-cli-0.4.6-SNAPSHOT.tgz -o ibm-rse-rest-for-zowe-cli-0.4.6-SNAPSHOT.tgz
RUN npm install -g "ibm-rse-rest-for-zowe-cli-0.4.6-SNAPSHOT.tgz" \
    rm ibm-rse-rest-for-*.tgz
RUN zowe plugins install "/usr/local/lib/node_modules/@ibm/rse-rest-for-zowe-cli"

ENV JAVA_HOME /usr/lib/jvm/default-jvm/
ADD etc/before-start.sh /before-start.sh

ADD etc/entrypoint.sh /entrypoint.sh

ENTRYPOINT [ "/entrypoint.sh" ]
CMD ${PLUGIN_REMOTE_ENDPOINT_EXECUTABLE}
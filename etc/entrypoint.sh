#!/bin/sh

#
# Copyright (c) 2019 Red Hat, Inc.
# Copyright IBM Corporation 2020
# This program and the accompanying materials are made
# available under the terms of the Eclipse Public License 2.0
# which is available at https://www.eclipse.org/legal/epl-2.0/
#
# SPDX-License-Identifier: EPL-2.0
#
# Contributors:
#   Red Hat, Inc. - initial API and implementation
#   IBM Corporation - implementation
#

set -e

export USER_ID=$(id -u)
export GROUP_ID=$(id -g)


# Add current (arbitrary) user `theia` to /etc/passwd
if ! whoami &> /dev/null; then
  echo "${USER_NAME:-wazi}:x:${USER_ID}:0:${USER_NAME:-wazi} wazi:${HOME}:/bin/bash" >> /etc/passwd
fi

# Grant access to projects volume in case of non root user with sudo rights
if [ "${USER_ID}" -ne 0 ] && command -v sudo >/dev/null 2>&1 && sudo -n true > /dev/null 2>&1; then
    sudo chown "${USER_ID}:${GROUP_ID}" /projects && sudo chown "${USER_ID}:${GROUP_ID}" /home/wazi
fi

[ -f "/before-start.sh" ] && . "/before-start.sh"
exec "$@"

#!/bin/bash
#
# Copyright 2019 IBM Corp. All Rights Reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

set -e

RELEASE="latest/"

# check if running piped from curl
if [ -z ${BASH_SOURCE} ]; then
  echo "* Downloading install yaml..."
  rm -rf /tmp/ibm-operators && mkdir -p /tmp/ibm-operators
  cd /tmp/ibm-operators
  curl -sLJO https://github.com/IBM/cos-bucket-operator/archive/master.zip
  unzip -qq cos-bucket-operator-master.zip
  cd cos-bucket-operator-master
  SCRIPTS_HOME=${PWD}/hack
else
  SCRIPTS_HOME=$(dirname ${BASH_SOURCE})
fi

# configure the operator
${SCRIPTS_HOME}/config-operator.sh

# install the operator
kubectl apply -f ${SCRIPTS_HOME}/../releases/${RELEASE}

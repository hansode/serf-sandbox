#!/bin/bash
#
# requires:
#  bash
#
set -e
set -o pipefail
set -x

function yum() {
  $(type -P yum) --disablerepo=updates "${@}"
}

# Add installation packages ...
addpkgs="
 unzip
"

if [[ -n "$(echo ${addpkgs})" ]]; then
  yum install -y ${addpkgs}
fi

# Download and install Serf

cd /tmp
case "$(arch)" in
x86_64) arch=amd64 ;;
  i*86) arch=386   ;;
esac

if [[ ! -f serf.zip ]]; then
  until curl -fSkL -o serf.zip https://dl.bintray.com/mitchellh/serf/0.5.0_linux_${arch}.zip; do
    sleep 1
  done
  unzip serf.zip
  mv serf /usr/bin/serf
fi

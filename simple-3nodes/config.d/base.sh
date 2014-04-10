#!/bin/bash
#
# requires:
#  bash
#
set -e
set -o pipefail
set -x

# Do some changes ...

ifcfg_setup=/usr/local/bin/ifcfg-setup

if [[ ! -f ${ifcfg_setup} ]]; then
  curl -fSkL https://raw.githubusercontent.com/hansode/ifutils/master/bin/ifcfg-setup -o ${ifcfg_setup}
  chmod +x ${ifcfg_setup}
fi

case "$(hostname)" in
node01) ip=192.168.1.11 ;;
node02) ip=192.168.1.12 ;;
node03) ip=192.168.1.13 ;;
esac

${ifcfg_setup} install ethernet eth1 ip=${ip}
ifup eth1

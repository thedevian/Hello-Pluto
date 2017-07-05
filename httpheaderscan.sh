#!/bin/bash
#Author: thedevian
#
#Program designed to analyse http responses for the pressence of security headers

function runxframe() {
  substring="X-Frame"
  cmd=$(curl -s -I $1 | grep -e "$substring")
  if test "${cmd#*$substring}" != "$cmd"
  then
    echo "$cmd"
  else
    echo "****** $substring is not present."
  fi
}

function runxprotect() {
  substring="X-Xss-Protection"
  cmd=$(curl -s -I $1 | grep -e "$substring")
  if test "${cmd#*$substring}" != "$cmd"
  then
    echo "$cmd"
  else
    echo "****** $substring is not present."
  fi
}

function runxcontent() {
  substring="X-Content-Type"
  cmd=$(curl -s -I $1 | grep -e "$substring")
  if test "${cmd#*$substring}" != "$cmd"
  then
    echo "$cmd"
  else
    echo "****** $substring is not present."
  fi
}

function runcontentsec() {
  substring="Content-Security-Policy"
  cmd=$(curl -s -I $1 | grep -e "$substring" | cut -d':' -f1)
  if test "${cmd#*$substring}" != "$cmd"
  then
    echo "$cmd"
  else
    echo "****** $substring is not present."
  fi
}

function runxpermit() {
  substring="X-Permitted-Cross-Domain-Policies"
  cmd=$(curl -s -I $1 | grep -e "$substring")
  if test "${cmd#*$substring}" != "$cmd"
  then
    echo "$cmd"
  else
    echo "****** $substring is not present."
  fi
}

function runreferrer() {
  substring="Referrer"
  cmd=$(curl -s -I $1 | grep -e "$substring")
  if test "${cmd#*$substring}" != "$cmd"
  then
    echo "$cmd"
  else
    echo "****** $substring is not present."
  fi
}


for var in $@
do
  echo "============================================================="
  echo $var $'\n'
  eval runxframe $var
  eval runxprotect $var
  eval runxcontent $var
  eval runcontentsec $var
  eval runxpermit $var
  eval runreferrer $var
  echo "============================================================="
  echo $'\n'
done

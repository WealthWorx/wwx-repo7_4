#!/bin/sh

DIRNAME=`dirname "$0"`
PROGNAME=`basename "$0"`
JBOSS_CLI="$DIRNAME/jboss-cli.sh"
$JBOSS_CLI --user=@jboss.management.user.username@ --password=@jboss.management.user.password@ --connect command=:shutdown

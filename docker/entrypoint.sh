#!/bin/bash
/etc/init.d/cache-stnsd start
/etc/init.d/rsyslog start
/usr/sbin/sshd -De

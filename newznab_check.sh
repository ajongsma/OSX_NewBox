#!/bin/sh

## http://www.howtogeek.com/120285/how-to-build-your-own-usenet-indexer/

PHP_INI_1=/private/etc/php.ini
PHP_INI_2=/usr/local/etc/php/5.4/php.ini
APACHE2_CONF=/private/etc/apache2/httpd.conf
MYSQL_CONF=/etc/my.cnf
SPHINX_CONF=/etc/default/sphinxsearch

PATH_TO_SPOTWEB=/User/Spotweb/Sites/spotweb
PATH_TO_PHP_1=/usr/bin/php
PATH_TO_PHP_2=(brew --prefix josegonzalez/php/php54)/bin

## http://forum.qnap.com/viewtopic.php?p=306612
RED=$(tput setaf 1)
GREEN=$(tput setaf 2)
NORMAL=$(tput sgr0)
col=40

echo $PID > ${NN_PID_PATH}${PIDFILE}
if [ -f ${NN_PID_PATH}${PIDFILE} ]
then
 printf '%s%*s%s\n' "$GREEN" $col '[OK]' "$NORMAL"
else
 printf '%s%*s%s\n' "$RED" $col '[FAIL]' "$NORMAL"
fi

## -----------------------------------------------

echo "============================================"
echo "`date +%Y-%m-%d\ %H:%M` : Starting check"
echo "============================================"
echo ".BASH_PROFILE (source ~/.bash_profile)"
echo "--------------------------------------------"
echo "=> PATH PHP:"
cat ~/.bash_profile | grep php
echo "$(brew --prefix josegonzalez/php/php54)/bin:$PATH"

if [ -e APACHE2_CONF ] ; then
	echo "======================"
	echo "APACHE2 => ${APACHE2_CONF}"
	echo "----------------------"
	echo "Check :$(/usr/local/apache2/bin/httpd -S)"
	echo "----------------------"
	cat $APACHE2_CONF | grep "mod_rewrite.so"
	cat $APACHE2_CONF | grep "proxy_http_module"
	cat $APACHE2_CONF | grep "proxy_module"
else
	echo "Missing file : ${APACHE2_CONF}   [ERR]"
fi

echo '======================'
echo 'PHP'
echo '----------------------'
echo 'Add/Change the following lines:'
echo 'include_path = ".:/opt/share/pear"'
echo 'date.timezone = Europe/Amsterdam'
echo 'register_globals = Off'
echo 'max_execution_time = 120'
echo 'memory_limit = 256M'
echo 'error_reporting = E_ALL ^ E_STRICT'
echo '?? extension=sphinx.so'
echo "----------------------"
if [ -e PHP_INI_1 ] ; then
	echo "=> ${PHP_INI_1} : "
	cat $PHP_INI_1 | grep "^include_path"
	cat $PHP_INI_1 | grep "^date.timezone"
	cat $PHP_INI_1 | grep "^register_globals"
	cat $PHP_INI_1 | grep "^max_execution_time"
	cat $PHP_INI_1 | grep "^memory_limit"
	cat $PHP_INI_1 | grep "^error_reporting"
	echo "----------------------"
else
	echo "Missing file : ${PHP_INI_1}   [ERR]"
fi
if [ -e PHP_INI_2 ] ; then
	echo "=> ${PHP_INI_2} :" 
	cat $PHP_INI_2 | grep "^include_path"
	cat $PHP_INI_2 | grep "^date.timezone"
	cat $PHP_INI_2 | grep "^register_globals"
	cat $PHP_INI_2 | grep "^max_execution_time"
	cat $PHP_INI_2 | grep "^memory_limit"
	cat $PHP_INI_2 | grep "^error_reporting"
else
	echo "Missing file : ${PHP_INI_2}   [ERR]"
fi

if [ -e $MYSQL_CONF ] ; then
	# https://newznab.readthedocs.org/en/latest/install/
	# http://gathering.tweakers.net/forum/list_message/39531009#39531009
	echo "======================"
	echo "MYSQL => ${MYSQL_CONF}"
	echo "?? max_allowed_packet= 32M"
	echo "----------------------"
	echo "[mysqld]"
	echo "max_allowed_packet = 12582912"
	echo "group_concat_max_len = 8M"
	echo ""
	cat $MYSQL_CONF | grep "max_allowed_packet"
else
	echo "Missing file : ${MYSQL_CONF}   [ERR]"
fi

if [ -e SPHINX_CONF ] ; then
	echo "======================"
	echo "Sphinx => ${SPHINX_CONF}"
	echo "?? ON"
	echo "----------------------"
	cat SPHINX_CONF
else
	echo "Missing file : ${SPHINX_CONF}   [ERR]"
fi

echo "======================"
echo "Up and Running"
echo "----------------------"
echo "MySQL      :$(mysql.server status)"
echo "PostgreSQL : $(pg_ctl status -D /usr/local/var/postgres)" | grep pg_ctl

echo "memcached  :$(ps aux)" | grep memcached
echo "searchd    :$(ps aux)" | grep searchd

echo "SABnzbd    :$(ps aux)" | grep SABnzbd
echo "SickBeard  :$(ps aux)" | grep SickBeard.py
echo "AutoSub    :$(ps aux)" | grep AutoSub.py



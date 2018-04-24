basepath="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd  $basepath
if [ ! -f .initd ]; then
	mysql $mysql_flags < test.sql
	touch .initd
fi

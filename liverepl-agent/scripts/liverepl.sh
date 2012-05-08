#!/bin/sh
# Starter script for Clojure liverepl

[ -z "$JDK_HOME" ] && JDK_HOME=/usr/lib/jvm/default-java
LIVEREPL_HOME="$(cd -P -- "$(dirname -- "$0")" && pwd -P)"

if [ "x" != "x$CLASSPATH" ]; then
CLASSPATH="${CLASSPATH}:"
fi
CLASSPATH="${CLASSPATH}`find \"$LIVEREPL_HOME\" -name '*.jar' -print | tr '\n' :`"

MAIN=net.djpowell.liverepl.client.Main
CLOJURE_JAR=$(find $LIVEREPL_HOME -name 'clojure-*[0-9].jar')

if [ "Darwin" = "`uname -s`" ]; then
    CLASSPATH="${CLASSPATH}${JAVA_HOME}/bundle/Classes/classes.jar"
elif [ ! -f "$JDK_HOME/lib/tools.jar" ]; then
    echo 'Unable to find $JDK_HOME/lib/tools.jar'
    echo "Please set the JDK_HOME environment variable to the location of your JDK."
    exit 1
else
    CLASSPATH="${CLASSPATH}${JDK_HOME}/lib/tools.jar"
fi

if [ "$TERM" != "dumb" ] && which rlwrap >/dev/null; then
    echo "Found rlwrap"
    breakchars="(){}[],^%$#@\"\";:''|\\"
    WRAP="exec rlwrap --remember -c -b \"$breakchars\" "
fi

${WRAP}java -Xmx128M -cp $CLASSPATH $MAIN "$CLOJURE_JAR" "$LIVEREPL_HOME/liverepl-agent.jar" "$LIVEREPL_HOME/liverepl-server.jar" "$@"




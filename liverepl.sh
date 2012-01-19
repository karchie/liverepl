#!/bin/sh
# Starter script for Clojure liverepl

[ -z "$JDK_HOME" ] && JDK_HOME=/usr/lib/jvm/default-java
LIVEREPL_HOME="$(cd -P -- "$(dirname -- "$0")" && pwd -P)"

if [ "x" != "x$CLASSPATH" ]; then
CLASSPATH="${CLASSPATH}:"
fi
CLASSPATH="${CLASSPATH}`find \"$LIVEREPL_HOME\" -name '*.jar' -print | tr '\n' :`"

if [ ! -f "$JDK_HOME/lib/tools.jar" ]; then
    echo 'Unable to find $JDK_HOME/lib/tools.jar'
    echo "Please set the JDK_HOME environment variable to the location of your JDK."
    exit 1
else
    CLASSPATH="${CLASSPATH}${JDK_HOME}/lib/tools.jar"
fi

echo Running with classpath $CLASSPATH
java -cp $CLASSPATH net.djpowell.liverepl.client.Main "$CLOJURE_JAR" "$LIVEREPL_HOME/liverepl-agent.jar" "$LIVEREPL_HOME/liverepl-server.jar" "$@"


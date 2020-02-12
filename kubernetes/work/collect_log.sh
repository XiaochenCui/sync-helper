#!/bin/sh
for namespace in dfjkfin profin fintest; do
    for pod in generator reply gateway parse; do
        if [ ${pod} = "gateway" ]; then
            kubectl -n ${namespace} get pod | grep ${pod} | awk '{print $1}' | xargs -n 1 kubectl -n ${namespace} -c gateway logs > ${namespace}-${pod}.log
        else
            kubectl -n ${namespace} get pod | grep ${pod} | awk '{print $1}' | xargs -n 1 kubectl -n ${namespace} logs > ${namespace}-${pod}.log
        fi
        echo "[$namespace][$pod]Collect log success"
    done
done

#!/bin/sh
test() {
    for pod in $(kubectl get pods -n profin | grep web- | awk '{print $1}'); do
      kubectl exec ${pod} -n profin python /code/scripts/test_grpc_service.py
    done
}

shell() {
    pod=$(kubectl get pods -n profin | grep web- | awk '{print $1}' | sed q)
    kubectl exec -it ${pod} -n profin /bin/bash
}

cp() {
    kubectl cp $src $dst
}

command=$1
case $1 in
    test )
        test
        ;;
    shell )
        shell
        ;;
esac
shift

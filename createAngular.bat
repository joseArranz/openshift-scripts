::oc login https://172.17.90.212:8443  -u admin -p admin
oc login --token=hC1ewPyT8D3PLECNMtlpNtZiyZDm9Coa5BvjCVz2Gug --server=https://api.crc.testing:6443

::oc delete template --all
::oc delete project jarranzz
::oc new-project jarranzz
:End
PAUSE

::angular app
oc create -f angulartemplate.json
oc process -f angulartemplate.json  -p APPLICATION_NAME=angularcloudsample -p SOURCE_REPOSITORY_URL=https://github.com/joseArranz/angularcloudsample.git  | oc apply -f-
::configmap
oc create -f angularconfigmaptemplate.json
oc process -f angularconfigmaptemplate.json  -p ANGULAR_TEMPLATE_NAME=angularcloudconfigmap -p BACKEND_SERVICE_HOST=springcloud.jarranzz.svc -p BACKEND_KAFKA_HOST=springcloudkafka.jarranzz.svc | oc apply -f-
oc set env --from=configmap/angularcloudconfigmap dc/angularcloudsample




:End
PAUSE
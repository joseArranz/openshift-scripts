oc login 172.18.71.124:8443  -u admin -p admin


::oc delete template --all
::oc delete project jarranzz
::oc new-project jarranzz
:End
PAUSE

::templates
::oc create -f jenkinstemplate.json
::oc create -f springbootcloudtemplate.json
::oc create -f mongotemplate.json
::oc create -f jenkinsbuildtemplate
::oc create -f springbootcloudconfigmaptemplate.json

::jenkins
oc process -f jenkinstemplate.json | oc apply -f-



:End
PAUSE

::micro 1 mongo
oc process -f springbootcloudtemplate.json  -p APPLICATION_NAME=springcloud -p SOURCE_REPOSITORY_URL=https://github.com/joseArranz/springcloud.git   | oc apply -f-
oc process -f mongotemplate.json  -p MONGODB_USER=user -p MONGODB_PASSWORD=user -p MONGODB_DATABASE=sampledb -p MONGODB_ADMIN_PASSWORD=admin -p DATABASE_SERVICE_NAME=mongodb   | oc apply -f-
oc process -f springbootcloudconfigmaptemplate.json  -p MONGODB_USER=user -p MONGODB_PASSWORD=user -p MONGODB_DATABASE=sampledb -p MONGODB_HOST=mongodb.jarranzz.svc -p MONGODB_PORT=27017 -p=MONGODB_TEMPLATE_NAME=mongodb  | oc apply -f-
oc set env --from=configmap/mongodb dc/springcloud
oc process -f jenkinsbuildtemplate.yaml -p APPLICATION_NAME=springcloud | oc apply -f-

::micro 2 mongo
oc process -f springbootcloudtemplate.json  -p APPLICATION_NAME=springcloud2 -p SOURCE_REPOSITORY_URL=https://github.com/joseArranz/springcloud.git   | oc apply -f-
oc process -f mongotemplate.json  -p MONGODB_USER=user -p MONGODB_PASSWORD=user -p MONGODB_DATABASE=sampledb -p MONGODB_ADMIN_PASSWORD=admin -p DATABASE_SERVICE_NAME=mongodb2   | oc apply -f-
oc process -f springbootcloudconfigmaptemplate.json  -p MONGODB_USER=user -p MONGODB_PASSWORD=user -p MONGODB_DATABASE=sampledb -p MONGODB_HOST=mongodb2.jarranzz.svc -p MONGODB_PORT=27017 -p=MONGODB_TEMPLATE_NAME=mongodb2  | oc apply -f-
oc set env --from=configmap/mongodb2 dc/springcloud2
oc process -f jenkinsbuildtemplate.yaml -p APPLICATION_NAME=springcloud2 | oc apply -f-


:End
PAUSE



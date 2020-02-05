oc login 172.18.71.124:8443 -u admin -p admin


oc delete template --all
oc delete project jarranzz
oc new-project jarranzz
:End
PAUSE

::templates
::oc create -f springbootcloudtemplate.json
::oc create -f springbootcloudkafkaconfigmaptemplate.json


::kafka
::https://strimzi.io/documentation/
::https://operatorhub.io/operator/strimzi-kafka-operator
oc apply -f strimzi-user-operator-0.16.1
oc apply -f strimzi-topic-operator-0.16.1.yaml
oc apply -f strimzi-cluster-operator-0.16.1.yaml
oc apply -f kafka-persistent-single.yaml -n jarranzz
:End
PAUSE

::kafka topic -- debajo pruebas en cluster
oc apply -f kafkatopic1.yaml
::oc wait kafka/my-cluster --for=condition=Ready --timeout=300s -n jarranzz
::oc -n jarranzz run kafka-producer -ti --image=strimzi/kafka:0.16.1-kafka-2.4.0 --rm=true --restart=Never -- bin/kafka-console-producer.sh --broker-list my-cluster-kafka-bootstrap:9092 --topic my-topic
::oc -n jarranzz run kafka-consumer -ti --image=strimzi/kafka:0.16.1-kafka-2.4.0 --rm=true --restart=Never -- bin/kafka-console-consumer.sh --bootstrap-server my-cluster-kafka-bootstrap:9092 --topic my-topic --from-beginning


:End
PAUSE
::micro 3 kafka 
oc process -f springbootcloudtemplate.json  -p APPLICATION_NAME=springcloudkafka -p SOURCE_REPOSITORY_URL=https://github.com/joseArranz/springcloudkafka.git   | oc apply -f-
oc process -f springbootcloudkafkaconfigmaptemplate.json  -p KAFKA_HOST=my-cluster-kafka-bootstrap.jarranzz.svc -p KAFKA_PORT=9092 -p KAFKA_TEMPLATE_NAME=kafka-configmap   | oc apply -f-
oc set env --from=configmap/kafka-configmap dc/springcloudkafka
::oc process -f jenkinsbuildtemplate.yaml -p APPLICATION_NAME=springcloudkafka | oc apply -f-


:End
PAUSE




::delete
::oc delete all --all
::oc delete configmap --all



::oc delete buildconfig spring-boot-jenkins-pipeline
::oc create -f jenkinsbuildtemplate.yaml
::oc start-build spring-boot-jenkins-pipeline

::oc delete template mongo-configmap-template
::oc login https://172.17.90.212:8443 --token=DJKi1ffTDYSMjvUZfhALM0-HZA5fAzQRHCiMubaDpbE
::oc login -u admin -p admin
::oc start-build <buildconfig_name>
::oc delete all --all
::oc delete configmap --all
::oc get templates -n openshift
::oc get templates -n jarranz
::oc delete template openjdk18-web-basic-s2i
::oc create -f springbootcloudtemplate.yaml
::oc create -f springbootcloudtemplate.yml -n jarranz
::oc process -f springbootcloudtemplate.yaml  -p APPLICATION_NAME=springcloud -p GIT_URI=https://github.com/joseArranz/springcloud.git   | oc apply -f-
:: oc build-logs springcloud
:: oc logs springcloud

::oc create -f kafka-persistent-template.yaml 
::oc process -f kafka-persistent-template.yaml -p KAFKA_VOLUME_SIZE=1Gi | oc apply -f-


::oc process -f kafka-persistent-template.yaml -p KAFKA_VOLUME_SIZE=1Gi |  oc apply -f-
::oc process -f kafka-ephemeral-template.yaml |  oc apply -f-

::oc process -f kafka-statefulsets/resources/openshift-template.yaml |  oc apply -f-
::oc create -f barnabas/kafka-statefulsets/resources/openshift-template.yaml
::oc process -f kafkabarnabasTemplate.yaml |  oc apply -f-
::https://github.com/finiteloopme/apache-kafka-openshift


::git clone https://github.com/engapa/kafka-k8s-openshift.git
::cd F:\Proyectos\Programacion\openshift\cloud\springbootmongotemplate\kafka-k8s-openshift\openshift
::oc create -f buildconfig.yaml
::oc new-app kafka-builder -p GITHUB_REF="v2.12-2.3.0" -p IMAGE_STREAM_VERSION="2.12-2.3.0"
::oc get is

::oc create -f kafka.yaml
::renombrar archivo a kafka
::oc new-app kafka -p REPLICAS=1 -p SOURCE_IMAGE=172.30.1.1:5000/jarranzz/kafka
::-p ZK_LOCAL=true


::italiano
::git clone https://github.com/mvilche/apache-kafka-openshift.git
::oc process -f apache-kafka-openshift-template.yaml -p NAMESPACE=jarranzz -n jarranzz  | oc apply -f-






::https://rondinif.github.io/openshift-kafka/
::git clone https://github.com/rondinif/openshift-kafka.git
::si no esta el repo hacer de local
::oc create -f https://raw.githubusercontent.com/rondinif/openshift-kafka/master/resources.yaml
::oc new-app apache-kafka

::-------prueba en otra CMD
::oc run -it --rm kafka-debug --image=rondinif/openshift-kafka --command -- bash
::bin/kafka-topics.sh --create --zookeeper apache-kafka --replication-factor 1 --partitions 1 --topic test
::bin/kafka-topics.sh --list --zookeeper apache-kafka
::-------------------send msg
::bin/kafka-console-producer.sh --broker-list apache-kafka:9092 --topic test <<EOF
::foo
::bar
::baz
::EOF
::-----------------------------recibe 
::bin/kafka-console-consumer.sh --bootstrap-server apache-kafka:9092 --topic test --from-beginning

::oc get pods
::oc expose svc/apache-kafka

::oc get pods
::oc get services
::oc port-forward apache-kafka-1-jbztw 9092


::oc config view
::cluester name





::create topics spring boot
::oc run -it --rm kafka-debug --image=rondinif/openshift-kafka --command -- bash
::o pegar en la terminal del pod kafka
::bin/kafka-topics.sh --create --zookeeper apache-kafka --replication-factor 1 --partitions 1 --topic baeldung
::bin/kafka-topics.sh --create --zookeeper apache-kafka --replication-factor 1 --partitions 1 --topic greeting
::bin/kafka-topics.sh --create --zookeeper apache-kafka --replication-factor 1 --partitions 1 --topic filtered
::bin/kafka-topics.sh --create --zookeeper apache-kafka --replication-factor 1 --partitions 1 --topic partitioned




::pruebas kafka strinzzz
::oc create -f kafkaconect1.yaml




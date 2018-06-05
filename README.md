# Sbonacho Event Driven Architecture (SEDA) Infrastructure

It takes less than 5 minutes.

## Required Software

```
Docker (11 or up)
Java (1.8 or up)
Maven (3.5 or up)
```

## Install infrastructure

Lets starts with an example. A simple & complete working example of SBonacho Event Driven Architecture.

1.- Clone this repository https://github.com/sbonacho/seda-infraestructure.git

```
➜  pocs git clone https://github.com/sbonacho/seda-infraestructure.git
Cloning into 'seda-infraestructure'...
remote: Counting objects: 27, done.
remote: Compressing objects: 100% (26/26), done.
remote: Total 27 (delta 8), reused 0 (delta 0)
Unpacking objects: 100% (27/27), done.
Checking connectivity... done.
```

2.- Go inside the folder: cd seda-infraestructure

3.- Install Demo:

```
➜  seda-infraestructure git:(master) ./seda.sh install
Cloning into 'ch-create-client'...
remote: Counting objects: 254, done.
remote: Compressing objects: 100% (122/122), done.
remote: Total 254 (delta 55), reused 195 (delta 40)
Receiving objects: 100% (254/254), 30.91 KiB | 0 bytes/s, done.
Resolving deltas: 100% (55/55), done.
Checking connectivity... done.
Cloning into 'domain-clients'...
remote: Counting objects: 159, done.
remote: Compressing objects: 100% (68/68), done.
remote: Total 159 (delta 32), reused 108 (delta 25)
Receiving objects: 100% (159/159), 19.09 KiB | 0 bytes/s, done.
Resolving deltas: 100% (32/32), done.
Checking connectivity... done.
This command makes this stuff for you:
```

Clone all repositories of the example (5 repositories in total)
Tests all microservices
Generate Docker and install locally
By default the target directory is ../demo but it is possible to change it, this way: ./seda.sh install ../othertarget

## Checking Installation

Check if all repositories are cloned: Go to demo folder:

```
➜  transactions cd demo
➜  demo ls -las
total 0
0 drwxr-xr-x   7 sbonacho  staff  224 30 ene 17:26 .
0 drwxr-xr-x   9 sbonacho  staff  288 30 ene 17:26 .
0 drwxr-xr-x  10 sbonacho  staff  320 30 ene 17:26 ch-create-client
0 drwxr-xr-x  10 sbonacho  staff  320 30 ene 17:27 domain-clients
0 drwxr-xr-x  10 sbonacho  staff  320 30 ene 17:28 domain-portfolios
0 drwxr-xr-x  10 sbonacho  staff  320 30 ene 17:30 query-clients
0 drwxr-xr-x  10 sbonacho  staff  320 30 ene 17:29 saga-create-client
```

Check if all docker SEDA images are installed on the local docker instance.

```
➜  seda-infraestructure git:(master) docker images
REPOSITORY                       TAG                 IMAGE ID            CREATED             SIZE
sbonacho/query-clients        latest              ea65339f4fe6        22 minutes ago      122MB
sbonacho/domain-portfolios    latest              8b2ec7b1312a        24 minutes ago      115MB
sbonacho/domain-clients       latest              46f84871fead        25 minutes ago      115MB
sbonacho/ch-create-client     latest              e57f404f2af3        26 minutes ago      121MB
sbonacho/saga-create-client   latest              de1d22513b4b        29 minutes ago      115MB
```

Install kafka docker images just running docker-compose up -d

```
➜  seda-infraestructure git:(master) docker-compose up -d
Pulling zookeeper (wurstmeister/zookeeper:latest)...
latest: Pulling from wurstmeister/zookeeper
a3ed95caeb02: Pull complete
ef38b711a50f: Pull complete
e057c74597c7: Pull complete
666c214f6385: Pull complete
c3d6a96f1ffc: Pull complete
3fe26a83e0ca: Pull complete
3d3a7dd3a3b1: Pull complete
f8cc938abe5f: Pull complete
9978b75f7a58: Pull complete
4d4dbcc8f8cc: Pull complete
```

Then stop kafka by running docker-compose stop

## Running The Demo

Start all microservices and infraestructure

```
➜  seda-infraestructure git:(master) ./seda.sh start
Creating sedainfraestructure_zookeeper_1 ... done
Creating sedainfraestructure_kafka_1     ... done
5fa918e47eb7a905ef11df95c482779623447043fa416e3fed8bb56dd563e34b
b78fea04cf758423551ab36acfe4bae37d820f34d457904e7311b3e2b1da8c2e
0036b85ee4c8d0da65b80222ea66e6e1f15e639c0ab5cca16ed412d0b42ffcac
1b204259f4f9097f1659d7b1b6a5e6b92bd396d93653588302c9425dc2de0dd2
5dbd8810628fcd284154b33f9e355180bdda15ff806c8b8c083963c7626a4ee2
```

Check if everything is running:

```
➜  seda-infraestructure git:(master) docker ps -a
CONTAINER ID        IMAGE                            COMMAND                  CREATED              STATUS              PORTS                                                NAMES
5dbd8810628f        sbonacho/query-clients        "/bin/sh -c 'exec ja…"   About a minute ago   Up About a minute   0.0.0.0:8082->8082/tcp                               query-clients
1b204259f4f9        sbonacho/saga-create-client   "/bin/sh -c 'exec ja…"   About a minute ago   Up About a minute                                                        saga-create-client
0036b85ee4c8        sbonacho/domain-portfolios    "/bin/sh -c 'exec ja…"   About a minute ago   Up About a minute                                                        domain-portfolios
b78fea04cf75        sbonacho/domain-clients       "/bin/sh -c 'exec ja…"   About a minute ago   Up About a minute                                                        domain-clients
5fa918e47eb7        sbonacho/ch-create-client     "/bin/sh -c 'exec ja…"   About a minute ago   Up About a minute   0.0.0.0:8080->8080/tcp                               ch-create-client
78afec73cce9        sedainfraestructure_kafka        "start-kafka.sh"         About a minute ago   Up About a minute   0.0.0.0:9092->9092/tcp                               sedainfraestructure_kafka_1
4d6e10ec429f        wurstmeister/zookeeper           "/bin/sh -c '/usr/sb…"   About a minute ago   Up About a minute   22/tcp, 2888/tcp, 3888/tcp, 0.0.0.0:2181->2181/tcp   sedainfraestructure_zookeeper_1
```

Open one console in seda-infraestructure and run. This is going to open all logs of all microservices logs by running docker logs -f commands of all docker containers

```
➜  seda-infraestructure git:(master) ./seda.sh watch
  .   ____          _            __ _ _
 /\\ / ___'_ __ _ _(_)_ __  __ _ \ \ \ \
( ( )\___ | '_ | '_| | '_ \/ _` | \ \ \ \
 \\/  ___)| |_)| | | | | || (_| |  ) ) ) )
  '  |____| .__|_| |_|_| |_\__, | / / / /
 =========|_|==============|___/=/_/_/_/
 :: Spring Boot ::        (v1.5.9.RELEASE)

2018-01-31 08:25:56.081  INFO 1 --- [           main] c.s.s.e.insurance.CreateClientBoot       : Starting CreateClientBoot v0.1.0 on 5fa918e47eb7 with PID 1 (/app.jar started by root in /)
2018-01-31 08:25:56.213  INFO 1 --- [           main] c.s.s.e.insurance.CreateClientBoot       : No active profile set, falling back to default profiles: default
2018-01-31 08:25:57.454  INFO 1 --- [           main] ationConfigEmbeddedWebApplicationContext : Refreshing org.springframework.boot.context.embedded.AnnotationConfigEmbeddedWebApplicationContext@6bf2d08e: startup date [Wed Jan 31 08:25:57 GMT 2018]; root of context hierarchy
```

Play: The command port is 8080 and the Query port is 8082

Create one client:

```
➜  demo curl -X PUT -w "%{http_code}" -H "Content-Type: application/json" -d '{"name": "paco", "address": "C/manzanares 10", "interest": "Many"}' http://localhost:8080/client
200%
➜  demo curl http://localhost:8082/client
{"_embedded":{"clientPorfolioList":[{"id":"4f2d23cf-ecf1-4281-8941-ac73b310ec4f","clientId":null,"name":"paco","address":"C/manzanares 10","interest":"Many"}]},"_links":{"self":{"href":"http://localhost:8082/client"}}}%
```

Inspecting the log is easy to see all events flying between microservices.

```
2018-01-31 08:43:43.441  INFO 1 --- [nio-8080-exec-2] c.s.s.e.insurance.api.ClientController   : CreateClient API command received -> {
  "name" : "paco",
  "address" : "C/manzanares 10",
  "interest" : "Many"
}
2018-01-31 08:43:43.443  INFO 1 --- [nio-8080-exec-2] c.s.s.e.i.bus.kafka.producer.SenderImpl  : sending event='{
  "type" : "ClientCreated",
  "id" : "a78bf5a6-09c0-43de-934a-f79c8bae93c7",
  "name" : "paco",
  "address" : "C/manzanares 10",
  "interest" : "Many"
}' to topic='createClient'
2018-01-31 08:43:43.483  INFO 1 --- [ntainer#1-0-C-1] c.s.s.e.i.b.k.listeners.ClientsListener  : ClientCreated Event Received -> {
  "type" : "ClientCreated",
  "id" : "a78bf5a6-09c0-43de-934a-f79c8bae93c7",
  "name" : "paco"
}
2018-01-31 08:43:43.510  INFO 1 --- [ntainer#0-0-C-1] c.s.s.e.i.b.k.l.ClientCreatedListener    : ClientCreated Event Received -> {
  "type" : "ClientCreated",
  "id" : "a78bf5a6-09c0-43de-934a-f79c8bae93c7",
  "name" : "paco",
  "address" : "C/manzanares 10",
  "interest" : "Many"
}
2018-01-31 08:43:43.512  INFO 1 --- [ntainer#0-0-C-1] c.s.s.e.i.b.k.l.ClientCreatedListener    : PortfolioStored Event Emitted -> {
  "type" : "PortfolioStored",
  "clientId" : "a78bf5a6-09c0-43de-934a-f79c8bae93c7",
  "name" : "paco",
  "address" : "C/manzanares 10",
  "interest" : "Many",
2018-01-31 08:43:43.475  INFO 1 --- [ntainer#0-0-C-1] c.s.s.e.i.b.k.l.ClientCreateSagaManager  : ClientCreated Event Received -> {
  "type" : "ClientCreated",
  "id" : "a78bf5a6-09c0-43de-934a-f79c8bae93c7",
  "name" : "paco",
  "address" : "C/manzanares 10",
  "interest" : "Many"
}
  "id" : "95c349cd-a7e5-434d-b793-13748003eabd"
}
2018-01-31 08:43:43.490  INFO 1 --- [ntainer#1-0-C-1] c.s.s.e.i.b.k.listeners.ClientsListener  : ClientStored Event Emitted -> {
2018-01-31 08:43:43.515  INFO 1 --- [ntainer#0-0-C-1] c.s.s.e.i.b.k.l.ClientCreateSagaManager  : Saga '13e4d6fe-4148-4e4e-ae11-85bb5b830882' Created!
  "type" : "ClientStored",
  "id" : "a78bf5a6-09c0-43de-934a-f79c8bae93c7",
  "name" : "paco"
}
2018-01-31 08:43:43.515  INFO 1 --- [ntainer#0-0-C-1] c.s.s.e.i.b.k.l.ClientCreateSagaManager  : Checking Saga -> {
  "id" : "13e4d6fe-4148-4e4e-ae11-85bb5b830882",
  "idClientCreated" : "a78bf5a6-09c0-43de-934a-f79c8bae93c7",
  "idClientStored" : null,
  "idPortfolioStored" : null,
  "name" : "paco",
  "failed" : false,
  "address" : "C/manzanares 10",
  "interest" : "Many",
  "complete" : false
}
2018-01-31 08:43:43.572  INFO 1 --- [ntainer#1-0-C-1] c.s.s.e.i.b.k.l.ClientCreateSagaManager  : ClientStored Event Received -> {
  "type" : "ClientStored",
  "id" : "a78bf5a6-09c0-43de-934a-f79c8bae93c7",
  "name" : "paco"
}
2018-01-31 08:43:43.586  INFO 1 --- [ntainer#1-0-C-1] c.s.s.e.i.b.k.l.ClientCreateSagaManager  : Saga '13e4d6fe-4148-4e4e-ae11-85bb5b830882' Client Stored!
2018-01-31 08:43:43.589  INFO 1 --- [ntainer#1-0-C-1] c.s.s.e.i.b.k.l.ClientCreateSagaManager  : Checking Saga -> {
  "id" : "13e4d6fe-4148-4e4e-ae11-85bb5b830882",
  "idClientCreated" : "a78bf5a6-09c0-43de-934a-f79c8bae93c7",
  "idClientStored" : "a78bf5a6-09c0-43de-934a-f79c8bae93c7",
  "idPortfolioStored" : null,
  "name" : "paco",
  "failed" : false,
  "address" : "C/manzanares 10",
  "interest" : "Many",
  "complete" : false
}
2018-01-31 08:43:43.631  INFO 1 --- [ntainer#1-0-C-1] c.s.s.e.i.b.k.l.ClientCreateSagaManager  : PortfolioStored Event Received -> {
  "type" : "PortfolioStored",
  "id" : "95c349cd-a7e5-434d-b793-13748003eabd",
  "name" : "paco",
  "clientId" : "a78bf5a6-09c0-43de-934a-f79c8bae93c7"
}
2018-01-31 08:43:43.650  INFO 1 --- [ntainer#1-0-C-1] c.s.s.e.i.b.k.l.ClientCreateSagaManager  : Saga '13e4d6fe-4148-4e4e-ae11-85bb5b830882' Portfolio Stored!
2018-01-31 08:43:43.654  INFO 1 --- [ntainer#1-0-C-1] c.s.s.e.i.b.k.l.ClientCreateSagaManager  : Checking Saga -> {
  "id" : "13e4d6fe-4148-4e4e-ae11-85bb5b830882",
  "idClientCreated" : "a78bf5a6-09c0-43de-934a-f79c8bae93c7",
  "idClientStored" : "a78bf5a6-09c0-43de-934a-f79c8bae93c7",
  "idPortfolioStored" : "95c349cd-a7e5-434d-b793-13748003eabd",
  "name" : "paco",
  "failed" : false,
  "address" : "C/manzanares 10",
  "interest" : "Many",
  "complete" : true
}
2018-01-31 08:43:43.679  INFO 1 --- [ntainer#1-0-C-1] c.s.s.e.i.bus.kafka.producer.SenderImpl  : sending message='{
  "type" : "ClientPortfolioCompleted",
  "id" : null,
  "name" : "paco",
  "portfolioId" : "95c349cd-a7e5-434d-b793-13748003eabd",
  "clientId" : "a78bf5a6-09c0-43de-934a-f79c8bae93c7",
  "address" : "C/manzanares 10",
  "interest" : "Many"
}' to topic='saga'
2018-01-31 08:43:43.685  INFO 1 --- [ntainer#1-0-C-1] c.s.s.e.i.b.k.l.ClientCreateSagaManager  : Saga '13e4d6fe-4148-4e4e-ae11-85bb5b830882' Completed!
2018-01-31 08:43:43.707  INFO 1 --- [ntainer#0-0-C-1] c.s.s.e.i.b.k.l.ClientsPortfolioListener : ClientPortfolioCompleted Event Received -> {
  "type" : "ClientPortfolioCompleted",
  "portfolioId" : "95c349cd-a7e5-434d-b793-13748003eabd",
  "clientId" : "a78bf5a6-09c0-43de-934a-f79c8bae93c7",
  "name" : "paco",
  "address" : "C/manzanares 10",
  "interest" : "Many"
}
```

Note: It is possible to see what happen on each microservice by running docker logs containername -f command for each microservice
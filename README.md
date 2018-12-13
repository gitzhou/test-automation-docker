test-automation-docker
----

The Dockerfile is based on [dorowu/ubuntu-desktop-lxde-vnc](https://github.com/fcwu/docker-ubuntu-vnc-desktop), will build out an image contains:

- Ubuntu 18.04 with Firefox 61.0.1(64-bit), Chromium 66.0.3359.181 and VNC service **(root/Passw9rd!)**
- SSH service, use `authorized_keys` to login as root
- Robot Framework and robotframework-selenium2library
- chromedriver 2.40 and geckodriver v0.21.0 installed in path `/usr/local/bin`
- openjdk-8
- apache-maven-3.5.4 installed in path `/opt/maven`, soft-linked `mvn` to path `/usr/local/bin`

## How to build

Put pub-key of server A to file `authorized_keys` before building image, if you want to SSH to this container from server A

```
$ docker build -t test-automation .
```

## How to run

```
$ docker run -d --name automation-test -p 2200:22 -p 6080:80 -p 5900:5900 test-automation
```

Now you can access the container with 

- Command `docker exec`, `docker exec -it -u root automation-test bash`
- VNC viewer client, connect to port `5900`
- Browser, connect to port `6080`, http://127.0.0.1:6080/

Start `sshd` when the container is launched

```
# /usr/sbin/sshd
```

Now you can also access the container with 

- SSH, connect to port `2200`, `ssh -oStrictHostKeyChecking=no root@localhost -p 2200`

## Test Demo

There are 2 test demo in the container implemented with
- Robot Framework, in `/root/robot-demo-test`
- TestNG, in `/root/testng-demo-test`

### Robot

```
# robot -d /root/robot-demo-test/logs /root/robot-demo-test/test.robot
```

Everything's fine if you get the output as below

```
root@3b7926046478:~# robot -d /root/robot-demo-test/logs /root/robot-demo-test/test.robot
==============================================================================
Test :: Suite description
==============================================================================
Open browser and lanch baidu.com                                      | PASS |
------------------------------------------------------------------------------
Test :: Suite description                                             | PASS |
1 critical test, 1 passed, 0 failed
1 test total, 1 passed, 0 failed
==============================================================================
Output:  /root/robot-demo-test/logs/output.xml
Log:     /root/robot-demo-test/logs/log.html
Report:  /root/robot-demo-test/logs/report.html
root@3b7926046478:~#
```

### TestNG

```
# cd /root/testng-demo-test
# mvn install
```

Everything's fine if you get the output as below

```
root@3b7926046478:~/testng-demo-test# mvn install
[INFO] Scanning for projects...
[INFO]
[INFO] ----< hello-selenium-testng-example:hello-selenium-testng-example >-----
[INFO] Building hello-selenium-testng-example 1.0-SNAPSHOT
[INFO] --------------------------------[ jar ]---------------------------------
Downloading from central: https://repo.maven.apache.org/maven2/org/apache/maven/plugins/maven-resources-plugin/2.6/maven-resources-plugin-2.6.pom
Downloaded from central: https://repo.maven.apache.org/maven2/org/apache/maven/plugins/maven-resources-plugin/2.6/maven-resources-plugin-2.6.pom (8.1 kB at 5.5 kB/s)
Downloading from central: https://repo.maven.apache.org/maven2/org/apache/maven/plugins/maven-plugins/23/maven-plugins-23.pom

...

-------------------------------------------------------
 T E S T S
-------------------------------------------------------
Running HelloTest
Configuring TestNG with: org.apache.maven.surefire.testng.conf.TestNG652Configurator@cac736f
1534407557748	geckodriver	INFO	geckodriver 0.21.0
1534407557753	geckodriver	INFO	Listening on 127.0.0.1:21564
1534407558152	mozrunner::runner	INFO	Running command: "/usr/lib/firefox/firefox" "-marionette" "-foreground" "-no-remote" "-profile" "/tmp/rust_mozprofile.c5UpGl6rEqSV"

(firefox:507): Gtk-WARNING **: 08:19:18.177: Locale not supported by C library.
	Using the fallback 'C' locale.

(/usr/lib/firefox/firefox:579): Gtk-WARNING **: 08:19:19.276: Locale not supported by C library.
	Using the fallback 'C' locale.
1534407559989	Marionette	INFO	Listening on port 39753
1534407560076	Marionette	WARN	TLS certificate errors will be ignored for this session
Aug 16, 2018 8:19:20 AM org.openqa.selenium.remote.ProtocolHandshake createSession
INFO: Detected dialect: W3C

(/usr/lib/firefox/firefox:635): Gtk-WARNING **: 08:19:20.301: Locale not supported by C library.
	Using the fallback 'C' locale.
[Parent 507, Gecko_IOThread] WARNING: pipe error (54): Connection reset by peer: file /build/firefox-oscv9o/firefox-61.0.1+build1/ipc/chromium/src/chrome/common/ipc_channel_posix.cc, line 353
*** UTM:SVC TimerManager:registerTimer called after profile-before-change notification. Ignoring timer registration for id: telemetry_modules_ping
Tests run: 1, Failures: 0, Errors: 0, Skipped: 0, Time elapsed: 10.482 sec

Results :

Tests run: 1, Failures: 0, Errors: 0, Skipped: 0

...

[INFO] ------------------------------------------------------------------------
[INFO] BUILD SUCCESS
[INFO] ------------------------------------------------------------------------
[INFO] Total time: 02:16 min
[INFO] Finished at: 2018-08-16T08:19:36Z
[INFO] ------------------------------------------------------------------------
root@3b7926046478:~/testng-demo-test#
```



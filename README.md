# mBus #

mBus is a lightweight messaging system providing communication between daemons
and applications. enabling development of component based distributed applications.

1. <a href="#1-overview">overview</a>
2. <a href="#2-download">download</a>
3. <a href="#3-build">download</a>
4. <a href="#4-applications">applications</a>
    - <a href="#41-controller">controller</a>
        - <a href="#411-command-line-options">command line options</a>
    - <a href="#42-listener">listener</a>
        - <a href="#421-command-line-options">command line options</a>
    - <a href="#43-command">command</a>
        - <a href="#431-command-line-options">command line options</a>
    - <a href="#44-event">event</a>
        - <a href="#441-command-line-options">command line options</a>
5. <a href="#5-library">library</a>
    - <a href="#51-server">server</a>
    - <a href="#52-client">client</a>
6. <a href="#6-protocol">protocol</a>
7. <a href="#7-tls">tls</a>
    - <a href="#71-certificate-authority">certificate authority</a>
    - <a href="#72-server">server</a>
    - <a href="#73-client">client</a>
8. <a href="#8-contact">contact</a>
9. <a href="#9-license">license</a>

## 1. overview ##

mBus is a lightweight messaging system providing communication between daemons 
and applications. enabling development of component based distributed
applications.

every daemon registers with a unique namespace and a set of procedures with
various number of arguments under the namespace. procedure request and responce
are in JSON format. any daemon can post an event under registered namespace
with various number of arguments in JSON format. any daemon or application can
subscribe to events with namespaces and can call procedures from other
namespaces.

mBus consists of two parts; a server and client[s]. server interface for other
daemons/applications to register themselves, send events and call procedures from
other daemons/applications.

all messaging is in JSON format, and communication is based on TLV (type-length-value)
messages.

mBus framework has built in applications; controller, listener, command and event.
controller is a very simple implementation of server and is the hearth of mBus.
listener is to listen every messages generated by either server or clients, and
useful for debug purposes. event is for publishing an event, and command is for
calling a procedure from connected clients.

mBus client library (libmbus-client) is to simplify development of software using mbus
(connecting to it).

## 2. download ##

    git clone git@github.com:alperakcan/mbus.git

## 3. build ##

    cd mbus
    make

## 4. applications ##

### 4.1 controller ###

#### 4.1.1 command line options ####

  - --mbus-help
  
    print available parameters list and exit

  - --mbus-debug-level

    set debug level, available options: debug, info, error. default: error
  
  - --mbus-server-tcp-enable
  
    server tcp enable, default: 1
  
  - --mbus-server-tcp-address
  
    server tcp address, default: 127.0.0.1
  
  - --mbus-server-tcp-port
  
    server tcp port, default: 8000
  
  - --mbus-server-uds-enable
  
    server uds enable, default: 1
  
  - --mbus-server-uds-address
  
    server uds address, default: /tmp/mbus-server
  
  - --mbus-server-uds-port
  
    server uds port, default: -1
  
  - --mbus-server-websocket-enable
  
    server websocket enable, default: 1
    
  - --mbus-server-websocket-address
  
    server websocket address, default: 127.0.0.1
  
  - --mbus-server-websocket-port
  
    server websocket port, default: 9000
  
### 4.2 listener ###

#### 4.2.1 command line options ####

  - --mbus-help
  
    print available parameters list and exit

  - --mbus-debug-level

    set debug level, available options: debug, info, error. default: error
  
  - --mbus-server-protocol
  
    set communication protocol, available options: tcp, uds. default: uds

  - --mbus-server-address
  
    set server address:

    - tcp: default is 127.0.0.1
    - uds: default is /tmp/mbus-server
  
  - --mbus-server-port
  
    set server port:

    - tcp: default is 8000
    - uds: unused

  - --mbus-client-name
  
    set client name, default: org.mbus.app.listener

### 4.3 cli ###

#### 4.3.1 command line options ####

  - --mbus-help
  
    print available parameters list and exit

  - --mbus-debug-level

    set debug level, available options: debug, info, error. default: error
  
  - --mbus-server-protocol
  
    set communication protocol, available options: tcp, uds. default: uds

  - --mbus-server-address
  
    set server address:

    - tcp: default is 127.0.0.1
    - uds: default is /tmp/mbus-server
  
  - --mbus-server-port
  
    set server port:

    - tcp: default is 8000
    - uds: unused

  - --mbus-client-name
  
    set client name, default: org.mbus.app.cli

### 4.4 launcher ###

## 5. library ##

### 5.1 server ###

  - struct mbus_server * mbus_server_create (int argc, char *argv[]);
  - void mbus_server_destroy (struct mbus_server *server);

  - int mbus_server_run (struct mbus_server *server);
  - int mbus_server_run_timeout (struct mbus_server *server, int milliseconds);

### 5.2 client ###

  - struct mbus_client * mbus_client_create (const char *name, int argc, char *argv[]);
  - void mbus_client_destroy (struct mbus_client *client);

  - int mbus_client_subscribe (struct mbus_client *client, const char *source, const char *event, void (*function) (struct mbus_client *client, const char *source, const char *event, struct mbus_json *payload, void *data), void *data);
  - int mbus_client_register (struct mbus_client *client, const char *command, int (*function) (struct mbus_client *client, const char *source, const char *command, struct mbus_json *payload, struct mbus_json *result, void *data), void *data);
  - int mbus_client_event (struct mbus_client *client, const char *event, struct mbus_json *payload);
  - int mbus_client_event_to (struct mbus_client *client, const char *to, const char *identifier, struct mbus_json *event);
  - int mbus_client_command (struct mbus_client *client, const char *destination, const char *command, struct mbus_json *call, struct mbus_json **result);

  - int mbus_client_run (struct mbus_client *client);
  - int mbus_client_run_timeout (struct mbus_client *client, int milliseconds);

## 6. protocol ##

mbus controller supports tcp, uds, and websockets connections.

## 7. tls ##

mbus provides ssl support for encrypted network connections and authentication

### 7.1 certificate authority ###

generate a certificate authority certificate and key

    openssl req -new -x509 -days 365 -extensions v3_ca -keyout ca.key -out ca.crt

### 7.2 server ###

generate server key

    openssl genrsa -des3 -out server.key 2048

generate server key without encryption

    openssl genrsa -out server.key 2048

generate a certificate signing request to send to the ca

    openssl req -out server.csr -key server.key -new

send the csr to the ca, or sign it with you ca key

    openssl x509 -req -in server.csr -CA ca.crt -CAkey ca.key -CAcreateserial -out server.crt -days 365

### 7.3 client ###

generate client key

    openssl genrsa -des3 -out client.key 2048

generate a certificate signing request to send to the ca

    openssl req -out client.csr -key client.key -new

send the csr to the ca, or sign it with you ca key

    openssl x509 -req -in client.csr -CA ca.crt -CAkey ca.key -CAcreateserial -out client.crt -days <duration>

## 8. contact ##

if you are using the software and/or have any questions, suggestions, etc.
please contact with me at alper.akcan@gmail.com

## 9. license ##

### mBus Copyright (c) 2014, Alper Akcan <alper.akcan@gmail.com> ###

All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are met:

  - Redistributions of source code must retain the above copyright
    notice, this list of conditions and the following disclaimer.

  - Redistributions in binary form must reproduce the above copyright
    notice, this list of conditions and the following disclaimer in the
    documentation and/or other materials provided with the distribution.

  - Neither the name of the developer nor the
    names of its contributors may be used to endorse or promote products
    derived from this software without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
DISCLAIMED. IN NO EVENT SHALL <COPYRIGHT HOLDER> BE LIABLE FOR ANY
DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
(INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

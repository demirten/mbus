
subdir-y = \
	app \
	src \
	test

app_depends-y = \
	src \
	test

test_depends-y = \
	src

include Makefile.lib

install: app src test
	install -d ${DESTDIR}/usr/local/bin
	install -m 0755 dist/bin/mbus-command ${DESTDIR}/usr/local/bin/mbus-command
	install -m 0755 dist/bin/mbus-controller ${DESTDIR}/usr/local/bin/mbus-controller
	install -m 0755 dist/bin/mbus-event ${DESTDIR}/usr/local/bin/mbus-event
	install -m 0755 dist/bin/mbus-listener ${DESTDIR}/usr/local/bin/mbus-listener
	install -m 0755 dist/bin/mbus-version ${DESTDIR}/usr/local/bin/mbus-version
	
	install -d ${DESTDIR}/usr/local/include/mbus
	install -m 0644 dist/include/mbus/buffer.h ${DESTDIR}/usr/local/include/mbus/buffer.h
	install -m 0644 dist/include/mbus/client.h ${DESTDIR}/usr/local/include/mbus/client.h
	install -m 0644 dist/include/mbus/clock.h ${DESTDIR}/usr/local/include/mbus/clock.h
	install -m 0644 dist/include/mbus/compress.h ${DESTDIR}/usr/local/include/mbus/compress.h
	install -m 0644 dist/include/mbus/debug.h ${DESTDIR}/usr/local/include/mbus/debug.h
	install -m 0644 dist/include/mbus/json.h ${DESTDIR}/usr/local/include/mbus/json.h
	install -m 0644 dist/include/mbus/method.h ${DESTDIR}/usr/local/include/mbus/method.h
	install -m 0644 dist/include/mbus/server.h ${DESTDIR}/usr/local/include/mbus/server.h
	install -m 0644 dist/include/mbus/socket.h ${DESTDIR}/usr/local/include/mbus/socket.h
	install -m 0644 dist/include/mbus/tailq.h ${DESTDIR}/usr/local/include/mbus/tailq.h
	install -m 0644 dist/include/mbus/version.h ${DESTDIR}/usr/local/include/mbus/version.h
	
	install -d ${DESTDIR}/usr/local/lib
	if [ -f dist/lib/libmbus-buffer.so ]; then install -m 0755 dist/lib/libmbus-buffer.so ${DESTDIR}/usr/local/lib/libmbus-buffer.so; fi
	if [ -f dist/lib/libmbus-client.so ]; then install -m 0755 dist/lib/libmbus-client.so ${DESTDIR}/usr/local/lib/libmbus-client.so; fi
	if [ -f dist/lib/libmbus-clock.so ]; then install -m 0755 dist/lib/libmbus-clock.so ${DESTDIR}/usr/local/lib/libmbus-clock.so; fi
	if [ -f dist/lib/libmbus-compress.so ]; then install -m 0755 dist/lib/libmbus-compress.so ${DESTDIR}/usr/local/lib/libmbus-compress.so; fi
	if [ -f dist/lib/libmbus-debug.so ]; then install -m 0755 dist/lib/libmbus-debug.so ${DESTDIR}/usr/local/lib/libmbus-debug.so; fi
	if [ -f dist/lib/libmbus-json.so ]; then install -m 0755 dist/lib/libmbus-json.so ${DESTDIR}/usr/local/lib/libmbus-json.so; fi
	if [ -f dist/lib/libmbus-json-cJSON.so ]; then install -m 0755 dist/lib/libmbus-json-cJSON.so ${DESTDIR}/usr/local/lib/libmbus-json-cJSON.so; fi
	if [ -f dist/lib/libmbus-server.so ]; then install -m 0755 dist/lib/libmbus-server.so ${DESTDIR}/usr/local/lib/libmbus-server.so; fi
	if [ -f dist/lib/libmbus-socket.so ]; then install -m 0755 dist/lib/libmbus-socket.so ${DESTDIR}/usr/local/lib/libmbus-socket.so; fi
	if [ -f dist/lib/libmbus-version.so ]; then install -m 0755 dist/lib/libmbus-version.so ${DESTDIR}/usr/local/lib/libmbus-version.so; fi

	install -d ${DESTDIR}/usr/local/lib
	install -m 0644 dist/lib/libmbus-buffer.a ${DESTDIR}/usr/local/lib/libmbus-buffer.a
	install -m 0644 dist/lib/libmbus-client.a ${DESTDIR}/usr/local/lib/libmbus-client.a
	install -m 0644 dist/lib/libmbus-clock.a ${DESTDIR}/usr/local/lib/libmbus-clock.a
	install -m 0644 dist/lib/libmbus-compress.a ${DESTDIR}/usr/local/lib/libmbus-compress.a
	install -m 0644 dist/lib/libmbus-debug.a ${DESTDIR}/usr/local/lib/libmbus-debug.a
	install -m 0644 dist/lib/libmbus-json.a ${DESTDIR}/usr/local/lib/libmbus-json.a
	install -m 0644 dist/lib/libmbus-json-cJSON.a ${DESTDIR}/usr/local/lib/libmbus-json-cJSON.a
	install -m 0644 dist/lib/libmbus-server.a ${DESTDIR}/usr/local/lib/libmbus-server.a
	install -m 0644 dist/lib/libmbus-socket.a ${DESTDIR}/usr/local/lib/libmbus-socket.a
	install -m 0644 dist/lib/libmbus-version.a ${DESTDIR}/usr/local/lib/libmbus-version.a

	install -d ${DESTDIR}/usr/local/lib/pkgconfig
	sed 's?'prefix=/usr/local'?'prefix=${DESTDIR}/usr/local'?g' libmbus-client.pc > ${DESTDIR}/usr/local/lib/pkgconfig/libmbus-client.pc
	sed 's?'prefix=/usr/local'?'prefix=${DESTDIR}/usr/local'?g' libmbus-controller.pc > ${DESTDIR}/usr/local/lib/pkgconfig/libmbus-controller.pc
	sed 's?'prefix=/usr/local'?'prefix=${DESTDIR}/usr/local'?g' libmbus-json.pc > ${DESTDIR}/usr/local/lib/pkgconfig/libmbus-json.pc

uninstall:
	rm -f ${DESTDIR}/usr/local/bin/mbus-command
	rm -f ${DESTDIR}/usr/local/bin/mbus-controller
	rm -f ${DESTDIR}/usr/local/bin/mbus-event
	rm -f ${DESTDIR}/usr/local/bin/mbus-listener
	rm -f ${DESTDIR}/usr/local/bin/mbus-version
	
	rm -f ${DESTDIR}/usr/local/include/mbus/buffer.h
	rm -f ${DESTDIR}/usr/local/include/mbus/client.h
	rm -f ${DESTDIR}/usr/local/include/mbus/clock.h
	rm -f ${DESTDIR}/usr/local/include/mbus/compress.h
	rm -f ${DESTDIR}/usr/local/include/mbus/debug.h
	rm -f ${DESTDIR}/usr/local/include/mbus/json.h
	rm -f ${DESTDIR}/usr/local/include/mbus/method.h
	rm -f ${DESTDIR}/usr/local/include/mbus/server.h
	rm -f ${DESTDIR}/usr/local/include/mbus/socket.h
	rm -f ${DESTDIR}/usr/local/include/mbus/tailq.h
	rm -f ${DESTDIR}/usr/local/include/mbus/version.h
	rm -rf ${DESTDIR}/usr/local/include/mbus
	
	rm -f ${DESTDIR}/usr/local/lib/libmbus-buffer.so
	rm -f ${DESTDIR}/usr/local/lib/libmbus-client.so
	rm -f ${DESTDIR}/usr/local/lib/libmbus-clock.so
	rm -f ${DESTDIR}/usr/local/lib/libmbus-compress.so
	rm -f ${DESTDIR}/usr/local/lib/libmbus-debug.so
	rm -f ${DESTDIR}/usr/local/lib/libmbus-json.so
	rm -f ${DESTDIR}/usr/local/lib/libmbus-json-cJSON.so
	rm -f ${DESTDIR}/usr/local/lib/libmbus-server.so
	rm -f ${DESTDIR}/usr/local/lib/libmbus-socket.so
	rm -f ${DESTDIR}/usr/local/lib/libmbus-version.so
	
	rm -f ${DESTDIR}/usr/local/lib/libmbus-buffer.a
	rm -f ${DESTDIR}/usr/local/lib/libmbus-client.a
	rm -f ${DESTDIR}/usr/local/lib/libmbus-clock.a
	rm -f ${DESTDIR}/usr/local/lib/libmbus-compress.a
	rm -f ${DESTDIR}/usr/local/lib/libmbus-debug.a
	rm -f ${DESTDIR}/usr/local/lib/libmbus-json.a
	rm -f ${DESTDIR}/usr/local/lib/libmbus-json-cJSON.a
	rm -f ${DESTDIR}/usr/local/lib/libmbus-server.a
	rm -f ${DESTDIR}/usr/local/lib/libmbus-socket.a
	rm -f ${DESTDIR}/usr/local/lib/libmbus-version.a

	rm -f ${DESTDIR}/usr/local/lib/pkgconfig/libmbus-client.pc
	rm -f ${DESTDIR}/usr/local/lib/pkgconfig/libmbus-json.pc

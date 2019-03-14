Content-Type: multipart/mixed; boundary="===============8105495858429539137=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net-next] selftest: mptcp: explicitly check for any
 kind of tcp-like socket pairs
Date: Thu, 14 Mar 2019 14:54:38 +0100
Message-ID: <87d9e6c77010eb2e181cda3c0a50bd6511913064.1552571659.git.pabeni@redhat.com>
X-Status: 
X-Keywords:                  
X-UID: 1029

--===============8105495858429539137==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This expands a bit the existing tests checking for any {[mp]tcp,subflow}
<->{[mp]tcp,subflow} pairs.

Moving most of the logic to the shell script we can simplify a bit the
test program.

This change also cleans a bit the tests script output.

Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
---
 .../selftests/net/mptcp/mptcp_connect.c       | 103 ++++++++++--------
 .../selftests/net/mptcp/mptcp_connect.sh      |  38 +++++--
 2 files changed, 90 insertions(+), 51 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.c b/tools/test=
ing/selftests/net/mptcp/mptcp_connect.c
index eeaba101512b..ca5c1e6305f1 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.c
@@ -9,6 +9,7 @@
 #include <stdint.h>
 #include <stdio.h>
 #include <stdlib.h>
+#include <strings.h>
 #include <unistd.h>
 =

 #include <sys/poll.h>
@@ -21,7 +22,7 @@
 =

 extern int optind;
 =

-#ifndef IPPROTO_MTPCP
+#ifndef IPPROTO_MPTCP
 #define IPPROTO_MPTCP 99
 #endif
 =

@@ -29,10 +30,16 @@ extern int optind;
 #define IPPROTO_SUBFLOW (IPPROTO_TCP | 0x100)
 #endif
 =

-static void die_usage(int x)
+static const char *cfg_host;
+static const char *cfg_port	=3D "12000";
+static int cfg_server_proto	=3D IPPROTO_MPTCP;
+static int cfg_client_proto	=3D IPPROTO_MPTCP;
+
+static void die_usage(void)
 {
-	fputs("Usage: mptcp_connect host port\n", x ? stderr : stdout);
-	exit(x);
+	fprintf(stderr, "Usage: mptcp_connect [-c MPTCP|TCP|SUBFLOW] [-p port] "
+	        "[-s MPTCP|TCP|SUBFLOW]\n");
+	exit(-1);
 }
 =

 static const char *getxinfo_strerr(int err)
@@ -100,7 +107,7 @@ static int sock_listen_mptcp(const char * const listena=
ddr, const char * const p
 	xgetaddrinfo(listenaddr, port, &hints, &addr);
 =

 	for (a =3D addr; a !=3D NULL ; a =3D a->ai_next) {
-		sock =3D socket(a->ai_family, a->ai_socktype, IPPROTO_MPTCP);
+		sock =3D socket(a->ai_family, a->ai_socktype, cfg_server_proto);
 		if (sock < 0) {
 			perror("socket");
 			continue;
@@ -230,17 +237,6 @@ int main_loop_s(int listensock)
         int remotesock;
 	char buf[2];
 =

-	salen =3D sizeof(ss);
-	while ((remotesock =3D accept(listensock, (struct sockaddr *)&ss, &salen)=
) < 0)
-		perror("accept");
-
-	logendpoint(&ss, salen);
-
-	/* deal with 'bogus' client first (plain tcp, not mptcp) */
-	if (read(remotesock, buf, sizeof(buf)) !=3D 0)
-		return -1;
-
-	close(remotesock);
 	salen =3D sizeof(ss);
 	while ((remotesock =3D accept(listensock, (struct sockaddr *)&ss, &salen)=
) < 0)
 		perror("accept");
@@ -264,7 +260,7 @@ static void init_rng(void)
 	srand(foo);
 }
 =

-int main_loop(const char *host, const char *port)
+int main_loop()
 {
 	int pollfds =3D 2, timeout =3D -1;
 	char start[32];
@@ -283,7 +279,7 @@ int main_loop(const char *host, const char *port)
 =

 		init_rng();
 =

-		fd =3D sock_listen_mptcp(NULL, port);
+		fd =3D sock_listen_mptcp(NULL, cfg_port);
 		if (fd < 0)
 			return -1;
 =

@@ -308,17 +304,8 @@ int main_loop(const char *host, const char *port)
 	if (ret !=3D 4 || strcmp(start, "RDY\n"))
 		return -1;
 =

-	/* listener is ready.
-	 *
-	 * First connect with _SUBFLOW, used to trigger NULL deref in kernel.
-	 */
-	fd =3D sock_connect_mptcp(host, port, IPPROTO_SUBFLOW);
-	if (fd < 0)
-		return -1;
-
-	close(fd);
-
-	fd =3D sock_connect_mptcp(host, port, IPPROTO_MPTCP);
+	/* listener is ready. */
+	fd =3D sock_connect_mptcp(cfg_host, cfg_port, cfg_client_proto);
 	if (fd < 0)
 		return -1;
 =

@@ -362,7 +349,8 @@ int main_loop(const char *host, const char *port)
 			}
 =

 			write(1, buf, len);
-		} else if (fds[1].revents & POLLIN) {
+		}
+		if (fds[1].revents & POLLIN) {
 			len =3D read(0, buf, sizeof(buf));
 			if (len =3D=3D 0) {
 				pollfds =3D 1;
@@ -382,22 +370,51 @@ int main_loop(const char *host, const char *port)
 	return 1;
 }
 =

-int main(int argc, char *argv[])
+int parse_proto(const char *proto)
 {
-	const char *host, *port;
+	if (!strcasecmp(proto, "MPTCP"))
+		return IPPROTO_MPTCP;
+	if (!strcasecmp(proto, "TCP"))
+		return IPPROTO_TCP;
+	if (!strcasecmp(proto, "SUBFLOW"))
+		return IPPROTO_SUBFLOW;
+	die_usage();
+
+	/* silence compiler warning */
+	return 0;
+}
 =

-	if (optind >=3D argc)
-		die_usage(1);
+static void parse_opts(int argc, char **argv)
+{
+	int c;
+
+	while ((c =3D getopt(argc, argv, "c:p:s:h")) !=3D -1) {
+		switch (c) {
+		case 'c':
+			cfg_client_proto =3D parse_proto(optarg);
+			break;
+		case 'p':
+			cfg_port =3D optarg;
+			break;
+		case 's':
+			cfg_server_proto =3D parse_proto(optarg);
+			break;
+		case 'h':
+			die_usage();
+			break;
+		}
+	}
+
+	if (optind + 1 !=3D argc)
+		die_usage();
+	cfg_host =3D argv[optind];
+}
 =

-	init_rng();
 =

-	host =3D argv[optind];
-	argv++;
-	argc--;
-	if (optind < argc)
-		port =3D argv[optind];
-	else
-		port =3D "12000";
+int main(int argc, char *argv[])
+{
+	init_rng();
 =

-	return main_loop(host, port);
+	parse_opts(argc, argv);
+	return main_loop();
 }
diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/tes=
ting/selftests/net/mptcp/mptcp_connect.sh
index 2714c8a3f837..91db1ed5ff50 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
@@ -8,6 +8,28 @@ cleanup()
 	rm -f "$tmpin" "$tmpout"
 }
 =

+check_transfer()
+{
+	cl_proto=3D${1}
+	srv_proto=3D${2}
+
+	printf "%-8s -> %-8s socket\t\t" ${cl_proto} ${srv_proto}
+
+	./mptcp_connect -c ${cl_proto} -p 43212 -s ${srv_proto} 127.0.0.1  < "$tm=
pin" > "$tmpout" 2>/dev/null
+	ret=3D$?
+	if [ ${ret} -ne 0 ]; then
+		echo "[ FAIL ]"
+		return " exit code $ret"
+	fi
+	cmp "$tmpin" "$tmpout" > /dev/null 2>&1
+	if [ $? -ne 0 ] ;then
+		echo "[ FAIL ]"
+		ls -l "$tmpin" "$tmpout" 1>&2
+	else
+		echo "[  OK  ]"
+	fi
+}
+
 trap cleanup EXIT
 =

 SIZE=3D$((RANDOM % (1024 * 1024)))
@@ -16,14 +38,14 @@ if [ $SIZE -eq 0 ] ; then
 fi
 =

 dd if=3D/dev/urandom of=3D"$tmpin" bs=3D1 count=3D$SIZE 2> /dev/null
-./mptcp_connect 127.0.0.1 43212 < "$tmpin" > "$tmpout"
 =

-cmp "$tmpin" "$tmpout"
-if [ $? -ne 0 ] ;then
-	echo "FAIL: Input and output differ" 1>&2
-	ls -l "$tmpin" "$tmpout" 1>&2
-	exit 1
-fi
+check_transfer MPTCP MPTCP
+check_transfer MPTCP TCP
+check_transfer TCP MPTCP
+check_transfer SUBFLOW MPTCP
+check_transfer SUBFLOW TCP
+check_transfer SUBFLOW SUBFLOW
+check_transfer MPTCP SUBFLOW
+check_transfer TCP SUBFLOW
 =

-echo "PASS: Input of $SIZE passed though mptcp connection unchanged"
 exit 0
-- =

2.20.1


--===============8105495858429539137==--

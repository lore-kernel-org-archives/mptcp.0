Content-Type: multipart/mixed; boundary="===============7672654923206755057=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH 12/16] mptcp: fix checkpatch issues
Date: Sat, 15 Jun 2019 12:52:55 +0200
Message-ID: <20190615105259.15151-13-matthieu.baerts@tessares.net>
In-Reply-To: 20190615105259.15151-1-matthieu.baerts@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 1397

--===============7672654923206755057==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

What has been fixed:

 - code indent should use tabs where possible
 - Missing a blank line after declarations
 - line over 80 characters (7)
 - spaces required around that : (ctx:VxW) (2)
 - space required after that , (ctx:VxVi) (4)
 - space required before that & (ctx:OxV)
 - sizeof one should be sizeof(one)
 - space prohibited before that , (ctx:WxV)
 - spaces required around that =3D (ctx:VxV)
 - space prohibited before that close parenthesis )
 - space required before the open parenthesis (
 - please, no spaces at the start of a line
 - Bad function definition - int main_loop() should probably be int
   main_loop(void)
 - Missing or malformed SPDX-License-Identifier tag in line 2

What has not been fixed:

 - added, moved or deleted file(s), does MAINTAINERS need updating?
   > TBD later
 - quoted string split across lines
   > otherwise the line is too long

Note: when we discussed checkpatch and files in scripts, we agreed it
was fine to leave warnings here. But the license was missing in the bash
script so I started... and fix the others :)

Fixes: cdca8a5f12c2 (mptcp: add basic kselftest program)
Signed-off-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
---
 .../selftests/net/mptcp/mptcp_connect.c       | 48 ++++++++++---------
 .../selftests/net/mptcp/mptcp_connect.sh      |  1 +
 2 files changed, 27 insertions(+), 22 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.c b/tools/test=
ing/selftests/net/mptcp/mptcp_connect.c
index 79f6e95ed541..78c43624e84f 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.c
@@ -34,7 +34,7 @@ static int cfg_client_proto	=3D IPPROTO_MPTCP;
 static void die_usage(void)
 {
 	fprintf(stderr, "Usage: mptcp_connect [-c MPTCP|TCP] [-p port] "
-	        "[-s MPTCP|TCP]\n");
+		"[-s MPTCP|TCP]\n");
 	exit(-1);
 }
 =

@@ -47,19 +47,22 @@ static const char *getxinfo_strerr(int err)
 }
 =

 static void xgetaddrinfo(const char *node, const char *service,
-			const struct addrinfo *hints,
-			struct addrinfo **res)
+			 const struct addrinfo *hints,
+			 struct addrinfo **res)
 {
 	int err =3D getaddrinfo(node, service, hints, res);
+
 	if (err) {
 		const char *errstr =3D getxinfo_strerr(err);
 =

-		fprintf(stderr, "Fatal: getaddrinfo(%s:%s): %s\n", node ? node: "", serv=
ice ? service: "", errstr);
-	        exit(1);
+		fprintf(stderr, "Fatal: getaddrinfo(%s:%s): %s\n",
+			node ? node : "", service ? service : "", errstr);
+		exit(1);
 	}
 }
 =

-static int sock_listen_mptcp(const char * const listenaddr, const char * c=
onst port)
+static int sock_listen_mptcp(const char * const listenaddr,
+			     const char * const port)
 {
 	int sock;
 	struct addrinfo hints =3D {
@@ -75,17 +78,17 @@ static int sock_listen_mptcp(const char * const listena=
ddr, const char * const p
 =

 	xgetaddrinfo(listenaddr, port, &hints, &addr);
 =

-	for (a =3D addr; a !=3D NULL ; a =3D a->ai_next) {
+	for (a =3D addr; a; a =3D a->ai_next) {
 		sock =3D socket(a->ai_family, a->ai_socktype, cfg_server_proto);
 		if (sock < 0) {
 			perror("socket");
 			continue;
 		}
 =

-		if (-1 =3D=3D setsockopt(sock, SOL_SOCKET,SO_REUSEADDR,&one,sizeof one))
+		if (-1 =3D=3D setsockopt(sock, SOL_SOCKET, SO_REUSEADDR, &one,
+				     sizeof(one)))
 			perror("setsockopt");
 =

-
 		if (bind(sock, a->ai_addr, a->ai_addrlen) =3D=3D 0)
 			break; /* success */
 =

@@ -94,14 +97,15 @@ static int sock_listen_mptcp(const char * const listena=
ddr, const char * const p
 		sock =3D -1;
 	}
 =

-	if ((sock >=3D 0) && listen(sock ,20))
+	if (sock >=3D 0 && listen(sock, 20))
 		perror("listen");
 =

 	freeaddrinfo(addr);
 	return sock;
 }
 =

-static int sock_connect_mptcp(const char * const remoteaddr, const char * =
const port, int proto)
+static int sock_connect_mptcp(const char * const remoteaddr,
+			      const char * const port, int proto)
 {
 	struct addrinfo hints =3D {
 		.ai_protocol =3D IPPROTO_TCP,
@@ -113,7 +117,7 @@ static int sock_connect_mptcp(const char * const remote=
addr, const char * const
 	hints.ai_family =3D AF_INET;
 =

 	xgetaddrinfo(remoteaddr, port, &hints, &addr);
-	for (a=3Daddr; a !=3D NULL; a =3D a->ai_next) {
+	for (a =3D addr; a; a =3D a->ai_next) {
 		sock =3D socket(a->ai_family, a->ai_socktype, proto);
 		if (sock < 0) {
 			perror("socket");
@@ -145,13 +149,13 @@ static size_t do_write(const int fd, char *buf, const=
 size_t len)
 		if (do_w =3D=3D 0 || do_w > (len - offset))
 			do_w =3D len - offset;
 =

-		bw =3D write(fd, buf+offset, do_w);
-		if (bw < 0 ) {
+		bw =3D write(fd, buf + offset, do_w);
+		if (bw < 0) {
 			perror("write");
 			return 0;
 		}
 =

-		written =3D (size_t) bw;
+		written =3D (size_t)bw;
 		offset +=3D written;
 	}
 	return offset;
@@ -167,7 +171,7 @@ static void copyfd_io(int peerfd)
 		char buf[4096];
 		ssize_t len;
 =

-		switch(poll(&fds, 1, -1)) {
+		switch (poll(&fds, 1, -1)) {
 		case -1:
 			if (errno =3D=3D EINTR)
 				continue;
@@ -195,7 +199,6 @@ static void copyfd_io(int peerfd)
 =

 		if (!do_write(peerfd, buf, len))
 			return;
-
 	}
 }
 =

@@ -203,10 +206,11 @@ int main_loop_s(int listensock)
 {
 	struct sockaddr_storage ss;
 	socklen_t salen;
-        int remotesock;
+	int remotesock;
 =

 	salen =3D sizeof(ss);
-	while ((remotesock =3D accept(listensock, (struct sockaddr *)&ss, &salen)=
) < 0)
+	while ((remotesock =3D accept(listensock, (struct sockaddr *)&ss,
+				    &salen)) < 0)
 		perror("accept");
 =

 	copyfd_io(remotesock);
@@ -228,7 +232,7 @@ static void init_rng(void)
 	srand(foo);
 }
 =

-int main_loop()
+int main_loop(void)
 {
 	int pollfds =3D 2, timeout =3D -1;
 	char start[32];
@@ -312,7 +316,8 @@ int main_loop()
 			}
 =

 			if (len > blen) {
-				fprintf(stderr, "read returned more data than buffer length\n");
+				fprintf(stderr, "read returned more data than "
+						"buffer length\n");
 				len =3D blen;
 			}
 =

@@ -376,7 +381,6 @@ static void parse_opts(int argc, char **argv)
 	cfg_host =3D argv[optind];
 }
 =

-
 int main(int argc, char *argv[])
 {
 	init_rng();
diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/tes=
ting/selftests/net/mptcp/mptcp_connect.sh
index f8445192e40e..efcdda84b62a 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
@@ -1,4 +1,5 @@
 #!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
 =

 tmpin=3D$(mktemp)
 tmpout=3D$(mktemp)
-- =

2.20.1


--===============7672654923206755057==--

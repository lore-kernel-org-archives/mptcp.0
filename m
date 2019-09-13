Content-Type: multipart/mixed; boundary="===============0787398802110961935=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH selftests 2/5] selftests: mptcp: extend mptcp_connect
 tool for ipv6 family
Date: Fri, 13 Sep 2019 11:45:25 +0200
Message-ID: <20190913094528.3163-3-fw@strlen.de>
In-Reply-To: 20190913094528.3163-1-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 1839

--===============0787398802110961935==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

At this time socket() will fail when requesting an ipv6 mptcp socket.
This is ok for now, as the test script won't request ipv6 tests yet.

Tested with a tcp <-> tcp connection.

Signed-off-by: Florian Westphal <fw(a)strlen.de>
---
 .../testing/selftests/net/mptcp/mptcp_connect.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.c b/tools/test=
ing/selftests/net/mptcp/mptcp_connect.c
index cac71f0ac8f8..32a1630b7fa3 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.c
@@ -32,11 +32,11 @@ static int  poll_timeout;
 static const char *cfg_host;
 static const char *cfg_port	=3D "12000";
 static int cfg_sock_proto	=3D IPPROTO_MPTCP;
-
+static int pf =3D AF_INET;
 =

 static void die_usage(void)
 {
-	fprintf(stderr, "Usage: mptcp_connect [-s MPTCP|TCP] [-p port] "
+	fprintf(stderr, "Usage: mptcp_connect [ -6 ] [-s MPTCP|TCP] [-p port] "
 		"[ -l ] [ -t timeout ] connect_address\n");
 	exit(1);
 }
@@ -74,12 +74,13 @@ static int sock_listen_mptcp(const char * const listena=
ddr,
 		.ai_flags =3D AI_PASSIVE | AI_NUMERICHOST
 	};
 =

-	hints.ai_family =3D AF_INET;
+	hints.ai_family =3D pf;
 =

 	struct addrinfo *a, *addr;
 	int one =3D 1;
 =

 	xgetaddrinfo(listenaddr, port, &hints, &addr);
+	hints.ai_family =3D pf;
 =

 	for (a =3D addr; a; a =3D a->ai_next) {
 		sock =3D socket(a->ai_family, a->ai_socktype, cfg_sock_proto);
@@ -124,7 +125,7 @@ static int sock_connect_mptcp(const char * const remote=
addr,
 	struct addrinfo *a, *addr;
 	int sock =3D -1;
 =

-	hints.ai_family =3D AF_INET;
+	hints.ai_family =3D pf;
 =

 	xgetaddrinfo(remoteaddr, port, &hints, &addr);
 	for (a =3D addr; a; a =3D a->ai_next) {
@@ -362,7 +363,7 @@ static void parse_opts(int argc, char **argv)
 {
 	int c;
 =

-	while ((c =3D getopt(argc, argv, "lp:s:ht:")) !=3D -1) {
+	while ((c =3D getopt(argc, argv, "6lp:s:ht:")) !=3D -1) {
 		switch (c) {
 		case 'l':
 			listen_mode =3D true;
@@ -376,6 +377,9 @@ static void parse_opts(int argc, char **argv)
 		case 'h':
 			die_usage();
 			break;
+		case '6':
+			pf =3D AF_INET6;
+			break;
 		case 't':
 			poll_timeout =3D atoi(optarg) * 1000;
 			if (poll_timeout <=3D 0)
@@ -387,6 +391,9 @@ static void parse_opts(int argc, char **argv)
 	if (optind + 1 !=3D argc)
 		die_usage();
 	cfg_host =3D argv[optind];
+
+	if (strchr(cfg_host, ':'))
+		pf =3D AF_INET6;
 }
 =

 int main(int argc, char *argv[])
-- =

2.21.0


--===============0787398802110961935==--

Content-Type: multipart/mixed; boundary="===============4374539542001041211=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH v4 3/9] selftests: mptcp: extend mptcp_connect tool
 for ipv6 family
Date: Fri, 25 Oct 2019 14:16:45 +0200
Message-ID: <20191025121651.25946-4-fw@strlen.de>
In-Reply-To: 20191025121651.25946-1-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 2313

--===============4374539542001041211==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

At this time socket() will fail when requesting an ipv6 mptcp socket.
This is ok for now, as the test script won't request ipv6 tests yet.

Once someone starts to implement mptcp v6 support, just set ipv6=3Dtrue in
the script and the selftest will attempt to connect via ipv6.

Tested with a tcp <-> tcp connection.

Signed-off-by: Florian Westphal <fw(a)strlen.de>
---
 .../selftests/net/mptcp/mptcp_connect.c       | 21 +++--
 .../selftests/net/mptcp/mptcp_connect.sh      | 77 ++++++++++++++++---
 2 files changed, 79 insertions(+), 19 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.c b/tools/test=
ing/selftests/net/mptcp/mptcp_connect.c
index c9738a8dcc7f..feca1b729c03 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.c
@@ -37,11 +37,11 @@ static const char *cfg_host;
 static const char *cfg_port	=3D "12000";
 static int cfg_sock_proto	=3D IPPROTO_MPTCP;
 static bool tcpulp_audit;
-
+static int pf =3D AF_INET;
 =

 static void die_usage(void)
 {
-	fprintf(stderr, "Usage: mptcp_connect [-u] [-s MPTCP|TCP] [-p port] "
+	fprintf(stderr, "Usage: mptcp_connect [-6] [-u] [-s MPTCP|TCP] [-p port] "
 		"[ -l ] [ -t timeout ] connect_address\n");
 	exit(1);
 }
@@ -94,12 +94,13 @@ static int sock_listen_mptcp(const char * const listena=
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
@@ -182,7 +183,7 @@ static int sock_connect_mptcp(const char * const remote=
addr,
 	struct addrinfo *a, *addr;
 	int sock =3D -1;
 =

-	hints.ai_family =3D AF_INET;
+	hints.ai_family =3D pf;
 =

 	xgetaddrinfo(remoteaddr, port, &hints, &addr);
 	for (a =3D addr; a; a =3D a->ai_next) {
@@ -345,11 +346,9 @@ static int copyfd_io(int infd, int peerfd, int outfd)
 static void check_sockaddr(int pf, struct sockaddr_storage *ss,
 			   socklen_t salen)
 {
-	char addr[INET6_ADDRSTRLEN];
-	char serv[INET6_ADDRSTRLEN];
 	struct sockaddr_in6 *sin6;
 	struct sockaddr_in *sin;
-	int wanted_size =3D 0;
+	socklen_t wanted_size =3D 0;
 =

 	switch (pf) {
 	case AF_INET:
@@ -512,7 +511,7 @@ static void parse_opts(int argc, char **argv)
 {
 	int c;
 =

-	while ((c =3D getopt(argc, argv, "lp:s:hut:")) !=3D -1) {
+	while ((c =3D getopt(argc, argv, "6lp:s:hut:")) !=3D -1) {
 		switch (c) {
 		case 'l':
 			listen_mode =3D true;
@@ -529,6 +528,9 @@ static void parse_opts(int argc, char **argv)
 		case 'u':
 			tcpulp_audit =3D true;
 			break;
+		case '6':
+			pf =3D AF_INET6;
+			break;
 		case 't':
 			poll_timeout =3D atoi(optarg) * 1000;
 			if (poll_timeout <=3D 0)
@@ -540,6 +542,9 @@ static void parse_opts(int argc, char **argv)
 	if (optind + 1 !=3D argc)
 		die_usage();
 	cfg_host =3D argv[optind];
+
+	if (strchr(cfg_host, ':'))
+		pf =3D AF_INET6;
 }
 =

 int main(int argc, char *argv[])
diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/tes=
ting/selftests/net/mptcp/mptcp_connect.sh
index d31fe01824ec..26f8a2dadbe2 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
@@ -9,6 +9,7 @@ cout=3D""
 ksft_skip=3D4
 capture=3D0
 timeout=3D30
+ipv6=3Dfalse
 =

 TEST_COUNT=3D0
 =

@@ -57,29 +58,48 @@ ip link add ns2eth3 netns ns2 type veth peer name ns3et=
h2 netns ns3
 ip link add ns3eth4 netns ns3 type veth peer name ns4eth3 netns ns4
 =

 ip -net ns1 addr add 10.0.1.1/24 dev ns1eth2
+if $ipv6 ; then
+	ip -net ns1 addr add dead:beef:1::1/64 dev ns1eth2
+	if [ $? -ne 0 ] ;then
+		echo "SKIP: Can't add ipv6 address, skip ipv6 tests" 1>&2
+		ipv6=3Dfalse
+	fi
+fi
+
 ip -net ns1 link set ns1eth2 up
 ip -net ns1 route add default via 10.0.1.2
+$ipv6 && ip -net ns1 route add default via dead:beef:1::2
 =

 ip -net ns2 addr add 10.0.1.2/24 dev ns2eth1
+$ipv6 && ip -net ns2 addr add dead:beef:1::2/64 dev ns2eth1
 ip -net ns2 link set ns2eth1 up
 =

 ip -net ns2 addr add 10.0.2.1/24 dev ns2eth3
+$ipv6 && ip -net ns2 addr add dead:beef:2::1/64 dev ns2eth3
 ip -net ns2 link set ns2eth3 up
 ip -net ns2 route add default via 10.0.2.2
+$ipv6 && ip -net ns2 route add default via dead:beef:2::2
 ip netns exec ns2 sysctl -q net.ipv4.ip_forward=3D1
+$ipv6 && ip netns exec ns2 sysctl -q net.ipv6.conf.all.forwarding=3D1
 =

 ip -net ns3 addr add 10.0.2.2/24 dev ns3eth2
+$ipv6 && ip -net ns3 addr add dead:beef:2::2/64 dev ns3eth2
 ip -net ns3 link set ns3eth2 up
 =

 ip -net ns3 addr add 10.0.3.2/24 dev ns3eth4
+$ipv6 && ip -net ns3 addr add dead:beef:3::2/64 dev ns3eth4
 ip -net ns3 link set ns3eth4 up
 ip -net ns3 route add default via 10.0.2.1
+$ipv6 && ip -net ns3 route add default via dead:beef:2::1
 ip netns exec ns3 ethtool -K ns3eth2 tso off 2>/dev/null
 ip netns exec ns3 sysctl -q net.ipv4.ip_forward=3D1
+$ipv6 && ip netns exec ns3 sysctl -q net.ipv6.conf.all.forwarding=3D1
 =

 ip -net ns4 addr add 10.0.3.1/24 dev ns4eth3
+$ipv6 && ip -net ns4 addr add dead:beef:3::1/64 dev ns4eth3
 ip -net ns4 link set ns4eth3 up
 ip -net ns4 route add default via 10.0.3.2
+$ipv6 && ip -net ns4 route add default via dead:beef:3::2
 =

 print_file_err()
 {
@@ -161,7 +181,11 @@ do_ping()
 	if [ $? -ne 0 ] ; then
 		echo "$listener_ns -> $connect_addr connectivity [ FAIL ]" 1>&2
 		ret=3D1
+
+		return 1
 	fi
+
+	return 0
 }
 =

 do_transfer()
@@ -171,6 +195,7 @@ do_transfer()
 	cl_proto=3D"$3"
 	srv_proto=3D"$4"
 	connect_addr=3D"$5"
+	local_addr=3D"$6"
 =

 	port=3D$((10000+$TEST_COUNT))
 	TEST_COUNT=3D$((TEST_COUNT+1))
@@ -196,7 +221,7 @@ do_transfer()
 	    sleep 1
 	fi
 =

-	ip netns exec ${listener_ns} ./mptcp_connect -t $timeout -l -p $port -s $=
{srv_proto} 0.0.0.0 < "$sin" > "$sout" &
+	ip netns exec ${listener_ns} ./mptcp_connect -t $timeout -l -p $port -s $=
{srv_proto} $local_addr < "$sin" > "$sout" &
 	spid=3D$!
 =

 	sleep 1
@@ -264,23 +289,26 @@ run_tests()
 	listener_ns=3D"$1"
 	connector_ns=3D"$2"
 	connect_addr=3D"$3"
+	local_addr=3D"$4"
 	lret=3D0
 =

 	for proto in MPTCP TCP;do
-		do_transfer ${listener_ns} ${connector_ns} MPTCP "$proto" ${connect_addr}
+		do_transfer ${listener_ns} ${connector_ns} MPTCP "$proto" ${connect_addr=
} ${local_addr}
 		lret=3D$?
 		if [ $lret -ne 0 ]; then
 			ret=3D$lret
-			return
+			return 1
 		fi
 	done
 =

-	do_transfer ${listener_ns} ${connector_ns} TCP MPTCP ${connect_addr}
+	do_transfer ${listener_ns} ${connector_ns} TCP MPTCP ${connect_addr} ${lo=
cal_addr}
 	lret=3D$?
 	if [ $lret -ne 0 ]; then
 		ret=3D$lret
-		return
+		return 1
 	fi
+
+	return 0
 }
 =

 make_file "$cin" "client"
@@ -290,16 +318,31 @@ check_mptcp_disabled
 =

 check_mptcp_ulp_setsockopt
 =

+# Allow DAD to finish
+$ipv6 && sleep 2
+
 for sender in 1 2 3 4;do
 	do_ping ns1 ns$sender 10.0.1.1
+	if $ipv6;then
+		do_ping ns1 ns$sender dead:beef:1::1
+		if [ $? -ne 0 ]; then
+			echo "SKIP: IPv6 tests" 2>&1
+			ipv6=3Dfalse
+		fi
+	fi
 =

 	do_ping ns2 ns$sender 10.0.1.2
+	$ipv6 && do_ping ns2 ns$sender dead:beef:1::2
 	do_ping ns2 ns$sender 10.0.2.1
+	$ipv6 && do_ping ns2 ns$sender dead:beef:2::1
 =

 	do_ping ns3 ns$sender 10.0.2.2
+	$ipv6 && do_ping ns3 ns$sender dead:beef:2::2
 	do_ping ns3 ns$sender 10.0.3.2
+	$ipv6 && do_ping ns3 ns$sender dead:beef:3::2
 =

 	do_ping ns4 ns$sender 10.0.3.1
+	$ipv6 && do_ping ns4 ns$sender dead:beef:3::1
 done
 =

 loss=3D$((RANDOM%101))
@@ -328,15 +371,27 @@ elif [ $delay -gt 0 ]; then
 fi
 =

 for sender in 1 2 3 4;do
-	run_tests ns1 ns$sender 10.0.1.1
+	run_tests ns1 ns$sender 10.0.1.1 0.0.0.0
+	if $ipv6;then
+		run_tests ns1 ns$sender dead:beef:1::1 ::
+		if [ $? -ne 0 ] ;then
+			echo "SKIP: IPv6 tests" 2>&1
+			ipv6=3Dfalse
+		fi
+	fi
 =

-	run_tests ns2 ns$sender 10.0.1.2
-	run_tests ns2 ns$sender 10.0.2.1
+	run_tests ns2 ns$sender 10.0.1.2 0.0.0.0
+	$ipv6 && run_tests ns2 ns$sender dead:beef:1::2 ::
+	run_tests ns2 ns$sender 10.0.2.1 0.0.0.0
+	$ipv6 && run_tests ns2 ns$sender dead:beef:2::1 ::
 =

-	run_tests ns3 ns$sender 10.0.2.2
-	run_tests ns3 ns$sender 10.0.3.2
+	run_tests ns3 ns$sender 10.0.2.2 0.0.0.0
+	$ipv6 && run_tests ns3 ns$sender dead:beef:2::2 ::
+	run_tests ns3 ns$sender 10.0.3.2 0.0.0.0
+	$ipv6 && run_tests ns3 ns$sender dead:beef:3::2 ::
 =

-	run_tests ns4 ns$sender 10.0.3.1
+	run_tests ns4 ns$sender 10.0.3.1 0.0.0.0
+	$ipv6 && run_tests ns4 ns$sender dead:beef:3::1 ::
 done
 =

 exit $ret
-- =

2.23.0

--===============4374539542001041211==--

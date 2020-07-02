Content-Type: multipart/mixed; boundary="===============0519909322781594865=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH v3 4/4] selftests/mptcp: add diag interface tests
Date: Thu, 02 Jul 2020 13:32:33 +0200
Message-ID: <19677fb838e3f44f07269f64be89074374ae796e.1593689328.git.pabeni@redhat.com>
In-Reply-To: cover.1593689328.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 4900

--===============0519909322781594865==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

basic functional test, triggering the msk diag interface
code. Require appropriate iproute2 support, skip elsewhere.

Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
---
v2 -> v3:
 - update to new iproute2 output (ack -> remote_key)
 - make the tests less fragile to timinig issue
v1 -> v2:
 - include diag.sh in the makefile
---
 tools/testing/selftests/net/mptcp/Makefile    |   2 +-
 tools/testing/selftests/net/mptcp/diag.sh     | 122 ++++++++++++++++++
 .../selftests/net/mptcp/mptcp_connect.c       |  22 +++-
 3 files changed, 141 insertions(+), 5 deletions(-)
 create mode 100755 tools/testing/selftests/net/mptcp/diag.sh

diff --git a/tools/testing/selftests/net/mptcp/Makefile b/tools/testing/sel=
ftests/net/mptcp/Makefile
index f50976ee7d44..aa254aefc2c3 100644
--- a/tools/testing/selftests/net/mptcp/Makefile
+++ b/tools/testing/selftests/net/mptcp/Makefile
@@ -5,7 +5,7 @@ KSFT_KHDR_INSTALL :=3D 1
 =

 CFLAGS =3D  -Wall -Wl,--no-as-needed -O2 -g  -I$(top_srcdir)/usr/include
 =

-TEST_PROGS :=3D mptcp_connect.sh pm_netlink.sh mptcp_join.sh
+TEST_PROGS :=3D mptcp_connect.sh pm_netlink.sh mptcp_join.sh diag.sh
 =

 TEST_GEN_FILES =3D mptcp_connect pm_nl_ctl
 =

diff --git a/tools/testing/selftests/net/mptcp/diag.sh b/tools/testing/self=
tests/net/mptcp/diag.sh
new file mode 100755
index 000000000000..b3eee7ede18a
--- /dev/null
+++ b/tools/testing/selftests/net/mptcp/diag.sh
@@ -0,0 +1,122 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+rndh=3D$(printf %x $sec)-$(mktemp -u XXXXXX)
+ns=3D"ns1-$rndh"
+ksft_skip=3D4
+test_cnt=3D1
+ret=3D0
+pids=3D()
+
+flush_pids()
+{
+	# mptcp_connect in join mode will sleep a bit before completing,
+	# give it some time
+	sleep 1.1
+
+	for pid in ${pids[@]}; do
+		[ -d /proc/$pid ] && kill -SIGUSR1 $pid >/dev/null 2>&1
+	done
+	pids=3D()
+}
+
+cleanup()
+{
+	ip netns del $ns
+	for pid in ${pids[@]}; do
+		[ -d /proc/$pid ] && kill -9 $pid >/dev/null 2>&1
+	done
+}
+
+ip -Version > /dev/null 2>&1
+if [ $? -ne 0 ];then
+	echo "SKIP: Could not run test without ip tool"
+	exit $ksft_skip
+fi
+ss -h | grep -q MPTCP
+if [ $? -ne 0 ];then
+	echo "SKIP: ss tool does not support MPTCP"
+	exit $ksft_skip
+fi
+
+__chk_nr()
+{
+	local condition=3D"$1"
+	local expected=3D$2
+	local msg nr
+
+	shift 2
+	msg=3D$*
+	nr=3D$(ss -inmHMN $ns | $condition)
+
+	printf "%-50s" "$msg"
+	if [ $nr !=3D $expected ]; then
+		echo "[ fail ] expected $expected found $nr"
+		ret=3D$test_cnt
+	else
+		echo "[  ok  ]"
+	fi
+	test_cnt=3D$((test_cnt+1))
+}
+
+chk_msk_nr()
+{
+	__chk_nr "grep -c token:" $*
+}
+
+chk_msk_fallback_nr()
+{
+		__chk_nr "grep -c fallback" $*
+}
+
+chk_msk_remote_key_nr()
+{
+		__chk_nr "grep -c remote_key" $*
+}
+
+
+trap cleanup EXIT
+ip netns add $ns
+ip -n $ns link set dev lo up
+
+echo "a" | ip netns exec $ns ./mptcp_connect -p 10000 -l 0.0.0.0 -t 100 >/=
dev/null &
+sleep 0.1
+pids[0]=3D$!
+chk_msk_nr 0 "no msk on netns creation"
+
+echo "b" | ip netns exec $ns ./mptcp_connect -p 10000 127.0.0.1 -j -t 100 =
>/dev/null &
+sleep 0.1
+pids[1]=3D$!
+chk_msk_nr 2 "after MPC handshake "
+chk_msk_remote_key_nr 2 "....chk remote_key"
+chk_msk_fallback_nr 0 "....chk no fallback"
+flush_pids
+
+
+echo "a" | ip netns exec $ns ./mptcp_connect -p 10001 -s TCP -l 0.0.0.0 -t=
 100 >/dev/null &
+pids[0]=3D$!
+sleep 0.1
+echo "b" | ip netns exec $ns ./mptcp_connect -p 10001 127.0.0.1 -j -t 100 =
>/dev/null &
+pids[1]=3D$!
+sleep 0.1
+chk_msk_fallback_nr 1 "check fallback"
+flush_pids
+
+NR_CLIENTS=3D100
+for I in `seq 1 $NR_CLIENTS`; do
+	echo "a" | ip netns exec $ns ./mptcp_connect -p $((I+10001)) -l 0.0.0.0 -=
t 100 -w 10 >/dev/null  &
+	pids[$((I*2))]=3D$!
+done
+sleep 0.1
+
+for I in `seq 1 $NR_CLIENTS`; do
+	echo "b" | ip netns exec $ns ./mptcp_connect -p $((I+10001)) 127.0.0.1 -t=
 100 -w 10 >/dev/null &
+	pids[$((I*2 + 1))]=3D$!
+done
+sleep 1.5
+
+chk_msk_nr $((NR_CLIENTS*2)) "many msk socket present"
+flush_pids
+
+exit $ret
+
diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.c b/tools/test=
ing/selftests/net/mptcp/mptcp_connect.c
index cedee5b952ba..cad6f73a5fd0 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.c
@@ -11,6 +11,7 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <strings.h>
+#include <signal.h>
 #include <unistd.h>
 =

 #include <sys/poll.h>
@@ -36,6 +37,7 @@ extern int optind;
 =

 static int  poll_timeout =3D 10 * 1000;
 static bool listen_mode;
+static bool quit;
 =

 enum cfg_mode {
 	CFG_MODE_POLL,
@@ -52,11 +54,12 @@ static int pf =3D AF_INET;
 static int cfg_sndbuf;
 static int cfg_rcvbuf;
 static bool cfg_join;
+static int cfg_wait;
 =

 static void die_usage(void)
 {
 	fprintf(stderr, "Usage: mptcp_connect [-6] [-u] [-s MPTCP|TCP] [-p port] =
[-m mode]"
-		"[-l] connect_address\n");
+		"[-l] [-w sec] connect_address\n");
 	fprintf(stderr, "\t-6 use ipv6\n");
 	fprintf(stderr, "\t-t num -- set poll timeout to num\n");
 	fprintf(stderr, "\t-S num -- set SO_SNDBUF to num\n");
@@ -65,9 +68,15 @@ static void die_usage(void)
 	fprintf(stderr, "\t-m [MPTCP|TCP] -- use tcp or mptcp sockets\n");
 	fprintf(stderr, "\t-s [mmap|poll] -- use poll (default) or mmap\n");
 	fprintf(stderr, "\t-u -- check mptcp ulp\n");
+	fprintf(stderr, "\t-w num -- wait num sec before closing the socket\n");
 	exit(1);
 }
 =

+static void handle_signal(int nr)
+{
+	quit =3D true;
+}
+
 static const char *getxinfo_strerr(int err)
 {
 	if (err =3D=3D EAI_SYSTEM)
@@ -418,8 +427,8 @@ static int copyfd_io_poll(int infd, int peerfd, int out=
fd)
 	}
 =

 	/* leave some time for late join/announce */
-	if (cfg_join)
-		usleep(400000);
+	if (cfg_wait)
+		usleep(cfg_wait);
 =

 	close(peerfd);
 	return 0;
@@ -812,11 +821,12 @@ static void parse_opts(int argc, char **argv)
 {
 	int c;
 =

-	while ((c =3D getopt(argc, argv, "6jlp:s:hut:m:S:R:")) !=3D -1) {
+	while ((c =3D getopt(argc, argv, "6jlp:s:hut:m:S:R:w:")) !=3D -1) {
 		switch (c) {
 		case 'j':
 			cfg_join =3D true;
 			cfg_mode =3D CFG_MODE_POLL;
+			cfg_wait =3D 400000;
 			break;
 		case 'l':
 			listen_mode =3D true;
@@ -850,6 +860,9 @@ static void parse_opts(int argc, char **argv)
 		case 'R':
 			cfg_rcvbuf =3D parse_int(optarg);
 			break;
+		case 'w':
+			cfg_wait =3D atoi(optarg)*1000000;
+			break;
 		}
 	}
 =

@@ -865,6 +878,7 @@ int main(int argc, char *argv[])
 {
 	init_rng();
 =

+	signal(SIGUSR1, handle_signal);
 	parse_opts(argc, argv);
 =

 	if (tcpulp_audit)
-- =

2.26.2

--===============0519909322781594865==--

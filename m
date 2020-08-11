Content-Type: multipart/mixed; boundary="===============4861289752411309550=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][PATCH v6 mptcp-next 2/2] selftests: mptcp: add remove
 addr and subflow test case
Date: Tue, 11 Aug 2020 17:34:26 +0800
Message-ID: <3ff88d930a76757c8560409daf3419612028c69e.1597136641.git.geliangtang@gmail.com>
In-Reply-To: cover.1597136641.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 5538

--===============4861289752411309550==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch added remove addr and subflow test case.

1 We droped the flag "first" in do_rnd_write, since we need to slow down
all the transfer process to let the sending and receiving of the RM_ADDR
suboption complete.

2 We added a new argument "remove_addr" in run_tests and do_transfer, if
this flag is true, we called do_remove_addr to remove the addr and
subflow.

Suggested-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
Suggested-by: Paolo Abeni <pabeni(a)redhat.com>
Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
---
 .../selftests/net/mptcp/mptcp_connect.c       |  7 +--
 .../testing/selftests/net/mptcp/mptcp_join.sh | 62 ++++++++++++++-----
 2 files changed, 47 insertions(+), 22 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.c b/tools/test=
ing/selftests/net/mptcp/mptcp_connect.c
index 090620c3e10c..e48c00fc117d 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.c
@@ -260,7 +260,6 @@ static int sock_connect_mptcp(const char * const remote=
addr,
 =

 static size_t do_rnd_write(const int fd, char *buf, const size_t len)
 {
-	static bool first =3D true;
 	unsigned int do_w;
 	ssize_t bw;
 =

@@ -268,7 +267,7 @@ static size_t do_rnd_write(const int fd, char *buf, con=
st size_t len)
 	if (do_w =3D=3D 0 || do_w > len)
 		do_w =3D len;
 =

-	if (cfg_join && first && do_w > 100)
+	if (cfg_join && do_w > 100)
 		do_w =3D 100;
 =

 	bw =3D write(fd, buf, do_w);
@@ -276,10 +275,8 @@ static size_t do_rnd_write(const int fd, char *buf, co=
nst size_t len)
 		perror("write");
 =

 	/* let the join handshake complete, before going on */
-	if (cfg_join && first) {
+	if (cfg_join)
 		usleep(200000);
-		first =3D false;
-	}
 =

 	return bw;
 }
diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testin=
g/selftests/net/mptcp/mptcp_join.sh
index f39c1129ce5f..3b250df8a7f8 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -125,6 +125,17 @@ do_ping()
 	fi
 }
 =

+do_remove_addr()
+{
+	sleep 1
+	ip netns exec $ns1 ./pm_nl_ctl del 1
+	ip netns exec $ns2 ./pm_nl_ctl del 1
+
+	sleep 1
+	ip netns exec $ns1 ./pm_nl_ctl del 2
+	ip netns exec $ns2 ./pm_nl_ctl del 2
+}
+
 do_transfer()
 {
 	listener_ns=3D"$1"
@@ -132,6 +143,7 @@ do_transfer()
 	cl_proto=3D"$3"
 	srv_proto=3D"$4"
 	connect_addr=3D"$5"
+	remove_addr=3D"$6"
 =

 	port=3D$((10000+$TEST_COUNT))
 	TEST_COUNT=3D$((TEST_COUNT+1))
@@ -164,6 +176,10 @@ do_transfer()
 	ip netns exec ${connector_ns} ./mptcp_connect -j -t $timeout -p $port -s =
${cl_proto} $connect_addr < "$cin" > "$cout" &
 	cpid=3D$!
 =

+	if [ $remove_addr -eq 1 ]; then
+		do_remove_addr
+	fi
+
 	wait $cpid
 	retc=3D$?
 	wait $spid
@@ -217,9 +233,10 @@ run_tests()
 	listener_ns=3D"$1"
 	connector_ns=3D"$2"
 	connect_addr=3D"$3"
+	remove_addr=3D"$4"
 	lret=3D0
 =

-	do_transfer ${listener_ns} ${connector_ns} MPTCP MPTCP ${connect_addr}
+	do_transfer ${listener_ns} ${connector_ns} MPTCP MPTCP ${connect_addr} ${=
remove_addr}
 	lret=3D$?
 	if [ $lret -ne 0 ]; then
 		ret=3D$lret
@@ -285,20 +302,20 @@ make_file "$cin" "client"
 make_file "$sin" "server"
 trap cleanup EXIT
 =

-run_tests $ns1 $ns2 10.0.1.1
+run_tests $ns1 $ns2 10.0.1.1 0
 chk_join_nr "no JOIN" "0" "0" "0"
 =

 # subflow limted by client
 reset
 ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
-run_tests $ns1 $ns2 10.0.1.1
+run_tests $ns1 $ns2 10.0.1.1 0
 chk_join_nr "single subflow, limited by client" 0 0 0
 =

 # subflow limted by server
 reset
 ip netns exec $ns2 ./pm_nl_ctl limits 0 1
 ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
-run_tests $ns1 $ns2 10.0.1.1
+run_tests $ns1 $ns2 10.0.1.1 0
 chk_join_nr "single subflow, limited by server" 1 1 0
 =

 # subflow
@@ -306,7 +323,7 @@ reset
 ip netns exec $ns1 ./pm_nl_ctl limits 0 1
 ip netns exec $ns2 ./pm_nl_ctl limits 0 1
 ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
-run_tests $ns1 $ns2 10.0.1.1
+run_tests $ns1 $ns2 10.0.1.1 0
 chk_join_nr "single subflow" 1 1 1
 =

 # multiple subflows
@@ -315,7 +332,7 @@ ip netns exec $ns1 ./pm_nl_ctl limits 0 2
 ip netns exec $ns2 ./pm_nl_ctl limits 0 2
 ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
 ip netns exec $ns2 ./pm_nl_ctl add 10.0.2.2 flags subflow
-run_tests $ns1 $ns2 10.0.1.1
+run_tests $ns1 $ns2 10.0.1.1 0
 chk_join_nr "multiple subflows" 2 2 2
 =

 # multiple subflows limited by serverf
@@ -324,13 +341,13 @@ ip netns exec $ns1 ./pm_nl_ctl limits 0 1
 ip netns exec $ns2 ./pm_nl_ctl limits 0 2
 ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
 ip netns exec $ns2 ./pm_nl_ctl add 10.0.2.2 flags subflow
-run_tests $ns1 $ns2 10.0.1.1
+run_tests $ns1 $ns2 10.0.1.1 0
 chk_join_nr "multiple subflows, limited by server" 2 2 1
 =

 # add_address, unused
 reset
 ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
-run_tests $ns1 $ns2 10.0.1.1
+run_tests $ns1 $ns2 10.0.1.1 0
 chk_join_nr "unused signal address" 0 0 0
 =

 # accept and use add_addr
@@ -338,7 +355,7 @@ reset
 ip netns exec $ns1 ./pm_nl_ctl limits 0 1
 ip netns exec $ns2 ./pm_nl_ctl limits 1 1
 ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
-run_tests $ns1 $ns2 10.0.1.1
+run_tests $ns1 $ns2 10.0.1.1 0
 chk_join_nr "signal address" 1 1 1
 =

 # accept and use add_addr with an additional subflow
@@ -350,7 +367,7 @@ ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
 ip netns exec $ns1 ./pm_nl_ctl limits 0 2
 ip netns exec $ns2 ./pm_nl_ctl limits 1 2
 ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
-run_tests $ns1 $ns2 10.0.1.1
+run_tests $ns1 $ns2 10.0.1.1 0
 chk_join_nr "subflow and signal" 2 2 2
 =

 # accept and use add_addr with additional subflows
@@ -360,15 +377,26 @@ ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags sig=
nal
 ip netns exec $ns2 ./pm_nl_ctl limits 1 3
 ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
 ip netns exec $ns2 ./pm_nl_ctl add 10.0.4.2 flags subflow
-run_tests $ns1 $ns2 10.0.1.1
+run_tests $ns1 $ns2 10.0.1.1 0
 chk_join_nr "multiple subflows and signal" 3 3 3
 =

+# remove subflow and signal
+reset
+ip netns exec $ns1 ./pm_nl_ctl limits 2 2
+ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
+ip netns exec $ns1 ./pm_nl_ctl add 10.0.3.1 flags subflow
+ip netns exec $ns2 ./pm_nl_ctl limits 2 2
+ip netns exec $ns2 ./pm_nl_ctl add 10.0.2.2 flags signal
+ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
+run_tests $ns1 $ns2 10.0.1.1 1
+chk_join_nr "remove subflow and signal" 2 2 1
+
 # single subflow, syncookies
 reset_with_cookies
 ip netns exec $ns1 ./pm_nl_ctl limits 0 1
 ip netns exec $ns2 ./pm_nl_ctl limits 0 1
 ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
-run_tests $ns1 $ns2 10.0.1.1
+run_tests $ns1 $ns2 10.0.1.1 0
 chk_join_nr "single subflow with syn cookies" 1 1 1
 =

 # multiple subflows with syn cookies
@@ -377,7 +405,7 @@ ip netns exec $ns1 ./pm_nl_ctl limits 0 2
 ip netns exec $ns2 ./pm_nl_ctl limits 0 2
 ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
 ip netns exec $ns2 ./pm_nl_ctl add 10.0.2.2 flags subflow
-run_tests $ns1 $ns2 10.0.1.1
+run_tests $ns1 $ns2 10.0.1.1 0
 chk_join_nr "multiple subflows with syn cookies" 2 2 2
 =

 # multiple subflows limited by server
@@ -386,7 +414,7 @@ ip netns exec $ns1 ./pm_nl_ctl limits 0 1
 ip netns exec $ns2 ./pm_nl_ctl limits 0 2
 ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
 ip netns exec $ns2 ./pm_nl_ctl add 10.0.2.2 flags subflow
-run_tests $ns1 $ns2 10.0.1.1
+run_tests $ns1 $ns2 10.0.1.1 0
 chk_join_nr "subflows limited by server w cookies" 2 2 1
 =

 # test signal address with cookies
@@ -394,7 +422,7 @@ reset_with_cookies
 ip netns exec $ns1 ./pm_nl_ctl limits 0 1
 ip netns exec $ns2 ./pm_nl_ctl limits 1 1
 ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
-run_tests $ns1 $ns2 10.0.1.1
+run_tests $ns1 $ns2 10.0.1.1 0
 chk_join_nr "signal address with syn cookies" 1 1 1
 =

 # test cookie with subflow and signal
@@ -403,7 +431,7 @@ ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
 ip netns exec $ns1 ./pm_nl_ctl limits 0 2
 ip netns exec $ns2 ./pm_nl_ctl limits 1 2
 ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
-run_tests $ns1 $ns2 10.0.1.1
+run_tests $ns1 $ns2 10.0.1.1 0
 chk_join_nr "subflow and signal w cookies" 2 2 2
 =

 # accept and use add_addr with additional subflows
@@ -413,7 +441,7 @@ ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
 ip netns exec $ns2 ./pm_nl_ctl limits 1 3
 ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
 ip netns exec $ns2 ./pm_nl_ctl add 10.0.4.2 flags subflow
-run_tests $ns1 $ns2 10.0.1.1
+run_tests $ns1 $ns2 10.0.1.1 0
 chk_join_nr "subflows and signal w. cookies" 3 3 3
 =

 exit $ret
-- =

2.17.1

--===============4861289752411309550==--

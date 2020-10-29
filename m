Content-Type: multipart/mixed; boundary="===============8244568627267217887=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][PATCH mptcp-next 8/8] selftests: mptcp: add testcases
 for ADD_ADDR with port
Date: Thu, 29 Oct 2020 14:39:28 +0800
Message-ID: <19324d5229646e70adb89dc08fd29637cdcd5613.1603952836.git.geliangtang@gmail.com>
In-Reply-To: 74a7932cdf68d481379e0910f511b4ef017661ce.1603952836.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 6471

--===============8244568627267217887==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch added testcases for ADD_ADDR with port.

Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 26 ++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testin=
g/selftests/net/mptcp/mptcp_join.sh
index 0eae628d1ffd..826d662a9bf8 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -212,6 +212,7 @@ do_transfer()
 	rm_nr_ns1=3D"$7"
 	rm_nr_ns2=3D"$8"
 	speed=3D"$9"
+	with_port=3D"${10}"
 =

 	port=3D$((10000+$TEST_COUNT))
 	TEST_COUNT=3D$((TEST_COUNT+1))
@@ -253,6 +254,11 @@ do_transfer()
 		-s ${srv_proto} ${local_addr} < "$sin" > "$sout" &
 	spid=3D$!
 =

+	if [ "$with_port" -gt 0 ];then
+		ip netns exec ${listener_ns} $mptcp_connect -t $timeout -l -p $with_port=
 \
+			-s ${srv_proto} ${local_addr} < "$sin" > "$sout" &
+	fi
+
 	sleep 1
 =

 	if [ "$test_link_fail" -eq 0 ];then
@@ -348,6 +354,7 @@ run_tests()
 	rm_nr_ns1=3D"${5:-0}"
 	rm_nr_ns2=3D"${6:-0}"
 	speed=3D"${7:-fast}"
+	with_port=3D"${8:-0}"
 	lret=3D0
 	oldin=3D""
 =

@@ -362,7 +369,7 @@ run_tests()
 	fi
 =

 	do_transfer ${listener_ns} ${connector_ns} MPTCP MPTCP ${connect_addr} \
-		${test_linkfail} ${rm_nr_ns1} ${rm_nr_ns2} ${speed}
+		${test_linkfail} ${rm_nr_ns1} ${rm_nr_ns2} ${speed} ${with_port}
 	lret=3D$?
 =

 	if [ "$test_linkfail" -eq 1 ];then
@@ -717,6 +724,23 @@ chk_join_nr "remove subflow and signal IPv6" 2 2 2
 chk_add_nr 1 1
 chk_rm_nr 1 1
 =

+# subflow with port
+reset
+ip netns exec $ns1 ./pm_nl_ctl limits 0 1
+ip netns exec $ns2 ./pm_nl_ctl limits 0 1
+ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow port 10100
+run_tests $ns1 $ns2 10.0.1.1
+chk_join_nr "single subflow with port" 1 1 1
+
+# signal address with port
+reset
+ip netns exec $ns1 ./pm_nl_ctl limits 0 1
+ip netns exec $ns2 ./pm_nl_ctl limits 1 1
+ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal port 10100
+run_tests $ns1 $ns2 10.0.1.1 0 0 0 fast 10100
+chk_join_nr "signal address with port" 1 1 1
+chk_add_nr 1 1
+
 # single subflow, syncookies
 reset_with_cookies
 ip netns exec $ns1 ./pm_nl_ctl limits 0 1
-- =

2.26.2

--===============8244568627267217887==--

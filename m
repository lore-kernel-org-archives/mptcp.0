Content-Type: multipart/mixed; boundary="===============2849881791951799504=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][PATCH mptcp-next 3/3] Squash to "selftests: mptcp:
 add testcases for ADD_ADDR with port"
Date: Mon, 16 Nov 2020 12:31:01 +0800
Message-ID: <ea4b0e9dafb772a71be3264c1bf5c8415920b2c5.1605500515.git.geliangtang@gmail.com>
In-Reply-To: e6d99c38352b1494235eb577805a21939b7f9281.1605500515.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 6737

--===============2849881791951799504==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Added a new test for listening the new port from userspace.

Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 29 ++++++++++++++-----
 1 file changed, 22 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testin=
g/selftests/net/mptcp/mptcp_join.sh
index 8fe184a5ef25..e5669f79b1ad 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -257,6 +257,7 @@ do_transfer()
 	if [ "$with_port" -gt 0 ];then
 		ip netns exec ${listener_ns} $mptcp_connect -t $timeout -l -p $with_port=
 \
 			-s ${srv_proto} ${local_addr} < "$sin" > "$sout" &
+		spid_with_port=3D$!
 	fi
 =

 	sleep 1
@@ -298,6 +299,11 @@ do_transfer()
 	wait $spid
 	rets=3D$?
 =

+	if [ "$with_port" -gt 0 ];then
+		sleep 1
+		kill $spid_with_port
+	fi
+
 	if [ $capture -eq 1 ]; then
 	    sleep 1
 	    kill $cappid
@@ -437,9 +443,9 @@ chk_add_nr()
 	local add_nr=3D$1
 	local echo_nr=3D$2
 	local port_nr=3D${3:-0}
-	local syn_nr=3D$port_nr
-	local syn_ack_nr=3D$port_nr
-	local ack_nr=3D$port_nr
+	local syn_nr=3D${4:-$port_nr}
+	local syn_ack_nr=3D${5:-$port_nr}
+	local ack_nr=3D${6:-$port_nr}
 	local count
 	local dump_stats
 =

@@ -781,7 +787,7 @@ reset
 ip netns exec $ns1 ./pm_nl_ctl limits 0 1
 ip netns exec $ns2 ./pm_nl_ctl limits 1 1
 ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal port 10100
-run_tests $ns1 $ns2 10.0.1.1 0 0 0 fast 10100
+run_tests $ns1 $ns2 10.0.1.1 0 0 0 fast
 chk_join_nr "signal address with port" 1 1 1
 chk_add_nr 1 1 1
 =

@@ -791,7 +797,7 @@ ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signa=
l port 10100
 ip netns exec $ns1 ./pm_nl_ctl limits 0 2
 ip netns exec $ns2 ./pm_nl_ctl limits 1 2
 ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
-run_tests $ns1 $ns2 10.0.1.1 0 0 0 fast 10100
+run_tests $ns1 $ns2 10.0.1.1 0 0 0 fast
 chk_join_nr "subflow and signal with port" 2 2 2
 chk_add_nr 1 1 1
 =

@@ -800,7 +806,7 @@ reset
 ip netns exec $ns1 ./pm_nl_ctl limits 0 1
 ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal port 10100
 ip netns exec $ns2 ./pm_nl_ctl limits 1 1
-run_tests $ns1 $ns2 10.0.1.1 0 1 0 slow 10100
+run_tests $ns1 $ns2 10.0.1.1 0 1 0 slow
 chk_join_nr "remove single address with port" 1 1 1
 chk_add_nr 1 1 1
 chk_rm_nr 0 0
@@ -811,11 +817,20 @@ ip netns exec $ns1 ./pm_nl_ctl limits 0 2
 ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal port 10100
 ip netns exec $ns2 ./pm_nl_ctl limits 1 2
 ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
-run_tests $ns1 $ns2 10.0.1.1 0 1 1 slow 10100
+run_tests $ns1 $ns2 10.0.1.1 0 1 1 slow
 chk_join_nr "remove subflow and signal with port" 2 2 2
 chk_add_nr 1 1 1
 chk_rm_nr 1 1
 =

+# signal address with port, userspace
+reset
+ip netns exec $ns1 ./pm_nl_ctl limits 0 1
+ip netns exec $ns2 ./pm_nl_ctl limits 1 1
+ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal port 10100
+run_tests $ns1 $ns2 10.0.1.1 0 0 0 fast 10100
+chk_join_nr "signal address with port, userspace" 1 0 0
+chk_add_nr 1 1 1 0 0 0
+
 # single subflow, syncookies
 reset_with_cookies
 ip netns exec $ns1 ./pm_nl_ctl limits 0 1
-- =

2.26.2

--===============2849881791951799504==--
